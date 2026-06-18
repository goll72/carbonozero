-- Obs. todos os inserts foram colocados em uma única transação para
-- facilitar a depuração: cada vez que o script é rodado todas as
-- inserções são feitas com sucesso ou nenhuma inserção é feita,
-- permitindo corrigir bugs e rodar o script novamente. Além disso,
-- podemos ignorar temporariamente algumas restrições, fazendo as
-- inserções em uma ordem mais conveniente, porém ainda garantindo
-- a consistência dos dados, como mencionado a seguir.

BEGIN TRANSACTION;

-- A inserção em `uf` e `org_adm_mun` antes de `ent_fed` viola as restrições de
-- integridade referencial (chaves estrangeiras), por isso habilitamos o modo
-- "deferred", para que as restrições sejam verificadas apenas no final da transação.
SET CONSTRAINTS ALL DEFERRED;

INSERT INTO uf VALUES
    ('SP', '35'),
    ('PR', '41'),
    ('SC', '42'),
    ('RS', '43'),
    ('AM', '13'),
    ('MA', '21'),
    ('RN', '24'),
    ('PE', '26'),
    ('SE', '28'),
    ('BA', '29'),
    ('MG', '31'),
    ('RJ', '33'),
    ('MT', '51'),
    ('DF', '53'),
    ('ES', '32')
ON CONFLICT DO NOTHING;

INSERT INTO org_adm_mun VALUES
    ('3505906', '92.574.068/0001-00', 'Prefeitura da Estância Turística de Batatais', 'Trevo de das Neves', 9509, '14301-144', 'Batatais', 'SP'),
    ('3548906', '18.653.207/0001-20', 'Defesa Civil de São Carlos', 'Passarela Santos', 5710, '13001-301', 'São Carlos', 'SP'),
    ('3501905', '92.657.083/0001-04', 'Prefeitura de Amparo', 'Avenida Olivia Mendonça', 4953, '17456-090', 'Amparo', 'SP'),
    ('3550308', '51.840.276/0001-19', 'Órgão Gestor Ambiental de São Paulo', 'Conjunto de Pacheco', 7448, '11001-030', 'São Paulo', 'SP'),
    ('3106200', '30.618.594/0001-60', 'Gerência Ambiental de Belo Horizonte', 'Largo Moraes', 4052, '39910-305', 'Belo Horizonte', 'MG'),
    ('3146206', '43.061.298/0001-52', 'Prefeitura de Ouro Verde de Minas', 'Chácara Montenegro', 2949, '38402-110', 'Ouro Verde de Minas', 'MG'),
    ('3146107', '39.861.402/0001-16', 'Defesa Civil de Ouro Preto', 'Praça Pedro Novais', 2354, '39702-141', 'Ouro Preto', 'MG'),
    ('3304557', '29.086.354/0001-82', 'Administração Ambiental', 'Feira Erick Correia', 6806, '38010-112', 'Rio de Janeiro', 'RJ'),
    ('3306305', '12.736.805/0001-87', 'Prefeitura de Volta Redonda', 'Largo de Freitas', 4809, '21130-012', 'Volta Redonda', 'RJ'),
    ('3205309', '01.264.593/0001-66', 'Defesa Civil de Vitória', 'Aeroporto Leão', 2211, '29110-012', 'Vitória', 'ES'),
    ('2927408', '04.576.382/0001-57', 'Fiscalização Ambiental da Macrorregião de Salvador', 'Rua de Araújo', 7522, '43040-120', 'Salvador', 'BA'),
    ('2919306', '25.169.804/0001-40', 'Prefeitura de Lençóis', 'Passarela João Felipe Lopes', 1187, '49540-120', 'Lençóis', 'BA'),
    ('4208302', '97.581.432/0001-75', 'Prefeitura de Itapema', 'Quadra de da Mota', 6137, '88902-102', 'Itapema', 'SC'),
    ('4314902', '16.982.453/0001-09', 'Tribunal Regional de Porto Alegre', 'Feira da Costa', 1641, '92991-079', 'Porto Alegre', 'RS'),
    ('4205407', '40.932.671/0001-05', 'Prefeitura de Florianópolis', 'Vila de Costela', 3978, '88327-252', 'Florianópolis', 'SC'),
    ('4308250', '89.512.704/0001-57', 'Administração Ambiental', 'Ladeira Vieira', 7142, '98354-201',  'Floriano Peixoto', 'RS'),
    ('5300108', '58.247.031/0001-21', 'Gestão e Planejamento Ambiental de Brasília', 'Chácara Vinicius Casa Grande', 7905, '70001-021', 'Brasília', 'DF'),
    ('1302603', '25.683.971/0001-04', 'Defesa Civil de Manaus', 'Rua Carlos Eduardo Nunes', 8647, '69340-748', 'Manaus', 'AM'),
    ('4106902', '13.756.812/0001-34', 'Prefeitura de Curitiba', 'Avenida Marechal Rubens', 346, '86351-332', 'Curitiba', 'PR')
