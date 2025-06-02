# Stage 1: Build stage
FROM node:18 AS build

WORKDIR /app

# Copy package files and install all dependencies (including dev)
COPY package*.json ./

RUN npm install

# Copy all source files
COPY . .

# (If you had a build step like `npm run build`, you'd run it here)
# RUN npm run build

# Stage 2: Production stage
FROM node:18-alpine AS production

WORKDIR /app

# Copy only production dependencies from build stage
COPY --from=build /app/node_modules ./node_modules

# Copy source files
COPY --from=build /app ./

EXPOSE 3000

CMD ["node", "server.js"]

