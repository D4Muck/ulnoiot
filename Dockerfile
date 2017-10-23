FROM ubuntu:artful

RUN apt-get update && apt-get install -y \
    bridge-utils \
    curl \ 
    git \
    iproute2 \
    iptables \
    mc \
    mosquitto \
    mosquitto-clients \
    openssh-server \
    virtualenv \
    iptables

#ssh setup
ENV NOTVISIBLE "in users profile"
RUN mkdir /var/run/sshd \
    && echo 'root:ulnoiot' | chpasswd \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd \
    && echo "export VISIBLE=now" >> /etc/profile

expose 22

#ulnoiot setup
COPY . /ulnoiot
COPY docker/ulnoiot /bin

RUN ulnoiot exec /ulnoiot/bin/fix_bin \
    && echo Y | ulnoiot exec /ulnoiot/bin/install clean

CMD ["/usr/sbin/sshd", "-D"]
