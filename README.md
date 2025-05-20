### Projeto DBT com dados de clientes e vendas.

 O objetivo do projeto foi simular um cenário de negócio para aplicar práticas modernas de engenharia de dados, como modelos incrementais e transformações SQL modularizadas que o dbt proporciona.

<br>

### Activação do pyenv no prompt:
```
python -m venv my_env
.\venv\bin\activate
```

### Instalação 
1. `pip install -r requirements.txt`
2. criar `.env` e adicionar credenciais do banco dentro da pasta do projeto
```
export GCP_DEV_PROJECT="seu_banco_de_dados"
export DBT_DEV_SCHEMA="dev_seu_nome"
export GCP_DEV_KEYFILE_PATH="seu_json_de_credenciais_do_GCP.json"
```
3. `dbt debug` para checar se está tudo certo.
4. `dbt deps` instala as dependências.

### Testando macros
`dbt run-operation <macro> (--vars)`

Ex.  
```
dbt run-operation get_start_date
```
### Rodando modelos:
`dbt run --select <nome> <argumentos opcionais>`  
Ex.
```
dbt run --select clientes --target dev
```
##### Passo a passo do que foi feito em atividade pratica
1. Remover clientes duplicados
2. Criar colunas calculadas ex. anos, tempo de serviço
3. Detalhes do pedido
4. Tabela desnormalizadas (inclusão de joins)
5. Particionamento ex. divisão por ano

<br>
obs: caso precise dos dados em csv, se encontra em: `data.zip`