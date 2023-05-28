
DROP DATABASE IF EXISTS uvv;
DROP USER IF EXISTS luiz;
CREATE USER luiz WITH PASSWORD 'computacao@raiz' CREATEDB;

											-- Criar o banco de dados "UVV" --

CREATE 		DATABASE uvv
			owner luiz
			template template0
			encoding 'UTF8'
			lc_collate 'pt_BR.UTF8'
			lc_ctype 'pt_BR.UTF8'
			allow_connections TRUE;
		
\c 'dbname=uvv user=luiz password=computacao@raiz'

											-- Criar o esquema --

CREATE SCHEMA lojas AUTHORIZATION luiz;
ALTER USER luiz 
SET SEARCH_PATH TO lojas, "$user", public;
SET SEARCH_PATH TO lojas, "$user", public;

			
											-- Cria a tabela produtos --

CREATE TABLE produtos (
                produto_id  												NUMERIC(38) NOT NULL,
                nome 														VARCHAR(255) NOT NULL,
                preco_unitario 												NUMERIC(10,2),
                detalhes BYTEA,
                imagem 														BYTEA,
                imagem_mime_type 											VARCHAR(512),
                imagem_arquivo 												VARCHAR(512),
                imagem_charset 												VARCHAR(512),
                imagem_ultima_atualizacao 									DATE,
                CONSTRAINT produto_id 										PRIMARY KEY (produto_id)
);
				COMMENT ON COLUMN produtos.produto_id 						IS 'id do produto.';
				COMMENT ON COLUMN produtos.nome 							IS 'nome do produto.';
				COMMENT ON COLUMN produtos.preco_unitario 					IS 'preco da unidade';
				COMMENT ON COLUMN produtos.detalhes 						IS 'detalhes.';
				COMMENT ON COLUMN produtos.imagem 							IS 'imagem.';
				COMMENT ON COLUMN produtos.imagem_mime_type 				IS 'imagem mime type.';
				COMMENT ON COLUMN produtos.imagem_arquivo 					IS 'imagem do arquivo.';
				COMMENT ON COLUMN produtos.imagem_charset 					IS 'imagem charset.';
				COMMENT ON COLUMN produtos.imagem_ultima_atualizacao 		IS 'ultima atualizacao';

											-- Cria a tabela lojas --

CREATE TABLE lojas (
                loja_id 													NUMERIC(38) NOT NULL,
                endereco_web 												VARCHAR(100),
                endereco_fisico 											VARCHAR(512),
                nome 														VARCHAR(255) NOT NULL,
                latitude 													NUMERIC,
                logo 														BYTEA,
                longitude 													NUMERIC,
                logo_mime_type 												VARCHAR(512),
                logo_arquivo 												VARCHAR(512),
                logo_charset 												VARCHAR(512),
                logo_ultima_atualizacao 									DATE,
                CONSTRAINT loja_id 											PRIMARY KEY (loja_id)
);
				COMMENT ON COLUMN lojas.loja_id 							IS 'id da loja.';
				COMMENT ON COLUMN lojas.endereco_web 						IS 'endereco web.';
				COMMENT ON COLUMN lojas.endereco_fisico 					IS 'endereco fisico.';
				COMMENT ON COLUMN lojas.nome 								IS 'nome.';
				COMMENT ON COLUMN lojas.latitude 							IS 'latitude.';
				COMMENT ON COLUMN lojas.logo 								IS 'logo.';
				COMMENT ON COLUMN lojas.longitude 							IS 'longitude.';
				COMMENT ON COLUMN lojas.logo_mime_type 						IS 'tipo da logo.';
				COMMENT ON COLUMN lojas.logo_arquivo 						IS 'arquivo da logo.';
				COMMENT ON COLUMN lojas.logo_charset 						IS 'charset da logo.';
				COMMENT ON COLUMN lojas.logo_ultima_atualizacao 			IS 'ultima atualizacao da logo.';

			
											-- Cria a tabela estoques --

CREATE TABLE estoques (
                estoque_id 													NUMERIC(38) NOT NULL,
                produto_id 													NUMERIC(38) NOT NULL,
                loja_id 													NUMERIC(38) NOT NULL,
                quantidade 													NUMERIC(38) NOT NULL,
                CONSTRAINT estoque_id 										PRIMARY KEY (estoque_id)
);
				COMMENT ON COLUMN estoques.estoque_id 						IS 'id do estoque.';
				COMMENT ON COLUMN estoques.produto_id 						IS 'id do produto.';
				COMMENT ON COLUMN estoques.loja_id 							IS 'id da loja.';
				COMMENT ON COLUMN estoques.quantidade 						IS 'quantidade de produtos no estoque.';

											
			
											-- Cria a tabela clientes --			
			
			
