<img src="assets/banner.svg" alt="Banner do Spawnly: paisagem em pixel art com mascote" width="100%">

<div align="center">

<img src="assets/logo.svg" alt="Spawnly" width="460">

<img src="https://img.shields.io/badge/PROJETO_ACAD%C3%8AMICO-CRUD-4ca66a?style=for-the-badge&labelColor=152820" alt="Projeto acadêmico CRUD">

<h1>SPAWNLY</h1>

<h3>Encontre seu mundo perfeito.</h3>

<p>
Site de sugestões de seeds para Minecraft com questionário de preferências<br>
e recomendações personalizadas, construído como projeto acadêmico de CRUD.
</p>

<p>
<img src="https://img.shields.io/badge/HTML5-4ca66a?style=for-the-badge&logo=html5&logoColor=white" alt="HTML5">
<img src="https://img.shields.io/badge/CSS3-f5c969?style=for-the-badge&logo=css3&logoColor=152820" alt="CSS3">
<img src="https://img.shields.io/badge/JavaScript-214032?style=for-the-badge&logo=javascript&logoColor=f5c969" alt="JavaScript">
<img src="https://img.shields.io/badge/Node.js-4ca66a?style=for-the-badge&logo=nodedotjs&logoColor=white" alt="Node.js">
<img src="https://img.shields.io/badge/Express-214032?style=for-the-badge&logo=express&logoColor=f5c969" alt="Express">
<img src="https://img.shields.io/badge/MySQL-f5c969?style=for-the-badge&logo=mysql&logoColor=152820" alt="MySQL">
</p>

</div>

<img src="assets/divider.svg" alt="" width="100%">

<h2>
<img src="https://img.shields.io/badge/MENU-PRINCIPAL-152820?style=for-the-badge&labelColor=4ca66a" alt="Menu Principal">
</h2>

<table>
<tr>
<td align="center" width="25%"><a href="#sobre-o-mundo"><b>Sobre o Mundo</b></a></td>
<td align="center" width="25%"><a href="#jornada-do-jogador"><b>Jornada do Jogador</b></a></td>
<td align="center" width="25%"><a href="#crafting-table-tecnologias"><b>Crafting Table</b></a></td>
<td align="center" width="25%"><a href="#mapa-de-chunks-arquitetura"><b>Mapa de Chunks</b></a></td>
</tr>
<tr>
<td align="center"><a href="#inventario-banco-de-dados"><b>Inventário</b></a></td>
<td align="center"><a href="#comandos-rotas-da-api"><b>Comandos</b></a></td>
<td align="center"><a href="#iniciando-o-servidor"><b>Iniciando o Servidor</b></a></td>
<td align="center"><a href="#party-equipe"><b>Party</b></a></td>
</tr>
</table>

<h3>Paleta do mundo</h3>

<p>
<img src="https://img.shields.io/badge/Floresta-152820?style=for-the-badge" alt="Floresta #152820">
<img src="https://img.shields.io/badge/Musgo-214032?style=for-the-badge" alt="Musgo #214032">
<img src="https://img.shields.io/badge/Grama-4ca66a?style=for-the-badge" alt="Grama #4ca66a">
<img src="https://img.shields.io/badge/Ouro-f5c969?style=for-the-badge&logoColor=152820" alt="Ouro #f5c969">
<img src="https://img.shields.io/badge/Folhagem-eff6f0?style=for-the-badge" alt="Folhagem #eff6f0">
<img src="https://img.shields.io/badge/Areia-fff4d9?style=for-the-badge" alt="Areia #fff4d9">
</p>

<img src="assets/divider.svg" alt="" width="100%">

<h2 id="sobre-o-mundo">
<img src="https://img.shields.io/badge/01-SOBRE_O_MUNDO-152820?style=for-the-badge&labelColor=4ca66a" alt="01 Sobre o Mundo">
</h2>

<blockquote>
<b>Advancement Made!</b> Você encontrou o Spawnly.
</blockquote>

