FROM node:12.18.3-alpine

ENV APP_ROOT /app
RUN mkdir -p ${APP_ROOT}
WORKDIR ${APP_ROOT}

RUN apk update && yarn global add @vue/cli
COPY package.json .
RUN yarn install