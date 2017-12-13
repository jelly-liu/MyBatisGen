package com.jelly.mybatis.interfaces.impl;

import com.jelly.mybatis.interfaces.Gen;
import com.jelly.mybatis.util.Logger;
import com.mysql.jdbc.jdbc2.optional.MysqlDataSource;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.MapListHandler;

import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Properties;

public class MySQLGen extends Gen {
	
	public MySQLGen(Properties properties) throws Exception{
		this.prepare(properties);
	}
	
	protected void initDs() throws Exception{
		MysqlDataSource myDs = new MysqlDataSource();
		myDs.setUrl(this.properties.getProperty("mysql.url"));
		myDs.setUser(this.properties.getProperty("mysql.username"));
		myDs.setPassword(this.properties.getProperty("mysql.password"));
		this.ds = myDs;
		this.qr = new QueryRunner(this.ds);
	}

	protected void getTables() throws Exception{
		String sql = "";
		sql += "SELECT a.TABLE_NAME AS \"TABLE_NAME\" ";
		sql += "FROM information_schema.TABLES a ";
		sql += "WHERE LOWER(a.TABLE_SCHEMA) = '" + this.databaseName.toLowerCase() + "'";
		
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
		sql += "SELECT a.TABLE_NAME as \"TABLE_NAME\", GROUP_CONCAT(a.COLUMN_NAME) AS \"PKS\" ";
		sql += "FROM information_schema.columns a  ";
		sql += "WHERE 1 = 1 ";
		sql += "AND LOWER(a.TABLE_SCHEMA) = '" + this.databaseName.toLowerCase() + "' ";
		sql += "AND LOWER(a.COLUMN_KEY) = 'pri' ";
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
				tmp += pks[i] + ",";
			}
			
			this.pksMap.put(tableName, pks);
			Logger.info(tableName + "--pks-->" + tmp);
		}
	}
	
	protected void getColumnsInfo() throws Exception {
		for(String tableName : this.tablesNames){
			String sql = "";
			sql += "SELECT a.COLUMN_NAME as \"COLUMN_NAME\", a.DATA_TYPE as \"DATA_TYPE\" ";
			sql += "FROM information_schema.columns a ";
			sql += "WHERE LOWER(a.TABLE_SCHEMA) = '" + this.databaseName.toLowerCase() + "' ";
			sql += "AND LOWER(a.TABLE_NAME) = '" + tableName.toLowerCase() + "' ";
			sql += "ORDER BY a.ORDINAL_POSITION ASC";
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
		
		Logger.info(Logger.PRE_LONG + "getColumnJavaType()");
		Logger.info("tableName,columnName,databaseType,javaType");
		Logger.info(Logger.PRE_MID);
		
		for(Entry<String, Map<String, Object>> entry : this.columnInfoMap.entrySet()){
			tableName = entry.getKey().substring(0, entry.getKey().indexOf("|"));
			columnName = entry.getKey().substring(entry.getKey().indexOf("|") + 1);
			
			databaseType = this.columnInfoMap.get(tableName + "|" + columnName).get("DATA_TYPE").toString().toUpperCase();
			javaType = this.refMap.get(databaseType);
			Logger.info(tableName + "," + columnName + "," + databaseType + "," + javaType);
			
			this.columnJavaTypeMap.put(tableName + "|" + columnName, javaType);
		}
	}
}
