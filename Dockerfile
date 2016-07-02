FROM trenpixster/elixir:1.2.5
MAINTAINER Manchaques

ENV VERSION 0.0.1
ENV MIX_HOST 4000
EXPOSE $MIX_HOST

VOLUME /app
WORKDIR /app
COPY ./rel/micose_backend/releases/$VERSION/micose_backend.tar.gz /app/micose_backend.tar.gz
RUN tar -zxvf micose_backend.tar.gz


WORKDIR /app/releases/$VERSION
ENTRYPOINT ["./micose_backend.sh"]
CMD ["foreground"]
# Start up in 'foreground' mode by default so the container stays running