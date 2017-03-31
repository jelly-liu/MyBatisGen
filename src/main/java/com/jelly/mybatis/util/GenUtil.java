package com.jelly.mybatis.util;

public class GenUtil {
	//将数据库的表名，转换为JavaBean名
	public static String TableNameToPojoName(String tableName){
		tableName = ColumnNameToJavaPropertyName(tableName);
		tableName = UpperFirstKeepOthers(tableName);
		return tableName;
	}
	
	// 将表的字段名，转换为JavaBean属性名
	public static String ColumnNameToJavaPropertyName(String columnName) {
		//将任意的空白符用空字符串替换
		columnName = columnName.replaceAll("\\s", "");

		if (columnName.startsWith("_")) {
			columnName = columnName.substring(1);
		}

		if (columnName.endsWith("_")) {
			columnName = columnName.substring(0, columnName.length() - 1);
		}

		if (columnName.indexOf("_") == -1) {
			return columnName.toLowerCase();
		}

		StringBuilder sb = new StringBuilder();

		String[] segs = columnName.split("_");
		for (int i = 0; i < segs.length; i++) {
			if (i == 0) {
				sb.append(segs[i].toLowerCase());
			} else {
				sb.append(UpperFirstLowerOthers(segs[i]));
			}
		}

		return sb.toString();
	}

	// 首字母大写，其它字符保持不变
	public static String UpperFirstKeepOthers(String str) {
		if (str.length() == 1) {
			return str.toUpperCase();
		}

		str = str.substring(0, 1).toUpperCase() + str.substring(1);
		return str;
	}
	
	// 首字母大写，其它字符转换成小写
	public static String UpperFirstLowerOthers(String str) {
		if (str.length() == 1) {
			return str.toUpperCase();
		}

		str = str.substring(0, 1).toUpperCase() + str.substring(1).toLowerCase();
		return str;
	}
	
	// 首字母小写，其它字符保持不变
	public static String LowerFirstKeepOthers(String str) {
		if (str.length() == 1) {
			return str.toLowerCase();
		}

		str = str.substring(0, 1).toLowerCase() + str.substring(1);
		return str;
	}
	
	// 首字母小写，其它字符转换成大写
	public static String LowerFirstUpperOthers(String str) {
		str = str.substring(0, 1).toLowerCase() + str.substring(1).toUpperCase();
		return str;
	}

	public static void main(String[] args) {
		// String rs = ColumnNameToJavaName(">>>" + " a_b cDEf_ELIE " + "<<<");
		// Logger.info(rs);

//		String rs = UpperFirstKeepOthers("aba");
//		Logger.info(rs);
		
		String rs = LowerFirstUpperOthers("A");
		Logger.info(rs);
	}
}
