# Use official Node.js image
FROM node:18

# Set working directory
WORKDIR /usr/src/app

# Copy dependency files and install
COPY package.json yarn.lock ./
RUN yarn install

# Copy all project files
COPY . .

# Install Express for the API server
RUN yarn add express

# Copy the actual API server file
COPY src/server.js src/server.js

# Expose port expected by Coolify
EXPOSE 3000

# Run the Express API server
CMD ["node", "src/server.js"]
