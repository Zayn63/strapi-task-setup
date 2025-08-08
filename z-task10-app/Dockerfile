# ---- Base Node Image ----
FROM node:18-alpine as base

# Set working directory
WORKDIR /app

# Copy package.json and lock file first
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the app
COPY . .

# Build Strapi admin panel
RUN npm run build

# ---- Production Image ----
FROM node:18-alpine

WORKDIR /app

# Copy only necessary files from build stage
COPY --from=base /app /app

# Expose Strapi port
EXPOSE 1337

# Set environment variable
ENV NODE_ENV=production

# Start Strapi
CMD ["npm", "start"]
