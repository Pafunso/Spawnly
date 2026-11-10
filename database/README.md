# Banco local do Spawnly

`spawnly_mariadb.sql` e uma copia do catalogo oficial ajustada para MariaDB:

- usa somente o banco isolado `spawnly_integracao`;
- troca a collation exclusiva do MySQL 8 por `utf8mb4_unicode_ci`;
- remove o `DEFINER=root` da view;
- nao contem comandos `DROP`;
- preserva as chaves estrangeiras e os registros de catalogo.

O instalador do back-end verifica o banco antes da importacao. Se encontrar um
esquema parcial, ele para sem remover tabelas ou dados. O banco `seedcraft` nao
e consultado nem alterado.

1. Copie `backend/.env.example` para `backend/.env` e escolha uma senha local.
2. Execute o instalador com uma conta administrativa do MariaDB. Em uma
   instalacao Kali que usa autenticacao por socket:

   ```bash
   cd backend
   sudo DB_ADMIN_SOCKET=/run/mysqld/mysqld.sock node scripts/setup-database.js
   ```

Tambem e possivel definir `DB_ADMIN_USER` e `DB_ADMIN_PASSWORD` apenas na sessao
do terminal. A aplicacao usa exclusivamente `DB_USER` e `DB_PASSWORD` do `.env`.
