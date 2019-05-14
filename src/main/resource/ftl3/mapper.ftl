<#include "common.ftl">
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<!-- author:${author} -->

<#-- JavaBean类名 -->
<#assign pojoName = tableNamePojoNameMap[tableName] />
<#-- JavaBean全名(包名+类名) -->
<#assign pojoCanonicalName = modelPackage + "." + pojoName />

<mapper namespace="${mapperInterfacePackage}.${tableNamePojoNameMap[tableName]}Mapper">
    <!-- 生成Insert -->
	<#if pksMap[tableName]??><#-- 该表有主键 -->
        <#if (pksMap[tableName]?size == 1)><#-- 该表有主键，且是单列主键 -->
        	<insert id="insert" useGeneratedKeys="true" keyProperty="${pksMap[tableName][0]}" parameterType="${pojoCanonicalName}">
        <#elseif (pksMap[tableName]?size > 1)><#-- 该表有主键，且是联合主键 -->
			<!-- 该表有联合主键，不能用useGeneratedKeys和keyProperty返回主键 -->
        	<insert id="insert" parameterType="${pojoCanonicalName}">
        </#if>
    <#else><#-- 该表无主键 -->
    <insert id="insert" parameterType="${pojoCanonicalName}">
    </#if>
    insert into ${tableName} (
    <trim suffixOverrides=",">
					<#list columnNames as columnName>
						<#assign columnJavaType = columnJavaTypeMap[tableName + "|" + columnName] />
						<#assign columnJavaName = columnJavaNameMap[tableName + "|" + columnName] />
						<#if (columnJavaType == 'String')>
                            <if test="${columnJavaName} != null and ${columnJavaName} != ''">
                                ${columnName},
                            </if>
                        <#else>
                            <if test="${columnJavaName} != null">
                                ${columnName},
                            </if>
                        </#if>

                    </#list>
    </trim>
    ) values (
    <trim suffixOverrides=",">
					<#list columnNames as columnName>
						<#assign columnJavaType = columnJavaTypeMap[tableName + "|" + columnName] />
						<#assign columnJavaName = columnJavaNameMap[tableName + "|" + columnName] />
						<#if (columnJavaType == 'String')>
                            <if test="${columnJavaName} != null and ${columnJavaName} != ''">
                                #${r"{"}${columnJavaName}${r"}"},
                            </if>
                        <#else>
                            <if test="${columnJavaName} != null">
                                #${r"{"}${columnJavaName}${r"}"},
                            </if>
                        </#if>
                    </#list>
    </trim>
    )
