FROM trenpixster/elixir:1.2.5
MAINTAINER Manchaques

ENV MIX_HOST 4000
EXPOSE $MIX_HOST

VOLUME /app
WORKDIR /app

ENTRYPOINT ["./micose_backend.sh"]
CMD ["foreground"]
# Start up in 'foreground' mode by default so the container stays running