<p>
O <b>Spawnly</b> recomenda seeds de Minecraft que combinam com o seu estilo de jogo. O usuário responde um questionário sobre edição, bioma, modo de jogo e estruturas desejadas, e o sistema retorna seeds previamente cadastradas e verificadas, ordenadas por compatibilidade.
</p>

<table>
<tr>
<td width="50%">

<img src="https://img.shields.io/badge/O_QUE_FAZ-4ca66a?style=flat-square" alt="O que o Spawnly faz">
<ul>
<li>Cadastra usuários, preferências e seeds</li>
<li>Consulta o catálogo e as recomendações</li>
<li>Edita dados, filtros e seeds</li>
<li>Exclui registros mediante confirmação</li>
</ul>

</td>
<td width="50%">

<img src="https://img.shields.io/badge/O_QUE_N%C3%83O_FAZ-f5c969?style=flat-square" alt="O que o Spawnly não faz">
<ul>
<li>Não descobre seeds aleatórias do jogo</li>
<li>Não simula login falso</li>
<li>Não recomenda seeds sem edição e versão</li>
</ul>

</td>
</tr>
</table>

<h3>CRUD obrigatório</h3>

<table>
<tr>
<td width="15%" align="center"><img src="https://img.shields.io/badge/CREATE-4ca66a?style=for-the-badge" alt="CREATE"></td>
<td>Cadastrar usuários, preferências e seeds.</td>
</tr>
<tr>
<td align="center"><img src="https://img.shields.io/badge/READ-4ca66a?style=for-the-badge" alt="READ"></td>
<td>Consultar cadastros, catálogo e recomendações.</td>
</tr>
<tr>
<td align="center"><img src="https://img.shields.io/badge/UPDATE-4ca66a?style=for-the-badge" alt="UPDATE"></td>
<td>Editar dados de usuário, filtros e seeds.</td>
</tr>
<tr>
<td align="center"><img src="https://img.shields.io/badge/DELETE-4ca66a?style=for-the-badge" alt="DELETE"></td>
<td>Excluir registros mediante confirmação.</td>
</tr>
</table>

<blockquote>
<b>Limite de escopo:</b> o site recomenda apenas seeds já registradas no MySQL. Isso mantém o trabalho realizável e as recomendações confiáveis.
</blockquote>

<img src="assets/divider.svg" alt="" width="100%">

<h2 id="jornada-do-jogador">
<img src="https://img.shields.io/badge/02-JORNADA_DO_JOGADOR-152820?style=for-the-badge&labelColor=4ca66a" alt="02 Jornada do Jogador">
</h2>

<table>
<tr>
<th align="center">Nível</th>
<th align="left">Etapa</th>
<th align="left">Descrição</th>
</tr>
<tr>
<td align="center"><img src="https://img.shields.io/badge/-1-152820?style=for-the-badge" alt="1"></td>
<td><b>Entrar ou cadastrar</b></td>
<td>Informar nome de usuário. Autenticação completa é opcional.</td>
</tr>
<tr>
<td align="center"><img src="https://img.shields.io/badge/-2-152820?style=for-the-badge" alt="2"></td>
<td><b>Responder ao questionário</b></td>
<td>Escolher Java ou Bedrock, bioma, modo de jogo e estruturas desejadas.</td>
</tr>
<tr>
<td align="center"><img src="https://img.shields.io/badge/-3-152820?style=for-the-badge" alt="3"></td>
<td><b>Ver recomendações</b></td>
<td>Receber cards com código da seed, versão, características e pontuação de compatibilidade.</td>
</tr>
<tr>
<td align="center"><img src="https://img.shields.io/badge/-4-152820?style=for-the-badge" alt="4"></td>
<td><b>Refinar preferências</b></td>
<td>Alterar filtros sem repetir todo o processo.</td>
</tr>
</table>

<div align="center">
<img src="assets/hotbar.svg" alt="Hotbar com blocos de bioma" width="720">
</div>

