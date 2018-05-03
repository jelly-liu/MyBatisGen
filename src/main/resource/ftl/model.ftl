<#include "common.ftl">

/**
* Author:${author}
*/
package ${modelPackage};

import java.math.BigDecimal;
import java.util.Date;

public class ${tableNamePojoNameMap[tableName]} {
	public static final String Insert = "${tableNamePojoNameMap[tableName]}.Insert";
	public static final String Update = "${tableNamePojoNameMap[tableName]}.Update";
	public static final String UpdateWithNull = "${tableNamePojoNameMap[tableName]}.UpdateWithNull";
	public static final String DeleteByPk = "${tableNamePojoNameMap[tableName]}.DeleteByPk";
	public static final String DeleteByPojo = "${tableNamePojoNameMap[tableName]}.DeleteByPojo";
	public static final String Select = "${tableNamePojoNameMap[tableName]}.Select";
	public static final String SelectCount = "${tableNamePojoNameMap[tableName]}.SelectCount";
	public static final String SelectByPk = "${tableNamePojoNameMap[tableName]}.SelectByPk";
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