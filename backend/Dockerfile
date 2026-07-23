FROM node:22-alpine AS build

WORKDIR /app
COPY package*.json ./
RUN npm ci --omit=dev
COPY . .

FROM node:22-alpine

WORKDIR /app
ENV NODE_ENV=production
COPY --from=build --chown=node:node /app /app
USER node

EXPOSE 3000
CMD ["node", "server.js"]