<pre>
Hotbar:  [ 1 Entrar ][ 2 Questionário ][ 3 Recomendações ][ 4 Refinar ]
</pre>

<details>
<summary><b>Slots de bioma (exemplos para o questionário)</b></summary>

<table>
<tr>
<th>1</th><th>2</th><th>3</th><th>4</th><th>5</th><th>6</th><th>7</th><th>8</th><th>9</th>
</tr>
<tr>
<td align="center">Planície</td><td align="center">Deserto</td><td align="center">Neve</td><td align="center">Montanha</td><td align="center">Floresta</td><td align="center">Oceano</td><td align="center">Pântano</td><td align="center">Picos</td><td align="center">Savana</td>
</tr>
</table>

<p>Os biomas reais ficam no banco de dados, na tabela <code>seeds</code>. Esta lista é só um exemplo.</p>

</details>

<img src="assets/divider.svg" alt="" width="100%">

<h2 id="crafting-table-tecnologias">
<img src="https://img.shields.io/badge/03-CRAFTING_TABLE-152820?style=for-the-badge&labelColor=4ca66a" alt="03 Crafting Table: Tecnologias">
</h2>

<table>
<tr>
<td align="center" width="33%"><img src="https://img.shields.io/badge/FRONT--END-4ca66a?style=for-the-badge" alt="Front-end"><br><br>HTML5<br>CSS3 responsivo<br>JavaScript</td>
<td align="center" width="33%"><img src="https://img.shields.io/badge/BACK--END-f5c969?style=for-the-badge" alt="Back-end"><br><br>Node.js<br>Express<br>mysql2 e dotenv</td>
<td align="center" width="33%"><img src="https://img.shields.io/badge/DADOS-214032?style=for-the-badge" alt="Dados"><br><br>MariaDB<br>Banco relacional<br>Script SQL/DDL</td>
</tr>
</table>

<pre>
   RECEITA DE CRAFTING

  ┌───────┬───────┬───────┐
  │ HTML5 │ CSS3  │  JS   │
  ├───────┼───────┼───────┤       ┌─────────────┐
  │ Node  │Express│ MySQL │ ───►  │  SPAWNLY x1 │
  ├───────┼───────┼───────┤       └─────────────┘
  │ mysql2│dotenv │  DDL  │
  │       │       │       │
  └───────┴───────┴───────┘
</pre>

<img src="assets/divider.svg" alt="" width="100%">

<h2 id="mapa-de-chunks-arquitetura">
<img src="https://img.shields.io/badge/04-MAPA_DE_CHUNKS-152820?style=for-the-badge&labelColor=4ca66a" alt="04 Mapa de Chunks: Arquitetura">
</h2>

<pre>
 ┌──────────────────┐      ┌──────────────────┐      ┌──────────────────┐
 │    FRONT-END     │      │     BACK-END     │      │      DADOS       │
 │                  │ ───► │                  │ ───► │                  │
 │ HTML5 + CSS3 + JS│ ◄─── │ Node.js + Express│ ◄─── │     MariaDB      │
 └──────────────────┘      └──────────────────┘      └──────────────────┘
      Navegador                 API REST                  Banco de dados
</pre>

<details>
<summary><b>Estrutura de pastas implementada</b></summary>

<pre>
Spawnly-Integracao/
├── README.md
├── assets/
├── database/
│   ├── spawnly_mariadb.sql
│   └── README.md
├── backend/
│   ├── config/db.js
│   ├── routes/
│   ├── services/
│   ├── test/
│   ├── package.json
│   └── server.js
└── frontend/
    ├── index.html
    ├── questionario.html
    ├── resultados.html
    ├── gerenciar.html
    ├── css/
    └── js/
</pre>

<p>O Express serve diretamente os arquivos de <code>frontend/</code> e os assets compartilhados.</p>

</details>

<img src="assets/divider.svg" alt="" width="100%">

