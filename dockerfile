# Dockerfile for building a Node.js application using Alpine Linux
# Use a multi-stage build to keep the final image small

FROM node:20-alpine3.16 as builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

#nginx stage
FROM nginx:1.25-alpine
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY --from=builder /app/dist /usr/share/nginx/html
ENTRYPOINT [ "nginx", "-g", "daemon off;" ]