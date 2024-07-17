FROM alpine:3.19

ENV NODE_VERSION 22.4.1

# Install Node.js and other dependencies
RUN apk add --no-cache nodejs npm

WORKDIR /app

# Copy package.json and package-lock.json first for better caching
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application
COPY . .

# Change to the directory containing the Prisma schema and run migrations
RUN cd packages/db && npx prisma migrate dev

# Start the application
CMD ["npm", "run", "start"]