</insert>

    <!-- 生成Update -->
    <!-- 注意调用该SQL前必须检查参数的正确性，否则可能会误更新 -->
	<#if pksMap[tableName]??><#-- 该表有主键 -->
	<update id="update" parameterType="${pojoCanonicalName}">
        update ${tableName} set
        <trim suffixOverrides=",">
			<#list columnNames as columnName>
                <#assign columnJavaType = columnJavaTypeMap[tableName + "|" + columnName] />
				<#assign columnJavaName = columnJavaNameMap[tableName + "|" + columnName] />
                <#if (columnJavaType == 'String')>
                    <if test="${columnJavaName} != null and ${columnJavaName} != ''">
                        ${columnName} = #${r"{"}${columnJavaName}${r"}"},
                    </if>
                <#else>
                    <if test="${columnJavaName} != null">
                        ${columnName} = #${r"{"}${columnJavaName}${r"}"},
                    </if>
                </#if>
            </#list>
        </trim>
        where
        <#list pksMap[tableName] as columnName>
            <#assign columnJavaName = columnJavaNameMap[tableName + "|" + columnName] />
            <#if (columnJavaType == 'String')>
                <if test="${columnJavaName} != null and ${columnJavaName} != ''">
                    ${columnName} = #${r"{"}${columnJavaName}${r"}"}
                </if>
            <#else>
                <if test="${columnJavaName} != null">
                    ${columnName} = #${r"{"}${columnJavaName}${r"}"}
                </if>
            </#if>
            <#if columnName_has_next>and</#if>
        </#list>
    </update>
    </#if>

    <!-- 生成Update -->
    <!-- 注意调用该SQL前必须检查参数的正确性，否则可能会误更新 -->
    <#if pksMap[tableName]??><#-- 该表有主键 -->
        <update id="updateWithVersion" parameterType="${pojoCanonicalName}">
            update ${tableName} set
            <trim prefixOverrides="," suffixOverrides=",">
                <#list columnNames as columnName>
                    <#assign columnJavaType = columnJavaTypeMap[tableName + "|" + columnName] />
                    <#assign columnJavaName = columnJavaNameMap[tableName + "|" + columnName] />
                    <#if (columnJavaType == 'String')>
                        <if test="${columnJavaName} != null and ${columnJavaName} != ''">
                            ${columnName} = #${r"{"}${columnJavaName}${r"}"},
                        </if>
                    <#else>
                        <if test="${columnJavaName} != null and ${columnJavaName?lower_case} != 'version'">
                            ${columnName} = #${r"{"}${columnJavaName}${r"}"},
                        </if>
                    </#if>
                </#list>
                , version = version + 1
            </trim>

            where
            <trim prefixOverrides="," suffixOverrides=",">
                <#list pksMap[tableName] as columnName>
                    <#assign columnJavaName = columnJavaNameMap[tableName + "|" + columnName] />
                    <#if (columnJavaType == 'String')>
                        <if test="${columnJavaName} != null and ${columnJavaName} != ''">
                            ${columnName} = #${r"{"}${columnJavaName}${r"}"}
                        </if>
                    <#else>
                        <if test="${columnJavaName} != null">
                            ${columnName} = #${r"{"}${columnJavaName}${r"}"}
                        </if>
                    </#if>
                    <#if columnName_has_next>and</#if>
                </#list>
                and version = #${r"{version}"}
            </trim>
        </update>
    </#if>

    <!-- 生成UpdateWithNull -->
    <!-- 注意调用该SQL前必须先根据主键查询出该记录所有列数据，再设置某列为null -->
	<#if pksMap[tableName]??><#-- 该表有主键 -->
    <update id="updateWithNull" parameterType="${pojoCanonicalName}">
        update ${tableName} set
        <trim suffixOverrides=",">
		<#list columnNames as columnName>
			<#assign columnJavaName = columnJavaNameMap[tableName + "|" + columnName] />
            ${columnName} = #${r"{"}${columnJavaName}${r"}"},
        </#list>
        </trim>
        where
		<#list pksMap[tableName] as columnName>
            <#assign columnJavaName = columnJavaNameMap[tableName + "|" + columnName] />
            ${columnName} = #${r"{"}${columnJavaName}${r"}"}
            <#if columnName_has_next>and</#if>
        </#list>
    </update>
    </#if>

    <!-- 根据表的主键生成Delete -->
	<#if pksMap[tableName]??><#-- 该表有主键 -->
        <#if (pksMap[tableName]?size == 1)><#-- 该表有主键，且是单列主键 -->
            <#assign parameterType = "java.io.Serializable" />
        <#elseif (pksMap[tableName]?size > 1)><#-- 该表有主键，且是联合主键 -->
            <#assign parameterType = pojoCanonicalName />
        </#if>
		<delete id="deleteByPk" parameterType="${parameterType}">
			<#if (pksMap[tableName]?size > 1)><!-- 请注意，该表是联合主键 --></#if>
            delete
            from ${tableName}
            where
			<#list pksMap[tableName] as columnName>
                <#assign columnJavaName = columnJavaNameMap[tableName + "|" + columnName] />
                ${columnName} = #${r"{"}${columnJavaName}${r"}"}
                <#if columnName_has_next>and</#if>
            </#list>
        </delete>
    </#if>
    <!-- 注意调用该SQL前必须检查参数的正确性，否则可能会误删除 -->
    <delete id="delete" parameterType="${pojoCanonicalName}">
        <!-- 请注意，该表没有主键 -->
        delete
        from ${tableName}
        where
        <trim suffixOverrides="and">
		<#list columnNames as columnName>
			<#assign columnJavaType = columnJavaTypeMap[tableName + "|" + columnName] />
			<#assign columnJavaName = columnJavaNameMap[tableName + "|" + columnName] />
			<#if (columnJavaType == 'String')>
                <if test="${columnJavaName} != null and ${columnJavaName} != ''">
                    ${columnName} = #${r"{"}${columnJavaName}${r"}"} and
                </if>
            <#else>
                <if test="${columnJavaName} != null">
                    ${columnName} = #${r"{"}${columnJavaName}${r"}"} and
                </if>
            </#if>
        </#list>
        </trim>
    </delete>

    <!-- 生成Select通用表头 -->
    <sql id="selectColumns">
        <trim suffixOverrides=",">
			<#list columnNames as columnName>
				<#assign columnJavaName = columnJavaNameMap[tableName + "|" + columnName] />
                ${columnName} as "${columnJavaName}",
            </#list>
        </trim>
    </sql>

    <!-- 生成Select通用查询条件 -->
    <sql id="selectWheres">
		<#list columnNames as columnName>
			<#assign columnJavaType = columnJavaTypeMap[tableName + "|" + columnName] />
			<#assign columnJavaName = columnJavaNameMap[tableName + "|" + columnName] />
			<#if (columnJavaType == 'String')>
                <if test="${columnJavaName} != null and ${columnJavaName} != ''">
                    <choose>
                        <when test="likeSqlColumnSet != null and '${columnJavaName}' in likeSqlColumnSet">
                            and ${columnName} like '%$${r"{"}${columnJavaName}${r"}"}%'
                        </when>
                        <otherwise>
                            and ${columnName} = #${r"{"}${columnJavaName}${r"}"}
                        </otherwise>
                    </choose>
                </if>
            <#else>
                <if test="${columnJavaName} != null">
                    and ${columnName} = #${r"{"}${columnJavaName}${r"}"}
                </if>
            </#if>
        </#list>
    </sql>

    <sql id="selectOrderBy">
        <if test="sortConditionSet != null and sortConditionSet.size() > 0">
            order by
            <trim suffixOverrides=",">
                <foreach collection="sortConditionSet" item="item">
                ${r"${item.colName}"} ${r"${item.sort}"},
                </foreach>
            </trim>
        </if>
    </sql>

    <!-- 生成Select -->
    <select id="select" parameterType="${pojoCanonicalName}" resultType="${pojoCanonicalName}">
        select
        <include refid="selectColumns"/>
        from ${tableName}
        where 1 = 1
        <include refid="selectWheres"/>
        <include refid="selectOrderBy"/>
    </select>

    <!-- 生成Select -->
    <select id="selectPage" parameterType="${pojoCanonicalName}" resultType="${pojoCanonicalName}">
        select
        <include refid="selectColumns"/>
        from ${tableName}
        where 1 = 1
        <include refid="selectWheres"/>
        <include refid="selectOrderBy"/>
        limit ${r"#{offset}"},${r"#{length}"}
    </select>

    <!-- 生成SelectCount -->
    <select id="selectCount" parameterType="${pojoCanonicalName}" resultType="Integer">
        select count(*) ct
        from ${tableName}
        <where>
            <include refid="selectWheres"/>
        </where>
    </select>

    <!-- 根据表的主键生成SelectByPk，该表只有单列主键 -->
	<#if pksMap[tableName]?? && pksMap[tableName]?size == 1>
	<select id="selectByPk" parameterType="java.io.Serializable" resultType="${pojoCanonicalName}">
        select
        <include refid="selectColumns"/>
        from ${tableName}
        where
		<#list pksMap[tableName] as columnName>
            <#assign columnJavaName = columnJavaNameMap[tableName + "|" + columnName] />
            ${columnName} = #${r"{"}${columnJavaName}${r"}"}
            <#if columnName_has_next>and</#if>
        </#list>
    </select>
    </#if>

    <select id="selectOne" parameterType="${pojoCanonicalName}" resultType="${pojoCanonicalName}">
        select
        <include refid="selectColumns"/>
        from ${tableName}
        where 1 = 1
        <include refid="selectWheres"/>
        limit 1
    </select>

    <select id="selectAll" resultType="${pojoCanonicalName}">
        select
        <include refid="selectColumns"/>
        from ${tableName}
    </select>
</mapper>