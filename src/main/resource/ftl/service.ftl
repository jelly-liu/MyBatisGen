<#include "common.ftl">

/**
* Author:${author}
*/
package ${servicePackage};

import ${modelPackage}.${tableNamePojoNameMap[tableName]};
import org.apache.ibatis.session.RowBounds;

import java.util.List;

public interface ${tableNamePojoNameMap[tableName]}Service {
    <#--public Student selectByPrimaryKey(String id);-->
    public int insert(${tableNamePojoNameMap[tableName]} ${tableNamePojoNameMap[tableName]?uncap_first});
    public int update(${tableNamePojoNameMap[tableName]} ${tableNamePojoNameMap[tableName]?uncap_first});
    public int updateWithNull(${tableNamePojoNameMap[tableName]} ${tableNamePojoNameMap[tableName]?uncap_first});
    public int deleteByPk(String pk);
    public int deleteByPojo(${tableNamePojoNameMap[tableName]} ${tableNamePojoNameMap[tableName]?uncap_first});
    public List<${tableNamePojoNameMap[tableName]}> select(${tableNamePojoNameMap[tableName]} ${tableNamePojoNameMap[tableName]?uncap_first});
    public List<${tableNamePojoNameMap[tableName]}> selectPage(${tableNamePojoNameMap[tableName]} ${tableNamePojoNameMap[tableName]?uncap_first}, RowBounds rowBounds);
    public ${tableNamePojoNameMap[tableName]} selectOne(${tableNamePojoNameMap[tableName]} ${tableNamePojoNameMap[tableName]?uncap_first});
    public Long selectCount(${tableNamePojoNameMap[tableName]} ${tableNamePojoNameMap[tableName]?uncap_first});
    public ${tableNamePojoNameMap[tableName]} selectByPrimaryKey(String pk);
}