ON CONFLICT DO NOTHING;

INSERT INTO ent_fed (SELECT cod_ibge, 'mun' FROM org_adm_mun) ON CONFLICT DO NOTHING;
INSERT INTO ent_fed (SELECT cod_ibge, 'uf' FROM uf) ON CONFLICT DO NOTHING;

INSERT INTO empresa VALUES
    ('01.274.895', '2910-7/01', '1994-12-17', 'Melo', '207-0', '2024-06-23'),
    ('65.172.380', '6204-0/00', '1995-10-29', 'Machado', '204-6', '2021-03-03'),
    ('79.821.563', '4721-1/02', '1994-04-13', 'Nunes - ME', '230-5', '2021-03-18'),
    ('45.690.123', '4711-3/01', '2006-01-24', 'Carvalho Ltda.', '204-6', '2021-02-20'),
    ('27.401.593', '4711-3/02', '1995-07-24', 'Oliveira Pastor Ltda.', '399-9', '2022-09-01'),
    ('53.921.807', '6202-3/00', '2014-07-05', 'Novaes', '214-3', '2022-10-24'),
    ('13.690.872', '6209-1/00', '1992-06-17', 'Melo Fogaça S/A', '204-6', '2021-05-13'),
    ('09.723.145', '6319-4/00', '2001-11-12', 'Pereira Garcia S/A', '204-6', '2023-12-27'),
    ('51.360.297', '4731-8/00', '1997-01-31', 'Montenegro Siqueira Ltda.', '206-2', '2023-02-16'),
    ('18.024.935', '4511-1/01', '2015-10-26', 'da Cunha Fonseca S/A', '204-6', '2023-01-25'),
    ('64.087.915', '7810-8/00', '2008-04-29', 'Siqueira', '229-1', '2024-08-16'),
    ('48.912.037', '8630-5/01', '2009-10-18', 'Peixoto S.A.', '204-6', '2024-12-07'),
    ('12.905.674', '1011-2/01', '1993-01-29', 'Lima', '412-0', '2021-05-31'),
    ('71.498.635', '8610-1/01', '2013-09-22', 'Vasconcelos', '204-6', '2024-06-14'),
    ('39.605.871', '8622-4/00', '1997-09-16', 'Lopes da Cunha e Filhos', '204-6', '2023-02-27'),
    ('48.603.715', '8630-5/03', '1990-04-19', 'Ramos', '306-9', '2021-12-23'),
    ('20.978.635', '1091-1/01', '1996-05-09', 'Oliveira Melo S.A.', '204-6', '2024-01-29'),
    ('56.738.014', '8520-1/00', '2000-10-05', 'Nogueira - ME', '230-5', '2022-11-24'),
    ('75.893.062', '4711-3/02', '2011-02-10', 'Pacheco - ME', '230-5', '2022-12-15'),
    ('28.659.130', '6202-3/00', '2014-07-04', 'Porto S/A', '204-6', '2021-05-26'),
    ('33.738.001', '4711-3/02', '2011-01-12', 'Cachê Ltda', '306-9', '2023-01-02'),
    ('88.635.333', '4731-8/00', '2009-07-07', 'Machado S/A', '204-6', '2024-03-27')
