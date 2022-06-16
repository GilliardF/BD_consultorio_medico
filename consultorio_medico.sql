CREATE SCHEMA consultorio_medico;

CREATE TABLE tb_paciente (
                cpf VARCHAR(11) NOT NULL,
                nome_completo VARCHAR(45) NOT NULL,
                nome VARCHAR(15) NOT NULL,
                sobrenome VARCHAR(30) NOT NULL,
                rg VARCHAR(8) NOT NULL,
                sexo VARCHAR(1) NOT NULL,
                data_nascimento DATE NOT NULL,
                endereco VARCHAR(20) NOT NULL,
                bairro VARCHAR(12) NOT NULL,
                cidade VARCHAR(12) NOT NULL,
                estado VARCHAR(2) NOT NULL,
                cep VARCHAR(9) NOT NULL,
                telefone_fixo VARCHAR(15) NOT NULL,
                celular VARCHAR(15) NOT NULL,
                email VARCHAR(25) NOT NULL,
                plano_saude_id_matricula VARCHAR(10),
                plano_saude_nome_plano VARCHAR(15),
                PRIMARY KEY (cpf, nome_completo));

CREATE TABLE tb_medico (
                crm VARCHAR(10) NOT NULL,
                nome_completo VARCHAR(45) NOT NULL,
                especializacao VARCHAR(20) NOT NULL,
                id_especializacao VARCHAR(10) NOT NULL,
                nome VARCHAR(15) NOT NULL,
                sobrenome VARCHAR(30) NOT NULL,
                endereco VARCHAR(20) NOT NULL,
                bairro VARCHAR(12) NOT NULL,
                cidade VARCHAR(12) NOT NULL,
                estado VARCHAR(2) NOT NULL,
                cep VARCHAR(9) NOT NULL,
                telefone_fixo VARCHAR(15),
                celular VARCHAR(15) NOT NULL,
                email VARCHAR(25) NOT NULL,
                PRIMARY KEY (crm, nome_completo, especializacao));

CREATE TABLE tb_especializacao ( id_especializacao VARCHAR(10) NOT NULL,
				tipo VARCHAR(20) NOT NULL, PRIMARY KEY (id_especializacao, tipo));
                
CREATE TABLE tb_plano_saude (id_matricula VARCHAR(10) NOT NULL,
                nome_plano VARCHAR(15) NOT NULL,
                PRIMARY KEY (id_matricula, nome_plano));

CREATE TABLE tb_consulta (
                id_consulta INT NOT NULL,
                data_agendamento DATE NOT NULL,
                id_paciente VARCHAR(11) NOT NULL,
                nome_paciente VARCHAR(45) NOT NULL,
                id_medico VARCHAR(10) NOT NULL,
                nome_medico VARCHAR(45) NOT NULL,
                especialidade_medico VARCHAR(20) NOT NULL,
                id_plano VARCHAR(10),
                nome_plano VARCHAR(15),
                PRIMARY KEY (id_consulta));

ALTER TABLE tb_especializacao MODIFY COLUMN tipo VARCHAR(20) COMMENT 'Descreve o tipo/nome da especialização.';

ALTER TABLE tb_medico MODIFY COLUMN especializacao VARCHAR(20) COMMENT 'Descreve o tipo/nome da especialização.';

ALTER TABLE tb_medico MODIFY COLUMN estado VARCHAR(2) COMMENT 'Referente para deixar salvar dados do tipo UF com apenas dois caracteres, exemplo: DF.';

ALTER TABLE tb_paciente MODIFY COLUMN cpf VARCHAR(11) COMMENT 'Salvar dados referente ao cpf (somente numeros).';

ALTER TABLE tb_paciente MODIFY COLUMN sexo VARCHAR(1) COMMENT 'Salvar dados referente ao sexo com 1 caractere, "M" masculino e "F" feminino.';

ALTER TABLE tb_paciente MODIFY COLUMN estado VARCHAR(2) COMMENT 'Referente para deixar salvar dados do tipo UF com apenas dois caracteres, exemplo: DF.';

ALTER TABLE tb_paciente MODIFY COLUMN plano_saude_id_matricula VARCHAR(10) COMMENT 'Se o paciente tiver plano de saude sera armazenado os dados referente ao identificador.';

ALTER TABLE tb_paciente MODIFY COLUMN plano_saude_nome_plano VARCHAR(15) COMMENT 'Se o paciente tiver plano de saude sera armazenado os dados referente ao nome.';

ALTER TABLE tb_consulta MODIFY COLUMN id_consulta INTEGER COMMENT 'Identificar de consultas, não sendo aceito o primeiro digito ser 0.';

ALTER TABLE tb_consulta MODIFY COLUMN id_paciente VARCHAR(11) COMMENT 'Salvar dados referente ao id_paciente/cpf.';

ALTER TABLE tb_consulta MODIFY COLUMN especialidade_medico VARCHAR(20) COMMENT 'Descreve o tipo/nome da especialização.';

ALTER TABLE tb_medico ADD CONSTRAINT tb_especializacao_tb_medico_fk
FOREIGN KEY (id_especializacao, especializacao)
REFERENCES tb_especializacao (id_especializacao, tipo)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE tb_paciente ADD CONSTRAINT tb_plano_saude_tb_paciente_fk1
FOREIGN KEY (plano_saude_id_matricula, plano_saude_nome_plano)
REFERENCES tb_plano_saude (id_matricula, nome_plano)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE tb_consulta ADD CONSTRAINT tb_paciente_tb_consulta_fk
FOREIGN KEY (id_paciente, nome_paciente)
REFERENCES tb_paciente (cpf, nome_completo)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE tb_consulta ADD CONSTRAINT tb_plano_saude_tb_consulta_fk
FOREIGN KEY (id_plano, nome_plano)
REFERENCES tb_plano_saude (id_matricula, nome_plano)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE tb_consulta ADD CONSTRAINT tb_medico_tb_consulta_fk
FOREIGN KEY (id_medico, nome_medico, especialidade_medico)
REFERENCES tb_medico (crm, nome_completo, especializacao)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

SHOW TABLES;