-- apagar usuário gustavo se existir
drop user if exists gustavo;

-- apagar banco de dados uvv se existir
drop database if exists uvv;

-- apagar role gustavo se existir
drop role if exists gustavo;

-- Criar usuário com senha criptografada 
CREATE USER gustavo WITH encrypted password 'senha1' createdb createrole;

-- colocar a role como o usuário gustavo
set role gustavo;

-- Criar banco de dados 
CREATE Database uvv
WITH 
owner             =  gustavo
template          = 'template0'
encoding          = "UTF8"
lc_collate        = 'pt_BR.UTF-8'
lc_ctype          = 'pt_BR.UTF-8'
allow_connections = TRUE;

-- salvar a senha do banco de dados para entrada automática
\setenv PGPASSWORD senha1

-- Conectar ao banco de dados uvv com o usuario gustavo 
\c uvv gustavo

-- Criar schema lojas
CREATE SCHEMA lojas;

-- Autorizando o usuário a utilizar o schema lojas
GRANT USAGE, CREATE ON SCHEMA  lojas TO gustavo;

-- Fazendo com que o schema lojas seja o schema padrão do usuário gustavo
ALTER USER gustavo 
SET search_path TO lojas, "$user", public;

                                                               -- criando as tabelas do schema uvv

-- criando a tabela produtos, suas colunas e sua PK
CREATE TABLE lojas.produtos (
                produto_id                NUMERIC(38)   NOT NULL,
                nome                      VARCHAR(255)  NOT NULL,
                preco_unitario            NUMERIC(10,2),
                detalhes                  BYTEA,
                imagem                    BYTEA,
                imagem_mime_type          VARCHAR(512),
                imagem_arquivo            NUMERIC(512),
                imagem_charset            VARCHAR(512),
                imagem_ultima_atualizacao DATE,
                CONSTRAINT pk_produtos PRIMARY KEY (produto_id)
);

-- comentando a tabela produtos e suas colunas
COMMENT ON TABLE lojas.produtos                            IS 'mostra os dados dos produtos das lojas UVV.';
COMMENT ON COLUMN lojas.produtos.produto_id                IS 'código dos produtos das lojas UVV.';
COMMENT ON COLUMN lojas.produtos.nome                      IS 'nome dos produtos das lojas UVV.';
COMMENT ON COLUMN lojas.produtos.preco_unitario            IS 'preço unitario dos produtos das lojas UVV.';
COMMENT ON COLUMN lojas.produtos.detalhes                  IS 'detalhes dos produtos vendidos nas lojas UVV.';
COMMENT ON COLUMN lojas.produtos.imagem                    IS 'imagens dos produtos das lojas UVV.';
COMMENT ON COLUMN lojas.produtos.imagem_mime_type          IS 'mostra onde os documentos das imagens estão salvos.';
COMMENT ON COLUMN lojas.produtos.imagem_arquivo            IS 'mostra em que arquivo as imagens das lojas UVV estão salvas.';
COMMENT ON COLUMN lojas.produtos.imagem_charset            IS 'charset das imagens das lojas UVV.';
COMMENT ON COLUMN lojas.produtos.imagem_ultima_atualizacao IS 'mostra a ultima vez que as imagens das lojas UVV foram atualizadas.';

--Criando a tabela lojas, suas colunas e sua PK
CREATE TABLE lojas.lojas (
                loja_id                 NUMERIC(38)  NOT NULL,
                nome                    VARCHAR(255) NOT NULL,
                endereco_web            VARCHAR(100),
                endereco_fisico         VARCHAR(512),
                latitude                NUMERIC,
                longitude               NUMERIC,
                logo                    BYTEA,
                logo_mime_type          VARCHAR(512),
                logo_arquivo            VARCHAR(512),
                logo_charset            VARCHAR(512),
                logo_ultima_atualizacao DATE,
                CONSTRAINT pk_lojas PRIMARY KEY (loja_id)
);
-- comentando a tabela lojas e suas colunas
COMMENT ON TABLE lojas.lojas                          IS 'mostra os dados das lojas UVV.';
COMMENT ON COLUMN lojas.lojas.loja_id                 IS 'código das lojas UVV.';
COMMENT ON COLUMN lojas.lojas.nome                    IS 'nome das lojas UVV.';
COMMENT ON COLUMN lojas.lojas.endereco_web            IS 'endereço dos sites das lojas UVV.';
COMMENT ON COLUMN lojas.lojas.endereco_fisico         IS 'endereço fisico das lojas UVV.';
COMMENT ON COLUMN lojas.lojas.latitude                IS 'latitude das lojas UVV.';
COMMENT ON COLUMN lojas.lojas.longitude               IS 'longitude das lojas UVV.';
COMMENT ON COLUMN lojas.lojas.logo                    IS 'logo das lojas UVV.';
COMMENT ON COLUMN lojas.lojas.logo_mime_type          IS 'mostra onde os documentos das logos das lojas UVV estão salvos.';
COMMENT ON COLUMN lojas.lojas.logo_arquivo            IS 'arquivo onde as logos das lojas UVV estão salvas.';
COMMENT ON COLUMN lojas.lojas.logo_charset            IS 'charset das logos das lojas UVV.';
COMMENT ON COLUMN lojas.lojas.logo_ultima_atualizacao IS 'mostra a ultima vez em que as logos das lojas UVV foram atualizadas.';

