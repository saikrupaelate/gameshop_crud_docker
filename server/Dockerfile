# -------- Stage 1: Build --------
FROM node:18 AS builder

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
    
# -------- Stage 2: Runtime --------
FROM node:18-slim
    
# Install MySQL client and dependencies
RUN apt-get update && \
    apt-get install -y default-mysql-client && \
    rm -rf /var/lib/apt/lists/*
    
WORKDIR /app
COPY --from=builder /app ./
COPY --from=builder /app/node_modules ./node_modules
EXPOSE 5000
COPY wait-for-db.sh .
RUN chmod +x wait-for-db.sh
    
CMD ["./wait-for-db.sh", "node", "index.js"]