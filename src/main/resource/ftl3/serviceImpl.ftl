<#include "common.ftl">

/**
* Author:${author}
*/
package ${servicePackage}.impl;

<#assign PojoName = tableNamePojoNameMap[tableName] />
<#assign PojoNameUncapFirst = tableNamePojoNameMap[tableName]?uncap_first />

import ${modelPackage}.${PojoName};
import ${mapperPackage}.${PojoName}Mapper;
import ${servicePackage}.${PojoName}Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class ${PojoName}ServiceImpl implements ${PojoName}Service{
	@Autowired
    private ${PojoName}Mapper ${PojoNameUncapFirst}Mapper;

	public List<${tableNamePojoNameMap[tableName]}> select(${tableNamePojoNameMap[tableName]} ${tableNamePojoNameMap[tableName]?uncap_first}){
		return ${PojoNameUncapFirst}Mapper.select(${tableNamePojoNameMap[tableName]?uncap_first});
	}

    public List<${tableNamePojoNameMap[tableName]}> selectPage(${tableNamePojoNameMap[tableName]} ${tableNamePojoNameMap[tableName]?uncap_first}){
        return ${PojoNameUncapFirst}Mapper.selectPage(${tableNamePojoNameMap[tableName]?uncap_first});
    }

	public Integer selectCount(${tableNamePojoNameMap[tableName]} ${tableNamePojoNameMap[tableName]?uncap_first}){
		return ${PojoNameUncapFirst}Mapper.selectCount(${tableNamePojoNameMap[tableName]?uncap_first});
	}

	@Override
	public ${PojoName} selectByPk(String id) {
        return ${PojoNameUncapFirst}Mapper.selectByPk(id);
	}

	@Override
	public void insert(${PojoName} ${PojoNameUncapFirst}) {
            ${PojoNameUncapFirst}Mapper.insert(${PojoNameUncapFirst});
	}

    @Override
    public void update(${PojoName} ${PojoNameUncapFirst}) {
        ${PojoNameUncapFirst}Mapper.update(${PojoNameUncapFirst});
    }

	@Override
	public void updateWithNull(${PojoName} ${PojoNameUncapFirst}) {
        ${PojoNameUncapFirst}Mapper.updateWithNull(${PojoNameUncapFirst});
	}

    @Override
    public void deleteByPk(String pk){
        ${PojoNameUncapFirst}Mapper.deleteByPk(pk);
    }

    @Override
    public void deleteByPojo(${tableNamePojoNameMap[tableName]} ${tableNamePojoNameMap[tableName]?uncap_first}){
        ${PojoNameUncapFirst}Mapper.deleteByPojo(${tableNamePojoNameMap[tableName]?uncap_first});
    }

}