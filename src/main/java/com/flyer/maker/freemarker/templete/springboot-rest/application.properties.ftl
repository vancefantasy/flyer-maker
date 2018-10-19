#set profile=dev
spring.profiles.active=dev
spring.application.name=${projectArtifactId}
#mybatis
mybatis.type-aliases-package=${projectPackage}.domain
mybatis.mapper-locations=classpath:/mapper/*.xml
mybatis.configuration.map-underscore-to-camel-case=true
mybatis.configuration.use-generated-keys=true
mybatis.configuration.default-fetch-size=100
mybatis.configuration.default-statement-timeout=30
#jackson
spring.jackson.date-format=yyyy-MM-dd HH:mm:ss
spring.jackson.time-zone=GMT+8
