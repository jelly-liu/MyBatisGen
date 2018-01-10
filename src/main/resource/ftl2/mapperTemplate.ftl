<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="ips.server.market.core.mapper.ApplyDateMapper">
    <sql id="Base_Column_List">
        id, summary_id, apply_date, create_time
    </sql>
    <select id="selectByPrimaryKey" parameterType="java.lang.String" resultMap="BaseResultMap">
        select
        <include refid="Base_Column_List" />
        from apply_date
        where id = #{id,jdbcType=VARCHAR}
    </select>
    <delete id="deleteByPrimaryKey" parameterType="java.lang.String">
        delete from apply_date
        where id = #{id,jdbcType=VARCHAR}
    </delete>
    <insert id="insert" parameterType="ips.server.market.core.domain.ApplyDate">
        insert into apply_date (id, summary_id, apply_date,
        create_time)
        values (#{id,jdbcType=VARCHAR}, #{summaryId,jdbcType=VARCHAR}, #{applyDate,jdbcType=DATE},
	#{createTime,jdbcType=TIMESTAMP})
    </insert>
    <insert id="insertSelective" parameterType="ips.server.market.core.domain.ApplyDate">
        insert into apply_date
        <trim prefix="(" suffix=")" suffixOverrides=",">
            <if test="id != null">
                id,
            </if>
            <if test="summaryId != null">
                summary_id,
            </if>
            <if test="applyDate != null">
                apply_date,
            </if>
            <if test="createTime != null">
                create_time,
            </if>
        </trim>
        <trim prefix="values (" suffix=")" suffixOverrides=",">
            <if test="id != null">
			#{id,jdbcType=VARCHAR},
            </if>
            <if test="summaryId != null">
			#{summaryId,jdbcType=VARCHAR},
            </if>
            <if test="applyDate != null">
			#{applyDate,jdbcType=DATE},
            </if>
            <if test="createTime != null">
			#{createTime,jdbcType=TIMESTAMP},
            </if>
        </trim>
    </insert>
    <update id="updateByPrimaryKeySelective" parameterType="ips.server.market.core.domain.ApplyDate">
        update apply_date
        <set>
            <if test="summaryId != null">
                summary_id = #{summaryId,jdbcType=VARCHAR},
            </if>
            <if test="applyDate != null">
                apply_date = #{applyDate,jdbcType=DATE},
            </if>
            <if test="createTime != null">
                create_time = #{createTime,jdbcType=TIMESTAMP},
            </if>
        </set>
        where id = #{id,jdbcType=VARCHAR}
    </update>
    <update id="updateByPrimaryKey" parameterType="ips.server.market.core.domain.ApplyDate">
        update apply_date
        set summary_id = #{summaryId,jdbcType=VARCHAR},
        apply_date = #{applyDate,jdbcType=DATE},
        create_time = #{createTime,jdbcType=TIMESTAMP}
        where id = #{id,jdbcType=VARCHAR}
    </update>
</mapper>