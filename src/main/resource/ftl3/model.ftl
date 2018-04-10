<#include "common.ftl">

/**
* Author:${author}
*/
package ${modelPackage};

import java.math.BigDecimal;
import java.util.Date;

import com.krc.lottery.model.framework.ModelBase;

public class ${tableNamePojoNameMap[tableName]} extends ModelBase {

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