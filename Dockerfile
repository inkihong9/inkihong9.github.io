FROM node:current-alpine

# Install git
RUN apk add --no-cache git

WORKDIR /app

# Copy package.json first for caching
COPY package*.json ./

# Install dependencies deterministically
RUN npm ci

# Copy the rest of the app
COPY . .

# Dev server environment variable for file watching
ENV CHOKIDAR_USEPOLLING=true

CMD ["npm", "run", "dev", "--", "--host", "0.0.0.0", "--port", "4321"]
