FROM node:18-alpine

# Set working directory
WORKDIR /app

# Install required packages
RUN apk add --no-cache python3 make g++

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy rest of the files
COPY . .

# Expose port
EXPOSE 1337

# Run Strapi in production
CMD ["npm", "start"]
