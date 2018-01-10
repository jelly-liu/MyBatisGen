<#include "common.ftl">

/**
* Author:${author}
*/
package ${servicePackage}.impl;

<#assign PojoName = tableNamePojoNameMap[tableName] />
<#assign PojoNameUncapFirst = tableNamePojoNameMap[tableName]?uncap_first />

import ${modelPackage}.${PojoName};
import ${daoPackage}.${PojoName}Dao;
import ${servicePackage}.${PojoName}Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;



@Repository
public class ${PojoName}ServiceImpl implements ${PojoName}Service{
	@Autowired
    private ${PojoName}Dao ${PojoNameUncapFirst}Dao;

	@Override
	public ${PojoName} selectByPrimaryKey(String id) {
        return ${PojoNameUncapFirst}Dao.selectByPrimaryKey(id);
	}

	@Override
	public void insert(${PojoName} ${PojoNameUncapFirst}) {
            ${PojoNameUncapFirst}Dao.insert(${PojoNameUncapFirst});
	}

	@Override
	public void insertSelective(${PojoName} ${PojoNameUncapFirst}) {
        ${PojoNameUncapFirst}Dao.insertSelective(${PojoNameUncapFirst});
	}

	@Override
	public void updateByPrimaryKeySelective(${PojoName} ${PojoNameUncapFirst}) {
        ${PojoNameUncapFirst}Dao.updateByPrimaryKeySelective(${PojoNameUncapFirst});
	}

	@Override
	public void updateByPrimaryKey(${PojoName} ${PojoNameUncapFirst}) {
        ${PojoNameUncapFirst}Dao.updateByPrimaryKey(${PojoNameUncapFirst});
	}

}