ON CONFLICT DO NOTHING;

INSERT INTO filial VALUES
    ('01.274.895', '0001-23', 61, 'Sítio de Novais', 4534, '71158-954', '5300108'),
    ('01.274.895', '0001-40', 192, 'Campo Lavínia Azevedo', 9275, '15714-317', '3550308'),
    ('01.274.895', '0001-13', 141, 'Setor Pires', 1466, '35881-862', '3106200'),
    ('65.172.380', '0001-61', 5, 'Condomínio Azevedo', 31, '39630-513', '3106200'),
    ('65.172.380', '0001-53', 55, 'Viela Abreu', 3029, '31133-836', '3146107'),
    ('79.821.563', '0001-65', 115, 'Estrada de Cardoso', 5620, '02724-407', '3505906'),
    ('79.821.563', '0001-00', 58, 'Avenida João Abreu', 2070, '89771-584', '4205407'),
    ('79.821.563', '0001-99', 109, 'Esplanada Maria Júlia Dias', 3484, '89733-344', '4208302'),
    ('79.821.563', '0001-43', 44, 'Travessa Ravy Abreu', 6551, '28275-844', '3304557'),
    ('45.690.123', '0001-36', 129, 'Chácara Gustavo Henrique Porto', 8862, '69810-111', '1302603'),
    ('27.401.593', '0001-66', 6, 'Praia de Pacheco', 1215, '15777-927', '3548906'),
    ('53.921.807', '0001-18', 199, 'Residencial Cardoso', 2502, '97841-473', '4308250'),
    ('13.690.872', '0001-54', 92, 'Vereda Lima', 7701, '39743-888', '3146206'),
    ('13.690.872', '0001-09', 148, 'Estação Duarte', 2028, '34101-068', '3106200'),
    ('09.723.145', '0001-78', 112, 'Colônia Pacheco', 4071, '23514-347', '3306305'),
    ('09.723.145', '0001-93', 64, 'Estação Ana Luiza Monteiro', 3318, '86440-540', '4106902'),
    ('09.723.145', '0001-56', 58, 'Feira de Borges', 4228, '30505-616', '3146107'),
    ('51.360.297', '0001-43', 9, 'Distrito Eloah Barros', 6288, '15539-877', '3550308'),
    ('18.024.935', '0001-76', 23, 'Loteamento Freitas', 8290, '06991-211', '3550308'),
    ('64.087.915', '0001-27', 49, 'Vereda de Pastor', 6786, '11172-356', '3550308'),
    ('48.912.037', '0001-48', 186, 'Campo Ana Luiza Cirino', 9189, '14718-703', '3501905'),
    ('48.912.037', '0001-38', 162, 'Estrada de Alves', 5154, '10518-502', '3501905'),
    ('12.905.674', '0001-18', 198, 'Área Oliveira', 4851, '32174-516', '3106200'),
    ('71.498.635', '0001-06', 6, 'Trecho Amanda Rezende', 696, '10170-165', '3548906'),
    ('39.605.871', '0001-83', 60, 'Ladeira Pietro Sá', 7688, '80702-892', '4106902'),
    ('48.603.715', '0001-45', 106, 'Praia Davi Lucca da Luz', 3049, '36352-060', '3106200'),
    ('48.603.715', '0001-78', 75, 'Vila Gustavo Henrique Costela', 6509, '30119-515', '3146107'),
    ('20.978.635', '0001-10', 194, 'Via Correia', 5203, '37457-389', '3146206'),
    ('56.738.014', '0001-69', 175, 'Residencial Maya Rocha', 2645, '08204-147', '3505906'),
    ('75.893.062', '0001-33', 16, 'Jardim Liam Vargas', 4019, '96077-131', '4314902'),
    ('75.893.062', '0001-31', 176, 'Vale Teixeira', 4200, '88869-262', '4205407'),
    ('28.659.130', '0001-07', 199, 'Morro da Luz', 3080, '88180-390', '4205407'),
    ('33.738.001', '0001-77', 33, 'Alameda dos Peixes', 867, '43240-010', '2927408'),
    ('88.635.333', '0001-98', 21, 'Praça da Refração', 1341, '29345-188', '3205309')
