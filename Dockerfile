FROM elixir:1.2.6
MAINTAINER Manchaques

ENV MIX_HOST 4000
EXPOSE $MIX_HOST

VOLUME /app
WORKDIR /app/

CMD ["./run_prod.sh"]
# Start up in 'foreground' mode by default so the container stays running