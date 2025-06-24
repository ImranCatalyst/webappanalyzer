# Use official Node.js image
FROM node:18

WORKDIR /usr/src/app

# Copy and install dependencies with npm
COPY package.json ./
RUN npm install

COPY . .

# Install express
RUN npm install express

# Copy API server
COPY src/server.js src/server.js

EXPOSE 3000

CMD ["node", "src/server.js"]