ON CONFLICT DO NOTHING;

INSERT INTO organiz_socioamb VALUES
    ('35.179.804/0001-84', 'Pandas Sorridentes', 'Vale Borges', 2447, '03499-122', '3548906'),
    ('74.029.536/0001-76', 'WWF Brasil', 'Área Benjamim Nogueira', 9059, '07691-025', '3550308'),
    ('52.061.387/0001-90', 'EnxofreZero', 'Colônia Ana Beatriz Borges', 1461, '14275-290', '3548906'),
    ('37.186.429/0001-25', 'Recicla+', 'Pátio Albuquerque', 4823, '24318-646', '3304557'),
    ('68.532.497/0001-22', 'Inova', 'Rodovia Machado', 1867, '33849-208', '3146107'),
    ('20.594.183/0001-28', 'Anti-Shell', 'Jardim José Miguel Duarte', 8789, '31142-732', '3106200'),
    ('63.754.089/0001-00', 'Nature Collective', 'Alameda de Sá', 2223, '89476-628', '4205407'),
    ('07.219.354/0001-70', 'Associação Cultura Sustentável', 'Estação Silveira', 6514, '16936-879', '3505906'),
    ('64.253.970/0001-81', 'Metrosus', 'Feira de Rezende', 5499, '35274-763', '3106200'),
    ('14.679.502/0001-03', 'Acolhe Agora', 'Vila de Jesus', 8482, '69227-245', '1302603')
ON CONFLICT DO NOTHING;

