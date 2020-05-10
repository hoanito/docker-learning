FROM node:latest

ENV PORT=8000
WORKDIR /root/njs2

COPY . /root

RUN npm install

CMD [ "npm", "start" ]

EXPOSE 8000

