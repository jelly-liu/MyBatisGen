package com.jelly.mybatis;

import org.apache.commons.lang3.StringUtils;

public class GenMain {

	public static void main(String[] args) throws Exception {
		MybatisFreemarker mybatisGen = new MybatisFreemarker();
		mybatisGen.init();

		if(StringUtils.equals(mybatisGen.getFtlDir(), "ftl")){
            mybatisGen.genPOJO();
            mybatisGen.genMapper();
            mybatisGen.genMapperInterface();
            mybatisGen.genDao();
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
		
		Runtime.getRuntime().exec("cmd.exe /c start " + mybatisGen.getOutDir());
	}

}
