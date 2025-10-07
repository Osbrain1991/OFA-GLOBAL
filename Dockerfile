# Multi-stage build for OFA site
# Build stage
FROM node:18-alpine AS build
WORKDIR /app
COPY package.json package-lock.json* ./
COPY package.json ./
# Install dependencies
RUN npm ci --silent || npm install --silent
COPY . .
# Build frontend
RUN npm run build --if-present

# Production stage
FROM node:18-alpine
WORKDIR /app
# Create uploads and data directories
RUN mkdir -p /app/server/uploads /app/server/data
# Copy server files
COPY server server
# Copy built frontend
COPY --from=build /app/dist dist
# Copy package.json and install production deps
COPY package.json .
RUN npm ci --production --silent || true
ENV NODE_ENV=production
EXPOSE 5178
CMD ["node", "server/index.js"]