INSERT INTO acao_co2 VALUES
    ('74.029.536/0001-76', '2020-06-21', 'Campanha de reflorestamento local', 0.0005, 130000.0, 24, 15, 6, 7, 70, 78),
    ('64.253.970/0001-81', '2025-04-10', 'Campanha de reflorestamento no Amazonas', 0.00702, 310000.0, 89, 91, 11, 9, 0, 0),
    ('74.029.536/0001-76', '2026-02-25', 'Incentivos de transporte sustentável', 0.0045, 50000, 27, 28, 22, 21, 51, 51),
    ('52.061.387/0001-90', '2024-08-26', 'Implantação de painéis solares em estabelecimentos públicos', 0.0005, 390000.0, 24, 34, 20, 25, 56, 41),
    ('68.532.497/0001-22', '2021-12-25', 'Compensação de emissões no transporte urbano', 0.00144, 50000, 77, 91, 18, 3, 5, 6),
    ('37.186.429/0001-25', '2021-03-21', 'Programa de neutralização de carbono logístico', 0.0005, 60000.0, 4, 17, 32, 25, 64, 58),
    ('63.754.089/0001-00', '2021-11-01', 'Mobilidade sustentável com baixa emissão', 0.0005, 50000, 66, 82, 32, 17, 2, 1),
    ('14.679.502/0001-03', '2022-11-12', 'Transporte coletivo carbono neutro', 0.00313, 150000.0, 66, 47, 10, 11, 24, 42),
    ('64.253.970/0001-81', '2020-03-22', 'Frota verde para redução de emissões', 0.00196, 60000.0, 69, 47, 6, 3, 25, 50),
    ('37.186.429/0001-25', '2022-06-02', 'Compensação de viagens corporativas', 0.0005, 150000.0, 87, 84, 13, 16, 0, 0),
    ('20.594.183/0001-28', '2025-01-07', 'Neutralização de emissões de entregas', 0.000513, 440000.0, 92, 72, 6, 17, 2, 11),
    ('68.532.497/0001-22', '2023-01-16', 'Corredores verdes de mobilidade', 0.000612, 300000.0, 92, 77, 8, 23, 0, 0),
    ('52.061.387/0001-90', '2021-12-16', 'Transporte limpo para comunidades', 0.0005, 290000.0, 54, 61, 4, 21, 42, 18),
    ('52.061.387/0001-90', '2023-11-04', 'Redução de carbono no deslocamento diário', 0.0005, 310000.0, 30, 28, 26, 27, 44, 45),
    ('64.253.970/0001-81', '2022-06-27', 'Geração comunitária de energia solar', 0.0005, 220000.0, 43, 32, 18, 41, 39, 27),
    ('74.029.536/0001-76', '2025-03-15', 'Energia renovável para todos', 0.0005, 100000.0, 97, 74, 3, 1, 0, 25),
    ('52.061.387/0001-90', '2022-04-07', 'Transição energética sustentável', 0.0005, 550000.0, 69, 73, 17, 5, 14, 22),
    ('14.679.502/0001-03', '2026-05-11', 'Eficiência energética em edificações', 0.0005, 110000.0, 24, 37, 2, 11, 74, 52),
    ('63.754.089/0001-00', '2025-04-04', 'Energia limpa para organizações sociais', 0.00125, 50000, 58, 82, 13, 4, 29, 14),
    ('35.179.804/0001-84', '2023-07-28', 'Compensação de emissões por energia renovável', 0.0005, 180000.0, 25, 30, 41, 17, 34, 53),
    ('14.679.502/0001-03', '2021-02-16', 'Modernização energética de baixo carbono', 0.00121, 150000.0, 61, 63, 35, 15, 4, 22),
    ('20.594.183/0001-28', '2022-03-18', 'Rede de energia solar comunitária', 0.0005, 340000.0, 4, 18, 87, 70, 9, 12),
    ('14.679.502/0001-03', '2020-02-10', 'Programa de economia de energia e carbono', 0.00153, 300000.0, 95, 71, 5, 19, 0, 10),
    ('74.029.536/0001-76', '2020-06-24', 'Substituição de fontes fósseis por renováveis', 0.00662, 180000.0, 25, 49, 37, 31, 38, 20),
    ('63.754.089/0001-00', '2023-12-04', 'Reciclagem solidária com compensação ambiental', 0.00857, 240000.0, 25, 9, 71, 80, 4, 11),
    ('35.179.804/0001-84', '2020-02-01', 'Gestão circular de resíduos urbanos', 0.0005, 490000.0, 30, 18, 0, 6, 70, 76),
    ('52.061.387/0001-90', '2021-06-26', 'Coleta seletiva para redução de carbono', 0.0005, 50000, 22, 3, 48, 61, 30, 36),
    ('74.029.536/0001-76', '2022-10-02', 'Reciclagem inclusiva e sustentável', 0.00121, 280000.0, 90, 96, 10, 4, 0, 0),
    ('52.061.387/0001-90', '2021-10-30', 'Valorização de resíduos para mitigação climática', 0.00398, 50000, 74, 52, 26, 44, 0, 4),
    ('74.029.536/0001-76', '2024-01-23', 'Economia circular em comunidades locais', 0.0005, 50000, 0, 10, 97, 75, 3, 15),
    ('74.029.536/0001-76', '2025-11-17', 'Reaproveitamento de materiais pós-consumo', 0.0005, 50000, 48, 46, 27, 19, 25, 35),
    ('37.186.429/0001-25', '2026-03-25', 'Programa de resíduos com baixa emissão', 0.0005, 50000.0, 76, 61, 18, 13, 6, 26),
    ('74.029.536/0001-76', '2020-06-26', 'Cadeia sustentável de reciclagem', 0.0005, 80000.0, 98, 88, 2, 3, 0, 9),
    ('37.186.429/0001-25', '2023-12-02', 'Transformação de resíduos em impacto positivo', 0.0005, 210000.0, 93, 85, 7, 15, 0, 0),
    ('64.253.970/0001-81', '2025-12-20', 'Reflorestamento para neutralização de carbono', 0.0005, 50000, 96, 98, 4, 2, 0, 0),
    ('52.061.387/0001-90', '2025-08-07', 'Recuperação de áreas degradadas e clima', 0.00201, 180000.0, 88, 79, 12, 2, 0, 19),
    ('63.754.089/0001-00', '2022-04-13', 'Corredores ecológicos para captura de carbono', 0.0005, 200000.0, 43, 32, 7, 13, 50, 55),
    ('68.532.497/0001-22', '2021-04-25', 'Plantio de árvores para compensação ambiental', 0.00363, 50000, 16, 20, 5, 26, 79, 54),
    ('68.532.497/0001-22', '2021-06-25', 'Conservação florestal e créditos de carbono', 0.0069, 230000.0, 37, 50, 22, 21, 41, 29),
    ('52.061.387/0001-90', '2021-06-23', 'Restauração de nascentes e sequestro de carbono', 0.0005, 330000.0, 57, 41, 0, 1, 43, 58),
    ('74.029.536/0001-76', '2023-10-17', 'Florestas comunitárias para o clima', 0.00151, 110000.0, 30, 52, 60, 46, 10, 2),
    ('68.532.497/0001-22', '2023-04-22', 'Recuperação da vegetação nativa', 0.0005, 80000.0, 91, 77, 9, 21, 0, 2),
    ('52.061.387/0001-90', '2021-09-22', 'Proteção de biomas e compensação climática', 0.0005, 330000.0, 90, 70, 10, 16, 0, 14),
    ('52.061.387/0001-90', '2023-11-20', 'Neutralização de emissões de eventos', 0.0207, 50000, 39, 40, 17, 39, 44, 21),
    ('52.061.387/0001-90', '2025-01-03', 'Compensação ambiental de operações organizacionais', 0.0005, 200000.0, 65, 46, 12, 35, 23, 19),
    ('14.679.502/0001-03', '2023-09-21', 'Ação climática para organizações sociais', 0.00647, 50000, 9, 16, 44, 39, 47, 45),
    ('07.219.354/0001-70', '2024-04-07', 'Gestão sustentável da pegada de carbono', 0.0005, 50000, 62, 37, 5, 29, 33, 34),
    ('63.754.089/0001-00', '2025-09-22', 'Programa integrado de mitigação climática', 0.00121, 150000.0, 65, 81, 28, 16, 7, 3)
