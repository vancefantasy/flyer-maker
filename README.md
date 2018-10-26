[![License](https://img.shields.io/github/license/vancefantasy/flyer-maker.svg)](https://github.com/vancefantasy/flyer-maker/blob/master/LICENSE)

# flyermaker是什么?
flyermaker是一个Java项目的脚手架工具，支持SpringBoot和SpringFramework，它允许动态生成工程代码和单元测试，同时尝试提供工程搭建、个别场景实现的最佳实践参考，让开发人员在短时间构建易维护、生产可用的服务。
flyermaker的灵感来自于[SPRING INITIALIZR](https://start.spring.io/)和[MyBatis Generator](https://github.com/mybatis/generator)。

# 集成环境
- Java 8
- SpringBoot2.0.5/SpringFramework4.3.18
- mapper、entity、dao、service、controller及对应单元测试
- 第三方工具(guava,jodd,vjkit,apache commons等)，满足缓存(内存)、字符串、日期、json、集合、Http、IO等的日常处理
- 异常处理
- 全局拦截器，记录请求响应日志
- SLF4J/Logback
- 单元测试、Mock测试

# flyermaker使用指南

> **注意:flyermaker当前版本要求数据库表有自增主键，且主键名必须为'id'**

> Windows用户参考[这里](https://github.com/vancefantasy/flyer-maker/issues/4)

1. 下载[最新版本](https://github.com/vancefantasy/flyer-maker/releases)并解压

        unzip flyermaker-0.0.1.zip //zip
        tar zxvf flyermaker-0.0.1.tar.gz //tar

2. 修改配置文件

    编辑application.properties文件

3. 命令行运行

        flyermaker -f application.properties

### 配置文件参考

字段       |名称       |是否必须   |默认值  |备注
----------|----------|-------|-----------|-----------
author       |作者|否        |flyermaker|例如：vance
target.dir       |目标目录|否        |当前目录|例如：/tmp/flyermaker
project.type       |项目类型|是        |-|可选springmvc-rest,springboot-rest,springmvc-page,springboot-page
project.groupId       |Maven groupId|是        |-|例如:com.flyer
project.artifactId       |Maven artifactId|是        |-|例如：flyer-springboot-rest
project.package       |包路径|是        |-|例如：com.flyer.springmvc.rest
mysql.jdbc.url       |jdbc url|是        |-|例如：jdbc:mysql://localhost:3306/flyer?useUnicode=true&characterEncoding=utf-8&useSSL=false
mysql.username       |mysql username|是        |-|例如：flyer_w
mysql.password       |mysql password|是        |-|例如：123456
mysql.table.include       |表白名单|否        |空|多个以逗号分割，例如：user,order,t2
mysql.table.exclude       |表黑名单|否        |空|多个以逗号分割，例如：user,order,t2
mysql.column.exclude       |字段黑名单|否        |空|多个以逗号分割，例如:_timestamp,updatetime

### 关于项目类型

- **springmvc-rest** 基于SpringFramework的Rest服务
- **springboot-rest** 基于SpringBoot的Rest服务
- **springmvc-page** 基于SpringFramework的页面服务，暂不支持
- **springboot-page** 基于SpringBoot的页面服务，暂不支持

### 关于白名单、黑名单
白名单和黑名单是互斥的，白名单的优先级高于黑名单。即：如果设置了白名单，只会扫描白名单的表，如果只设置了黑名单，则会过滤掉黑名单中的表，如果同时设置了白名单、黑名单，则只有白名单生效。
字段黑名单是全局的，用来过滤不想要的字段，例如'_timestamp(ON UPDATE CURRENT_TIMESTAMP)'

# 单元测试

写好单元测试不是一件容易的事，这里分享下自己的经验：多数情况下使用独立的数据库运行单元测试，运行完清空数据库，会是一个明智的选择。事实上，在本项目中，就体现了类似的规则。
>注意：为避免误清空其他环境数据，运行单元测试时会检测数据库实例是否以'_ut'结尾。生成代码后，请把单元测试的配置文件修改下。

# 模板项目
这里维护了flyermaker的模板：
- [flyer-springboot-rest](https://github.com/vancefantasy/flyer-springboot-rest)
- [flyer-springmvc-rest](https://github.com/vancefantasy/flyer-springmvc-rest)

# 贡献代码

欢迎提交Pull Request。有意见或建议，请提issue，也可以[邮件](mailto:vance.8807@gmail.com)。
