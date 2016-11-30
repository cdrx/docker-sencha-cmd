FROM java:8-jre

ENV DEBIAN_FRONTEND noninteractive

RUN set -x \
    && apt-get update -qy \
    && apt-get install --no-install-recommends -qfy unzip curl ruby \
    && apt-get clean

RUN mkdir /src && \
    useradd -m sencha && \
    cd && cp -R .bashrc .profile /home/sencha && \
    mkdir -p /src && \
    chown -R sencha:sencha /home/sencha /src

USER sencha
ENV HOME /home/sencha

RUN curl -o /home/sencha/cmd.sh.zip http://cdn.sencha.com/cmd/6.2.0.103/SenchaCmd-6.2.0.103-linux-amd64.sh.zip && \
    unzip -p /home/sencha/cmd.sh.zip > /home/sencha/cmd-install.sh && \
    chmod +x /home/sencha/cmd-install.sh && \
    /home/sencha/cmd-install.sh -q && \
    rm /home/sencha/cmd*

VOLUME /src
WORKDIR /src

EXPOSE 1841

ENV PATH /home/sencha/bin/Sencha/Cmd/6.2.0.103/:$PATH

CMD sencha app build production
