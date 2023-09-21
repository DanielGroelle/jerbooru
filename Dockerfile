# frontend
FROM node:20-alpine AS jerbooru-node-base
WORKDIR /app
COPY . .
RUN npm i
EXPOSE 3000

FROM jerbooru-node-base AS jerbooru-node-dev
CMD npm run dev

FROM jerbooru-node-base AS jerbooru-node-prod
RUN npm run build
CMD npm run start

# postgres
FROM postgres:16-alpine AS jerbooru-postgres-base
EXPOSE 5432

FROM jerbooru-postgres-base AS jerbooru-postgres-dev

FROM jerbooru-postgres-base AS jerbooru-postgres-prod
