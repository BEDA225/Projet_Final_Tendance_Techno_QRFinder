const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');

const app = express();
const PORT = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());

const MONGODB_URI = process.env.MONGODB_URI || 'mongodb://mongodb:27017/qrfinder';

mongoose.connect(MONGODB_URI)
  .then(() => console.log('Connecté à MongoDB'))
  .catch(err => console.error('Erreur MongoDB:', err));

app.get('/', (req, res) => {
  res.json({ 
    message: 'API prjWebQrFinder - Gestion des objets perdus',
    status: 'Running'
  });
});

app.get('/health', (req, res) => {
  res.json({ 
    status: 'OK', 
    service: 'qrfinder-api'
  });
});

app.listen(PORT, '0.0.0.0', () => {
  console.log('Serveur démarré sur le port ' + PORT);
});
