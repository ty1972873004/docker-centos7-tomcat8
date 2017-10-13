FROM bpatterson/centos7-jdk8:latest

LABEL name="CentOS7 with Apache Tomcat 8"

ENV APACHE_TOMCAT_DOWNLOAD_URL http://mirrors.tuna.tsinghua.edu.cn/apache/tomcat/tomcat-8/v8.5.23/bin/apache-tomcat-8.5.23.tar.gz
ENV APACHE_TOMCAT_INSTALL_DIR /usr/local/apache-tomcat-8.5.23

RUN curl \
	-L \
	-v \
	"${APACHE_TOMCAT_DOWNLOAD_URL}" \
	| tar -xz -C /usr/local

# Modify default config to use well-known paths

RUN cat ${APACHE_TOMCAT_INSTALL_DIR}/conf/server.xml | \
	sed 's/port="8080"/port="8080" useBodyEncodingForURI="true" URIEncoding="UTF-8" /' | \
	sed 's/appBase="webapps"/appBase="\/tomcat\/webapps"/' | \
	sed 's/directory="logs"/directory="\/tomcat\/logs"/' > \
	/tmp/server.xml

RUN cp /tmp/server.xml ${APACHE_TOMCAT_INSTALL_DIR}/conf/server.xml
RUN rm /tmp/server.xml

RUN mkdir -p /tomcat/webapps/
RUN mkdir -p /tomcat/logs/

COPY entrypoint.sh /

RUN chmod +x entrypoint.sh

EXPOSE 8080 8009
VOLUME ["/tomcat/webapps", "/tomcat/logs"]
CMD ["/entrypoint.sh"]
