CREATE TABLE "empresas" (
  "id" integer PRIMARY KEY,
  "nome_completo" varchar,
  "nome_fantasia" varchar,
  "cnpj" varchar,
  "tipo" varchar,
  "plano_assinatura" varchar,
  "senha_empresa" varchar,
  "created_at" timestamp,
  "updated_at" timestamp
);

CREATE TABLE "usuarios" (
  "id" integer PRIMARY KEY,
  "empresa_id" integer NOT NULL,
  "nome" varchar,
  "email" varchar,
  "senha_hash" varchar,
  "funcao_operacional" varchar,
  "created_at" timestamp,
  "updated_at" timestamp
);

CREATE TABLE "clientes" (
  "id" integer PRIMARY KEY,
  "empresa_id" integer NOT NULL,
  "nome" varchar,
  "cpf_cnpj" varchar,
  "email" varchar,
  "telefone" varchar,
  "created_at" timestamp,
  "updated_at" timestamp
);

CREATE TABLE "fornecedores" (
  "id" integer PRIMARY KEY,
  "empresa_id" integer NOT NULL,
  "razao_social" varchar,
  "cnpj" varchar,
  "email" varchar,
  "telefone" int,
  "created_at" timestamp,
  "updated_at" timestamp
);

CREATE TABLE "produtos_servicos" (
  "id" integer PRIMARY KEY,
  "empresa_id" integer NOT NULL,
  "fornecedor_id" integer NOT NULL,
  "fornecedor" varchar,
  "nome" varchar,
  "sku" varchar,
  "tipo_pedido" varchar,
  "preco_venda" decimal,
  "preco_custo" decimal,
  "quantidade_estoque" integer,
  "limite_minimo_estoque" integer,
  "observação" jsonb,
  "created_at" timestamp,
  "updated_at" timestamp
);

CREATE TABLE "centro_custos" (
  "id" integer PRIMARY KEY,
  "empresa_id" integer NOT NULL,
  "nome" varchar,
  "created_at" timestamp,
  "updated_at" timestamp
);

CREATE TABLE "transacoes_financeiras" (
  "id" integer PRIMARY KEY,
  "empresa_id" integer NOT NULL,
  "tipo" varchar,
  "valor" decimal,
  "categoria" varchar,
  "data_vencimento" timestamp,
  "status" varchar,
  "produtos_servicos_id" integer NOT NULL,
  "vendas_id" integer NOT NULL,
  "created_at" timestamp,
  "updated_at" timestamp
);

CREATE TABLE "vendas" (
  "id" integer PRIMARY KEY,
  "empresa_id" integer NOT NULL,
  "cliente_id" integer NOT NULL,
  "data_venda" timestamp,
  "valor_total" decimal,
  "forma_pagamento" varchar,
  "created_at" timestamp,
  "updated_at" timestamp
);

CREATE TABLE "itens_venda" (
  "id" integer PRIMARY KEY,
  "venda_id" integer NOT NULL,
  "produto_id" integer NOT NULL,
  "quantidade" integer,
  "preco_unitario_praticado" decimal,
  "created_at" timestamp,
  "updated_at" timestamp
);

CREATE TABLE "funcionarios" (
  "id" integer PRIMARY KEY,
  "empresa_id" integer NOT NULL,
  "nome" varchar,
  "cargo" varchar,
  "data_admissao" timestamp,
  "data_demissao" timestamp,
  "salario_base" decimal,
  "tipo_contrato" varchar,
  "created_at" timestamp,
  "updated_at" timestamp
);

CREATE TABLE "ferias" (
  "id" integer PRIMARY KEY,
  "funcionario_id" integer NOT NULL,
  "empresa_id" integer NOT NULL,
  "data_inicio" timestamp,
  "data_fim" timestamp,
  "status" varchar,
  "valor" decimal,
  "created_at" timestamp,
  "updated_at" timestamp
);

ALTER TABLE "ferias" ADD FOREIGN KEY ("funcionario_id") REFERENCES "funcionarios" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "usuarios" ADD FOREIGN KEY ("empresa_id") REFERENCES "empresas" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "clientes" ADD FOREIGN KEY ("empresa_id") REFERENCES "empresas" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "fornecedores" ADD FOREIGN KEY ("empresa_id") REFERENCES "empresas" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "produtos_servicos" ADD FOREIGN KEY ("empresa_id") REFERENCES "empresas" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "centro_custos" ADD FOREIGN KEY ("empresa_id") REFERENCES "empresas" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "transacoes_financeiras" ADD FOREIGN KEY ("empresa_id") REFERENCES "empresas" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "funcionarios" ADD FOREIGN KEY ("empresa_id") REFERENCES "empresas" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "vendas" ADD FOREIGN KEY ("empresa_id") REFERENCES "empresas" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "vendas" ADD FOREIGN KEY ("cliente_id") REFERENCES "clientes" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "itens_venda" ADD FOREIGN KEY ("venda_id") REFERENCES "vendas" ("id") DEFERRABLE INITIALLY IMMEDIATE;
