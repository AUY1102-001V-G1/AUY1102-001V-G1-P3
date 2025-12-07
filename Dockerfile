# ============================================================================
# ETAPA 1: COMPILAR
# ============================================================================
FROM node:18-alpine AS builder

WORKDIR /app

LABEL maintainer="Grupo AUY1102"
LABEL version="1.0.0"

COPY package*.json ./
RUN npm ci

COPY . .
RUN npm run build

# ============================================================================
# ETAPA 2: EJECUTAR
# ============================================================================
FROM node:18-alpine

WORKDIR /app

COPY --from=builder /app/dist ./dist
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/node_modules ./node_modules

RUN addgroup -g 1001 -S nodejs && \
    adduser -S nodejs -u 1001 && \
    chown -R nodejs:nodejs /app

USER nodejs

EXPOSE 3000

CMD ["node", "dist/index.js"]