<h2 id="inventario-banco-de-dados">
<img src="https://img.shields.io/badge/05-INVENT%C3%81RIO-152820?style=for-the-badge&labelColor=4ca66a" alt="05 Inventário: Banco de Dados">
</h2>

<table>
<tr>
<th align="left">Tabela</th>
<th align="left">Campos</th>
<th align="left">Função</th>
</tr>
<tr>
<td><code>usuarios</code></td>
<td><code>id</code>, <code>nome</code>, <code>edicao</code>, <code>versao</code></td>
<td>Cadastro e manutenção de usuários</td>
</tr>
<tr>
<td><code>preferencias_usuarios</code></td>
<td><code>id</code>, <code>usuario_id</code>, <code>dimensao</code>, <code>valor</code>, <code>peso</code></td>
<td>Preferências normalizadas e editáveis do questionário</td>
</tr>
<tr>
<td><code>seeds</code></td>
<td><code>id</code>, <code>codigo</code>, <code>edicao_versao_id</code>, <code>nome</code>, <code>spawn_texto</code>, <code>nota</code></td>
<td>Catálogo de mundos recomendáveis</td>
</tr>
</table>

<pre>
 ┌──────────────┐ 1      N ┌────────────────┐
 │   usuarios   │──────────│ preferencias_  │
 │              │          │    usuarios    │
 └──────────────┘          └────────────────┘

 ┌──────────────┐
 │    seeds     │   (catálogo independente, consultado pelas regras
 └──────────────┘    de recomendação)
</pre>

<blockquote>
<b>Atenção:</b> o código da seed usa <code>BIGINT</code> no banco e é devolvido como texto pela API, evitando perda de precisão no JavaScript. Edição e faixa de versão são obrigatórias para impedir recomendações incompatíveis.
</blockquote>

<img src="assets/divider.svg" alt="" width="100%">

<h2 id="comandos-rotas-da-api">
<img src="https://img.shields.io/badge/06-COMANDOS-152820?style=for-the-badge&labelColor=4ca66a" alt="06 Comandos: Rotas da API">
</h2>

<table>
<tr>
<th align="center">Método</th>
<th align="left">Rota</th>
<th align="left">Descrição</th>
</tr>
<tr>
<td align="center"><img src="https://img.shields.io/badge/GET-4ca66a?style=flat-square" alt="GET"></td>
<td><code>/api/seeds</code></td>
<td>Listar e filtrar seeds</td>
</tr>
<tr>
<td align="center"><img src="https://img.shields.io/badge/POST-4ca66a?style=flat-square" alt="POST"></td>
<td><code>/api/seeds</code></td>
<td>Cadastrar seed</td>
</tr>
<tr>
<td align="center"><img src="https://img.shields.io/badge/PUT-f5c969?style=flat-square" alt="PUT"></td>
<td><code>/api/seeds/:id</code></td>
<td>Alterar seed</td>
</tr>
<tr>
<td align="center"><img src="https://img.shields.io/badge/DELETE-152820?style=flat-square" alt="DELETE"></td>
<td><code>/api/seeds/:id</code></td>
<td>Excluir seed</td>
</tr>
<tr>
<td align="center"><img src="https://img.shields.io/badge/POST-4ca66a?style=flat-square" alt="POST"></td>
<td><code>/api/recomendar</code></td>
<td>Pontuar opções conforme as preferências do usuário</td>
</tr>
</table>

<p>As rotas de usuários e preferências seguem o mesmo padrão CRUD.</p>

<h3>Console do servidor (exemplo)</h3>

<pre>
&gt; /seed buscar --edicao java --bioma floresta --estrutura vilarejo
[Spawnly] Lendo preferências do jogador...
[Spawnly] Pontuando seeds do catálogo...
[Spawnly] 3 mundos encontrados, ordenados por compatibilidade.
</pre>

<h3>Como a recomendação funciona</h3>

<p>
A rota <code>/api/recomendar</code> compara <b>edição</b>, <b>versão</b>, <b>bioma</b> e <b>estruturas desejadas</b> com cada seed do catálogo, calcula uma pontuação de compatibilidade e devolve os resultados ordenados do maior para o menor.
</p>

