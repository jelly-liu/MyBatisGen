package com.jelly.mybatis;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;

import java.io.File;

public class GenMain {

	public static void main(String[] args) throws Exception {
		MybatisFreemarker mybatisGen = new MybatisFreemarker();
		mybatisGen.init("config-eoss.properties");

		if(StringUtils.equals(mybatisGen.getFtlDir(), "ftl")){
            mybatisGen.genPOJO();
            mybatisGen.genMapper();
//            mybatisGen.genMapperInterface();
//            mybatisGen.genDao();
            mybatisGen.genService();
        }else if(StringUtils.equals(mybatisGen.getFtlDir(), "ftl2")){
            mybatisGen.genPOJO();
            mybatisGen.genMapper();
            mybatisGen.genMapperInterface();
//            mybatisGen.genDao();
            mybatisGen.genService();
        }else if(StringUtils.equals(mybatisGen.getFtlDir(), "ftl3")){
            mybatisGen.genPOJO();
            mybatisGen.genMapper();
            mybatisGen.genMapperInterface();
//            mybatisGen.genDao();
            mybatisGen.genService();
        }else {
		    throw new RuntimeException("配置文件中的 ftl.dir， 值必须是 ftl 或 ftl2");
        }

//        FileUtils.copyDirectoryToDirectory(new File(mybatisGen.getOutDir() + "/com"), new File(mybatisGen.getProjectDir()));

        System.out.println("******************************************");
        System.out.println("*********** 输出目录：" + mybatisGen.getOutDir());
        System.out.println("******************************************");
	}

}
