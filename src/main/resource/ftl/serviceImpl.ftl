<#include "common.ftl">

/**
* Author:${author}
*/
package ${servicePackage}.impl;

<#assign PojoName = tableNamePojoNameMap[tableName] />
<#assign PojoNameUncapFirst = tableNamePojoNameMap[tableName]?uncap_first />

import ${modelPackage}.${PojoName};
import ${servicePackage}.${PojoName}Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ${PojoName}ServiceImpl implements ${PojoName}Service{
	@Autowired
    private ${daoPackage}.BaseDao baseDao;

	@Override
	public void insert(${PojoName} ${PojoNameUncapFirst}) {
		baseDao.myInsert(${PojoName}.Insert, ${PojoNameUncapFirst});
	}

	@Override
	public void update(${PojoName} ${PojoNameUncapFirst}) {
        baseDao.myUpdate(${PojoName}.Update, ${PojoNameUncapFirst});
	}

	@Override
	public void UpdateWithNull(${PojoName} ${PojoNameUncapFirst}) {
        baseDao.myUpdate(${PojoName}.UpdateWithNull, ${PojoNameUncapFirst});
	}

	@Override
	public void DeleteByPk(String pk) {
        baseDao.myDelete(${PojoName}.DeleteByPk, pk);
	}

	@Override
	public void DeleteByPojo(${PojoName} ${PojoNameUncapFirst}) {
        baseDao.myDelete(${PojoName}.DeleteByPojo, ${PojoNameUncapFirst});
	}

    @Override
	public List<${PojoName}> select(${PojoName} ${PojoNameUncapFirst}) {
        return baseDao.mySelectList(${PojoName}.Select, ${PojoNameUncapFirst});
	}

    @Override
	public Long SelectCount(${PojoName} ${PojoNameUncapFirst}) {
        return baseDao.mySelectOne(${PojoName}.SelectCount, ${PojoNameUncapFirst});
	}

	@Override
	public ${PojoName} selectByPrimaryKey(String pk) {
        return baseDao.mySelectOne(${PojoName}.SelectByPk, pk);
	}

}