CREATE TABLE clientes (
                cliente_id 													NUMERIC(38) NOT NULL,
                nome 														VARCHAR(255) NOT NULL,
                email 														VARCHAR(255) NOT NULL,
                telefone1 													VARCHAR(20),
                telefone3 													VARCHAR(20),
                telefone2 													VARCHAR(20),
                CONSTRAINT cliente_id 										PRIMARY KEY (cliente_id)
);
				COMMENT ON TABLE clientes 									IS 'Tabela de clientes';
				COMMENT ON COLUMN clientes.cliente_id 						IS 'ID do cliente.';
				COMMENT ON COLUMN clientes.nome 							IS 'nome do cliente.';
				COMMENT ON COLUMN clientes.email 							IS 'email do cliente.';
				COMMENT ON COLUMN clientes.telefone1 						IS 'telefone do cliente.';
				COMMENT ON COLUMN clientes.telefone3 						IS 'terceiro telefone do cliente.';
				COMMENT ON COLUMN clientes.telefone2 						IS 'segundo telefone do cliente.';

			
											-- Cria a tabela envios --

CREATE TABLE envios (
                envio_id 													VARCHAR(38) NOT NULL,
                endereco_entrega 											VARCHAR(512) NOT NULL,
                status 														VARCHAR(15) NOT NULL,
                loja_id 													NUMERIC(38) NOT NULL,
                cliente_id 													NUMERIC(38) NOT NULL,
                CONSTRAINT envio_id PRIMARY KEY (envio_id)
);
				COMMENT ON COLUMN envios.envio_id 							IS 'id de envio';
				COMMENT ON COLUMN envios.endereco_entrega 					IS 'endereco de entrega.';
				COMMENT ON COLUMN envios.status 							IS 'status do envio.';
				COMMENT ON COLUMN envios.loja_id 							IS 'id da loja.';
				COMMENT ON COLUMN envios.cliente_id 						IS 'ID do cliente.';


			
											-- Cria a tabela pedidos --
			
			
CREATE TABLE pedidos (
                pedidos_id 													NUMERIC(38) NOT NULL,
                status 														VARCHAR(15) NOT NULL,
                data_hora 													TIMESTAMP NOT NULL,
                cliente_id 													NUMERIC(38) NOT NULL,
                loja_id 													NUMERIC(38) NOT NULL,
                CONSTRAINT pedidos_id 										PRIMARY KEY (pedidos_id)
);
				COMMENT ON COLUMN pedidos.pedidos_id 						IS 'id do pedido.';
				COMMENT ON COLUMN pedidos.status 							IS 'status do pedido,';
				COMMENT ON COLUMN pedidos.data_hora 						IS 'data e hora.';
				COMMENT ON COLUMN pedidos.cliente_id 						IS 'ID do cliente.';
				COMMENT ON COLUMN pedidos.loja_id 							IS 'id da loja.';


			
											--Cria a tabela pedido_itens--	
											
			
CREATE TABLE pedido_itens (
                produto_id 													NUMERIC(38) NOT NULL,
                pedidos_id 													NUMERIC(38) NOT NULL,
                numero_da_linha 											NUMERIC(38) NOT NULL,
                preco_unitario 												NUMERIC(10,2) NOT NULL,
                quantidade 													NUMERIC(38) NOT NULL,
                envio_id 													VARCHAR(38),
                CONSTRAINT pedido_id 										PRIMARY KEY (produto_id, pedidos_id)
);
				COMMENT ON COLUMN pedido_itens.produto_id 					IS 'id do produto.';
				COMMENT ON COLUMN pedido_itens.pedidos_id 					IS 'id do pedido.';
				COMMENT ON COLUMN pedido_itens.numero_da_linha 				IS 'numero da linha';
				COMMENT ON COLUMN pedido_itens.preco_unitario 				IS 'preco unitario dos produtos.';
				COMMENT ON COLUMN pedido_itens.quantidade 					IS 'quantidade.';
				COMMENT ON COLUMN pedido_itens.envio_id 					IS 'id de envio';

			


ALTER TABLE estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedido_itens ADD CONSTRAINT produtos_pedido_itens_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedido_itens ADD CONSTRAINT envios_pedido_itens_fk
FOREIGN KEY (envio_id)
REFERENCES envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedido_itens ADD CONSTRAINT pedidos_pedido_itens_fk
FOREIGN KEY (pedidos_id)
REFERENCES pedidos (pedidos_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;



--Verifica o estado da compra do pedido, se já foi completado, aberto, pago, reembolsado, enviado ou cancelado--

ALTER TABLE pedidos ADD CONSTRAINT status_pedidos
CHECK (status IN('CANCELADO, COMPLETO, ABERTO, PAGO, REEMBOLSADO E ENVIADO'));

--Verifica o estado do envio pedido, se ele foi criado, enviado, está em trânsito ou foi entregue--

ALTER TABLE envios ADD CONSTRAINT status_envios
CHECK (status IN('CRIADO, ENVIADO, TRANSITO, ENTREGUE'));

ALTER TABLE lojas 		ADD CONSTRAINT enderecos
CHECK ((endereco_web IS NOT NULL AND endereco_fisico IS NULL) OR (endereco_web IS NULL AND endereco_fisico IS NOT NULL));











