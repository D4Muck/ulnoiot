FROM ubuntu:artful

RUN apt-get update && apt-get install curl git iproute2 mc mosquitto mosquitto-clients virtualenv iptables bridge-utils -y
RUN git clone https://github.com/ulno/ulnoiot

ADD ulnoiot /bin

RUN ulnoiot exec /ulnoiot/bin/fix_bin \
    && echo Y | ulnoiot exec /ulnoiot/bin/install clean

CMD ["/bin/bash", "/bin/ulnoiot"]

