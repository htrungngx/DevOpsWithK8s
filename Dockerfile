FROM node:16 AS base
WORKDIR /app
COPY package.json ./
RUN npm install . 
COPY . .

FROM node:16 as production 
WORKDIR /app
COPY --from=base /app .
EXPOSE 3000
CMD ["npm", "start"]

