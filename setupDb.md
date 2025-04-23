# Projeto [API HELPNEI]

## Configuração do Banco de Dados

Para criar o banco de dados, populá-lo e configurar as triggers e views necessárias, siga os passos abaixo:

1. **Instalar dependências**No terminal, na raiz do projeto, execute o seguinte comando para instalar as dependências necessárias:

   ```
   npm install
   ```
2. **Configurar o arquivo .env**Crie um arquivo `.env` na raiz do projeto com o seguinte modelo:

   ```
   DATABASE_URL="mysql://usuario:senha@localhost:3306/nome_do_banco"
   ```
   Substitua `usuario`, `senha` e `nome_do_banco` pelas credenciais e nome do seu banco de dados MySQL.
3. **Criar e popular o banco de dados**Execute o comando abaixo para criar e popular o banco de dados:

   ```
   npm run setup:db
   ```
4. **Configurar triggers e views**Para configurar as triggers e views, execute os arquivos SQL `triggers_and_views.sql` e `views.sql`, localizados na pasta `banco_de_dados/sql`. Use o método abaixo:

   - **Método recomendado: No terminal**Navegue até o diretório raiz do projeto (onde está a pasta `banco_de_dados/sql`) e execute os seguintes comandos na ordem indicada:

     ```
     mysql -u username -p nome_do_banco < banco_de_dados/sql/triggers_and_views.sql
     mysql -u username -p nome_do_banco < banco_de_dados/sql/views.sql
     ```
     - Substitua `username` pelo seu usuário do MySQL.
     - Substitua `nome_do_banco` pelo nome do banco de dados configurado no arquivo `.env`.
     - Você será solicitado a inserir a senha do usuário do MySQL.
   - **Alternativa: Dentro do MySQL**
     Conecte-se ao MySQL:

     ```
     mysql -u username -p
     ```
     Selecione o banco de dados:

     ```
     USE nome_do_banco;
     ```
     Execute os arquivos SQL:

     ```
     source banco_de_dados/sql/triggers_and_views.sql;
     source banco_de_dados/sql/views.sql;
     ```
     Certifique-se de que os arquivos estão no caminho correto ou use o caminho completo (ex.: `/caminho/para/projeto/banco_de_dados/sql/triggers_and_views.sql`).
5. **Verificar triggers e views**
   Confirme que as triggers e views foram criadas corretamente no banco de dados. No MySQL, conecte-se ao banco (`mysql -u username -p`), selecione o banco (`USE nome_do_banco;`) e use:

   ```
   SHOW TRIGGERS;
   ```
   Para listar as triggers, e:

   ```
   SHOW FULL TABLES WHERE TABLE_TYPE LIKE 'VIEW';
   ```
   Para listar as views.