# Use official Node.js LTS image
FROM node:18

# Set working directory
WORKDIR /usr/src/app

# Copy only package.json and install dependencies first (for caching)
COPY package.json ./
RUN npm install

# Copy the rest of the app
COPY . .

# Expose the port the Express app runs on
EXPOSE 3000

# Start the server
CMD ["node", "src/server.js"]
