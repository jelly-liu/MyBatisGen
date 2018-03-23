<#include "common.ftl">

/**
* Author:${author}
*/
package ${mapperInterfacePackage};

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;
import ${modelPackage}.${tableNamePojoNameMap[tableName]};

@Mapper
@Repository
public interface ${tableNamePojoNameMap[tableName]}Mapper {
    public List<${tableNamePojoNameMap[tableName]}> selectBySelective(${tableNamePojoNameMap[tableName]} ${tableNamePojoNameMap[tableName]?uncap_first});
    public List<${tableNamePojoNameMap[tableName]}> selectBySelectivePage(${tableNamePojoNameMap[tableName]} ${tableNamePojoNameMap[tableName]?uncap_first});
    public Integer selectCountBySelective(${tableNamePojoNameMap[tableName]} ${tableNamePojoNameMap[tableName]?uncap_first});
    public ${tableNamePojoNameMap[tableName]} selectByPrimaryKey(String id);
    public void insert(${tableNamePojoNameMap[tableName]} ${tableNamePojoNameMap[tableName]?uncap_first});
    public void insertSelective(${tableNamePojoNameMap[tableName]} ${tableNamePojoNameMap[tableName]?uncap_first});
    public void updateByPrimaryKey(${tableNamePojoNameMap[tableName]} ${tableNamePojoNameMap[tableName]?uncap_first});
    public void updateSelective(${tableNamePojoNameMap[tableName]} ${tableNamePojoNameMap[tableName]?uncap_first});
    public void deleteByPrimaryKey(String pk);
    public void deleteSelective(${tableNamePojoNameMap[tableName]} ${tableNamePojoNameMap[tableName]?uncap_first});
}