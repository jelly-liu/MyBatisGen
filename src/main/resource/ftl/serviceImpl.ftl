<#include "common.ftl">

/**
* Author:${author}
*/
package ${servicePackage}.impl;

<#assign PojoName = tableNamePojoNameMap[tableName] />
<#assign PojoNameUncapFirst = tableNamePojoNameMap[tableName]?uncap_first />

import ${modelPackage}.${PojoName};
import ${servicePackage}.${PojoName}Service;
import ${daoPackage}.BaseDao;
import org.apache.ibatis.session.RowBounds;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ${PojoName}ServiceImpl implements ${PojoName}Service{
	@Autowired
    private BaseDao baseDao;

	@Override
	public int insert(${PojoName} ${PojoNameUncapFirst}) {
		return baseDao.myInsert(${PojoName}.Insert, ${PojoNameUncapFirst});
	}

	@Override
	public int update(${PojoName} ${PojoNameUncapFirst}) {
        return baseDao.myUpdate(${PojoName}.Update, ${PojoNameUncapFirst});
	}

	@Override
	public int updateWithNull(${PojoName} ${PojoNameUncapFirst}) {
        return baseDao.myUpdate(${PojoName}.UpdateWithNull, ${PojoNameUncapFirst});
	}

	@Override
	public int deleteByPk(String pk) {
       return baseDao.myDelete(${PojoName}.DeleteByPk, pk);
	}

	@Override
	public int deleteByPojo(${PojoName} ${PojoNameUncapFirst}) {
        return baseDao.myDelete(${PojoName}.DeleteByPojo, ${PojoNameUncapFirst});
	}

    @Override
	public List<${PojoName}> select(${PojoName} ${PojoNameUncapFirst}) {
        return baseDao.mySelectList(${PojoName}.Select, ${PojoNameUncapFirst});
	}

	@Override
	public List<${PojoName}> selectPage(${PojoName} ${PojoNameUncapFirst}, RowBounds rowBounds) {
        return baseDao.mySelectListPage(${PojoName}.Select, ${PojoNameUncapFirst}, rowBounds);
	}

	@Override
	public ${PojoName} selectOne(${PojoName} ${PojoNameUncapFirst}) {
        List<${PojoName}> list = baseDao.mySelectList(${PojoName}.Select, ${PojoNameUncapFirst});
        if(list == null || list.size() == 0){
            return null;
        }
        return list.get(0);
	}

    @Override
	public Long selectCount(${PojoName} ${PojoNameUncapFirst}) {
        return baseDao.mySelectOne(${PojoName}.SelectCount, ${PojoNameUncapFirst});
	}

	@Override
	public ${PojoName} selectByPrimaryKey(String pk) {
        return baseDao.mySelectOne(${PojoName}.SelectByPk, pk);
	}

}