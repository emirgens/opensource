FROM mhart/alpine-node:14 as builder

RUN apk add --no-cache libc6-compat

ENV NODE_ENV development

WORKDIR /opt/app

COPY package*.json ./
RUN npm ci
COPY . ./
RUN npm run build

FROM nginx:1.15.8-alpine
WORKDIR /app
COPY --from=builder /opt/app/_site /app
COPY nginx.conf /etc/nginx/conf.d/default.conf
