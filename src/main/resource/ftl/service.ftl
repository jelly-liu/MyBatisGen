<#include "common.ftl">

/**
* Author:${author}
*/
package ${servicePackage};

import ${modelPackage}.${tableNamePojoNameMap[tableName]};

import java.util.List;

public interface ${tableNamePojoNameMap[tableName]}Service {
    <#--public Student selectByPrimaryKey(String id);-->
    public void insert(${tableNamePojoNameMap[tableName]} ${tableNamePojoNameMap[tableName]?uncap_first});
    public void update(${tableNamePojoNameMap[tableName]} ${tableNamePojoNameMap[tableName]?uncap_first});
    public void updateWithNull(${tableNamePojoNameMap[tableName]} ${tableNamePojoNameMap[tableName]?uncap_first});
    public void deleteByPk(String pk);
    public void deleteByPojo(${tableNamePojoNameMap[tableName]} ${tableNamePojoNameMap[tableName]?uncap_first});
    public List<${tableNamePojoNameMap[tableName]}> select(${tableNamePojoNameMap[tableName]} ${tableNamePojoNameMap[tableName]?uncap_first});
    public ${tableNamePojoNameMap[tableName]} selectOne(${tableNamePojoNameMap[tableName]} ${tableNamePojoNameMap[tableName]?uncap_first});
    public Long SelectCount(${tableNamePojoNameMap[tableName]} ${tableNamePojoNameMap[tableName]?uncap_first});
    public ${tableNamePojoNameMap[tableName]} selectByPrimaryKey(String pk);
}