-- criando a tabela estoques, suas colunas e sua PK
CREATE TABLE lojas.estoques (
                estoque_id NUMERIC(38) NOT NULL,
                loja_id    NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                CONSTRAINT pk_estoques PRIMARY KEY (estoque_id)
);
-- comentando a tabela estoques e suas colunas
COMMENT ON TABLE lojas.estoques             IS 'mostra os dados do estoque de produtos das lojas UVV.';
COMMENT ON COLUMN lojas.estoques.estoque_id IS 'código do estoque das lojas UVV.';
COMMENT ON COLUMN lojas.estoques.loja_id    IS 'código das lojas UVV.';
COMMENT ON COLUMN lojas.estoques.produto_id IS 'código dos produtos das lojas UVV.';
COMMENT ON COLUMN lojas.estoques.quantidade IS 'quantidade de itens ainda no estoque das lojas UVV.';

-- criando a tabela clientes, suas colunas e sua PK
CREATE TABLE lojas.clientes (
                cliente_id NUMERIC(38)  NOT NULL,
                email      VARCHAR(255) NOT NULL,
                nome       VARCHAR(255) NOT NULL,
                telefone1  VARCHAR(20),
                telefone2  VARCHAR(20),
                telefone3  VARCHAR(20),
                CONSTRAINT pk_clientes PRIMARY KEY (cliente_id)
);
-- comentando a tabela clientes e suas colunas
COMMENT ON TABLE  lojas.clientes             IS 'mostra alguns dados dos clientes das lojas UVV';
COMMENT ON COLUMN lojas.clientes.cliente_id IS 'código dos clientes das lojas UVV.';
COMMENT ON COLUMN lojas.clientes.email      IS 'email dos clientes das lojas UVV.';
COMMENT ON COLUMN lojas.clientes.nome       IS 'nome dos clientes das lojas UVV.';
COMMENT ON COLUMN lojas.clientes.telefone1  IS 'número primário dos clientes das lojas UVV.';
COMMENT ON COLUMN lojas.clientes.telefone2  IS 'número secundário dos clientes das lojas UVV.';
COMMENT ON COLUMN lojas.clientes.telefone3  IS 'número terciário dos clientes das lojas UVV.';

-- criando a tabela envios, suas colunas e sua PK
CREATE TABLE lojas.envios (
                envio_id         NUMERIC(38)  NOT NULL,
                loja_id          NUMERIC(38)  NOT NULL,
                cliente_id       NUMERIC(38)  NOT NULL,
                endereco_entrega VARCHAR(512) NOT NULL,
                status           VARCHAR(15)  NOT NULL,
                CONSTRAINT pk_envios PRIMARY KEY (envio_id)
);
-- comentando a tabela envios e suas colunas
COMMENT ON TABLE lojas.envios                   IS 'dados sobre o envio dos produtos das lojas UVV.';
COMMENT ON COLUMN lojas.envios.envio_id         IS 'código dos envios feitos pelas lojas UVV.';
COMMENT ON COLUMN lojas.envios.loja_id          IS 'código das lojas UVV.';
COMMENT ON COLUMN lojas.envios.cliente_id       IS 'código dos clientes das lojas UVV.';
COMMENT ON COLUMN lojas.envios.endereco_entrega IS 'endereço onde os produtos das lojas UVV devem ser entregues.';
COMMENT ON COLUMN lojas.envios.status           IS 'status dos envios dos produtos das lojas UVV.';

