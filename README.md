# docker-centos7-oarclejdk8-tomcat8
$ docker run -d -v /path/to/webapps:/tomcat/webapps -v /path/to/logs/:/tomcat/logs -p 80:8080 --name my-tomcat-container 306955302/jdk8tomcat8:latest
