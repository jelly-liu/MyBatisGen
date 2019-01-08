package com.jelly.mybatis;

import com.jelly.mybatis.interfaces.Gen;
import com.jelly.mybatis.interfaces.impl.MySQLGen;
import com.jelly.mybatis.interfaces.impl.OracleGen;
import com.jelly.mybatis.util.Logger;
import freemarker.template.Configuration;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.Template;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;

import java.io.*;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

public class MybatisFreemarker {
	private Configuration freemarkerConfiguration;

	private String ftlDir;
	private String outDir;
	private String projectDir;
    private String modelDir;
	private String mapperDir;
    private String mapperInterfaceDir;
    private String daoDir;
    private String daoImplDir;
    private String serviceDir;
    private String serviceImplDir;
	
	private Gen gen;
	private Map<String, Object> rootMap = new HashMap<String, Object>();
	
	public void init(String classPathConfig) throws Exception {
        //load config
        InputStream inputStream = ClassLoader.getSystemResourceAsStream(classPathConfig);
        Properties properties = new Properties();
        properties.load(inputStream);

		//freemarker初始化
		this.freemarkerConfiguration = new Configuration();
        ftlDir = properties.getProperty("ftl.dir");
        String ftlPath = GenMain.class.getResource("/").getPath() + ftlDir;
        System.out.println("ftlPath:" + ftlPath);
        freemarkerConfiguration.setDirectoryForTemplateLoading(new File(ftlPath));
		this.freemarkerConfiguration.setObjectWrapper(new DefaultObjectWrapper());

		//parse config
		this.outDir = properties.getProperty("outDir");
		this.outDir = this.outDir.replaceAll("\\\\", "/");
		if(!this.outDir.endsWith("/")){
			this.outDir += "/";
		}

        this.projectDir = properties.getProperty("projectDir");

		this.modelDir = this.outDir + StringUtils.replace(properties.getProperty("model.package"), ".", "/") + "/";
        this.mapperDir = this.outDir + StringUtils.replace(properties.getProperty("mapper.package"), ".", "/") + "/";
        this.mapperInterfaceDir = this.outDir + StringUtils.replace(properties.getProperty("mapperInterface.package"), ".", "/") + "/";
        this.daoDir = this.outDir + StringUtils.replace(properties.getProperty("dao.package"), ".", "/") + "/";
        this.daoImplDir = this.outDir + StringUtils.replace(properties.getProperty("dao.package"), ".", "/") + "/impl/";
        this.serviceDir = this.outDir + StringUtils.replace(properties.getProperty("service.package"), ".", "/") + "/";
        this.serviceImplDir = this.outDir + StringUtils.replace(properties.getProperty("service.package"), ".", "/") + "/impl/";
		this.checkDir();
		
		String databaseType = properties.getProperty("database.type").toLowerCase();
		Logger.info("databaseType:" + databaseType);
		if(databaseType.equals("mysql")){
			this.gen = new MySQLGen(properties);
		}else{
			this.gen = new OracleGen(properties);
		}
	}
	
	private void checkDir() throws Exception{
		//check pojo dir
		File dirPojo = new File(this.outDir);
		if(dirPojo.exists()){
            FileUtils.cleanDirectory(dirPojo);
		}

        new File(this.outDir).mkdirs();
        new File(this.modelDir).mkdirs();
        new File(this.mapperDir).mkdirs();
        new File(this.mapperInterfaceDir).mkdirs();
        new File(this.daoDir).mkdirs();
        new File(this.daoImplDir).mkdirs();
        new File(this.serviceDir).mkdirs();
        new File(this.serviceImplDir).mkdirs();
	}
	
