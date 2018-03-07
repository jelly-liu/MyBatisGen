<#include "common.ftl">

/**
* Author:${author}
*/
package ${daoPackage}.impl;

<#assign PojoName = tableNamePojoNameMap[tableName] />
<#assign PojoNameUncapFirst = tableNamePojoNameMap[tableName]?uncap_first />

import ${modelPackage}.${PojoName};
import ${mapperPackage}.${PojoName}Mapper;
import ${daoPackage}.${PojoName}Dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;



@Repository
public class ${PojoName}DaoImpl implements ${PojoName}Dao{
	@Autowired
    private ${PojoName}Mapper ${PojoNameUncapFirst}Mapper;

	@Override
	public ${PojoName} selectByPrimaryKey(String id) {
        return ${PojoNameUncapFirst}Mapper.selectByPrimaryKey(id);
	}

	@Override
	public void insert(${PojoName} ${PojoNameUncapFirst}) {
            ${PojoNameUncapFirst}Mapper.insert(${PojoNameUncapFirst});
	}

	@Override
	public void insertSelective(${PojoName} ${PojoNameUncapFirst}) {
        ${PojoNameUncapFirst}Mapper.insertSelective(${PojoNameUncapFirst});
	}

	@Override
	public void updateByPrimaryKeySelective(${PojoName} ${PojoNameUncapFirst}) {
        ${PojoNameUncapFirst}Mapper.updateByPrimaryKeySelective(${PojoNameUncapFirst});
	}

	@Override
	public void updateByPrimaryKey(${PojoName} ${PojoNameUncapFirst}) {
        ${PojoNameUncapFirst}Mapper.updateByPrimaryKey(${PojoNameUncapFirst});
	}

}