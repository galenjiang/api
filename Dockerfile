FROM node:latest AS dev
WORKDIR /app
EXPOSE 3000
COPY package.json /app/
RUN npm install
CMD ["npm", "start"]

FROM node:latest AS prod
WORKDIR /app
EXPOSE 3000
COPY --from=dev /app/node_modules ./node_modules
COPY . .
RUN npm run build
RUN npm i -g pm2
CMD ["pm2-runtime", "start", "--name", "api", "npm", "--", "run", "start:prod"]