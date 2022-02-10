## Simple webserver container 
# Using RHEL 7 base image and Apache Web server
# Version 1

# Pull the rhel image from the local repository
FROM registry.access.redhat.com/sgdfgdg
MAINTAINER <admin@example.com>

### Add Atomic/OpenShift Labels - https://github.com/projectatomic/ContainerApplicationGenericLabels#####
LABEL name="happywebserver1" \
      vendor="Example Inc1" \
      version="1.0" \
      release="1" \
      run='docker run -d -p 8080:80 --name=happyweb happywebserver' \ 
      description='a different sample description1' \
      summary='sa different sample summary label1'


### Atomic Help File - Write in Markdown, it will be converted to man format at build time.
### https://github.com/projectatomic/container-best-practices/blob/master/creating/help.adoc
# COPY help.md /tmp/help.md

#RUN yum clean all && yum-config-manager --disable \* &> /dev/null 
### Add necessary Red Hat repos here
RUN mkdir /licenses && echo "some license text" > /licenses/evil-terms

#RUN yum-config-manager --enable rhel-7-server-rpms,rhel-7-server-optional-rpms &> /dev/null 

# temporarily disabled due to yum issues in prod
# RUN yum -y update-minimal --security --sec-severity=Important --sec-severity=Critical --setopt=tsflags=nodocs
### Add your package needs to this installation line

# golang-github-cpuguy83-go-md2man  is not found for some reason... AWS repo difference?
# RUN  yum -y install --setopt=tsflags=nodocs golang-github-cpuguy83-go-md2man 
### help file markdown to man conversion
#  RUN   go-md2man -in /tmp/help.md -out /help.1 && yum -y remove golang-github-cpuguy83-go-md2man 


#RUN yum clean all

# Update and install the application
#COPY help.1 /help.1
#RUN yum update -y
#RUN yum install httpd -y

RUN echo "This container image was build on:" > /foo.text
RUN date >> /foobar.text
EXPOSE 8080

# Start the service
CMD ["-D", "FOREGROUND"]
ENTRYPOINT ["/usr/sbin/httpd"]