	private void setFtlParam(String tableName){
		rootMap.put("tableName", tableName);
		rootMap.put("tableNamePojoNameMap", this.gen.getTableNamePojoNameMap());
		rootMap.put("pksMap", this.gen.getPksMap());
		rootMap.put("columnNames", this.gen.getColumnNameMap().get(tableName));
		rootMap.put("columnJavaTypeMap", this.gen.getColumnJavaTypeMap());
		rootMap.put("columnJavaNameMap", this.gen.getColumnJavaNameMap());
		
		rootMap.put("modelPackage", this.gen.getModelPackage());
        rootMap.put("mapperPackage", this.gen.getMapperPackage());
        rootMap.put("mapperInterfacePackage", this.gen.getMapperInterfacePackage());
        rootMap.put("daoPackage", this.gen.getDaoPackage());
        rootMap.put("servicePackage", this.gen.getServicePackage());
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
			Writer out = new OutputStreamWriter(new FileOutputStream(this.modelDir + modelName + ".java"), "UTF-8");
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
			Writer out = new OutputStreamWriter(new FileOutputStream(this.mapperDir + mapperName + "Mapper.xml"), "UTF-8");
			template.process(rootMap, out);
			out.flush();

			out.close();
		}
	}

    public void genMapperInterface() throws Exception {
        for(String tableName : this.gen.getTablesNames()){
            Logger.info(Logger.PRE_LONG + "genMapperInterface(), tableName=" + tableName);

            /* 设置ftl模板参数 */
            this.setFtlParam(tableName);
            /* 获取模板 */
            Template template = freemarkerConfiguration.getTemplate("mapperInterface.ftl");
            /* 将模板和数据模型合并 */
            String mapperInterfaceName = this.gen.getTableNamePojoNameMap().get(tableName) + "Mapper";
            Writer out = new OutputStreamWriter(new FileOutputStream(this.mapperInterfaceDir + mapperInterfaceName + ".java"), "UTF-8");
            template.process(rootMap, out);
            out.flush();

            out.close();
        }
    }

    public void genDao() throws Exception {
        for(String tableName : this.gen.getTablesNames()){
            Logger.info(Logger.PRE_LONG + "genDao(), tableName=" + tableName);

            /* 设置ftl模板参数 */
            this.setFtlParam(tableName);
            /* 获取模板 */
            Template template = freemarkerConfiguration.getTemplate("dao.ftl");
            /* 将模板和数据模型合并 */
            String daoName = this.gen.getTableNamePojoNameMap().get(tableName) + "Dao";
            Writer out = new OutputStreamWriter(new FileOutputStream(this.daoDir + daoName + ".java"), "UTF-8");
            template.process(rootMap, out);
            out.flush();
            out.close();
        }
        for(String tableName : this.gen.getTablesNames()){
            Logger.info(Logger.PRE_LONG + "genDaoImpl(), tableName=" + tableName);

            /* 设置ftl模板参数 */
            this.setFtlParam(tableName);
            /* 获取模板 */
            Template template = freemarkerConfiguration.getTemplate("daoImpl.ftl");
            /* 将模板和数据模型合并 */
            String daoImplName = this.gen.getTableNamePojoNameMap().get(tableName) + "DaoImpl";
            Writer out = new OutputStreamWriter(new FileOutputStream(this.daoImplDir + daoImplName + ".java"), "UTF-8");
            template.process(rootMap, out);
            out.flush();
            out.close();
        }
    }

    public void genService() throws Exception {
        for(String tableName : this.gen.getTablesNames()){
            Logger.info(Logger.PRE_LONG + "genService(), tableName=" + tableName);

            /* 设置ftl模板参数 */
            this.setFtlParam(tableName);
            /* 获取模板 */
            Template template = freemarkerConfiguration.getTemplate("service.ftl");
            /* 将模板和数据模型合并 */
            String daoName = this.gen.getTableNamePojoNameMap().get(tableName) + "Service";
            Writer out = new OutputStreamWriter(new FileOutputStream(this.serviceDir + daoName + ".java"), "UTF-8");
            template.process(rootMap, out);
            out.flush();
            out.close();
        }
        for(String tableName : this.gen.getTablesNames()){
            Logger.info(Logger.PRE_LONG + "genServiceImpl(), tableName=" + tableName);

            /* 设置ftl模板参数 */
            this.setFtlParam(tableName);
            /* 获取模板 */
            Template template = freemarkerConfiguration.getTemplate("serviceImpl.ftl");
            /* 将模板和数据模型合并 */
            String daoImplName = this.gen.getTableNamePojoNameMap().get(tableName) + "ServiceImpl";
            Writer out = new OutputStreamWriter(new FileOutputStream(this.serviceImplDir + daoImplName + ".java"), "UTF-8");
            template.process(rootMap, out);
            out.flush();
            out.close();
        }
    }

	//getter and setter


    public String getProjectDir() {
        return projectDir;
    }

    public MybatisFreemarker setProjectDir(String projectDir) {
        this.projectDir = projectDir;
        return this;
    }

    public String getFtlDir() {
        return ftlDir;
    }

    public MybatisFreemarker setFtlDir(String ftlDir) {
        this.ftlDir = ftlDir;
        return this;
    }

    public String getOutDir() {
		return outDir;
	}

	public void setOutDir(String outDir) {
		this.outDir = outDir;
	}
}
