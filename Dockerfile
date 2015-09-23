FROM ubuntu
MAINTAINER Dominik Weidenfeld "dom.weidenfeld@gmail.com"

# Update
RUN apt-get update && apt-get clean
RUN apt-get install -y wget libreoffice

# Files
ADD docker/alfresco-installer.options /opt/alfresco-installer.options

# Alfresco
RUN wget -O /opt/alfresco-installer.bin http://dl.alfresco.com/release/community/5.0.d-build-00002/alfresco-community-5.0.d-installer-linux-x64.bin
RUN chmod +x /opt/alfresco-installer.bin
RUN /opt/alfresco-installer.bin --optionfile /opt/alfresco-installer.options
RUN sed -i 's/127.0.0.1/0.0.0.0/g' /opt/alfresco/tomcat/shared/classes/alfresco-global.properties

# Ports
EXPOSE 8080 8443

# RUN
CMD service alfresco start && tail -f /opt/alfresco/tomcat/logs/catalina.out
