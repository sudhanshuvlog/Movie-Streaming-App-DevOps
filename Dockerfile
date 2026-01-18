# Use an official Node.js runtime as the base image
FROM node:18

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy the package.json and package-lock.json files
COPY package*.json ./

# Install the dependencies
RUN npm install

# Copy the rest of the application code
COPY app.js .

# Expose the port the app runs on
EXPOSE 3000

# Start the application
CMD [ "node", "app.js" ]

