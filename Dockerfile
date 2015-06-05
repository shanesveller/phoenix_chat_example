FROM shanesveller/phoenix:latest

WORKDIR /usr/src/app

COPY *.js* /usr/src/app/
RUN npm install

ENV MIX_ENV prod
COPY mix.* /usr/src/app/
COPY config /usr/src/app/
RUN mix do deps.get, deps.compile

COPY . /usr/src/app
RUN node_modules/brunch/bin/brunch build --production
RUN mix do compile, compile.protocols

ENV PORT 4001
EXPOSE 4001
CMD ["mix","phoenix.server"]
