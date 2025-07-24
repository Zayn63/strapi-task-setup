# Use Node.js base image
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application
COPY . .

# Build Strapi Admin (important for production)
RUN npm run build

# Expose the default Strapi port
EXPOSE 1337

# Start the application
CMD ["npm", "start"]