-- criando a tabela pedidos, suas colunas e sua PK
CREATE TABLE lojas.pedidos (
                pedido_id  NUMERIC(38) NOT NULL,
                data_hora  TIMESTAMP   NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                status     VARCHAR(15) NOT NULL,
                loja_id    NUMERIC(38) NOT NULL,
                CONSTRAINT pk_pedidos PRIMARY KEY (pedido_id)
);
-- comentando a tabela pedidos e suas colunas
COMMENT ON TABLE lojas.pedidos             IS 'mostra os dados dos pedidos dos clientes.';
COMMENT ON COLUMN lojas.pedidos.pedido_id  IS 'código do pedido do cliente.';
COMMENT ON COLUMN lojas.pedidos.data_hora  IS 'data e hora em que o pedido do cliente foi feito.';
COMMENT ON COLUMN lojas.pedidos.cliente_id IS 'código dos clientes das lojas UVV.';
COMMENT ON COLUMN lojas.pedidos.status     IS 'status dos pedidos feitos pelos clientes das lojas UVV.';
COMMENT ON COLUMN lojas.pedidos.loja_id    IS 'código das lojas UVV.';

-- criando a tabela pedidos_itens, suas colunas e sua PK
CREATE TABLE lojas.pedidos_itens (
                pedido_id       NUMERIC(38)   NOT NULL,
                produto_id      NUMERIC(38)   NOT NULL,
                numero_da_linha NUMERIC(38)   NOT NULL,
                preco_unitario  NUMERIC(10,2) NOT NULL,
                quantidade      NUMERIC(38)   NOT NULL,
                envio_id        NUMERIC(38)   NOT NULL,
                CONSTRAINT pk_pedidos_itens PRIMARY KEY (pedido_id, produto_id)
);
-- comentando a tabela pedidos_itens e suas colunas
COMMENT ON TABLE lojas.pedidos_itens                  IS 'mostra os dados sobre os itens que foram pedidos das lojas UVV.';
COMMENT ON COLUMN lojas.pedidos_itens.pedido_id       IS 'código dos pedidos feitos nas lojas UVV.';
COMMENT ON COLUMN lojas.pedidos_itens.produto_id      IS 'código dos produtos das lojas UVV.';
COMMENT ON COLUMN lojas.pedidos_itens.numero_da_linha IS 'número da linha dos produtos das lojas UVV.';
COMMENT ON COLUMN lojas.pedidos_itens.preco_unitario  IS 'preço unitário dos produtos das lojas UVV.';
COMMENT ON COLUMN lojas.pedidos_itens.quantidade      IS 'quantidade dos produtos das lojas UVV.';
COMMENT ON COLUMN lojas.pedidos_itens.envio_id        IS 'código dos envios feitos pelas lojas UVV.';

                                                        -- Criando as foreign key das tabelas 
-- tornando a PK de produtos a FK de estoques
ALTER TABLE lojas.estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- tornando a PK de produtos a FK de pedidos_itens
ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- tornando a PK de lojas a FK de pedidos
ALTER TABLE lojas.pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- tornando a PK de lojas a FK de estoques
ALTER TABLE lojas.estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- tornando a PK de lojas a FK de envios
ALTER TABLE lojas.envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- tornando a PK de clientes a FK de pedidos
ALTER TABLE lojas.pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- tornando a PK de clientes a FK de envios
ALTER TABLE lojas.envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- tornando a PK de envios a FK de pedidos_itens
ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES lojas.envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- tonarndo a PK de pedidos a FK de pedidos_itens
alter table lojas.pedidos_itens add constraint pedidos_pedidos_itens_fk
foreign key (pedido_id)
references lojas.pedidos (pedido_id)
ON DELETE no action
ON UPDATE no action
not deferrable;

                                                                      -- criando as restrições das colunas

-- criando as restrições da tabela produtos
ALTER TABLE lojas.produtos
ADD CONSTRAINT check_preco_unitario_produtos
CHECK (preco_unitario >= 0);

-- criando as restrições da tabela lojas
ALTER TABLE lojas.lojas
ADD CONSTRAINT check_enderecos_lojas
CHECK (endereco_web IS NOT NULL OR endereco_fisico IS NOT NULL);

-- criando as restrições da tabela estoques
ALTER TABLE lojas.estoques
ADD CONSTRAINT check_quantidade_estoques
CHECK (quantidade >= 0);

-- Criando as restrições da tabela envios
ALTER TABLE lojas.envios
ADD CONSTRAINT check_status_envios
CHECK (status IN ('Criado','enviado','transito','entregue'));

-- Criando as restrições da tabela pedidos
ALTER TABLE lojas.pedidos
ADD CONSTRAINT check_status_pedidos
CHECK (status IN ('cancelado','completo','aberto','pago','reembolsado','enviado'));

--criando as restrições da tabela pedidos_itens
ALTER TABLE lojas.pedidos_itens
ADD CONSTRAINT check_quantidade_pedidos_itens
CHECK (quantidade >= 0);

ALTER TABLE lojas.pedidos_itens
ADD CONSTRAINT check_preco_unitario_pedidos_itens
CHECK (preco_unitario >= 0);

