# Stage 1: Build the app
FROM node:18 AS builder
WORKDIR /app

# First add the environment variables
# ARG VITE_API_URL=http://server:5000
# ENV VITE_API_URL=$VITE_API_URL

COPY package*.json ./
COPY vite.config.* ./
RUN npm install
COPY . .
RUN npm run build  # Outputs to /app/dist by default

# Stage 2: Serve the app
FROM node:18-slim
WORKDIR /app
RUN npm install -g serve
COPY --from=builder /app/dist ./dist
EXPOSE 3000
CMD ["serve", "-s", "dist"]