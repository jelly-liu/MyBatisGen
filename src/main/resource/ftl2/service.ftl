<#include "common.ftl">

/**
* Author:${author}
*/
package ${servicePackage};

import ${modelPackage}.${tableNamePojoNameMap[tableName]};

public interface ${tableNamePojoNameMap[tableName]}Service {
    <#--public Student selectByPrimaryKey(String id);-->
    public ${tableNamePojoNameMap[tableName]} selectByPrimaryKey(String id);
    public void insert(${tableNamePojoNameMap[tableName]} ${tableNamePojoNameMap[tableName]?uncap_first});
    public void insertSelective(${tableNamePojoNameMap[tableName]} ${tableNamePojoNameMap[tableName]?uncap_first});
    public void updateByPrimaryKeySelective(${tableNamePojoNameMap[tableName]} ${tableNamePojoNameMap[tableName]?uncap_first});
    public void updateByPrimaryKey(${tableNamePojoNameMap[tableName]} ${tableNamePojoNameMap[tableName]?uncap_first});
}