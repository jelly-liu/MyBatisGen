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

	public List<${tableNamePojoNameMap[tableName]}> selectBySelective(${tableNamePojoNameMap[tableName]} ${tableNamePojoNameMap[tableName]?uncap_first}){
		return ${PojoNameUncapFirst}Mapper.selectBySelective(${tableNamePojoNameMap[tableName]?uncap_first});
	}

    public List<${tableNamePojoNameMap[tableName]}> selectBySelectivePage(${tableNamePojoNameMap[tableName]} ${tableNamePojoNameMap[tableName]?uncap_first}){
        return ${PojoNameUncapFirst}Mapper.selectBySelectivePage(${tableNamePojoNameMap[tableName]?uncap_first});
    }

	public Integer selectCountBySelective(${tableNamePojoNameMap[tableName]} ${tableNamePojoNameMap[tableName]?uncap_first}){
		return ${PojoNameUncapFirst}Mapper.selectCountBySelective(${tableNamePojoNameMap[tableName]?uncap_first});
	}

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
    public void updateByPrimaryKey(${PojoName} ${PojoNameUncapFirst}) {
        ${PojoNameUncapFirst}Mapper.updateByPrimaryKey(${PojoNameUncapFirst});
    }

	@Override
	public void updateSelective(${PojoName} ${PojoNameUncapFirst}) {
        ${PojoNameUncapFirst}Mapper.updateSelective(${PojoNameUncapFirst});
	}

    @Override
    public void deleteByPrimaryKey(String pk){
        ${PojoNameUncapFirst}Mapper.deleteByPrimaryKey(pk);
    }

    @Override
    public void deleteSelective(${tableNamePojoNameMap[tableName]} ${tableNamePojoNameMap[tableName]?uncap_first}){
        ${PojoNameUncapFirst}Mapper.deleteSelective(${tableNamePojoNameMap[tableName]?uncap_first});
    }

}