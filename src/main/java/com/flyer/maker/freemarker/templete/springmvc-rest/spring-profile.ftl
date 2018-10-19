<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:context="http://www.springframework.org/schema/context"
       xsi:schemaLocation="http://www.springframework.org/schema/context
        http://www.springframework.org/schema/context/spring-context.xsd
        http://www.springframework.org/schema/beans
        http://www.springframework.org/schema/beans/spring-beans.xsd">
    <beans profile="default,dev">
        <context:property-placeholder location="classpath*:dev/*.properties"/>
    </beans>
    <beans profile="test">
        <context:property-placeholder location="classpath*:test/*.properties"/>
    </beans>
    <beans profile="stage">
        <context:property-placeholder location="classpath*:stage/*.properties"/>
    </beans>
    <beans profile="prod">
        <context:property-placeholder location="classpath*:prod/*.properties"/>
    </beans>
    <beans profile="ut">
        <context:property-placeholder location="classpath*:*.properties"/>
    </beans>
</beans>
