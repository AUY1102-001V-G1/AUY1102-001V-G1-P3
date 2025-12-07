# ============================================================================
# ETAPA 1: COMPILAR
# ============================================================================
FROM node:18-alpine AS builder

WORKDIR /app

# Metadatos
LABEL maintainer="Grupo AUY1102"
LABEL version="1.0.0"

# Copiar dependencias
COPY package*.json ./

# Instalar
RUN npm ci

# Copiar código
COPY . .

# Compilar
RUN npm run build


# ============================================================================
# ETAPA 2: EJECUTAR
# ============================================================================
FROM node:18-alpine

WORKDIR /app

# Copiar compilados
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/package*.json ./

# Instalar solo producción
RUN npm ci --only=production && \
    npm cache clean --force

# Crear usuario (seguridad)
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nodejs -u 1001 && \
    chown -R nodejs:nodejs /app

USER nodejs

# Puerto
EXPOSE 3000

# Comando
CMD ["node", "dist/index.js"]
