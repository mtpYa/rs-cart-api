FROM node:14-alpine AS base

WORKDIR /app

ENV PORT=4000

COPY package*.json ./
RUN npm install

COPY . .

RUN npm run build

FROM node:14-alpine as application

COPY --from=base /app/package*.json ./
RUN npm install --only=production


COPY --from=base /app/dist ./dist

EXPOSE 4000

CMD [ "node", "dist/main.js" ]
