# Use official Node.js LTS image
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Install dependencies for Sharp and sqlite (if needed)
RUN apk add --no-cache \
  python3 \
  make \
  g++ \
  libc6-compat \
  openssl \
  bash \
  && rm -rf /var/cache/apk/*

# Copy package files first for layer caching
COPY package.json package-lock.json* ./

# Install production dependencies
RUN npm ci --omit=dev

# Copy the rest of the project files
COPY . .

# Build the Strapi admin panel
RUN npm run build

# Expose the port Strapi runs on
EXPOSE 1337

# Run the Strapi server
CMD ["npm", "run", "start"]