ON CONFLICT DO NOTHING;

-- INSERT INTO vinc_contrib_co2 VALUES
--     ()
-- ON CONFLICT DO NOTHING;

-- INSERT INTO contrib_co2 VALUES
--     ()
-- ON CONFLICT DO NOTHING;

-- INSERT INTO hist_co2 VALUES
--     ()
-- ON CONFLICT DO NOTHING;

-- Obs. usamos o comando \copy do `psql` (roda no cliente) em vez do
-- comando `COPY FROM` (que roda no servidor), pois este requer
-- privilégios de administrador e não permite caminhos relativos.
--
-- Obs. rode esse script de inserção na raiz do repositório, usando o `psql`.
--
-- Obs. DELETE está sendo usado para garantir idempotência do comando \copy.
DELETE FROM serv_nbs;
DELETE FROM prod_ncm;

\copy serv_nbs FROM 'db/nbs.csv' WITH DELIMITER AS ';' CSV HEADER;
\copy prod_ncm FROM 'db/ncm.csv' WITH DELIMITER AS ';' CSV HEADER;

-- INSERT INTO reg_leg VALUES
--     ()
-- ON CONFLICT DO NOTHING;

INSERT INTO inst_cient VALUES
    ('58.826.745/0001-34', 'Universidade de São Paulo', 'Praça da Sé', 33, '00000001', '3550308'),
    ('37.669.280/0001-29', 'Universidade Federal de São Carlos', 'Rodovia Carlos Vignon', 767, '13769020', '3548906'),
    ('11.679.309/0001-01', 'Instituto de Pesquisa FioCruz', 'Avenida Pinheiro', 88, '01473394', '3550308'),
    ('53.396.825/0001-34', 'Laboratório de Pesquisa A.K.L.', 'Rua Sésamo', 35, '39445014', '3106200'),
    ('09.850.333/0001-77', 'Universidade Federal do Rio de Janeiro', 'Avenida Laerte', 56, '38997345', '3304557'),
    ('87.888.161/0001-65', 'Unidade Científica do Norte', 'Rua Corrêa', 1048, '69994-295', '1302603'),
    ('00.001.333/0001-99', 'Universidade Federal da Bahia', 'Rua Roberto Peixoto', 444, '43144-383', '2927408'),
    ('54.777.163/0001-46', 'Universidade Federal de Minas Gerais', 'Rodovia Afonso Pena', 998, '39802-120', '3106200')