<img src="assets/divider.svg" alt="" width="100%">

<h2 id="iniciando-o-servidor">
<img src="https://img.shields.io/badge/07-INICIANDO_O_SERVIDOR-152820?style=for-the-badge&labelColor=4ca66a" alt="07 Iniciando o Servidor">
</h2>

<h3>Requisitos</h3>

<table>
<tr>
<td align="center"><img src="https://img.shields.io/badge/NODE.JS-4ca66a?style=flat-square" alt="Node.js"><br>versão LTS</td>
<td align="center"><img src="https://img.shields.io/badge/MARIADB-f5c969?style=flat-square" alt="MariaDB"><br>servidor local</td>
<td align="center"><img src="https://img.shields.io/badge/NPM-214032?style=flat-square" alt="npm"><br>gerenciador de pacotes</td>
</tr>
</table>

<h3>Passo 1: Entrar no back-end</h3>

<sub>Conquista desbloqueada: <b>Primeiro Spawn</b></sub>

<pre><code>cd ~/Spawnly-Integracao/backend</code></pre>

<h3>Passo 2: Instalar as dependências</h3>

<sub>Conquista desbloqueada: <b>Coletando Recursos</b></sub>

<pre><code>npm install</code></pre>

<h3>Passo 3: Criar o banco de dados</h3>

<sub>Conquista desbloqueada: <b>Construindo a Base</b></sub>

<ol>
<li>Copie <code>.env.example</code> para <code>.env</code> e escolha uma senha local com pelo menos 8 caracteres.</li>
<li>Execute o instalador com autenticação administrativa por socket:</li>
</ol>

<pre><code>cp .env.example .env
sudo DB_ADMIN_SOCKET=/run/mysqld/mysqld.sock node scripts/setup-database.js</code></pre>

<p>O instalador aceita somente <code>spawnly_integracao</code>, não executa <code>DROP</code> e nunca consulta nem altera <code>seedcraft</code>. Se detectar um esquema parcial, ele para sem apagar dados.</p>

<h3>Passo 4: Configurar a conexão</h3>

<sub>Conquista desbloqueada: <b>Redstone Conectada</b></sub>

<p>As credenciais ficam somente em <code>backend/.env</code>. A aplicação usa uma conta própria, sem privilégios administrativos:</p>

<pre><code>DB_HOST=127.0.0.1
DB_PORT=3306
DB_USER=spawnly_app
DB_PASSWORD=escolha_uma_senha_local
DB_NAME=spawnly_integracao
PORT=3000</code></pre>

<h3>Passo 5: Iniciar o servidor</h3>

<sub>Conquista desbloqueada: <b>Servidor no Ar</b></sub>

<pre><code>npm test
npm start</code></pre>

<h3>Passo 6: Abrir no navegador</h3>

<sub>Conquista desbloqueada: <b>Mundo Aberto</b></sub>

<pre><code>http://localhost:3000</code></pre>

<p>A porta pode variar conforme a configuração do <code>server.js</code>.</p>

<img src="assets/divider.svg" alt="" width="100%">

<h2>
<img src="https://img.shields.io/badge/08-CHECKLIST_DE_ENTREGA-152820?style=for-the-badge&labelColor=4ca66a" alt="08 Checklist de Entrega">
</h2>

<table>
<tr>
<th align="center" width="10%">Status</th>
<th align="left">Item</th>
</tr>
<tr><td align="center">[x]</td><td>Páginas de cadastro em HTML5 e estilização responsiva em CSS3</td></tr>
<tr><td align="center">[x]</td><td><code>package.json</code> e dependências reproduzíveis pelo <code>package-lock.json</code></td></tr>
<tr><td align="center">[x]</td><td>Servidor JavaScript conectado ao MariaDB por variáveis de ambiente</td></tr>
<tr><td align="center">[x]</td><td>CRUD integrado de usuários, preferências e seeds</td></tr>
<tr><td align="center">[x]</td><td>SQL oficial adaptado e validado no MariaDB</td></tr>
<tr><td align="center">[x]</td><td><code>README.md</code> com passos de instalação, configuração e execução</td></tr>
<tr><td align="center">[x]</td><td>Questionário com recomendações reais e refinamento de preferências</td></tr>
</table>

