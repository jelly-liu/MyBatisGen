package com.collonn.mybatis.util;

public class Logger {
	public static final String PRE_SHORT = "------------";
	public static final String PRE_MID = "------------------------";
	public static final String PRE_LONG = "------------------------------------";

	public static void info(String info) {
		System.out.println("[INFO]" + info);
	}

	public static void warning(String info) {
		System.out.println("[WARNING]" + info);
	}
}
