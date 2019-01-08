<#include "common.ftl">

/**
* Author:${author}
*/
package ${servicePackage}.impl;

<#assign PojoName = tableNamePojoNameMap[tableName] />
<#assign PojoNameUncapFirst = tableNamePojoNameMap[tableName]?uncap_first />

import ${modelPackage}.${PojoName};
import ${mapperInterfacePackage}.${PojoName}Mapper;
import ${servicePackage}.${PojoName}Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class ${PojoName}ServiceImpl implements ${PojoName}Service{
    <#-- 如果表有2个列做为联合主键，如user_id, role_id，则生成selectByPk和deleteByPk的方法签名会生成为：(Integer userId, Integer roleId) -->
    <#assign methodSignature = "" />
    <#assign methodParams = "" />
    <#if pksMap[tableName]?? && pksMap[tableName]?size != 0>
        <#list pksMap[tableName] as columnName>
            <#assign columnJavaType = columnJavaTypeMap[tableName + "|" + columnName] />
            <#assign columnJavaName = columnJavaNameMap[tableName + "|" + columnName] />

            <#if columnName_has_next>
                <#assign methodSignature = methodSignature + columnJavaType + " " + columnJavaName + ", "/>
                <#assign methodParams = methodParams + columnJavaName + ", "/>
            <#else>
                <#assign methodSignature = methodSignature + columnJavaType + " " + columnJavaName />
                <#assign methodParams = methodParams + columnJavaName/>
            </#if>
        </#list>
    </#if>

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
	public ${PojoName} selectByPk(${methodSignature}) {
        return ${PojoNameUncapFirst}Mapper.selectByPk(${methodParams});
	}

    public ${tableNamePojoNameMap[tableName]} selectOne(${tableNamePojoNameMap[tableName]} ${tableNamePojoNameMap[tableName]?uncap_first}){
        List<${tableNamePojoNameMap[tableName]}> list = ${PojoNameUncapFirst}Mapper.select(${tableNamePojoNameMap[tableName]?uncap_first});
        if(list == null || list.size() == 0){
            return null;
        }

        return list.get(0);
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
    public void deleteByPk(${methodSignature}){
        ${PojoNameUncapFirst}Mapper.deleteByPk(${methodParams});
    }

    @Override
    public void deleteByPojo(${tableNamePojoNameMap[tableName]} ${tableNamePojoNameMap[tableName]?uncap_first}){
        ${PojoNameUncapFirst}Mapper.deleteByPojo(${tableNamePojoNameMap[tableName]?uncap_first});
    }

}