const express = require('express');
const cors = require('cors');
require('dotenv').config();

const pool = require('./config/db');

const app = express(); 

app.use(cors()); 
app.use(express.json());

app.use('/auth', require('./routes/authRoutes'));
app.use('/interactions', require('./routes/interactionRoutes'));
app.use('/homepage', require('./routes/homepageRoutes'));

app.listen(3000, () => console.log('Server running 🚀'));