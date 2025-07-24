# Use Node.js base image
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json first for caching
COPY ../package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application
COPY ../ ./

# Build Strapi Admin (optional if you're doing programmatic only)
RUN npm run build

# Expose the default Strapi port
EXPOSE 1337

# Start the application
CMD ["npm", "start"]
# Use Node.js base image
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json first for caching
COPY ../package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application
COPY ../ ./

# Build Strapi Admin (optional if you're doing programmatic only)
RUN npm run build

# Expose the default Strapi port
EXPOSE 1337

# Start the application
CMD ["npm", "start"]
