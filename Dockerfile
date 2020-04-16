#--------------------------------------------------------
# My Dockerfile: build Docker Image pptpd server VPN
#--------------------------------------------------------
FROM alpine
# Создатель
MAINTAINER erek  <admin@f2service.ru>

RUN apk add --no-cache iptables ppp pptpd

#Копируем Рабочие файлы
 
COPY ./data/pptpd.conf    /etc/
COPY ./data/chap-secrets  /etc/ppp/
COPY ./data/pptpd-options /etc/ppp/

#казываем на каком порту будет работать 
EXPOSE 1723

# Команда выполняемая при запуске контейнера
CMD set -xe \
    && iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE \
    && pptpd \
    && syslogd -n -O /dev/stdout
