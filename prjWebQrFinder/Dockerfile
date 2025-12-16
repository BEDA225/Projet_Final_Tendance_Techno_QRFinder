# Dockerfile pour l'API Node.js - prjWebQrFinder

FROM node:20-alpine

WORKDIR /app

# Copier seulement les fichiers nécessaires pour l'API
COPY package*.json ./
COPY server.js ./

# Installer les dépendances
RUN npm install --production

# Exposer le port 3000
EXPOSE 3000

# Démarrer l'API
CMD ["node", "server.js"]