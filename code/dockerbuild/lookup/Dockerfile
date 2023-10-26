FROM amazonlinux:2
ADD ws-ec2-lookup .
ADD server.ini .
RUN chmod a+x ws-ec2-lookup && yum update -y
CMD ./ws-ec2-lookup --port 7777
