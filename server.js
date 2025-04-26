// Carrega variáveis de ambiente do arquivo prisma/.env
require('dotenv').config({ path: './prisma/.env' });

const app = require('./app');

// Porta definida no .env ou 3000 como padrão
const PORT = process.env.PORT || 3000;

// Inicia o servidor
app.listen(PORT, () => {
  console.log(`Servidor rodando na porta ${PORT}`);
});
