FROM amazonlinux:2
ADD ws-ec2-root .
ADD server.ini .
RUN chmod a+x ws-ec2-root && yum update -y
CMD ./ws-ec2-root --port 7777
