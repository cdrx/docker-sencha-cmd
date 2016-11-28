FROM ubuntu:16.04

ENV DEBIAN_FRONTEND noninteractive

RUN set -x \
    && apt-get update -qy \
    && apt-get install --no-install-recommends -qfy unzip curl default-jre \
    && apt-get clean

RUN curl -o /cmd.run.zip http://cdn.sencha.com/cmd/6.2.0.103/SenchaCmd-6.2.0.103-linux-amd64.sh.zip && \
    unzip -p /cmd.run.zip > /cmd-install.run && \
    chmod +x /cmd-install.run && \
    /cmd-install.run -q -dir /opt/Sencha/Cmd/6.2.0.103 && \
    rm /cmd-install.run /cmd.run.zip

RUN mkdir /src
WORKDIR /src
ENV PATH="/opt/Sencha/Cmd:$PATH"
ENTRYPOINT sencha
