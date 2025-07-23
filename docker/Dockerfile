# Use the official Node.js LTS image
FROM node:18

# Set working directory
WORKDIR /app

# Copy all files into container
COPY . .

# Install dependencies
RUN npm install

# Expose port used by Strapi
EXPOSE 1337

# Start the Strapi application
CMD ["npm", "start"]
