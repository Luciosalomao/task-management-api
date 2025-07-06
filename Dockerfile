# Etapa 1: build da aplicação
FROM node:20-alpine AS builder

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

RUN npm run build

# Etapa 2: imagem final para produção
FROM node:20-alpine

WORKDIR /app

COPY package*.json ./
RUN npm install --only=production

COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/src ./src

# Copia também os arquivos de config (como .ts de migration)
COPY tsconfig.json ./

# Executa as migrações (ajuste se precisar de env vars ou configs extras)
RUN npm run migration:run || echo "Falha ao rodar migração (ok em dev)"

CMD ["npm", "run", "start:prod"]
