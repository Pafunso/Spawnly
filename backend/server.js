const express = require('express');
const bodyParser = require('body-parser');
const db = require('./config/db'); 

const app = express();
const PORT = 3000;

// Middlewares essenciais. Sem isso aqui, a gente não lê JSON nem os forms do front.
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// Arquivos estáticos. É aqui na pasta 'public' que o Vitor vai jogar o HTML/CSS dele.
app.use(express.static('public'));

// Rota de teste só pra garantir que o servidor tá de pé.
app.get('/api/status', (req, res) => {
    res.json({ status: 'Servidor SeedCraft rodando liso.' });
});

/* 
  -----------------------------------------------------------------------
  Área do João Lima.
  Onde ele vai plugar as rotas (GET, POST, PUT, DELETE) para o CRUD das 
  seeds e preferências. A constante 'db' já tá no jeito ali em cima pra usar.
  -----------------------------------------------------------------------
*/

app.listen(PORT, () => {
    console.log(`Servidor rodando na porta ${PORT}`);
    console.log(`Status: http://localhost:${PORT}/api/status`);
});
