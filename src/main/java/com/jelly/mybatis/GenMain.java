package com.jelly.mybatis;

public class GenMain {

	public static void main(String[] args) throws Exception {
		MybatisFreemarker mybatisGen = new MybatisFreemarker();
		mybatisGen.init();
		
		mybatisGen.genPOJO();
		mybatisGen.genMapper();
		mybatisGen.genMapperInterface();
		mybatisGen.genDao();
        mybatisGen.genService();
		
		Runtime.getRuntime().exec("cmd.exe /c start " + mybatisGen.getOutDir());
		//+1
	}

}
