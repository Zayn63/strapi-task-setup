FROM strapi/strapi:latest

# Set the working directory to where Strapi expects your app
WORKDIR /srv/app

# Copy only necessary files
COPY ./package.json ./package-lock.json ./

# Install production dependencies
RUN npm install --production

# Copy the rest of your Strapi project (API, config, etc.)
COPY . .

# Expose the Strapi default port
EXPOSE 1337

# Start the Strapi server
CMD ["npm", "start"]
