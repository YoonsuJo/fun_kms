FROM jenkins/jenkins:lts

# 切换到root用户以安装JDK
USER root

# 复制JDK安装包到容器中
COPY ../jdk1.7.0_71.tar.gz /opt/

# 解压JDK安装包
RUN tar -xzf /opt/jdk1.7.0_71.tar.gz -C /opt/ && \
    rm /opt/jdk1.7.0_71.tar.gz

# 设置环境变量
ENV JAVA_HOME /opt/jdk1.7.0_71
ENV PATH $JAVA_HOME/bin:$PATH

# 切换回jenkins用户
USER jenkins
