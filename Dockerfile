# Use slim image for smaller footprint
FROM node:18-slim

# Install dependencies required for puppeteer (Chromium)
RUN apt-get update && apt-get install -y \
    chromium \
    fonts-liberation \
    libasound2 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libcups2 \
    libdbus-1-3 \
    libdrm2 \
    libgbm1 \
    libgtk-3-0 \
    libnspr4 \
    libnss3 \
    libx11-xcb1 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    xdg-utils \
    ca-certificates \
    --no-install-recommends && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Puppeteer will look for Chromium here
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

# Create app directory
WORKDIR /usr/src/app

# Copy and install dependencies
COPY package.json ./
RUN npm install

# Install puppeteer directly (adds it to node_modules without needing to edit package.json manually)
RUN npm install puppeteer

# Copy the rest of your app
COPY . .

# Expose the port your server runs on
EXPOSE 3000

# Start your server
CMD ["node", "src/server.js"]
