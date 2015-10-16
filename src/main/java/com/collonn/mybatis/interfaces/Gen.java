package com.collonn.mybatis.interfaces;

import com.collonn.mybatis.util.GenUtil;
import com.collonn.mybatis.util.Logger;
import org.apache.commons.dbutils.QueryRunner;

import javax.sql.DataSource;
import java.util.*;
import java.util.Map.Entry;

public abstract class Gen {
	protected Properties properties;
	
	protected String databaseType;
	protected String databaseName;
	protected String sqlCase;
	
	protected String modelPackage;
	
	//INT-Integer|BIGINT-Long|DECIMAL-BigDecimal|CHAR-String|VARCHAR-String
	protected Map<String, String> refMap;
	protected DataSource ds;
	protected QueryRunner qr;
	//other names,upper case
	protected String[] tablesNames;
	//key=tableName, value=对就的JavaBean名称
	protected Map<String, String> tableNamePojoNameMap = new LinkedHashMap<String, String>();
	//key=tableName|columnName, value=column detail info
	protected Map<String, Map<String, Object>> columnInfoMap = new LinkedHashMap<String, Map<String, Object>>();
	//key=tableName, value=columnNames
	protected Map<String, List<String>> columnNameMap = new LinkedHashMap<String, List<String>>();
	//key=tableName|columnName, value=java表的属性名
	protected Map<String, String> columnJavaNameMap = new LinkedHashMap<String, String>();
	//key=tableName|columnName, value=java表的属性类型
	protected Map<String, String> columnJavaTypeMap = new LinkedHashMap<String, String>();
	//key=tableName, value=表的主键列表
	protected Map<String, String[]> pksMap = new LinkedHashMap<String, String[]>();
	
	protected void prepare(Properties properties) throws Exception{
		this.properties = properties;
		
		this.databaseType = this.properties.getProperty("database.type").toLowerCase();
		this.getRef(this.databaseType);
		this.databaseName = this.properties.getProperty("database.name").toLowerCase();
		this.sqlCase = this.properties.getProperty("sqlCase").toLowerCase();
		
		this.modelPackage = this.properties.getProperty("model.package");
		
		//注意，以下方法执行顺序不能变
		this.initDs();
		this.getTables();
		this.getPojoNames();
		this.getPKs();
		this.getColumnsInfo();
		this.getColumnNames();
		this.getColumnJavaName();
		this.getColumnJavaType();
	}
	
	/**
	 * 将字符串解析成HashMap<br/>
	 * 如：Integer-INT|Long-BIGINT|BigDecimal-DECIMAL
	 */
	protected void getRef(String databaseType) {
		String ref = this.properties.getProperty(databaseType + ".ref");
		Map<String, String> refMap = new HashMap<String, String>();
		
		Logger.info(Logger.PRE_LONG + "getRef()");
		Logger.info("ref:" + ref);
		Logger.info(Logger.PRE_LONG);
		String[] refSeg = ref.split("\\|");
		String[] kv = null;
		for(String r : refSeg){
			kv = r.split("-");
			refMap.put(kv[0].toUpperCase(), kv[1]);
			Logger.info(kv[0].toUpperCase() + ":" + kv[1]);
		}
		
		this.refMap = refMap;
	}
	
	protected abstract void initDs() throws Exception;
	
	protected abstract void getTables() throws Exception;
	
	protected void getPojoNames(){
		Logger.info(Logger.PRE_LONG + "getPojoNames()");
		Logger.info("tableName,pojoName");
		Logger.info(Logger.PRE_MID);
		for(String tableName : this.tablesNames){
			Logger.info(tableName + "," + GenUtil.TableNameToPojoName(tableName));
			this.tableNamePojoNameMap.put(tableName, GenUtil.TableNameToPojoName(tableName));
		}
	}
	
	protected abstract void getPKs() throws Exception;
	
	protected abstract void getColumnsInfo() throws Exception;
	
