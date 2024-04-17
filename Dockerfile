FROM node:alpine AS base
WORKDIR /app
COPY package*.json ./
RUN npm install 
COPY . .

FROM node:alpine as production 
WORKDIR /app
COPY --from=base /app .
EXPOSE 3000
CMD ["npm", "start"]

