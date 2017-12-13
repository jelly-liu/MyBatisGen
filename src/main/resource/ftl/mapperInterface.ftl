<#include "common.ftl">

/**
* Author:${author}
*/
package ${mapperInterfacePackage};

import org.apache.ibatis.annotations.Mapper;
import ${modelPackage}.${tableNamePojoNameMap[tableName]};

public interface ${tableNamePojoNameMap[tableName]}Mapper {
<#--public Student selectByPrimaryKey(String id);-->
    public ${tableNamePojoNameMap[tableName]} selectByPrimaryKey(String id);
    public void insert(${tableNamePojoNameMap[tableName]} ${tableNamePojoNameMap[tableName]?uncap_first});
    public void insertSelective(${tableNamePojoNameMap[tableName]} ${tableNamePojoNameMap[tableName]?uncap_first});
    public void updateByPrimaryKeySelective(${tableNamePojoNameMap[tableName]} ${tableNamePojoNameMap[tableName]?uncap_first});
    public void updateByPrimaryKey(${tableNamePojoNameMap[tableName]} ${tableNamePojoNameMap[tableName]?uncap_first});
}