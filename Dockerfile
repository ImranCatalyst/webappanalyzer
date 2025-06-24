# Use official Node.js image
FROM node:18

WORKDIR /usr/src/app

# Copy package.json and install all dependencies, including puppeteer
COPY package.json ./
RUN npm install

# Install Puppeteer with Chromium dependencies
RUN apt-get update && apt-get install -y \
    wget \
    ca-certificates \
    fonts-liberation \
    libappindicator3-1 \
    libasound2 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libcups2 \
    libdbus-1-3 \
    libgdk-pixbuf2.0-0 \
    libnspr4 \
    libnss3 \
    libx11-xcb1 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    xdg-utils \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

RUN npm install puppeteer

# Copy the rest of the files
COPY . .

EXPOSE 3000

CMD ["node", "src/server.js"]
