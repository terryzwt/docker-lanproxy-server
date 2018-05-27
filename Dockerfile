FROM java:8-jdk
#RUN apk add --no-cache zip unzip wget
RUN wget "https://seafile.io2c.com/d/3b1b44fee5f74992bb17/files/?p=/lanproxy-server/lanproxy-server-20171116.zip&dl=1" -O /tmp/lanproxy-server.zip && \
    unzip /tmp/lanproxy-server.zip -d /opt && \
    chmod +x /opt/proxy-server-20171116/bin/startup.sh && \
    sed -i "s/nohup //" /opt/proxy-server-20171116/bin/startup.sh && \
    sed -i "s/\&$//" /opt/proxy-server-20171116/bin/startup.sh

ADD docker-entrypoint.sh /usr/local/bin/docker-entrypoint
RUN chmod +x /usr/local/bin/docker-entrypoint

VOLUME ["/root/.lanproxy"]
ENTRYPOINT ["docker-entrypoint"]
CMD ["/opt/proxy-server-20171116/bin/startup.sh"]
