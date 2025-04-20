# 使用 JDK 11 作为基础镜像
FROM openjdk:11-jdk-slim

# 指定工作目录
WORKDIR /app

# 将本地生成的 jar 包添加到容器的工作目录
ADD target/tj-user.jar /app/tj-user.jar

# 暴露端口
EXPOSE 8082

# 启动命令，指定 Spring 环境配置为 `prod`
ENTRYPOINT ["java", "-jar", "/app/tj-user.jar", "--spring.profiles.active=prod"]