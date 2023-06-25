FROM ubuntu:16.04

RUN sed -i 's/archive.ubuntu.com/asia-east1.gce.archive.ubuntu.com/g' /etc/apt/sources.list && apt update && apt-get install -y lib32z1 xinetd && rm -rf /var/lib/apt/lists/ && rm -rf /root/.cache && apt-get autoclean && rm -rf /tmp/* /var/lib/apt/* /var/cache/* /var/log/*
#apt update && apt-get install -y lib32z1 xinetd && rm -rf /var/lib/apt/lists/ && rm -rf /root/.cache && apt-get autoclean && rm -rf /tmp/* /var/lib/apt/* /var/cache/* /var/log/*

COPY ./pwn.xinetd /etc/xinetd.d/pwn

COPY ./service.sh /service.sh

RUN chmod +x /service.sh

# useradd and put flag
RUN useradd -m 1 && useradd -m babyrop && useradd -m poc && useradd -m pwn1poc && useradd -m ret2libc && useradd -m ret2shellcode && useradd -m ret2shellcode1 && useradd -m ret2win && useradd -m sc_jmprsi && echo 'flag{bf0031d8-5a47-46ca-ad92-5abbe6662fa4}' > /home/1/flag && echo 'flag{b07d2ed8-e6a7-4e81-b596-db7dd397cacb}' > /home/babyrop/flag && echo 'flag{8705b6b0-923d-4932-adbb-09aecd216f90}' > /home/poc/flag && echo 'flag{35785404-acd0-4032-8890-3fad68a2773a}' > /home/pwn1poc/flag && echo 'flag{8b3931d0-bbd8-412f-ab1d-368424449da6}' > /home/ret2libc/flag && echo 'flag{6832b3f3-19d6-44be-9086-ad4c75e273cc}' > /home/ret2shellcode/flag && echo 'flag{647bd8d9-c22e-41f7-8895-ed8d87c1cc8d}' > /home/ret2shellcode1/flag && echo 'flag{61b108e3-8e3d-4c1c-919a-6d67574317f3}' > /home/ret2win/flag && echo 'flag{dd793e3e-a7f9-448f-be86-088072dc449b}' > /home/sc_jmprsi/flag

# copy bin
COPY ./bin/1 /home/1/1
COPY ./catflag /home/1/bin/sh
COPY ./bin/babyrop /home/babyrop/babyrop
COPY ./catflag /home/babyrop/bin/sh
COPY ./bin/poc /home/poc/poc
COPY ./catflag /home/poc/bin/sh
COPY ./bin/pwn1poc /home/pwn1poc/pwn1poc
COPY ./catflag /home/pwn1poc/bin/sh
COPY ./bin/ret2libc /home/ret2libc/ret2libc
COPY ./catflag /home/ret2libc/bin/sh
COPY ./bin/ret2shellcode /home/ret2shellcode/ret2shellcode
COPY ./catflag /home/ret2shellcode/bin/sh
COPY ./bin/ret2shellcode1 /home/ret2shellcode1/ret2shellcode1
COPY ./catflag /home/ret2shellcode1/bin/sh
COPY ./bin/ret2win /home/ret2win/ret2win
COPY ./catflag /home/ret2win/bin/sh
COPY ./bin/sc_jmprsi /home/sc_jmprsi/sc_jmprsi
COPY ./catflag /home/sc_jmprsi/bin/sh


# chown & chmod
RUN chown -R root:1 /home/1 && chmod -R 750 /home/1 && chmod 740 /home/1/flag && chown -R root:babyrop /home/babyrop && chmod -R 750 /home/babyrop && chmod 740 /home/babyrop/flag && chown -R root:poc /home/poc && chmod -R 750 /home/poc && chmod 740 /home/poc/flag && chown -R root:pwn1poc /home/pwn1poc && chmod -R 750 /home/pwn1poc && chmod 740 /home/pwn1poc/flag && chown -R root:ret2libc /home/ret2libc && chmod -R 750 /home/ret2libc && chmod 740 /home/ret2libc/flag && chown -R root:ret2shellcode /home/ret2shellcode && chmod -R 750 /home/ret2shellcode && chmod 740 /home/ret2shellcode/flag && chown -R root:ret2shellcode1 /home/ret2shellcode1 && chmod -R 750 /home/ret2shellcode1 && chmod 740 /home/ret2shellcode1/flag && chown -R root:ret2win /home/ret2win && chmod -R 750 /home/ret2win && chmod 740 /home/ret2win/flag && chown -R root:sc_jmprsi /home/sc_jmprsi && chmod -R 750 /home/sc_jmprsi && chmod 740 /home/sc_jmprsi/flag

# copy lib,/bin 
RUN cp -R /lib* /home/1 && cp -R /usr/lib* /home/1 && mkdir /home/1/dev && mknod /home/1/dev/null c 1 3 && mknod /home/1/dev/zero c 1 5 && mknod /home/1/dev/random c 1 8 && mknod /home/1/dev/urandom c 1 9 && chmod 666 /home/1/dev/* && cp /bin/sh /home/1/bin && cp /bin/ls /home/1/bin && cp /bin/cat /home/1/bin && cp -R /lib* /home/babyrop && cp -R /usr/lib* /home/babyrop && mkdir /home/babyrop/dev && mknod /home/babyrop/dev/null c 1 3 && mknod /home/babyrop/dev/zero c 1 5 && mknod /home/babyrop/dev/random c 1 8 && mknod /home/babyrop/dev/urandom c 1 9 && chmod 666 /home/babyrop/dev/* && cp /bin/sh /home/babyrop/bin && cp /bin/ls /home/babyrop/bin && cp /bin/cat /home/babyrop/bin && cp -R /lib* /home/poc && cp -R /usr/lib* /home/poc && mkdir /home/poc/dev && mknod /home/poc/dev/null c 1 3 && mknod /home/poc/dev/zero c 1 5 && mknod /home/poc/dev/random c 1 8 && mknod /home/poc/dev/urandom c 1 9 && chmod 666 /home/poc/dev/* && cp /bin/sh /home/poc/bin && cp /bin/ls /home/poc/bin && cp /bin/cat /home/poc/bin && cp -R /lib* /home/pwn1poc && cp -R /usr/lib* /home/pwn1poc && mkdir /home/pwn1poc/dev && mknod /home/pwn1poc/dev/null c 1 3 && mknod /home/pwn1poc/dev/zero c 1 5 && mknod /home/pwn1poc/dev/random c 1 8 && mknod /home/pwn1poc/dev/urandom c 1 9 && chmod 666 /home/pwn1poc/dev/* && cp /bin/sh /home/pwn1poc/bin && cp /bin/ls /home/pwn1poc/bin && cp /bin/cat /home/pwn1poc/bin && cp -R /lib* /home/ret2libc && cp -R /usr/lib* /home/ret2libc && mkdir /home/ret2libc/dev && mknod /home/ret2libc/dev/null c 1 3 && mknod /home/ret2libc/dev/zero c 1 5 && mknod /home/ret2libc/dev/random c 1 8 && mknod /home/ret2libc/dev/urandom c 1 9 && chmod 666 /home/ret2libc/dev/* && cp /bin/sh /home/ret2libc/bin && cp /bin/ls /home/ret2libc/bin && cp /bin/cat /home/ret2libc/bin && cp -R /lib* /home/ret2shellcode && cp -R /usr/lib* /home/ret2shellcode && mkdir /home/ret2shellcode/dev && mknod /home/ret2shellcode/dev/null c 1 3 && mknod /home/ret2shellcode/dev/zero c 1 5 && mknod /home/ret2shellcode/dev/random c 1 8 && mknod /home/ret2shellcode/dev/urandom c 1 9 && chmod 666 /home/ret2shellcode/dev/* && cp /bin/sh /home/ret2shellcode/bin && cp /bin/ls /home/ret2shellcode/bin && cp /bin/cat /home/ret2shellcode/bin && cp -R /lib* /home/ret2shellcode1 && cp -R /usr/lib* /home/ret2shellcode1 && mkdir /home/ret2shellcode1/dev && mknod /home/ret2shellcode1/dev/null c 1 3 && mknod /home/ret2shellcode1/dev/zero c 1 5 && mknod /home/ret2shellcode1/dev/random c 1 8 && mknod /home/ret2shellcode1/dev/urandom c 1 9 && chmod 666 /home/ret2shellcode1/dev/* && cp /bin/sh /home/ret2shellcode1/bin && cp /bin/ls /home/ret2shellcode1/bin && cp /bin/cat /home/ret2shellcode1/bin && cp -R /lib* /home/ret2win && cp -R /usr/lib* /home/ret2win && mkdir /home/ret2win/dev && mknod /home/ret2win/dev/null c 1 3 && mknod /home/ret2win/dev/zero c 1 5 && mknod /home/ret2win/dev/random c 1 8 && mknod /home/ret2win/dev/urandom c 1 9 && chmod 666 /home/ret2win/dev/* && cp /bin/sh /home/ret2win/bin && cp /bin/ls /home/ret2win/bin && cp /bin/cat /home/ret2win/bin && cp -R /lib* /home/sc_jmprsi && cp -R /usr/lib* /home/sc_jmprsi && mkdir /home/sc_jmprsi/dev && mknod /home/sc_jmprsi/dev/null c 1 3 && mknod /home/sc_jmprsi/dev/zero c 1 5 && mknod /home/sc_jmprsi/dev/random c 1 8 && mknod /home/sc_jmprsi/dev/urandom c 1 9 && chmod 666 /home/sc_jmprsi/dev/* && cp /bin/sh /home/sc_jmprsi/bin && cp /bin/ls /home/sc_jmprsi/bin && cp /bin/cat /home/sc_jmprsi/bin

CMD ["/service.sh"]
