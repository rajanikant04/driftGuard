FROM node:20-alpine

WORKDIR /app

# Install dependencies first for caching
COPY ./frontend/package*.json ./
RUN npm ci

# Copy source
COPY ./frontend ./

EXPOSE 5173

CMD ["npm", "run", "dev", "--", "--host"]

