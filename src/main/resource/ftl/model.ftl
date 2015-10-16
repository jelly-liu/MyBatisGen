<#include "common.ftl">

/**
* Author:${author}
*/
package ${modelPackage};

import java.math.BigDecimal;
import java.util.Date;

public class ${tableNamePojoNameMap[tableName]} {
	public static final String Insert = "${modelPackage}.${tableNamePojoNameMap[tableName]}.Insert";
	public static final String Update = "${modelPackage}.${tableNamePojoNameMap[tableName]}.Update";
	public static final String UpdateWithNull = "${modelPackage}.${tableNamePojoNameMap[tableName]}.UpdateWithNull";
	public static final String DeleteByPk = "${modelPackage}.${tableNamePojoNameMap[tableName]}.DeleteByPk";
	public static final String DeleteByPojo = "${modelPackage}.${tableNamePojoNameMap[tableName]}.DeleteByPojo";
	public static final String Select = "${modelPackage}.${tableNamePojoNameMap[tableName]}.Select";
	public static final String SelectCount = "${modelPackage}.${tableNamePojoNameMap[tableName]}.SelectCount";
	public static final String SelectByPk = "${modelPackage}.${tableNamePojoNameMap[tableName]}.SelectByPk";
<#list columnNames as columnName>
	<#assign columnJavaType = columnJavaTypeMap[tableName + "|" + columnName] />
	<#assign columnJavaName = columnJavaNameMap[tableName + "|" + columnName] />
	
	private ${columnJavaType} ${columnJavaName};
</#list>

<#list columnNames as columnName>
	<#assign columnJavaType=columnJavaTypeMap[tableName + "|" + columnName] />
	<#assign columnJavaName=columnJavaNameMap[tableName + "|" + columnName] />

	public ${tableNamePojoNameMap[tableName]} set${columnJavaName?cap_first} (${columnJavaType} ${columnJavaName}) ${r"{"}
		this.${columnJavaName} ${r"="} ${columnJavaName};
		return this;
	${r"}"}
	
	public ${columnJavaType} get${columnJavaName?cap_first} () ${r"{"}
		return this.${columnJavaName};
	${r"}"}
</#list>

}