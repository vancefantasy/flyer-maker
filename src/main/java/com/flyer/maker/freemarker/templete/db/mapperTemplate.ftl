<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//ibatis.apache.org//DTD Mapper 3.0//EN"
		"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${projectPackage}.dao.${clazz.bclassName}Dao">
	<resultMap id="${clazz.className}Map" type="${projectPackage}.domain.${clazz.bclassName}">
		<id column="id" property="id" />
		<#list clazz.tablefieldList as field>
			<result column="${field.tname}" property="${field.name}" />
		</#list>
	</resultMap>
	<sql id ="${clazz.className}Column">
		<trim suffix="" suffixOverrides=",">
			<#list clazz.tablefieldList as field>
			<if test="${field.name} != null">${field.tname},</if>
			</#list>
		</trim>
	</sql>
	<sql id="${clazz.className}Value">
		<trim suffix="" suffixOverrides=",">
			<#list clazz.tablefieldList as field>
			<if test="${field.name} != null">${r"#"}{${field.name}},</if>
			</#list>
		</trim>
	</sql>
	 <sql id="${clazz.className}BaseColumn">
	 	<trim suffix="" suffixOverrides=",">
			<#list clazz.tablefieldList as field>
				${field.tname},
			</#list>
		</trim>
    </sql>
	<insert id="save${clazz.bclassName}" parameterType="${projectPackage}.domain.${clazz.bclassName}"
			useGeneratedKeys="true" keyProperty="id">
		<selectKey resultType="${clazz.idType}" keyProperty="id" order="AFTER">
			SELECT LAST_INSERT_ID()
		</selectKey>
		insert into ${clazz.tableName} (<include refid="${clazz.className}Column"/>)
		values (<include refid="${clazz.className}Value"/>)
	</insert>
	<update id="update${clazz.bclassName}" parameterType="${projectPackage}.domain.${clazz.bclassName}">
	 	update ${clazz.tableName}
		<set>
			<#list clazz.insertfieldList as field>
			<if test="${field.name} != null">${field.tname}=${r"#"}{${field.name}}<#if field_has_next>,</#if></if>
			</#list>
		</set>
		where id = ${r"#"}{id}
	</update>
	<delete id="remove${clazz.bclassName}" parameterType="java.lang.${clazz.idType}">
    	delete from ${clazz.tableName}
    	where id = ${r"#"}{id}
    </delete>
    <select id="find${clazz.bclassName}ById" parameterType="java.lang.${clazz.idType}" resultMap="${clazz.className}Map">
		select
		<include refid="${clazz.className}BaseColumn"/>
		from ${clazz.tableName}
		where id = ${r"#"}{id}
    </select>
</mapper>
