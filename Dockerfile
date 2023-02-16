FROM node:16-alpine as builder

WORKDIR /app

COPY . .

RUN npm ci

RUN npm run generate

RUN rm -rf node_modules && \
  NODE_ENV=production npm ci

FROM node:16-alpine

WORKDIR /app

COPY --from=builder /app  .

ENV HOST 0.0.0.0
EXPOSE 3000

CMD [ "npm", "start" ]
