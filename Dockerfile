# frontend
FROM node:20-alpine AS jerbooru-node-base
WORKDIR /app
COPY ./package*.json ./
RUN npm i
COPY . .
RUN npx next telemetry disable
EXPOSE 3000

FROM jerbooru-node-base AS jerbooru-node-dev
RUN rm -rf src
CMD npm run dev

FROM jerbooru-node-base AS jerbooru-node-prod
RUN npm run build
CMD npm run start

# postgres
FROM postgres:16-alpine AS jerbooru-postgres-base
EXPOSE 5432

FROM jerbooru-postgres-base AS jerbooru-postgres-dev

FROM jerbooru-postgres-base AS jerbooru-postgres-prod
