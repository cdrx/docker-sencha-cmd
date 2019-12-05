FROM ubuntu:16.04

ENV DEBIAN_FRONTEND noninteractive

RUN set -x \
    && apt-get update -qy \
    && apt-get install --no-install-recommends -qfy unzip curl default-jre build-essential \
    && apt-get clean

RUN curl -o /cmd.run.zip http://cdn.sencha.com/cmd/6.7.0.63/no-jre/SenchaCmd-6.7.0.63-linux-amd64.sh.zip && \
    unzip -p /cmd.run.zip > /cmd-install.run && \
    chmod +x /cmd-install.run && \
    /cmd-install.run -q -dir /opt/Sencha/Cmd/6.7.0.63 && \
    rm /cmd-install.run /cmd.run.zip && \
    sed -i "s/^\-Xmx.*/\-Xmx2096m/" /opt/Sencha/Cmd/6.7.0.63/sencha.vmoptions

RUN mkdir /src
WORKDIR /src
ENV PATH="/opt/Sencha/Cmd:$PATH"
CMD sencha app build production
