FROM ubuntu:20.04

#install the ftp server
RUN apt -y update
RUN apt install -y vsftpd
COPY vsftpd.conf /etc/

#create local user
RUN useradd -rm -d /home/${{ secrets.FTP_USER }} -s /bin/bash -g root -G sudo -u 1001 ${{ secrets.FTP_USER }}
RUN echo "${{ secrets.FTP_USER }}:${{ secrets.FTP_PWD }}" | chpasswd
RUN echo "${{ secrets.FTP_USER }}" > /etc/vsftpd.userlist

#run the FTP server
CMD ["/sbin/service vsftpd","start"]
