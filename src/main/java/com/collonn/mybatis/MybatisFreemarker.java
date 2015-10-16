package com.collonn.mybatis;

import com.collonn.mybatis.impl.GenMySQL;
import com.collonn.mybatis.impl.GenOracle;
import com.collonn.mybatis.interfaces.Gen;
import com.collonn.mybatis.util.Logger;
import freemarker.template.Configuration;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.Template;
import org.apache.commons.io.FileUtils;

import java.io.*;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

public class MybatisFreemarker {
	private Configuration freemarkerConfiguration;

	private String outDir;
	private String mapperDir;
	
	private Gen gen;
	private Map<String, Object> rootMap = new HashMap<String, Object>();
	
	public void init() throws Exception {
		//freemarker初始化
		this.freemarkerConfiguration = new Configuration();
        String ftlPath = GenMain.class.getResource("/").getPath() + "ftl";
        System.out.println("ftlPath:" + ftlPath);
        freemarkerConfiguration.setDirectoryForTemplateLoading(new File(ftlPath));
		this.freemarkerConfiguration.setObjectWrapper(new DefaultObjectWrapper());
		
		//load config
		InputStream inputStream = ClassLoader.getSystemResourceAsStream("config.properties");
		Properties properties = new Properties();
		properties.load(inputStream);
		
		//parse config
		this.outDir = properties.getProperty("outDir");
		this.outDir = this.outDir.replaceAll("\\\\", "/");
		if(!this.outDir.endsWith("/")){
			this.outDir += "/";
		}
		this.mapperDir = this.outDir + "mapper/";
		this.checkDir();
		
		String databaseType = properties.getProperty("database.type").toLowerCase();
		Logger.info("databaseType:" + databaseType);
		if(databaseType.equals("mysql")){
			this.gen = new GenMySQL(properties);
		}else{
			this.gen = new GenOracle(properties);
		}
	}
	
	private void checkDir() throws Exception{
		//check pojo dir
		File dirPojo = new File(this.outDir);
		if(!dirPojo.exists()){
			dirPojo.mkdirs();
		}else{
			FileUtils.cleanDirectory(dirPojo);
		}
		
		//check mapper dir
		File dirMapper = new File(this.mapperDir);
		if(!dirMapper.exists()){
			dirMapper.mkdirs();
		}else{
			FileUtils.cleanDirectory(dirMapper);
		}
	}
	
	private void setFtlParam(String tableName){
		rootMap.put("tableName", tableName);
		rootMap.put("tableNamePojoNameMap", this.gen.getTableNamePojoNameMap());
		rootMap.put("pksMap", this.gen.getPksMap());
		rootMap.put("columnNames", this.gen.getColumnNameMap().get(tableName));
		rootMap.put("columnJavaTypeMap", this.gen.getColumnJavaTypeMap());
		rootMap.put("columnJavaNameMap", this.gen.getColumnJavaNameMap());
		
		rootMap.put("modelPackage", this.gen.getModelPackage());
	}
	
	public void genPOJO() throws Exception {
		for(String tableName : this.gen.getTablesNames()){
			Logger.info(Logger.PRE_LONG + "genPOJO(), tableName=" + tableName);

			/* 设置ftl模板参数 */
			this.setFtlParam(tableName);
			/* 获取模板 */
			Template template = freemarkerConfiguration.getTemplate("model.ftl");
			/* 将模板和数据模型合并 */
			String modelName = this.gen.getTableNamePojoNameMap().get(tableName);
			Writer out = new OutputStreamWriter(new FileOutputStream(this.outDir + modelName + ".java"), "UTF-8");
			template.process(rootMap, out);
			out.flush();

			out.close();
		}
	}
	
	public void genMapper() throws Exception {
		for(String tableName : this.gen.getTablesNames()){
			Logger.info(Logger.PRE_LONG + "genMapper(), tableName=" + tableName);

			/* 设置ftl模板参数 */
			this.setFtlParam(tableName);
			/* 获取模板 */
			Template template = freemarkerConfiguration.getTemplate("mapper.ftl");
			/* 将模板和数据模型合并 */
			String mapperName = this.gen.getTableNamePojoNameMap().get(tableName);
			Writer out = new OutputStreamWriter(new FileOutputStream(this.outDir + "mapper/" + mapperName + ".Mapper.xml"), "UTF-8");
			template.process(rootMap, out);
			out.flush();

			out.close();
		}
	}

	//getter and setter
	public String getOutDir() {
		return outDir;
	}

	public void setOutDir(String outDir) {
		this.outDir = outDir;
	}
}