ON CONFLICT DO NOTHING;

INSERT INTO equipe_inst_cient VALUES
    ('58.826.745/0001-34', 'Emissões a alto nível'),
    ('58.826.745/0001-34', 'Emissões e as metas da ONU'),
    ('58.826.745/0001-34', 'Impacto das técnicas de produção em emissões'),
    ('37.669.280/0001-29', 'Pesquisa de campo em emissões'),
    ('37.669.280/0001-29', 'Emissões em microempresas'),
    ('11.679.309/0001-01', 'Impacto de programas de incentivo fiscal na redução de emissões'),
    ('11.679.309/0001-01', 'Análise de emissões em São Paulo na última década'),
    ('53.396.825/0001-34', 'Formas de reduzir o impacto de emissões'),
    ('09.850.333/0001-77', 'Emissões: e eu com isso?'),
    ('87.888.161/0001-65', 'Impacto de atividades agropecuárias na Amazônia'),
    ('00.001.333/0001-99', 'Tipos de emissão em empresas de refinaria'),
    ('54.777.163/0001-46', 'O capitalismo como motor da exploração dos recursos naturais'),
    ('54.777.163/0001-46', 'Andamento das metas da ONU')
ON CONFLICT DO NOTHING;

INSERT INTO equipe_inst_cient_membro VALUES
    ('58.826.745/0001-34', 'Emissões a alto nível', 'Caio Melo'),
    ('58.826.745/0001-34', 'Emissões a alto nível', 'Apollo Fernandes'),
    ('58.826.745/0001-34', 'Emissões a alto nível', 'Gabriel Pacheco'),
    ('58.826.745/0001-34', 'Emissões a alto nível', 'Luigi Moura'),
    ('58.826.745/0001-34', 'Emissões a alto nível', 'Ian Sá'),
    ('58.826.745/0001-34', 'Emissões e as metas da ONU', 'Paulo da Paz'),
    ('58.826.745/0001-34', 'Emissões e as metas da ONU', 'Vitor Gabriel Rios'),
    ('58.826.745/0001-34', 'Emissões e as metas da ONU', 'Olivia Nunes'),
    ('58.826.745/0001-34', 'Emissões e as metas da ONU', 'Rafaela da Mata'),
    ('58.826.745/0001-34', 'Impacto das técnicas de produção em emissões', 'Henry Gabriel Costa'),
    ('58.826.745/0001-34', 'Impacto das técnicas de produção em emissões', 'Rodrigo Rios'),
    ('58.826.745/0001-34', 'Impacto das técnicas de produção em emissões', 'Heloisa Nascimento'),
    ('58.826.745/0001-34', 'Impacto das técnicas de produção em emissões', 'Sarah Rios'),
    ('58.826.745/0001-34', 'Impacto das técnicas de produção em emissões', 'Augusto Leão'),
    ('37.669.280/0001-29', 'Pesquisa de campo em emissões', 'Benicio Santos'),
    ('37.669.280/0001-29', 'Pesquisa de campo em emissões', 'Yago da Cunha'),
    ('37.669.280/0001-29', 'Pesquisa de campo em emissões', 'Daniela Pimenta'),
    ('37.669.280/0001-29', 'Pesquisa de campo em emissões', 'Danilo da Cruz'),
    ('37.669.280/0001-29', 'Emissões em microempresas', 'Lara Guerra'),
    ('37.669.280/0001-29', 'Emissões em microempresas', 'Maria Clara Monteiro'),
    ('37.669.280/0001-29', 'Emissões em microempresas', 'Letícia Farias'),
    ('11.679.309/0001-01', 'Impacto de programas de incentivo fiscal na redução de emissões', 'Catarina Cunha'),
    ('11.679.309/0001-01', 'Impacto de programas de incentivo fiscal na redução de emissões', 'Guilherme Martins'),
    ('11.679.309/0001-01', 'Impacto de programas de incentivo fiscal na redução de emissões', 'Ravi Lucca Mendes'),
    ('11.679.309/0001-01', 'Impacto de programas de incentivo fiscal na redução de emissões', 'Erick Rocha'),
    ('11.679.309/0001-01', 'Análise de emissões em São Paulo na última década', 'Pedro Miguel Machado'),
    ('11.679.309/0001-01', 'Análise de emissões em São Paulo na última década', 'Ágatha Almeida'),
    ('11.679.309/0001-01', 'Análise de emissões em São Paulo na última década', 'Marcela Pimenta'),
    ('11.679.309/0001-01', 'Análise de emissões em São Paulo na última década', 'Vinicius Caldeira'),
    ('11.679.309/0001-01', 'Análise de emissões em São Paulo na última década', 'Vinicius Oliveira'),
    ('11.679.309/0001-01', 'Análise de emissões em São Paulo na última década', 'Caleb Duarte'),
    ('53.396.825/0001-34', 'Formas de reduzir o impacto de emissões', 'Lunna Leão'),
    ('53.396.825/0001-34', 'Formas de reduzir o impacto de emissões', 'Sabrina Porto'),
    ('53.396.825/0001-34', 'Formas de reduzir o impacto de emissões', 'Caleb Vasconcelos'),
    ('53.396.825/0001-34', 'Formas de reduzir o impacto de emissões', 'Srta. Mariane Pastor'),
    ('09.850.333/0001-77', 'Emissões: e eu com isso?', 'Renan Pimenta'),
    ('09.850.333/0001-77', 'Emissões: e eu com isso?', 'Isaac Gomes'),
    ('09.850.333/0001-77', 'Emissões: e eu com isso?', 'Juan Abreu'),
    ('87.888.161/0001-65', 'Impacto de atividades agropecuárias na Amazônia', 'Vitor Hugo Carvalho'),
    ('87.888.161/0001-65', 'Impacto de atividades agropecuárias na Amazônia', 'Pietro da Luz'),
    ('87.888.161/0001-65', 'Impacto de atividades agropecuárias na Amazônia', 'Brenda Macedo'),
    ('87.888.161/0001-65', 'Impacto de atividades agropecuárias na Amazônia', 'Eloá Porto'),
    ('87.888.161/0001-65', 'Impacto de atividades agropecuárias na Amazônia', 'Renan Farias'),
    ('00.001.333/0001-99', 'Tipos de emissão em empresas de refinaria', 'Gael Henrique Duarte'),
    ('00.001.333/0001-99', 'Tipos de emissão em empresas de refinaria', 'Maya Moura'),
    ('00.001.333/0001-99', 'Tipos de emissão em empresas de refinaria', 'Diego Silva'),
    ('00.001.333/0001-99', 'Tipos de emissão em empresas de refinaria', 'Maria Isis Caldeira'),
    ('54.777.163/0001-46', 'O capitalismo como motor da exploração dos recursos naturais', 'Luan Moraes'),
    ('54.777.163/0001-46', 'O capitalismo como motor da exploração dos recursos naturais', 'Liam Cunha'),
    ('54.777.163/0001-46', 'Andamento das metas da ONU', 'Matteo Macedo'),
    ('54.777.163/0001-46', 'Andamento das metas da ONU', 'Thomas Barbosa'),
    ('54.777.163/0001-46', 'Andamento das metas da ONU', 'Léo Moura')
ON CONFLICT DO NOTHING;

-- INSERT INTO relatorio VALUES
--     ()
-- ON CONFLICT DO NOTHING;

-- INSERT INTO relatorio_prod VALUES
--     ()
-- ON CONFLICT DO NOTHING;

-- INSERT INTO relatorio_serv VALUES
--     ()
-- ON CONFLICT DO NOTHING;

COMMIT;