<blockquote>
<b>Critério de pronto:</b> outro integrante deve conseguir instalar o projeto seguindo este README e demonstrar o CRUD completo sem editar o código.
</blockquote>

<h3>Riscos a evitar</h3>

<blockquote>
<b>Evite estes erros:</b>
<ul>
<li>Seeds sem versão ou edição</li>
<li>Botões sem conexão real com o banco</li>
<li>Login falso</li>
<li>README incompleto</li>
<li>Tarefas divididas sem contrato de API</li>
</ul>
</blockquote>

<img src="assets/divider.svg" alt="" width="100%">

<h2 id="party-equipe">
<img src="https://img.shields.io/badge/09-PARTY-152820?style=for-the-badge&labelColor=4ca66a" alt="09 Party: Equipe">
</h2>

<img src="assets/residentes.svg" alt="Residentes do Spawnly: três mascotes em pixel art" width="100%">

<table>
<tr>
<th align="center">Jogador</th>
<th align="center">Classe</th>
<th align="left">Responsabilidades</th>
</tr>
<tr>
<td align="center"><b>Vitor</b></td>
<td align="center"><img src="https://img.shields.io/badge/BANCO_%2B_FRONT--END-4ca66a?style=flat-square" alt="Banco de dados e Front-end"></td>
<td>Modelo no Workbench, script SQL/DDL, páginas HTML5, CSS3 responsivo e integração dos formulários com o servidor</td>
</tr>
<tr>
<td align="center"><b>Caetano</b></td>
<td align="center"><img src="https://img.shields.io/badge/BACK--END-f5c969?style=flat-square" alt="Back-end"></td>
<td>Projeto Node.js, configuração do Express, conexão reutilizável com MySQL e integração com o front-end</td>
</tr>
<tr>
<td align="center"><b>João Lima</b></td>
<td align="center"><img src="https://img.shields.io/badge/BACK--END-f5c969?style=flat-square" alt="Back-end"></td>
<td>CRUD de seeds, usuários e preferências, regras de recomendação e validação dos endpoints</td>
</tr>
<tr>
<td align="center"><b>Nathaniel</b></td>
<td align="center"><img src="https://img.shields.io/badge/A_DEFINIR-214032?style=flat-square" alt="A definir"></td>
<td>Função ainda não confirmada pelo grupo. Sugestões: testes de qualidade, documentação, curadoria de seeds e suporte ao front-end</td>
</tr>
</table>

<h3>Roteiro de entrega</h3>

<pre>
 ETAPA 1            ETAPA 2            ETAPA 3            ETAPA 4
 ┌──────────┐       ┌──────────┐       ┌──────────┐       ┌──────────┐
 │ Decidir  │ ───►  │ Construir│ ───►  │ Integrar │ ───►  │ Preparar │
 │ campos e │       │ módulos  │       │ e testar │       │ apresen- │
 │ papéis   │       │          │       │          │       │ tação    │
 └──────────┘       └──────────┘       └──────────┘       └──────────┘
</pre>

<img src="assets/divider.svg" alt="" width="100%">

<div align="center">

<img src="assets/vida-xp.svg" alt="Barra de vida e de experiência decorativas" width="700">


<img src="https://img.shields.io/badge/SPAWNLY-PROJETO_ACAD%C3%8AMICO_DE_CRUD-152820?style=for-the-badge&labelColor=4ca66a" alt="Spawnly, projeto acadêmico de CRUD"><br><br>

Centro Universitário do Distrito Federal (UDF)<br><br>

<i>Que o seu próximo mundo seja o melhor já gerado.</i>

</div>
