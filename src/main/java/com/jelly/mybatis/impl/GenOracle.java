package com.jelly.mybatis.impl;

import com.jelly.mybatis.interfaces.Gen;
import com.jelly.mybatis.util.Logger;
import oracle.jdbc.pool.OracleDataSource;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.MapListHandler;

import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Properties;

public class GenOracle extends Gen {

	public GenOracle(Properties properties) throws Exception {
		this.prepare(properties);
	}

	protected void initDs() throws Exception{
		OracleDataSource oraDs = new OracleDataSource();
		oraDs.setURL(this.properties.getProperty("oracle.url"));
		oraDs.setUser(this.properties.getProperty("oracle.username"));
		oraDs.setPassword(this.properties.getProperty("oracle.password"));
		this.ds = oraDs;
		this.qr = new QueryRunner(this.ds);
	}

	protected void getTables() throws Exception{
		String sql = "";
		sql += "SELECT a.TABLE_NAME as \"TABLE_NAME\" FROM USER_TABLES a";
		
		List<Map<String, Object>> dataList = this.qr.query(sql, new MapListHandler());
		if(dataList == null || dataList.size() == 0){
			return;
		}
		
		String tname = null;
		this.tablesNames = new String[dataList.size()];
		Logger.info(Logger.PRE_LONG + "getTables()");
		for(int i = 0; i < dataList.size(); i++){
			tname = dataList.get(i).get("TABLE_NAME").toString();
			tname = this.sqlCase.equals("upper") ? tname.toUpperCase() : tname.toLowerCase();
			this.tablesNames[i] = tname;
			Logger.info("tableName:" + this.tablesNames[i]);
		}
	}
	
	protected void getPKs() throws Exception {
		String sql = "";
		sql += "SELECT a.TABLE_NAME AS \"TABLE_NAME\", wm_concat(a.column_name) AS \"PKS\" ";
		sql += "FROM user_cons_columns a ";
		sql += "INNER JOIN user_constraints b ON a.constraint_name = b.constraint_name ";
		sql += "WHERE 1 = 1 ";
		sql += "AND b.constraint_type = 'P'";
		sql += "AND INSTR(a.table_name, 'BIN$') = 0 ";
		sql += "AND UPPER(a.owner) = '" + this.databaseName.toUpperCase() + "' ";
		sql += "GROUP BY a.TABLE_NAME ";
		List<Map<String, Object>> dataList = qr.query(sql, new MapListHandler());
		
		if(dataList == null || dataList.size() ==0){
			Logger.info("[WARNING],no pk was found");
			return;
		}
		
		String tableName = null;
		String pksStr = null;
		String[] pks = null;
		Logger.info(Logger.PRE_LONG + "getPKs()");
		for(Map<String, Object> item : dataList){
			tableName = item.get("TABLE_NAME").toString();
			tableName = this.sqlCase.equals("upper") ? tableName.toUpperCase() : tableName.toLowerCase();
			pksStr = item.get("PKS").toString();
			pks = pksStr.split(",");
			
			//列名大小写转换
			String tmp = "";
			for(int i = 0; i < pks.length; i++){
				pks[i] = (this.sqlCase.equals("upper") ? pks[i].toUpperCase() : pks[i].toLowerCase());
				
				//will print this string
				tmp += pks[i];
				if(i != pks.length - 1){
					tmp += ",";
				}
			}
			
			this.pksMap.put(tableName, pks);
			Logger.info(tableName + "--pks-->" + tmp);
		}
	}
	
	protected void getColumnsInfo() throws Exception {
		for(String tableName : this.tablesNames){
			String sql = "";
			sql += "select a.COLUMN_NAME as \"COLUMN_NAME\", a.DATA_TYPE as \"DATA_TYPE\", a.DATA_SCALE as \"DATA_SCALE\" ";
			sql += "from user_tab_columns a where a.table_name ='" + tableName.toUpperCase() + "' ";
			sql += "order by a.COLUMN_ID asc";
			List<Map<String, Object>> dataList = qr.query(sql, new MapListHandler());
			
			String key = null;
			String columnName = null;
			for(Map<String, Object> columnInfo : dataList){
				columnName = columnInfo.get("COLUMN_NAME").toString();
				columnName = this.sqlCase.equals("upper") ? columnName.toUpperCase() : columnName.toLowerCase();
				
				key = tableName + "|" + columnName;
				this.columnInfoMap.put(key, columnInfo);
			}
		}
	}
	
	protected void getColumnJavaType() throws Exception {
		String tableName = null;
		String columnName = null;
		String javaType = null;
		String databaseType = null;
		Object dataScale = null;
		
		Logger.info(Logger.PRE_LONG + "getColumnJavaType()");
		Logger.info("tableName,columnName,databaseType,dataScale,javaType");
		Logger.info(Logger.PRE_MID);
		
		for(Entry<String, Map<String, Object>> entry : this.columnInfoMap.entrySet()){
			tableName = entry.getKey().substring(0, entry.getKey().indexOf("|"));
			columnName = entry.getKey().substring(entry.getKey().indexOf("|") + 1);
			
			dataScale = this.columnInfoMap.get(tableName + "|" + columnName).get("DATA_SCALE");
			databaseType = this.columnInfoMap.get(tableName + "|" + columnName).get("DATA_TYPE").toString().toUpperCase();
			
			if(dataScale == null || dataScale.toString().equals("")){
				javaType = this.refMap.get(databaseType);
				dataScale = "";
			}else{
				javaType = this.refMap.get("DATA_SCALE");
			}
			Logger.info(tableName + "," + columnName + "," + databaseType + "," + dataScale + "," + javaType);
			
			this.columnJavaTypeMap.put(tableName + "|" + columnName, javaType);
		}
	}
}