	protected void getColumnNames() throws Exception {
		String tableName = null;
		String columnName = null;
		List<String> columnNameList = null;
		//key=menu_name
		//tableName=menu
		//columnName=name
		for(Entry<String, Map<String, Object>> entry : this.columnInfoMap.entrySet()){
			tableName = entry.getKey().substring(0, entry.getKey().indexOf("|"));
			columnName = entry.getKey().substring(entry.getKey().indexOf("|") + 1);
			
			columnNameList = this.columnNameMap.get(tableName);
			if(columnNameList == null){
				columnNameList = new ArrayList<String>();
				this.columnNameMap.put(tableName, columnNameList);
			}
			
			columnNameList.add(columnName);
		}
		
		//print
		Logger.info(Logger.PRE_LONG + "getColumnNames()");
		for(Entry<String, List<String>> entry : this.columnNameMap.entrySet()){
			Logger.info("tableName:" + entry.getKey());
			for(String cname : entry.getValue()){
				Logger.info("columnName:" + cname);
			}
			Logger.info(Logger.PRE_MID);
		}
	}
	
	protected void getColumnJavaName() throws Exception {
		String tableName = null;
		String columnName = null;
		//key=menu_name
		//tableName=menu
		//columnName=name
		for(Entry<String, Map<String, Object>> entry : this.columnInfoMap.entrySet()){
			tableName = entry.getKey().substring(0, entry.getKey().indexOf("|"));
			columnName = entry.getKey().substring(entry.getKey().indexOf("|") + 1);
			this.columnJavaNameMap.put(tableName + "|" + columnName, GenUtil.ColumnNameToJavaPropertyName(columnName));
		}
		
		//print
		Logger.info(Logger.PRE_LONG + "getColumnJavaName()");
		for(String tName : this.tablesNames){
			List<String> columnNameList = this.columnNameMap.get(tName);
			Logger.info(Logger.PRE_MID);
			Logger.info("tableName:" + tName);
			for(String cName : columnNameList){
				Logger.info(cName + "<->" + this.columnJavaNameMap.get(tName + "|" + cName));
			}
		}
	}
	
	protected abstract void getColumnJavaType() throws Exception;

	//getter and setter
	public Properties getProperties() {
		return properties;
	}

	public void setProperties(Properties properties) {
		this.properties = properties;
	}

	public String getDatabaseType() {
		return databaseType;
	}

	public void setDatabaseType(String databaseType) {
		this.databaseType = databaseType;
	}

	public String getDatabaseName() {
		return databaseName;
	}

	public void setDatabaseName(String databaseName) {
		this.databaseName = databaseName;
	}

	public String getSqlCase() {
		return sqlCase;
	}

	public void setSqlCase(String sqlCase) {
		this.sqlCase = sqlCase;
	}

	public Map<String, String> getRefMap() {
		return refMap;
	}

	public void setRefMap(Map<String, String> refMap) {
		this.refMap = refMap;
	}

	public DataSource getDs() {
		return ds;
	}

	public void setDs(DataSource ds) {
		this.ds = ds;
	}

	public QueryRunner getQr() {
		return qr;
	}

	public void setQr(QueryRunner qr) {
		this.qr = qr;
	}

	public String[] getTablesNames() {
		return tablesNames;
	}

	public void setTablesNames(String[] tablesNames) {
		this.tablesNames = tablesNames;
	}

	public Map<String, Map<String, Object>> getColumnInfoMap() {
		return columnInfoMap;
	}

	public void setColumnInfoMap(Map<String, Map<String, Object>> columnInfoMap) {
		this.columnInfoMap = columnInfoMap;
	}

	public Map<String, List<String>> getColumnNameMap() {
		return columnNameMap;
	}

	public void setColumnNameMap(Map<String, List<String>> columnNameMap) {
		this.columnNameMap = columnNameMap;
	}

	public Map<String, String> getColumnJavaNameMap() {
		return columnJavaNameMap;
	}

	public void setColumnJavaNameMap(Map<String, String> columnJavaNameMap) {
		this.columnJavaNameMap = columnJavaNameMap;
	}

	public Map<String, String> getColumnJavaTypeMap() {
		return columnJavaTypeMap;
	}

	public void setColumnJavaTypeMap(Map<String, String> columnJavaTypeMap) {
		this.columnJavaTypeMap = columnJavaTypeMap;
	}

	public String getModelPackage() {
		return modelPackage;
	}

	public void setModelPackage(String modelPackage) {
		this.modelPackage = modelPackage;
	}

	public Map<String, String[]> getPksMap() {
		return pksMap;
	}

	public void setPksMap(Map<String, String[]> pksMap) {
		this.pksMap = pksMap;
	}

	public Map<String, String> getTableNamePojoNameMap() {
		return tableNamePojoNameMap;
	}

	public void setTableNamePojoNameMap(Map<String, String> tableNamePojoNameMap) {
		this.tableNamePojoNameMap = tableNamePojoNameMap;
	}
	
}
