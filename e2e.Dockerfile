FROM node:18.16.1-alpine

RUN apk add --no-cache bash
RUN npm i -g @nestjs/cli typescript ts-node

COPY package.json /tmp/app/
COPY yarn.lock /tmp/app/
RUN cd /tmp/app && yarn install

COPY . /usr/src/app
RUN cp -a /tmp/app/node_modules /usr/src/app
COPY ./bin/wait-for-it.sh /opt/wait-for-it.sh
COPY ./bin/startup.ci.sh /opt/startup.ci.sh
RUN sed -i 's/\r//g' /opt/wait-for-it.sh
RUN sed -i 's/\r//g' /opt/startup.ci.sh

WORKDIR /usr/src/app
RUN cp .env.example .env
RUN yarn build

CMD ["sh", "/opt/startup.ci.sh"]
