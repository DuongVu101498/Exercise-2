FROM ubuntu:20.04

# Install the ftp server
RUN apt -y update
RUN apt install -y vsftpd
COPY vsftpd.conf /etc/

# Default FTP user
ARG FTP_USER=ubuntu
ARG FTP_PWD=ubuntu

# Create local user
RUN useradd -rm -d /home/$FTP_USER  -s /bin/bash -g root -G sudo -u 1001 $FTP_USER
RUN echo "$FTP_USER:$FTP_PWD" | chpasswd
RUN echo "$FTP_USER" > /etc/vsftpd.userlist

# Run the FTP server
CMD ["/bin/bash","-c","/sbin/service","vsftpd","start"]
