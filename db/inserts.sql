-- Obs. todos os inserts foram colocados em uma única transação para
-- facilitar a depuração: cada vez que o script é rodado todas as
-- inserções são feitas com sucesso ou nenhuma inserção é feita,
-- permitindo corrigir bugs e rodar o script novamente. Além disso,
-- podemos ignorar temporariamente algumas restrições, fazendo as
-- inserções em uma ordem mais conveniente, porém ainda garantindo
-- a consistência dos dados, como mencionado a seguir.

-- Obs. para facilitar o teste das queries, foi feita uma quantidade
-- relativamente alta de inserções (com dados gerados automaticamente
-- por scripts). Como não seria viável garantir a consistência dos dados
-- em todos os aspectos no momento de gerá-los, ao final desse arquivo é
-- feita uma verificação em SQL para remover dados que ferem restrições
-- "de aplicação".

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
    ('ES', '32');

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
    ('4106902', '13.756.812/0001-34', 'Prefeitura de Curitiba', 'Avenida Marechal Rubens', 346, '86351-332', 'Curitiba', 'PR');

INSERT INTO ent_fed (SELECT cod_ibge, 'mun' FROM org_adm_mun);
INSERT INTO ent_fed (SELECT cod_ibge, 'uf' FROM uf);

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
    ('88.635.333', '4731-8/00', '2009-07-07', 'Machado S/A', '204-6', '2024-03-27');

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
    ('88.635.333', '0001-98', 21, 'Praça da Refração', 1341, '29345-188', '3205309');

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
    ('14.679.502/0001-03', 'Acolhe Agora', 'Vila de Jesus', 8482, '69227-245', '1302603');

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
    ('63.754.089/0001-00', '2025-09-22', 'Programa integrado de mitigação climática', 0.00121, 150000.0, 65, 81, 28, 16, 7, 3);

INSERT INTO vinc_contrib_co2 VALUES
    (1, '45.690.123', '0001-36', '74.029.536/0001-76', '2020-06-26', 'Cadeia sustentável de reciclagem');

INSERT INTO contrib_co2 VALUES
    (1, '2020-08-08', 5500),
    (1, '2020-08-30', 3500),
    (1, '2020-07-30', 3500),
    (1, '2020-09-12', 7800);

INSERT INTO vinc_contrib_co2 VALUES
    (2, '33.738.001', '0001-77', '35.179.804/0001-84', '2023-07-28', 'Compensação de emissões por energia renovável');

INSERT INTO contrib_co2 VALUES
    (2, '2023-08-11', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (3, '01.274.895', '0001-40', '37.186.429/0001-25', '2022-06-02', 'Compensação de viagens corporativas');

INSERT INTO contrib_co2 VALUES
    (3, '2022-06-23', 7400),
    (3, '2022-08-03', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (4, '13.690.872', '0001-54', '63.754.089/0001-00', '2022-04-13', 'Corredores ecológicos para captura de carbono');

INSERT INTO contrib_co2 VALUES
    (4, '2022-05-11', 6200),
    (4, '2022-04-29', 9000);

INSERT INTO vinc_contrib_co2 VALUES
    (5, '09.723.145', '0001-56', '14.679.502/0001-03', '2020-02-10', 'Programa de economia de energia e carbono');

INSERT INTO contrib_co2 VALUES
    (5, '2020-04-27', 9100),
    (5, '2020-05-07', 5000);

INSERT INTO vinc_contrib_co2 VALUES
    (6, '48.912.037', '0001-38', '74.029.536/0001-76', '2025-03-15', 'Energia renovável para todos');

INSERT INTO contrib_co2 VALUES
    (6, '2025-05-22', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (7, '75.893.062', '0001-33', '52.061.387/0001-90', '2021-06-26', 'Coleta seletiva para redução de carbono');

INSERT INTO contrib_co2 VALUES
    (7, '2021-09-18', 3500),
    (7, '2021-07-13', 3500),
    (7, '2021-09-11', 6200),
    (7, '2021-09-15', 8200),
    (7, '2021-07-22', 14000),
    (7, '2021-07-08', 14600);

INSERT INTO vinc_contrib_co2 VALUES
    (8, '56.738.014', '0001-69', '52.061.387/0001-90', '2021-06-26', 'Coleta seletiva para redução de carbono');

INSERT INTO contrib_co2 VALUES
    (8, '2021-06-30', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (9, '53.921.807', '0001-18', '64.253.970/0001-81', '2022-06-27', 'Geração comunitária de energia solar');

INSERT INTO contrib_co2 VALUES
    (9, '2022-07-31', 5100),
    (9, '2022-07-21', 9500);

INSERT INTO vinc_contrib_co2 VALUES
    (10, '01.274.895', '0001-13', '52.061.387/0001-90', '2023-11-04', 'Redução de carbono no deslocamento diário');

INSERT INTO contrib_co2 VALUES
    (10, '2023-12-23', 8200);

INSERT INTO vinc_contrib_co2 VALUES
    (11, '09.723.145', '0001-56', '63.754.089/0001-00', '2025-04-04', 'Energia limpa para organizações sociais');

INSERT INTO contrib_co2 VALUES
    (11, '2025-06-21', 8500),
    (11, '2025-05-09', 3500),
    (11, '2025-05-29', 13900);

INSERT INTO vinc_contrib_co2 VALUES
    (12, '01.274.895', '0001-40', '52.061.387/0001-90', '2023-11-20', 'Neutralização de emissões de eventos');

INSERT INTO contrib_co2 VALUES
    (12, '2024-02-05', 11900),
    (12, '2023-11-22', 3500),
    (12, '2023-12-03', 7700),
    (12, '2023-12-26', 21100),
    (12, '2024-01-09', 3500),
    (12, '2024-01-17', 3500),
    (12, '2023-12-27', 6600);

INSERT INTO vinc_contrib_co2 VALUES
    (13, '48.912.037', '0001-38', '63.754.089/0001-00', '2021-11-01', 'Mobilidade sustentável com baixa emissão');

INSERT INTO contrib_co2 VALUES
    (13, '2022-01-07', 6900),
    (13, '2021-11-29', 3500),
    (13, '2022-01-14', 7600),
    (13, '2021-11-27', 8100);

INSERT INTO vinc_contrib_co2 VALUES
    (14, '13.690.872', '0001-09', '74.029.536/0001-76', '2026-02-25', 'Incentivos de transporte sustentável');

INSERT INTO contrib_co2 VALUES
    (14, '2026-02-28', 3500),
    (14, '2026-05-11', 6200);

INSERT INTO vinc_contrib_co2 VALUES
    (15, '45.690.123', '0001-36', '68.532.497/0001-22', '2021-12-25', 'Compensação de emissões no transporte urbano');

INSERT INTO contrib_co2 VALUES
    (15, '2022-03-13', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (16, '48.603.715', '0001-78', '37.186.429/0001-25', '2022-06-02', 'Compensação de viagens corporativas');

INSERT INTO contrib_co2 VALUES
    (16, '2022-06-04', 3500),
    (16, '2022-08-11', 3500),
    (16, '2022-06-21', 6000),
    (16, '2022-08-28', 3500),
    (16, '2022-07-13', 7100);

INSERT INTO vinc_contrib_co2 VALUES
    (17, '13.690.872', '0001-09', '37.186.429/0001-25', '2022-06-02', 'Compensação de viagens corporativas');

INSERT INTO contrib_co2 VALUES
    (17, '2022-06-08', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (18, '79.821.563', '0001-99', '37.186.429/0001-25', '2022-06-02', 'Compensação de viagens corporativas');

INSERT INTO contrib_co2 VALUES
    (18, '2022-07-25', 5800),
    (18, '2022-06-23', 4900);

INSERT INTO vinc_contrib_co2 VALUES
    (19, '53.921.807', '0001-18', '68.532.497/0001-22', '2023-04-22', 'Recuperação da vegetação nativa');

INSERT INTO contrib_co2 VALUES
    (19, '2023-06-04', 8200),
    (19, '2023-06-13', 12200);

INSERT INTO vinc_contrib_co2 VALUES
    (20, '71.498.635', '0001-06', '52.061.387/0001-90', '2021-12-16', 'Transporte limpo para comunidades');

INSERT INTO contrib_co2 VALUES
    (20, '2021-12-30', 3800);

INSERT INTO vinc_contrib_co2 VALUES
    (21, '01.274.895', '0001-13', '37.186.429/0001-25', '2023-12-02', 'Transformação de resíduos em impacto positivo');

INSERT INTO contrib_co2 VALUES
    (21, '2024-02-08', 3500),
    (21, '2024-01-11', 3500),
    (21, '2024-01-13', 8300),
    (21, '2024-01-16', 21300),
    (21, '2023-12-02', 8100);

INSERT INTO vinc_contrib_co2 VALUES
    (22, '13.690.872', '0001-09', '68.532.497/0001-22', '2021-12-25', 'Compensação de emissões no transporte urbano');

INSERT INTO contrib_co2 VALUES
    (22, '2021-12-28', 12800);

INSERT INTO vinc_contrib_co2 VALUES
    (23, '48.912.037', '0001-48', '52.061.387/0001-90', '2024-08-26', 'Implantação de painéis solares em estabelecimentos públicos');

INSERT INTO contrib_co2 VALUES
    (23, '2024-10-24', 3500),
    (23, '2024-10-05', 5700);

INSERT INTO vinc_contrib_co2 VALUES
    (24, '45.690.123', '0001-36', '20.594.183/0001-28', '2025-01-07', 'Neutralização de emissões de entregas');

INSERT INTO contrib_co2 VALUES
    (24, '2025-01-31', 6900);

INSERT INTO vinc_contrib_co2 VALUES
    (25, '45.690.123', '0001-36', '68.532.497/0001-22', '2021-04-25', 'Plantio de árvores para compensação ambiental');

INSERT INTO contrib_co2 VALUES
    (25, '2021-05-24', 8200),
    (25, '2021-06-29', 3500),
    (25, '2021-07-14', 10300),
    (25, '2021-05-17', 4500),
    (25, '2021-05-21', 10600);

INSERT INTO vinc_contrib_co2 VALUES
    (26, '71.498.635', '0001-06', '52.061.387/0001-90', '2024-08-26', 'Implantação de painéis solares em estabelecimentos públicos');

INSERT INTO contrib_co2 VALUES
    (26, '2024-09-23', 3500),
    (26, '2024-09-17', 6700),
    (26, '2024-09-14', 3500),
    (26, '2024-11-06', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (27, '20.978.635', '0001-10', '37.186.429/0001-25', '2022-06-02', 'Compensação de viagens corporativas');

INSERT INTO contrib_co2 VALUES
    (27, '2022-08-02', 9800);

INSERT INTO vinc_contrib_co2 VALUES
    (28, '48.603.715', '0001-78', '74.029.536/0001-76', '2020-06-24', 'Substituição de fontes fósseis por renováveis');

INSERT INTO contrib_co2 VALUES
    (28, '2020-08-21', 4500),
    (28, '2020-07-29', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (29, '20.978.635', '0001-10', '37.186.429/0001-25', '2021-03-21', 'Programa de neutralização de carbono logístico');

INSERT INTO contrib_co2 VALUES
    (29, '2021-04-13', 9400),
    (29, '2021-05-15', 5000),
    (29, '2021-03-24', 6300),
    (29, '2021-05-07', 10400),
    (29, '2021-06-10', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (30, '88.635.333', '0001-98', '68.532.497/0001-22', '2023-01-16', 'Corredores verdes de mobilidade');

INSERT INTO contrib_co2 VALUES
    (30, '2023-01-29', 15700),
    (30, '2023-03-11', 8200),
    (30, '2023-02-08', 14700),
    (30, '2023-02-13', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (31, '79.821.563', '0001-00', '52.061.387/0001-90', '2021-06-23', 'Restauração de nascentes e sequestro de carbono');

INSERT INTO contrib_co2 VALUES
    (31, '2021-08-17', 5400),
    (31, '2021-07-09', 4300),
    (31, '2021-07-31', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (32, '65.172.380', '0001-53', '74.029.536/0001-76', '2026-02-25', 'Incentivos de transporte sustentável');

INSERT INTO contrib_co2 VALUES
    (32, '2026-04-22', 3500),
    (32, '2026-04-04', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (33, '09.723.145', '0001-93', '63.754.089/0001-00', '2025-04-04', 'Energia limpa para organizações sociais');

INSERT INTO contrib_co2 VALUES
    (33, '2025-06-05', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (34, '09.723.145', '0001-78', '37.186.429/0001-25', '2022-06-02', 'Compensação de viagens corporativas');

INSERT INTO contrib_co2 VALUES
    (34, '2022-07-16', 3500),
    (34, '2022-06-10', 10500),
    (34, '2022-07-23', 8800);

INSERT INTO vinc_contrib_co2 VALUES
    (35, '64.087.915', '0001-27', '64.253.970/0001-81', '2022-06-27', 'Geração comunitária de energia solar');

INSERT INTO contrib_co2 VALUES
    (35, '2022-07-10', 5300);

INSERT INTO vinc_contrib_co2 VALUES
    (36, '71.498.635', '0001-06', '74.029.536/0001-76', '2020-06-21', 'Campanha de reflorestamento local');

INSERT INTO contrib_co2 VALUES
    (36, '2020-09-16', 5200);

INSERT INTO vinc_contrib_co2 VALUES
    (37, '88.635.333', '0001-98', '68.532.497/0001-22', '2021-04-25', 'Plantio de árvores para compensação ambiental');

INSERT INTO contrib_co2 VALUES
    (37, '2021-07-09', 5200);

INSERT INTO vinc_contrib_co2 VALUES
    (38, '28.659.130', '0001-07', '74.029.536/0001-76', '2020-06-26', 'Cadeia sustentável de reciclagem');

INSERT INTO contrib_co2 VALUES
    (38, '2020-09-10', 3500),
    (38, '2020-07-22', 4000),
    (38, '2020-07-14', 12000),
    (38, '2020-09-21', 8200),
    (38, '2020-07-15', 6500),
    (38, '2020-08-08', 10600),
    (38, '2020-07-26', 10600);

INSERT INTO vinc_contrib_co2 VALUES
    (39, '65.172.380', '0001-61', '52.061.387/0001-90', '2025-01-03', 'Compensação ambiental de operações organizacionais');

INSERT INTO contrib_co2 VALUES
    (39, '2025-02-18', 8800);

INSERT INTO vinc_contrib_co2 VALUES
    (40, '01.274.895', '0001-40', '68.532.497/0001-22', '2021-12-25', 'Compensação de emissões no transporte urbano');

INSERT INTO contrib_co2 VALUES
    (40, '2022-03-04', 3500),
    (40, '2022-02-13', 6300);

INSERT INTO vinc_contrib_co2 VALUES
    (41, '71.498.635', '0001-06', '74.029.536/0001-76', '2022-10-02', 'Reciclagem inclusiva e sustentável');

INSERT INTO contrib_co2 VALUES
    (41, '2022-12-25', 4200),
    (41, '2022-11-22', 3500),
    (41, '2022-11-24', 10200);

INSERT INTO vinc_contrib_co2 VALUES
    (42, '13.690.872', '0001-54', '52.061.387/0001-90', '2025-08-07', 'Recuperação de áreas degradadas e clima');

INSERT INTO contrib_co2 VALUES
    (42, '2025-09-12', 3500),
    (42, '2025-08-26', 3500),
    (42, '2025-09-23', 5500);

INSERT INTO vinc_contrib_co2 VALUES
    (43, '01.274.895', '0001-23', '52.061.387/0001-90', '2023-11-20', 'Neutralização de emissões de eventos');

INSERT INTO contrib_co2 VALUES
    (43, '2023-11-24', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (44, '88.635.333', '0001-98', '14.679.502/0001-03', '2026-05-11', 'Eficiência energética em edificações');

INSERT INTO contrib_co2 VALUES
    (44, '2026-05-30', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (45, '39.605.871', '0001-83', '14.679.502/0001-03', '2023-09-21', 'Ação climática para organizações sociais');

INSERT INTO contrib_co2 VALUES
    (45, '2023-12-11', 8500);

INSERT INTO vinc_contrib_co2 VALUES
    (46, '48.603.715', '0001-45', '64.253.970/0001-81', '2020-03-22', 'Frota verde para redução de emissões');

INSERT INTO contrib_co2 VALUES
    (46, '2020-06-19', 5700);

INSERT INTO vinc_contrib_co2 VALUES
    (47, '20.978.635', '0001-10', '52.061.387/0001-90', '2021-09-22', 'Proteção de biomas e compensação climática');

INSERT INTO contrib_co2 VALUES
    (47, '2021-11-11', 4300),
    (47, '2021-10-24', 3500),
    (47, '2021-11-23', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (48, '65.172.380', '0001-53', '07.219.354/0001-70', '2024-04-07', 'Gestão sustentável da pegada de carbono');

INSERT INTO contrib_co2 VALUES
    (48, '2024-04-08', 5000);

INSERT INTO vinc_contrib_co2 VALUES
    (49, '01.274.895', '0001-13', '52.061.387/0001-90', '2021-10-30', 'Valorização de resíduos para mitigação climática');

INSERT INTO contrib_co2 VALUES
    (49, '2021-12-10', 3700),
    (49, '2022-01-20', 9500),
    (49, '2022-01-15', 9200);

INSERT INTO vinc_contrib_co2 VALUES
    (50, '28.659.130', '0001-07', '63.754.089/0001-00', '2025-04-04', 'Energia limpa para organizações sociais');

INSERT INTO contrib_co2 VALUES
    (50, '2025-05-12', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (51, '09.723.145', '0001-78', '52.061.387/0001-90', '2021-06-23', 'Restauração de nascentes e sequestro de carbono');

INSERT INTO contrib_co2 VALUES
    (51, '2021-09-01', 3500),
    (51, '2021-08-17', 14100),
    (51, '2021-07-25', 10500);

INSERT INTO vinc_contrib_co2 VALUES
    (52, '75.893.062', '0001-33', '74.029.536/0001-76', '2023-10-17', 'Florestas comunitárias para o clima');

INSERT INTO contrib_co2 VALUES
    (52, '2023-11-15', 13900);

INSERT INTO vinc_contrib_co2 VALUES
    (53, '20.978.635', '0001-10', '14.679.502/0001-03', '2023-09-21', 'Ação climática para organizações sociais');

INSERT INTO contrib_co2 VALUES
    (53, '2023-10-30', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (54, '79.821.563', '0001-65', '37.186.429/0001-25', '2026-03-25', 'Programa de resíduos com baixa emissão');

INSERT INTO contrib_co2 VALUES
    (54, '2026-06-04', 11800),
    (54, '2026-05-24', 8000),
    (54, '2026-06-11', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (55, '65.172.380', '0001-61', '74.029.536/0001-76', '2020-06-21', 'Campanha de reflorestamento local');

INSERT INTO contrib_co2 VALUES
    (55, '2020-07-16', 8700);

INSERT INTO vinc_contrib_co2 VALUES
    (56, '75.893.062', '0001-31', '37.186.429/0001-25', '2022-06-02', 'Compensação de viagens corporativas');

INSERT INTO contrib_co2 VALUES
    (56, '2022-06-25', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (57, '12.905.674', '0001-18', '52.061.387/0001-90', '2021-12-16', 'Transporte limpo para comunidades');

INSERT INTO contrib_co2 VALUES
    (57, '2022-02-05', 10200),
    (57, '2022-03-01', 3500),
    (57, '2022-02-23', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (58, '79.821.563', '0001-00', '74.029.536/0001-76', '2023-10-17', 'Florestas comunitárias para o clima');

INSERT INTO contrib_co2 VALUES
    (58, '2023-11-20', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (59, '79.821.563', '0001-00', '52.061.387/0001-90', '2024-08-26', 'Implantação de painéis solares em estabelecimentos públicos');

INSERT INTO contrib_co2 VALUES
    (59, '2024-11-01', 6000);

INSERT INTO vinc_contrib_co2 VALUES
    (60, '33.738.001', '0001-77', '52.061.387/0001-90', '2021-06-23', 'Restauração de nascentes e sequestro de carbono');

INSERT INTO contrib_co2 VALUES
    (60, '2021-09-19', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (61, '48.603.715', '0001-45', '52.061.387/0001-90', '2025-01-03', 'Compensação ambiental de operações organizacionais');

INSERT INTO contrib_co2 VALUES
    (61, '2025-02-09', 3500),
    (61, '2025-03-18', 5300),
    (61, '2025-03-13', 8300);

INSERT INTO vinc_contrib_co2 VALUES
    (62, '18.024.935', '0001-76', '74.029.536/0001-76', '2024-01-23', 'Economia circular em comunidades locais');

INSERT INTO contrib_co2 VALUES
    (62, '2024-04-13', 16500),
    (62, '2024-04-01', 7900),
    (62, '2024-03-10', 11400);

INSERT INTO vinc_contrib_co2 VALUES
    (63, '53.921.807', '0001-18', '14.679.502/0001-03', '2021-02-16', 'Modernização energética de baixo carbono');

INSERT INTO contrib_co2 VALUES
    (63, '2021-03-29', 18700),
    (63, '2021-04-09', 8400);

INSERT INTO vinc_contrib_co2 VALUES
    (64, '51.360.297', '0001-43', '74.029.536/0001-76', '2025-03-15', 'Energia renovável para todos');

INSERT INTO contrib_co2 VALUES
    (64, '2025-03-27', 3500),
    (64, '2025-06-12', 3500),
    (64, '2025-03-29', 7600);

INSERT INTO vinc_contrib_co2 VALUES
    (65, '01.274.895', '0001-40', '64.253.970/0001-81', '2020-03-22', 'Frota verde para redução de emissões');

INSERT INTO contrib_co2 VALUES
    (65, '2020-04-06', 3500),
    (65, '2020-05-13', 3500),
    (65, '2020-03-31', 3500),
    (65, '2020-05-17', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (66, '13.690.872', '0001-09', '74.029.536/0001-76', '2020-06-24', 'Substituição de fontes fósseis por renováveis');

INSERT INTO contrib_co2 VALUES
    (66, '2020-08-03', 5200),
    (66, '2020-09-20', 8600);

INSERT INTO vinc_contrib_co2 VALUES
    (67, '79.821.563', '0001-43', '68.532.497/0001-22', '2023-01-16', 'Corredores verdes de mobilidade');

INSERT INTO contrib_co2 VALUES
    (67, '2023-02-28', 5700);

INSERT INTO vinc_contrib_co2 VALUES
    (68, '18.024.935', '0001-76', '14.679.502/0001-03', '2026-05-11', 'Eficiência energética em edificações');

INSERT INTO contrib_co2 VALUES
    (68, '2026-07-26', 4700),
    (68, '2026-06-19', 9400),
    (68, '2026-07-30', 12000);

INSERT INTO vinc_contrib_co2 VALUES
    (69, '65.172.380', '0001-53', '74.029.536/0001-76', '2025-03-15', 'Energia renovável para todos');

INSERT INTO contrib_co2 VALUES
    (69, '2025-04-08', 3600);

INSERT INTO vinc_contrib_co2 VALUES
    (70, '01.274.895', '0001-13', '68.532.497/0001-22', '2023-01-16', 'Corredores verdes de mobilidade');

INSERT INTO contrib_co2 VALUES
    (70, '2023-04-09', 8000),
    (70, '2023-04-13', 7400),
    (70, '2023-02-10', 3500),
    (70, '2023-03-14', 6200);

INSERT INTO vinc_contrib_co2 VALUES
    (71, '56.738.014', '0001-69', '74.029.536/0001-76', '2025-03-15', 'Energia renovável para todos');

INSERT INTO contrib_co2 VALUES
    (71, '2025-06-12', 4900);

INSERT INTO vinc_contrib_co2 VALUES
    (72, '28.659.130', '0001-07', '74.029.536/0001-76', '2026-02-25', 'Incentivos de transporte sustentável');

INSERT INTO contrib_co2 VALUES
    (72, '2026-04-25', 3500),
    (72, '2026-04-08', 4900);

INSERT INTO vinc_contrib_co2 VALUES
    (73, '01.274.895', '0001-13', '14.679.502/0001-03', '2023-09-21', 'Ação climática para organizações sociais');

INSERT INTO contrib_co2 VALUES
    (73, '2023-11-15', 8100),
    (73, '2023-12-16', 8200),
    (73, '2023-12-17', 4800);

INSERT INTO vinc_contrib_co2 VALUES
    (74, '20.978.635', '0001-10', '52.061.387/0001-90', '2023-11-04', 'Redução de carbono no deslocamento diário');

INSERT INTO contrib_co2 VALUES
    (74, '2024-02-01', 5800);

INSERT INTO vinc_contrib_co2 VALUES
    (75, '56.738.014', '0001-69', '52.061.387/0001-90', '2025-08-07', 'Recuperação de áreas degradadas e clima');

INSERT INTO contrib_co2 VALUES
    (75, '2025-09-06', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (76, '64.087.915', '0001-27', '14.679.502/0001-03', '2026-05-11', 'Eficiência energética em edificações');

INSERT INTO contrib_co2 VALUES
    (76, '2026-07-17', 6600),
    (76, '2026-06-30', 11900),
    (76, '2026-07-19', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (77, '09.723.145', '0001-56', '68.532.497/0001-22', '2021-12-25', 'Compensação de emissões no transporte urbano');

INSERT INTO contrib_co2 VALUES
    (77, '2022-01-07', 14100),
    (77, '2022-03-16', 11300);

INSERT INTO vinc_contrib_co2 VALUES
    (78, '27.401.593', '0001-66', '14.679.502/0001-03', '2020-02-10', 'Programa de economia de energia e carbono');

INSERT INTO contrib_co2 VALUES
    (78, '2020-04-20', 7800),
    (78, '2020-04-27', 3700),
    (78, '2020-04-15', 7200),
    (78, '2020-04-06', 7200);

INSERT INTO vinc_contrib_co2 VALUES
    (79, '13.690.872', '0001-54', '37.186.429/0001-25', '2023-12-02', 'Transformação de resíduos em impacto positivo');

INSERT INTO contrib_co2 VALUES
    (79, '2023-12-28', 5600);

INSERT INTO vinc_contrib_co2 VALUES
    (80, '88.635.333', '0001-98', '52.061.387/0001-90', '2025-01-03', 'Compensação ambiental de operações organizacionais');

INSERT INTO contrib_co2 VALUES
    (80, '2025-04-02', 3600);

INSERT INTO vinc_contrib_co2 VALUES
    (81, '09.723.145', '0001-56', '64.253.970/0001-81', '2022-06-27', 'Geração comunitária de energia solar');

INSERT INTO contrib_co2 VALUES
    (81, '2022-09-10', 7800);

INSERT INTO vinc_contrib_co2 VALUES
    (82, '12.905.674', '0001-18', '74.029.536/0001-76', '2026-02-25', 'Incentivos de transporte sustentável');

INSERT INTO contrib_co2 VALUES
    (82, '2026-05-10', 6400);

INSERT INTO vinc_contrib_co2 VALUES
    (83, '65.172.380', '0001-53', '64.253.970/0001-81', '2020-03-22', 'Frota verde para redução de emissões');

INSERT INTO contrib_co2 VALUES
    (83, '2020-04-06', 8500),
    (83, '2020-05-31', 3900),
    (83, '2020-05-20', 3500),
    (83, '2020-05-01', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (84, '01.274.895', '0001-23', '74.029.536/0001-76', '2022-10-02', 'Reciclagem inclusiva e sustentável');

INSERT INTO contrib_co2 VALUES
    (84, '2022-12-18', 9000),
    (84, '2022-10-25', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (85, '56.738.014', '0001-69', '52.061.387/0001-90', '2023-11-20', 'Neutralização de emissões de eventos');

INSERT INTO contrib_co2 VALUES
    (85, '2024-01-01', 6800),
    (85, '2024-01-19', 3500),
    (85, '2024-01-18', 6900),
    (85, '2024-01-30', 3500),
    (85, '2023-12-15', 3500),
    (85, '2024-01-27', 13100),
    (85, '2024-01-20', 6900);

INSERT INTO vinc_contrib_co2 VALUES
    (86, '13.690.872', '0001-09', '63.754.089/0001-00', '2022-04-13', 'Corredores ecológicos para captura de carbono');

INSERT INTO contrib_co2 VALUES
    (86, '2022-05-24', 3500),
    (86, '2022-06-06', 9000);

INSERT INTO vinc_contrib_co2 VALUES
    (87, '79.821.563', '0001-43', '14.679.502/0001-03', '2022-11-12', 'Transporte coletivo carbono neutro');

INSERT INTO contrib_co2 VALUES
    (87, '2023-02-07', 3500),
    (87, '2022-11-16', 3500),
    (87, '2023-01-22', 6900);

INSERT INTO vinc_contrib_co2 VALUES
    (88, '01.274.895', '0001-23', '74.029.536/0001-76', '2020-06-24', 'Substituição de fontes fósseis por renováveis');

INSERT INTO contrib_co2 VALUES
    (88, '2020-06-24', 7700);

INSERT INTO vinc_contrib_co2 VALUES
    (89, '79.821.563', '0001-00', '52.061.387/0001-90', '2025-01-03', 'Compensação ambiental de operações organizacionais');

INSERT INTO contrib_co2 VALUES
    (89, '2025-01-09', 6300),
    (89, '2025-03-16', 3500),
    (89, '2025-03-02', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (90, '13.690.872', '0001-09', '07.219.354/0001-70', '2024-04-07', 'Gestão sustentável da pegada de carbono');

INSERT INTO contrib_co2 VALUES
    (90, '2024-06-07', 3500),
    (90, '2024-05-05', 6600);

INSERT INTO vinc_contrib_co2 VALUES
    (91, '75.893.062', '0001-31', '52.061.387/0001-90', '2022-04-07', 'Transição energética sustentável');

INSERT INTO contrib_co2 VALUES
    (91, '2022-06-04', 3800);

INSERT INTO vinc_contrib_co2 VALUES
    (92, '75.893.062', '0001-33', '63.754.089/0001-00', '2025-09-22', 'Programa integrado de mitigação climática');

INSERT INTO contrib_co2 VALUES
    (92, '2025-10-12', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (93, '01.274.895', '0001-40', '74.029.536/0001-76', '2024-01-23', 'Economia circular em comunidades locais');

INSERT INTO contrib_co2 VALUES
    (93, '2024-03-13', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (94, '65.172.380', '0001-53', '63.754.089/0001-00', '2025-04-04', 'Energia limpa para organizações sociais');

INSERT INTO contrib_co2 VALUES
    (94, '2025-06-02', 4100);

INSERT INTO vinc_contrib_co2 VALUES
    (95, '28.659.130', '0001-07', '14.679.502/0001-03', '2026-05-11', 'Eficiência energética em edificações');

INSERT INTO contrib_co2 VALUES
    (95, '2026-06-16', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (96, '13.690.872', '0001-54', '74.029.536/0001-76', '2020-06-21', 'Campanha de reflorestamento local');

INSERT INTO contrib_co2 VALUES
    (96, '2020-08-22', 6900),
    (96, '2020-08-15', 3500),
    (96, '2020-08-01', 10200),
    (96, '2020-09-12', 7500);

INSERT INTO vinc_contrib_co2 VALUES
    (97, '79.821.563', '0001-00', '63.754.089/0001-00', '2023-12-04', 'Reciclagem solidária com compensação ambiental');

INSERT INTO contrib_co2 VALUES
    (97, '2023-12-31', 4400),
    (97, '2024-01-30', 3500),
    (97, '2024-01-15', 10000);

INSERT INTO vinc_contrib_co2 VALUES
    (98, '27.401.593', '0001-66', '52.061.387/0001-90', '2021-09-22', 'Proteção de biomas e compensação climática');

INSERT INTO contrib_co2 VALUES
    (98, '2021-12-03', 3500),
    (98, '2021-11-14', 4100),
    (98, '2021-12-14', 6700),
    (98, '2021-10-08', 9100),
    (98, '2021-11-03', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (99, '27.401.593', '0001-66', '52.061.387/0001-90', '2023-11-04', 'Redução de carbono no deslocamento diário');

INSERT INTO contrib_co2 VALUES
    (99, '2023-11-10', 10200),
    (99, '2023-11-25', 3500),
    (99, '2023-12-08', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (100, '75.893.062', '0001-31', '64.253.970/0001-81', '2022-06-27', 'Geração comunitária de energia solar');

INSERT INTO contrib_co2 VALUES
    (100, '2022-07-21', 6700);

INSERT INTO vinc_contrib_co2 VALUES
    (101, '09.723.145', '0001-93', '35.179.804/0001-84', '2020-02-01', 'Gestão circular de resíduos urbanos');

INSERT INTO contrib_co2 VALUES
    (101, '2020-03-02', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (102, '88.635.333', '0001-98', '64.253.970/0001-81', '2022-06-27', 'Geração comunitária de energia solar');

INSERT INTO contrib_co2 VALUES
    (102, '2022-07-06', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (103, '75.893.062', '0001-31', '74.029.536/0001-76', '2022-10-02', 'Reciclagem inclusiva e sustentável');

INSERT INTO contrib_co2 VALUES
    (103, '2022-11-15', 13900),
    (103, '2022-12-19', 9900);

INSERT INTO vinc_contrib_co2 VALUES
    (104, '13.690.872', '0001-09', '14.679.502/0001-03', '2022-11-12', 'Transporte coletivo carbono neutro');

INSERT INTO contrib_co2 VALUES
    (104, '2022-11-17', 12600),
    (104, '2023-01-16', 7000),
    (104, '2022-11-27', 6200),
    (104, '2023-02-07', 3900);

INSERT INTO vinc_contrib_co2 VALUES
    (105, '09.723.145', '0001-56', '07.219.354/0001-70', '2024-04-07', 'Gestão sustentável da pegada de carbono');

INSERT INTO contrib_co2 VALUES
    (105, '2024-04-24', 3500),
    (105, '2024-04-26', 8300),
    (105, '2024-06-29', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (106, '48.912.037', '0001-48', '63.754.089/0001-00', '2021-11-01', 'Mobilidade sustentável com baixa emissão');

INSERT INTO contrib_co2 VALUES
    (106, '2021-11-24', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (107, '56.738.014', '0001-69', '14.679.502/0001-03', '2026-05-11', 'Eficiência energética em edificações');

INSERT INTO contrib_co2 VALUES
    (107, '2026-07-12', 14800),
    (107, '2026-05-21', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (108, '45.690.123', '0001-36', '74.029.536/0001-76', '2023-10-17', 'Florestas comunitárias para o clima');

INSERT INTO contrib_co2 VALUES
    (108, '2023-12-16', 5900),
    (108, '2023-11-17', 8000),
    (108, '2023-11-13', 7100);

INSERT INTO vinc_contrib_co2 VALUES
    (109, '13.690.872', '0001-54', '52.061.387/0001-90', '2021-12-16', 'Transporte limpo para comunidades');

INSERT INTO contrib_co2 VALUES
    (109, '2022-01-18', 7500);

INSERT INTO vinc_contrib_co2 VALUES
    (110, '09.723.145', '0001-78', '52.061.387/0001-90', '2023-11-04', 'Redução de carbono no deslocamento diário');

INSERT INTO contrib_co2 VALUES
    (110, '2023-11-29', 6400),
    (110, '2024-01-19', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (111, '75.893.062', '0001-33', '14.679.502/0001-03', '2022-11-12', 'Transporte coletivo carbono neutro');

INSERT INTO contrib_co2 VALUES
    (111, '2022-11-14', 12900),
    (111, '2023-01-27', 3500),
    (111, '2023-01-15', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (112, '45.690.123', '0001-36', '63.754.089/0001-00', '2025-04-04', 'Energia limpa para organizações sociais');

INSERT INTO contrib_co2 VALUES
    (112, '2025-06-06', 5800);

INSERT INTO vinc_contrib_co2 VALUES
    (113, '51.360.297', '0001-43', '63.754.089/0001-00', '2025-04-04', 'Energia limpa para organizações sociais');

INSERT INTO contrib_co2 VALUES
    (113, '2025-06-10', 4200);

INSERT INTO vinc_contrib_co2 VALUES
    (114, '65.172.380', '0001-53', '20.594.183/0001-28', '2025-01-07', 'Neutralização de emissões de entregas');

INSERT INTO contrib_co2 VALUES
    (114, '2025-02-18', 3500),
    (114, '2025-03-14', 10500),
    (114, '2025-03-15', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (115, '79.821.563', '0001-00', '14.679.502/0001-03', '2026-05-11', 'Eficiência energética em edificações');

INSERT INTO contrib_co2 VALUES
    (115, '2026-07-24', 6200),
    (115, '2026-05-17', 3500),
    (115, '2026-06-08', 9600);

INSERT INTO vinc_contrib_co2 VALUES
    (116, '65.172.380', '0001-53', '74.029.536/0001-76', '2025-11-17', 'Reaproveitamento de materiais pós-consumo');

INSERT INTO contrib_co2 VALUES
    (116, '2026-01-15', 3500),
    (116, '2025-12-17', 3500),
    (116, '2025-12-25', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (117, '65.172.380', '0001-61', '64.253.970/0001-81', '2025-04-10', 'Campanha de reflorestamento no Amazonas');

INSERT INTO contrib_co2 VALUES
    (117, '2025-06-21', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (118, '79.821.563', '0001-43', '35.179.804/0001-84', '2023-07-28', 'Compensação de emissões por energia renovável');

INSERT INTO contrib_co2 VALUES
    (118, '2023-08-30', 3900);

INSERT INTO vinc_contrib_co2 VALUES
    (119, '51.360.297', '0001-43', '64.253.970/0001-81', '2025-04-10', 'Campanha de reflorestamento no Amazonas');

INSERT INTO contrib_co2 VALUES
    (119, '2025-06-10', 8800);

INSERT INTO vinc_contrib_co2 VALUES
    (120, '48.603.715', '0001-45', '63.754.089/0001-00', '2022-04-13', 'Corredores ecológicos para captura de carbono');

INSERT INTO contrib_co2 VALUES
    (120, '2022-05-04', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (121, '53.921.807', '0001-18', '63.754.089/0001-00', '2022-04-13', 'Corredores ecológicos para captura de carbono');

INSERT INTO contrib_co2 VALUES
    (121, '2022-05-04', 3500),
    (121, '2022-04-28', 16600),
    (121, '2022-06-22', 7900);

INSERT INTO vinc_contrib_co2 VALUES
    (122, '45.690.123', '0001-36', '74.029.536/0001-76', '2026-02-25', 'Incentivos de transporte sustentável');

INSERT INTO contrib_co2 VALUES
    (122, '2026-03-27', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (123, '65.172.380', '0001-61', '52.061.387/0001-90', '2021-06-26', 'Coleta seletiva para redução de carbono');

INSERT INTO contrib_co2 VALUES
    (123, '2021-09-21', 3500),
    (123, '2021-08-16', 3500),
    (123, '2021-09-18', 9600);

INSERT INTO vinc_contrib_co2 VALUES
    (124, '27.401.593', '0001-66', '07.219.354/0001-70', '2024-04-07', 'Gestão sustentável da pegada de carbono');

INSERT INTO contrib_co2 VALUES
    (124, '2024-05-17', 4100),
    (124, '2024-05-30', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (125, '09.723.145', '0001-78', '74.029.536/0001-76', '2020-06-24', 'Substituição de fontes fósseis por renováveis');

INSERT INTO contrib_co2 VALUES
    (125, '2020-07-07', 3600);

INSERT INTO vinc_contrib_co2 VALUES
    (126, '01.274.895', '0001-13', '14.679.502/0001-03', '2022-11-12', 'Transporte coletivo carbono neutro');

INSERT INTO contrib_co2 VALUES
    (126, '2022-12-21', 9000),
    (126, '2022-12-07', 5600);

INSERT INTO vinc_contrib_co2 VALUES
    (127, '71.498.635', '0001-06', '64.253.970/0001-81', '2022-06-27', 'Geração comunitária de energia solar');

INSERT INTO contrib_co2 VALUES
    (127, '2022-08-22', 6600);

INSERT INTO vinc_contrib_co2 VALUES
    (128, '20.978.635', '0001-10', '14.679.502/0001-03', '2021-02-16', 'Modernização energética de baixo carbono');

INSERT INTO contrib_co2 VALUES
    (128, '2021-05-06', 9600);

INSERT INTO vinc_contrib_co2 VALUES
    (129, '56.738.014', '0001-69', '14.679.502/0001-03', '2021-02-16', 'Modernização energética de baixo carbono');

INSERT INTO contrib_co2 VALUES
    (129, '2021-05-05', 5500),
    (129, '2021-03-09', 7600);

INSERT INTO vinc_contrib_co2 VALUES
    (130, '27.401.593', '0001-66', '74.029.536/0001-76', '2026-02-25', 'Incentivos de transporte sustentável');

INSERT INTO contrib_co2 VALUES
    (130, '2026-03-29', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (131, '28.659.130', '0001-07', '74.029.536/0001-76', '2022-10-02', 'Reciclagem inclusiva e sustentável');

INSERT INTO contrib_co2 VALUES
    (131, '2022-11-24', 9200);

INSERT INTO vinc_contrib_co2 VALUES
    (132, '09.723.145', '0001-56', '52.061.387/0001-90', '2021-12-16', 'Transporte limpo para comunidades');

INSERT INTO contrib_co2 VALUES
    (132, '2021-12-20', 3500),
    (132, '2021-12-27', 5400),
    (132, '2022-02-08', 3500),
    (132, '2022-02-22', 11100);

INSERT INTO vinc_contrib_co2 VALUES
    (133, '51.360.297', '0001-43', '52.061.387/0001-90', '2021-10-30', 'Valorização de resíduos para mitigação climática');

INSERT INTO contrib_co2 VALUES
    (133, '2022-01-01', 7400);

INSERT INTO vinc_contrib_co2 VALUES
    (134, '18.024.935', '0001-76', '20.594.183/0001-28', '2022-03-18', 'Rede de energia solar comunitária');

INSERT INTO contrib_co2 VALUES
    (134, '2022-04-21', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (135, '01.274.895', '0001-40', '14.679.502/0001-03', '2026-05-11', 'Eficiência energética em edificações');

INSERT INTO contrib_co2 VALUES
    (135, '2026-06-19', 10000),
    (135, '2026-07-26', 11300);

INSERT INTO vinc_contrib_co2 VALUES
    (136, '33.738.001', '0001-77', '14.679.502/0001-03', '2022-11-12', 'Transporte coletivo carbono neutro');

INSERT INTO contrib_co2 VALUES
    (136, '2022-12-17', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (137, '13.690.872', '0001-09', '74.029.536/0001-76', '2025-11-17', 'Reaproveitamento de materiais pós-consumo');

INSERT INTO contrib_co2 VALUES
    (137, '2025-11-27', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (138, '18.024.935', '0001-76', '63.754.089/0001-00', '2022-04-13', 'Corredores ecológicos para captura de carbono');

INSERT INTO contrib_co2 VALUES
    (138, '2022-04-28', 7300);

INSERT INTO vinc_contrib_co2 VALUES
    (139, '18.024.935', '0001-76', '14.679.502/0001-03', '2021-02-16', 'Modernização energética de baixo carbono');

INSERT INTO contrib_co2 VALUES
    (139, '2021-03-28', 6800),
    (139, '2021-05-01', 3500),
    (139, '2021-03-22', 10200),
    (139, '2021-04-19', 4600);

INSERT INTO vinc_contrib_co2 VALUES
    (140, '33.738.001', '0001-77', '63.754.089/0001-00', '2023-12-04', 'Reciclagem solidária com compensação ambiental');

INSERT INTO contrib_co2 VALUES
    (140, '2024-01-28', 9800);

INSERT INTO vinc_contrib_co2 VALUES
    (141, '79.821.563', '0001-43', '74.029.536/0001-76', '2020-06-21', 'Campanha de reflorestamento local');

INSERT INTO contrib_co2 VALUES
    (141, '2020-06-29', 5400),
    (141, '2020-08-29', 4700),
    (141, '2020-07-30', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (142, '01.274.895', '0001-23', '74.029.536/0001-76', '2026-02-25', 'Incentivos de transporte sustentável');

INSERT INTO contrib_co2 VALUES
    (142, '2026-03-28', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (143, '48.912.037', '0001-38', '63.754.089/0001-00', '2025-04-04', 'Energia limpa para organizações sociais');

INSERT INTO contrib_co2 VALUES
    (143, '2025-06-24', 10700),
    (143, '2025-06-04', 3500),
    (143, '2025-04-08', 5700),
    (143, '2025-05-13', 3500),
    (143, '2025-04-27', 3500),
    (143, '2025-05-08', 6800);

INSERT INTO vinc_contrib_co2 VALUES
    (144, '20.978.635', '0001-10', '20.594.183/0001-28', '2022-03-18', 'Rede de energia solar comunitária');

INSERT INTO contrib_co2 VALUES
    (144, '2022-04-10', 5200);

INSERT INTO vinc_contrib_co2 VALUES
    (145, '39.605.871', '0001-83', '52.061.387/0001-90', '2021-06-23', 'Restauração de nascentes e sequestro de carbono');

INSERT INTO contrib_co2 VALUES
    (145, '2021-09-19', 3500),
    (145, '2021-07-17', 3500),
    (145, '2021-07-18', 9800),
    (145, '2021-08-06', 16800);

INSERT INTO vinc_contrib_co2 VALUES
    (146, '13.690.872', '0001-54', '74.029.536/0001-76', '2020-06-24', 'Substituição de fontes fósseis por renováveis');

INSERT INTO contrib_co2 VALUES
    (146, '2020-08-21', 10300),
    (146, '2020-09-04', 6300);

INSERT INTO vinc_contrib_co2 VALUES
    (147, '65.172.380', '0001-61', '63.754.089/0001-00', '2022-04-13', 'Corredores ecológicos para captura de carbono');

INSERT INTO contrib_co2 VALUES
    (147, '2022-05-10', 6700),
    (147, '2022-06-24', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (148, '48.603.715', '0001-45', '74.029.536/0001-76', '2023-10-17', 'Florestas comunitárias para o clima');

INSERT INTO contrib_co2 VALUES
    (148, '2023-12-29', 3500),
    (148, '2024-01-10', 3500),
    (148, '2023-11-12', 3500),
    (148, '2023-11-25', 8900);

INSERT INTO vinc_contrib_co2 VALUES
    (149, '53.921.807', '0001-18', '52.061.387/0001-90', '2025-08-07', 'Recuperação de áreas degradadas e clima');

INSERT INTO contrib_co2 VALUES
    (149, '2025-10-18', 9900);

INSERT INTO vinc_contrib_co2 VALUES
    (150, '64.087.915', '0001-27', '68.532.497/0001-22', '2021-06-25', 'Conservação florestal e créditos de carbono');

INSERT INTO contrib_co2 VALUES
    (150, '2021-09-02', 4300),
    (150, '2021-07-02', 3500),
    (150, '2021-09-11', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (151, '56.738.014', '0001-69', '20.594.183/0001-28', '2022-03-18', 'Rede de energia solar comunitária');

INSERT INTO contrib_co2 VALUES
    (151, '2022-04-13', 3500),
    (151, '2022-04-17', 6200),
    (151, '2022-04-14', 3500),
    (151, '2022-03-28', 3500),
    (151, '2022-04-20', 12200),
    (151, '2022-04-29', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (152, '12.905.674', '0001-18', '52.061.387/0001-90', '2021-09-22', 'Proteção de biomas e compensação climática');

INSERT INTO contrib_co2 VALUES
    (152, '2021-12-07', 3500),
    (152, '2021-12-05', 3500),
    (152, '2021-11-19', 3500),
    (152, '2021-09-24', 3500),
    (152, '2021-10-23', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (153, '53.921.807', '0001-18', '14.679.502/0001-03', '2026-05-11', 'Eficiência energética em edificações');

INSERT INTO contrib_co2 VALUES
    (153, '2026-08-08', 9800),
    (153, '2026-05-12', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (154, '39.605.871', '0001-83', '63.754.089/0001-00', '2023-12-04', 'Reciclagem solidária com compensação ambiental');

INSERT INTO contrib_co2 VALUES
    (154, '2024-02-18', 14100),
    (154, '2024-02-01', 3500),
    (154, '2023-12-28', 8200);

INSERT INTO vinc_contrib_co2 VALUES
    (155, '79.821.563', '0001-43', '20.594.183/0001-28', '2025-01-07', 'Neutralização de emissões de entregas');

INSERT INTO contrib_co2 VALUES
    (155, '2025-01-16', 6000);

INSERT INTO vinc_contrib_co2 VALUES
    (156, '33.738.001', '0001-77', '52.061.387/0001-90', '2022-04-07', 'Transição energética sustentável');

INSERT INTO contrib_co2 VALUES
    (156, '2022-06-08', 11300);

INSERT INTO vinc_contrib_co2 VALUES
    (157, '18.024.935', '0001-76', '64.253.970/0001-81', '2025-12-20', 'Reflorestamento para neutralização de carbono');

INSERT INTO contrib_co2 VALUES
    (157, '2026-02-09', 5800);

INSERT INTO vinc_contrib_co2 VALUES
    (158, '01.274.895', '0001-13', '64.253.970/0001-81', '2020-03-22', 'Frota verde para redução de emissões');

INSERT INTO contrib_co2 VALUES
    (158, '2020-06-15', 9300),
    (158, '2020-04-11', 3500),
    (158, '2020-05-12', 10600);

INSERT INTO vinc_contrib_co2 VALUES
    (159, '88.635.333', '0001-98', '37.186.429/0001-25', '2023-12-02', 'Transformação de resíduos em impacto positivo');

INSERT INTO contrib_co2 VALUES
    (159, '2024-01-23', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (160, '88.635.333', '0001-98', '74.029.536/0001-76', '2020-06-24', 'Substituição de fontes fósseis por renováveis');

INSERT INTO contrib_co2 VALUES
    (160, '2020-07-02', 8700),
    (160, '2020-09-12', 10400),
    (160, '2020-07-06', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (161, '64.087.915', '0001-27', '52.061.387/0001-90', '2025-01-03', 'Compensação ambiental de operações organizacionais');

INSERT INTO contrib_co2 VALUES
    (161, '2025-02-17', 4400);

INSERT INTO vinc_contrib_co2 VALUES
    (162, '18.024.935', '0001-76', '74.029.536/0001-76', '2026-02-25', 'Incentivos de transporte sustentável');

INSERT INTO contrib_co2 VALUES
    (162, '2026-05-20', 9300),
    (162, '2026-04-16', 3500),
    (162, '2026-05-08', 8000),
    (162, '2026-05-05', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (163, '48.912.037', '0001-38', '14.679.502/0001-03', '2023-09-21', 'Ação climática para organizações sociais');

INSERT INTO contrib_co2 VALUES
    (163, '2023-10-16', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (164, '12.905.674', '0001-18', '35.179.804/0001-84', '2023-07-28', 'Compensação de emissões por energia renovável');

INSERT INTO contrib_co2 VALUES
    (164, '2023-08-10', 3500),
    (164, '2023-08-26', 16500);

INSERT INTO vinc_contrib_co2 VALUES
    (165, '45.690.123', '0001-36', '14.679.502/0001-03', '2021-02-16', 'Modernização energética de baixo carbono');

INSERT INTO contrib_co2 VALUES
    (165, '2021-05-09', 8200),
    (165, '2021-04-15', 3500),
    (165, '2021-03-04', 4500),
    (165, '2021-03-06', 11300),
    (165, '2021-03-17', 6900);

INSERT INTO vinc_contrib_co2 VALUES
    (166, '27.401.593', '0001-66', '52.061.387/0001-90', '2025-01-03', 'Compensação ambiental de operações organizacionais');

INSERT INTO contrib_co2 VALUES
    (166, '2025-03-29', 3500),
    (166, '2025-01-04', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (167, '79.821.563', '0001-65', '14.679.502/0001-03', '2021-02-16', 'Modernização energética de baixo carbono');

INSERT INTO contrib_co2 VALUES
    (167, '2021-03-22', 4300),
    (167, '2021-04-04', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (168, '13.690.872', '0001-09', '52.061.387/0001-90', '2021-09-22', 'Proteção de biomas e compensação climática');

INSERT INTO contrib_co2 VALUES
    (168, '2021-09-24', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (169, '18.024.935', '0001-76', '68.532.497/0001-22', '2021-12-25', 'Compensação de emissões no transporte urbano');

INSERT INTO contrib_co2 VALUES
    (169, '2022-02-21', 8500),
    (169, '2022-02-06', 7300),
    (169, '2022-02-28', 10100);

INSERT INTO vinc_contrib_co2 VALUES
    (170, '18.024.935', '0001-76', '14.679.502/0001-03', '2022-11-12', 'Transporte coletivo carbono neutro');

INSERT INTO contrib_co2 VALUES
    (170, '2022-12-11', 10300),
    (170, '2022-12-25', 5700);

INSERT INTO vinc_contrib_co2 VALUES
    (171, '28.659.130', '0001-07', '52.061.387/0001-90', '2022-04-07', 'Transição energética sustentável');

INSERT INTO contrib_co2 VALUES
    (171, '2022-05-14', 5800),
    (171, '2022-06-03', 3500),
    (171, '2022-04-26', 3500),
    (171, '2022-06-10', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (172, '71.498.635', '0001-06', '37.186.429/0001-25', '2023-12-02', 'Transformação de resíduos em impacto positivo');

INSERT INTO contrib_co2 VALUES
    (172, '2024-02-04', 3500),
    (172, '2024-01-12', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (173, '28.659.130', '0001-07', '64.253.970/0001-81', '2025-04-10', 'Campanha de reflorestamento no Amazonas');

INSERT INTO contrib_co2 VALUES
    (173, '2025-04-18', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (174, '48.912.037', '0001-38', '64.253.970/0001-81', '2025-04-10', 'Campanha de reflorestamento no Amazonas');

INSERT INTO contrib_co2 VALUES
    (174, '2025-04-25', 3500),
    (174, '2025-06-11', 13500),
    (174, '2025-06-16', 6800);

INSERT INTO vinc_contrib_co2 VALUES
    (175, '28.659.130', '0001-07', '35.179.804/0001-84', '2020-02-01', 'Gestão circular de resíduos urbanos');

INSERT INTO contrib_co2 VALUES
    (175, '2020-04-28', 5000),
    (175, '2020-04-10', 6300);

INSERT INTO vinc_contrib_co2 VALUES
    (176, '13.690.872', '0001-54', '63.754.089/0001-00', '2021-11-01', 'Mobilidade sustentável com baixa emissão');

INSERT INTO contrib_co2 VALUES
    (176, '2021-12-21', 3500),
    (176, '2021-11-10', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (177, '48.603.715', '0001-45', '64.253.970/0001-81', '2022-06-27', 'Geração comunitária de energia solar');

INSERT INTO contrib_co2 VALUES
    (177, '2022-08-05', 12100);

INSERT INTO vinc_contrib_co2 VALUES
    (178, '79.821.563', '0001-65', '07.219.354/0001-70', '2024-04-07', 'Gestão sustentável da pegada de carbono');

INSERT INTO contrib_co2 VALUES
    (178, '2024-05-21', 6200),
    (178, '2024-04-22', 4400),
    (178, '2024-05-06', 3500),
    (178, '2024-05-12', 3500),
    (178, '2024-05-07', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (179, '64.087.915', '0001-27', '74.029.536/0001-76', '2024-01-23', 'Economia circular em comunidades locais');

INSERT INTO contrib_co2 VALUES
    (179, '2024-02-04', 7200);

INSERT INTO vinc_contrib_co2 VALUES
    (180, '13.690.872', '0001-09', '14.679.502/0001-03', '2026-05-11', 'Eficiência energética em edificações');

INSERT INTO contrib_co2 VALUES
    (180, '2026-08-07', 9100),
    (180, '2026-07-26', 3500),
    (180, '2026-05-27', 14400),
    (180, '2026-06-09', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (181, '28.659.130', '0001-07', '52.061.387/0001-90', '2023-11-04', 'Redução de carbono no deslocamento diário');

INSERT INTO contrib_co2 VALUES
    (181, '2023-12-15', 13400),
    (181, '2023-11-15', 3500),
    (181, '2024-01-03', 4400),
    (181, '2023-12-18', 6000),
    (181, '2024-01-22', 6400);

INSERT INTO vinc_contrib_co2 VALUES
    (182, '64.087.915', '0001-27', '37.186.429/0001-25', '2021-03-21', 'Programa de neutralização de carbono logístico');

INSERT INTO contrib_co2 VALUES
    (182, '2021-04-19', 3500),
    (182, '2021-05-29', 5100),
    (182, '2021-04-29', 9500),
    (182, '2021-06-03', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (183, '33.738.001', '0001-77', '35.179.804/0001-84', '2020-02-01', 'Gestão circular de resíduos urbanos');

INSERT INTO contrib_co2 VALUES
    (183, '2020-02-07', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (184, '27.401.593', '0001-66', '52.061.387/0001-90', '2021-12-16', 'Transporte limpo para comunidades');

INSERT INTO contrib_co2 VALUES
    (184, '2022-01-28', 13800),
    (184, '2022-02-21', 6700);

INSERT INTO vinc_contrib_co2 VALUES
    (185, '51.360.297', '0001-43', '63.754.089/0001-00', '2022-04-13', 'Corredores ecológicos para captura de carbono');

INSERT INTO contrib_co2 VALUES
    (185, '2022-06-05', 3500),
    (185, '2022-07-04', 5000);

INSERT INTO vinc_contrib_co2 VALUES
    (186, '79.821.563', '0001-99', '63.754.089/0001-00', '2025-04-04', 'Energia limpa para organizações sociais');

INSERT INTO contrib_co2 VALUES
    (186, '2025-06-11', 3500),
    (186, '2025-06-10', 3500),
    (186, '2025-06-12', 3500),
    (186, '2025-04-18', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (187, '64.087.915', '0001-27', '64.253.970/0001-81', '2025-04-10', 'Campanha de reflorestamento no Amazonas');

INSERT INTO contrib_co2 VALUES
    (187, '2025-05-06', 4800),
    (187, '2025-04-15', 9500);

INSERT INTO vinc_contrib_co2 VALUES
    (188, '79.821.563', '0001-43', '74.029.536/0001-76', '2022-10-02', 'Reciclagem inclusiva e sustentável');

INSERT INTO contrib_co2 VALUES
    (188, '2022-10-10', 10800),
    (188, '2022-12-29', 10400),
    (188, '2022-12-11', 5100),
    (188, '2022-12-14', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (189, '12.905.674', '0001-18', '37.186.429/0001-25', '2026-03-25', 'Programa de resíduos com baixa emissão');

INSERT INTO contrib_co2 VALUES
    (189, '2026-05-11', 3500),
    (189, '2026-06-06', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (190, '01.274.895', '0001-40', '52.061.387/0001-90', '2021-06-26', 'Coleta seletiva para redução de carbono');

INSERT INTO contrib_co2 VALUES
    (190, '2021-07-31', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (191, '12.905.674', '0001-18', '14.679.502/0001-03', '2023-09-21', 'Ação climática para organizações sociais');

INSERT INTO contrib_co2 VALUES
    (191, '2023-10-30', 3500),
    (191, '2023-11-06', 3900),
    (191, '2023-10-04', 8200);

INSERT INTO vinc_contrib_co2 VALUES
    (192, '79.821.563', '0001-99', '64.253.970/0001-81', '2025-04-10', 'Campanha de reflorestamento no Amazonas');

INSERT INTO contrib_co2 VALUES
    (192, '2025-05-18', 10400);

INSERT INTO vinc_contrib_co2 VALUES
    (193, '13.690.872', '0001-54', '64.253.970/0001-81', '2020-03-22', 'Frota verde para redução de emissões');

INSERT INTO contrib_co2 VALUES
    (193, '2020-06-03', 12200),
    (193, '2020-06-19', 3500),
    (193, '2020-03-30', 3500),
    (193, '2020-05-04', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (194, '51.360.297', '0001-43', '35.179.804/0001-84', '2023-07-28', 'Compensação de emissões por energia renovável');

INSERT INTO contrib_co2 VALUES
    (194, '2023-10-01', 10800);

INSERT INTO vinc_contrib_co2 VALUES
    (195, '18.024.935', '0001-76', '68.532.497/0001-22', '2021-04-25', 'Plantio de árvores para compensação ambiental');

INSERT INTO contrib_co2 VALUES
    (195, '2021-06-14', 4600);

INSERT INTO vinc_contrib_co2 VALUES
    (196, '09.723.145', '0001-78', '14.679.502/0001-03', '2020-02-10', 'Programa de economia de energia e carbono');

INSERT INTO contrib_co2 VALUES
    (196, '2020-03-27', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (197, '18.024.935', '0001-76', '20.594.183/0001-28', '2025-01-07', 'Neutralização de emissões de entregas');

INSERT INTO contrib_co2 VALUES
    (197, '2025-02-05', 8600);

INSERT INTO vinc_contrib_co2 VALUES
    (198, '13.690.872', '0001-54', '63.754.089/0001-00', '2025-04-04', 'Energia limpa para organizações sociais');

INSERT INTO contrib_co2 VALUES
    (198, '2025-05-01', 5500),
    (198, '2025-04-13', 6900),
    (198, '2025-05-24', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (199, '79.821.563', '0001-43', '74.029.536/0001-76', '2020-06-26', 'Cadeia sustentável de reciclagem');

INSERT INTO contrib_co2 VALUES
    (199, '2020-06-26', 9900);

INSERT INTO vinc_contrib_co2 VALUES
    (200, '75.893.062', '0001-33', '20.594.183/0001-28', '2022-03-18', 'Rede de energia solar comunitária');

INSERT INTO contrib_co2 VALUES
    (200, '2022-04-30', 6200),
    (200, '2022-06-03', 10000),
    (200, '2022-04-28', 5900);

INSERT INTO vinc_contrib_co2 VALUES
    (201, '18.024.935', '0001-76', '52.061.387/0001-90', '2024-08-26', 'Implantação de painéis solares em estabelecimentos públicos');

INSERT INTO contrib_co2 VALUES
    (201, '2024-11-14', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (202, '33.738.001', '0001-77', '37.186.429/0001-25', '2021-03-21', 'Programa de neutralização de carbono logístico');

INSERT INTO contrib_co2 VALUES
    (202, '2021-04-04', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (203, '75.893.062', '0001-33', '63.754.089/0001-00', '2023-12-04', 'Reciclagem solidária com compensação ambiental');

INSERT INTO contrib_co2 VALUES
    (203, '2023-12-12', 5200),
    (203, '2024-01-01', 3500),
    (203, '2024-02-03', 10500),
    (203, '2023-12-17', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (204, '75.893.062', '0001-33', '52.061.387/0001-90', '2023-11-04', 'Redução de carbono no deslocamento diário');

INSERT INTO contrib_co2 VALUES
    (204, '2023-11-20', 8200);

INSERT INTO vinc_contrib_co2 VALUES
    (205, '65.172.380', '0001-53', '52.061.387/0001-90', '2023-11-04', 'Redução de carbono no deslocamento diário');

INSERT INTO contrib_co2 VALUES
    (205, '2023-12-14', 4600),
    (205, '2023-12-23', 3500),
    (205, '2023-12-06', 11100),
    (205, '2024-01-20', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (206, '75.893.062', '0001-31', '14.679.502/0001-03', '2023-09-21', 'Ação climática para organizações sociais');

INSERT INTO contrib_co2 VALUES
    (206, '2023-10-22', 3500),
    (206, '2023-10-29', 3500),
    (206, '2023-11-28', 8200);

INSERT INTO vinc_contrib_co2 VALUES
    (207, '53.921.807', '0001-18', '20.594.183/0001-28', '2025-01-07', 'Neutralização de emissões de entregas');

INSERT INTO contrib_co2 VALUES
    (207, '2025-01-30', 3500),
    (207, '2025-02-13', 7300);

INSERT INTO vinc_contrib_co2 VALUES
    (208, '28.659.130', '0001-07', '52.061.387/0001-90', '2024-08-26', 'Implantação de painéis solares em estabelecimentos públicos');

INSERT INTO contrib_co2 VALUES
    (208, '2024-10-21', 3500),
    (208, '2024-11-02', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (209, '28.659.130', '0001-07', '35.179.804/0001-84', '2023-07-28', 'Compensação de emissões por energia renovável');

INSERT INTO contrib_co2 VALUES
    (209, '2023-10-12', 8800);

INSERT INTO vinc_contrib_co2 VALUES
    (210, '75.893.062', '0001-31', '74.029.536/0001-76', '2026-02-25', 'Incentivos de transporte sustentável');

INSERT INTO contrib_co2 VALUES
    (210, '2026-04-02', 6300);

INSERT INTO vinc_contrib_co2 VALUES
    (211, '01.274.895', '0001-40', '74.029.536/0001-76', '2023-10-17', 'Florestas comunitárias para o clima');

INSERT INTO contrib_co2 VALUES
    (211, '2023-10-23', 3500),
    (211, '2023-12-05', 5900);

INSERT INTO vinc_contrib_co2 VALUES
    (212, '65.172.380', '0001-61', '74.029.536/0001-76', '2020-06-24', 'Substituição de fontes fósseis por renováveis');

INSERT INTO contrib_co2 VALUES
    (212, '2020-09-09', 5200),
    (212, '2020-07-28', 16000),
    (212, '2020-06-28', 3500),
    (212, '2020-09-15', 3500),
    (212, '2020-07-09', 11200);

INSERT INTO vinc_contrib_co2 VALUES
    (213, '45.690.123', '0001-36', '64.253.970/0001-81', '2025-04-10', 'Campanha de reflorestamento no Amazonas');

INSERT INTO contrib_co2 VALUES
    (213, '2025-07-07', 3500),
    (213, '2025-06-29', 12400),
    (213, '2025-06-20', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (214, '01.274.895', '0001-23', '63.754.089/0001-00', '2022-04-13', 'Corredores ecológicos para captura de carbono');

INSERT INTO contrib_co2 VALUES
    (214, '2022-04-27', 3500),
    (214, '2022-07-04', 3500),
    (214, '2022-06-24', 5200),
    (214, '2022-05-17', 6400);

INSERT INTO vinc_contrib_co2 VALUES
    (215, '64.087.915', '0001-27', '52.061.387/0001-90', '2024-08-26', 'Implantação de painéis solares em estabelecimentos públicos');

INSERT INTO contrib_co2 VALUES
    (215, '2024-10-08', 3500),
    (215, '2024-09-20', 8800),
    (215, '2024-10-17', 3500),
    (215, '2024-09-11', 7500),
    (215, '2024-09-29', 9400);

INSERT INTO vinc_contrib_co2 VALUES
    (216, '75.893.062', '0001-31', '63.754.089/0001-00', '2025-09-22', 'Programa integrado de mitigação climática');

INSERT INTO contrib_co2 VALUES
    (216, '2025-10-19', 5700);

INSERT INTO vinc_contrib_co2 VALUES
    (217, '45.690.123', '0001-36', '52.061.387/0001-90', '2021-06-23', 'Restauração de nascentes e sequestro de carbono');

INSERT INTO contrib_co2 VALUES
    (217, '2021-06-26', 8900),
    (217, '2021-09-19', 10000),
    (217, '2021-07-21', 3500),
    (217, '2021-08-03', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (218, '09.723.145', '0001-93', '63.754.089/0001-00', '2022-04-13', 'Corredores ecológicos para captura de carbono');

INSERT INTO contrib_co2 VALUES
    (218, '2022-05-20', 11000),
    (218, '2022-05-01', 4800),
    (218, '2022-05-11', 3500),
    (218, '2022-07-07', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (219, '09.723.145', '0001-93', '68.532.497/0001-22', '2021-04-25', 'Plantio de árvores para compensação ambiental');

INSERT INTO contrib_co2 VALUES
    (219, '2021-06-01', 3500),
    (219, '2021-06-15', 3500),
    (219, '2021-05-10', 3500),
    (219, '2021-07-02', 8900),
    (219, '2021-07-03', 10300);

INSERT INTO vinc_contrib_co2 VALUES
    (220, '79.821.563', '0001-00', '07.219.354/0001-70', '2024-04-07', 'Gestão sustentável da pegada de carbono');

INSERT INTO contrib_co2 VALUES
    (220, '2024-06-20', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (221, '27.401.593', '0001-66', '35.179.804/0001-84', '2023-07-28', 'Compensação de emissões por energia renovável');

INSERT INTO contrib_co2 VALUES
    (221, '2023-09-23', 6400),
    (221, '2023-09-12', 8600),
    (221, '2023-08-23', 8400),
    (221, '2023-10-01', 4400);

INSERT INTO vinc_contrib_co2 VALUES
    (222, '65.172.380', '0001-53', '64.253.970/0001-81', '2025-12-20', 'Reflorestamento para neutralização de carbono');

INSERT INTO contrib_co2 VALUES
    (222, '2025-12-21', 7900),
    (222, '2026-02-24', 11700);

INSERT INTO vinc_contrib_co2 VALUES
    (223, '33.738.001', '0001-77', '74.029.536/0001-76', '2025-11-17', 'Reaproveitamento de materiais pós-consumo');

INSERT INTO contrib_co2 VALUES
    (223, '2025-12-18', 7900);

INSERT INTO vinc_contrib_co2 VALUES
    (224, '20.978.635', '0001-10', '63.754.089/0001-00', '2023-12-04', 'Reciclagem solidária com compensação ambiental');

INSERT INTO contrib_co2 VALUES
    (224, '2024-02-18', 4400);

INSERT INTO vinc_contrib_co2 VALUES
    (225, '53.921.807', '0001-18', '52.061.387/0001-90', '2021-12-16', 'Transporte limpo para comunidades');

INSERT INTO contrib_co2 VALUES
    (225, '2021-12-24', 11800);

INSERT INTO vinc_contrib_co2 VALUES
    (226, '71.498.635', '0001-06', '63.754.089/0001-00', '2025-09-22', 'Programa integrado de mitigação climática');

INSERT INTO contrib_co2 VALUES
    (226, '2025-10-12', 4500);

INSERT INTO vinc_contrib_co2 VALUES
    (227, '75.893.062', '0001-31', '74.029.536/0001-76', '2025-11-17', 'Reaproveitamento de materiais pós-consumo');

INSERT INTO contrib_co2 VALUES
    (227, '2025-11-18', 4500),
    (227, '2026-01-22', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (228, '65.172.380', '0001-61', '74.029.536/0001-76', '2026-02-25', 'Incentivos de transporte sustentável');

INSERT INTO contrib_co2 VALUES
    (228, '2026-03-10', 3500),
    (228, '2026-03-06', 3500),
    (228, '2026-02-26', 3500),
    (228, '2026-04-20', 5700);

INSERT INTO vinc_contrib_co2 VALUES
    (229, '09.723.145', '0001-93', '63.754.089/0001-00', '2025-09-22', 'Programa integrado de mitigação climática');

INSERT INTO contrib_co2 VALUES
    (229, '2025-10-29', 5500),
    (229, '2025-11-12', 9600);

INSERT INTO vinc_contrib_co2 VALUES
    (230, '09.723.145', '0001-93', '68.532.497/0001-22', '2023-01-16', 'Corredores verdes de mobilidade');

INSERT INTO contrib_co2 VALUES
    (230, '2023-04-03', 10200),
    (230, '2023-03-02', 13000);

INSERT INTO vinc_contrib_co2 VALUES
    (231, '79.821.563', '0001-65', '68.532.497/0001-22', '2023-01-16', 'Corredores verdes de mobilidade');

INSERT INTO contrib_co2 VALUES
    (231, '2023-02-27', 3500),
    (231, '2023-03-19', 3500),
    (231, '2023-04-03', 3800);

INSERT INTO vinc_contrib_co2 VALUES
    (232, '33.738.001', '0001-77', '74.029.536/0001-76', '2024-01-23', 'Economia circular em comunidades locais');

INSERT INTO contrib_co2 VALUES
    (232, '2024-02-21', 3500),
    (232, '2024-02-05', 12800),
    (232, '2024-02-08', 6100),
    (232, '2024-03-12', 3500),
    (232, '2024-03-22', 13900);

INSERT INTO vinc_contrib_co2 VALUES
    (233, '48.603.715', '0001-45', '14.679.502/0001-03', '2022-11-12', 'Transporte coletivo carbono neutro');

INSERT INTO contrib_co2 VALUES
    (233, '2022-11-14', 3800),
    (233, '2022-12-28', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (234, '65.172.380', '0001-53', '37.186.429/0001-25', '2026-03-25', 'Programa de resíduos com baixa emissão');

INSERT INTO contrib_co2 VALUES
    (234, '2026-04-30', 7200);

INSERT INTO vinc_contrib_co2 VALUES
    (235, '64.087.915', '0001-27', '63.754.089/0001-00', '2023-12-04', 'Reciclagem solidária com compensação ambiental');

INSERT INTO contrib_co2 VALUES
    (235, '2024-01-13', 9200),
    (235, '2023-12-21', 3500),
    (235, '2024-01-11', 7600),
    (235, '2023-12-12', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (236, '28.659.130', '0001-07', '52.061.387/0001-90', '2021-06-26', 'Coleta seletiva para redução de carbono');

INSERT INTO contrib_co2 VALUES
    (236, '2021-08-15', 3500),
    (236, '2021-08-12', 3700);

INSERT INTO vinc_contrib_co2 VALUES
    (237, '09.723.145', '0001-93', '63.754.089/0001-00', '2023-12-04', 'Reciclagem solidária com compensação ambiental');

INSERT INTO contrib_co2 VALUES
    (237, '2024-01-31', 14600),
    (237, '2024-01-01', 3500),
    (237, '2023-12-11', 11800),
    (237, '2024-01-19', 5700);

INSERT INTO vinc_contrib_co2 VALUES
    (238, '18.024.935', '0001-76', '63.754.089/0001-00', '2021-11-01', 'Mobilidade sustentável com baixa emissão');

INSERT INTO contrib_co2 VALUES
    (238, '2021-12-12', 6300);

INSERT INTO vinc_contrib_co2 VALUES
    (239, '01.274.895', '0001-23', '52.061.387/0001-90', '2021-12-16', 'Transporte limpo para comunidades');

INSERT INTO contrib_co2 VALUES
    (239, '2021-12-17', 3500),
    (239, '2022-01-23', 9600),
    (239, '2022-02-11', 7300),
    (239, '2022-02-26', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (240, '09.723.145', '0001-93', '20.594.183/0001-28', '2022-03-18', 'Rede de energia solar comunitária');

INSERT INTO contrib_co2 VALUES
    (240, '2022-06-04', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (241, '09.723.145', '0001-93', '63.754.089/0001-00', '2021-11-01', 'Mobilidade sustentável com baixa emissão');

INSERT INTO contrib_co2 VALUES
    (241, '2021-11-26', 11900),
    (241, '2021-12-23', 3500),
    (241, '2021-11-15', 3500),
    (241, '2021-12-25', 3700);

INSERT INTO vinc_contrib_co2 VALUES
    (242, '01.274.895', '0001-23', '74.029.536/0001-76', '2020-06-21', 'Campanha de reflorestamento local');

INSERT INTO contrib_co2 VALUES
    (242, '2020-07-26', 4500);

INSERT INTO vinc_contrib_co2 VALUES
    (243, '65.172.380', '0001-61', '74.029.536/0001-76', '2024-01-23', 'Economia circular em comunidades locais');

INSERT INTO contrib_co2 VALUES
    (243, '2024-02-11', 7700);

INSERT INTO vinc_contrib_co2 VALUES
    (244, '79.821.563', '0001-65', '52.061.387/0001-90', '2021-12-16', 'Transporte limpo para comunidades');

INSERT INTO contrib_co2 VALUES
    (244, '2022-03-12', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (245, '27.401.593', '0001-66', '52.061.387/0001-90', '2023-11-20', 'Neutralização de emissões de eventos');

INSERT INTO contrib_co2 VALUES
    (245, '2024-02-16', 3500),
    (245, '2024-01-04', 3500);

INSERT INTO vinc_contrib_co2 VALUES
    (246, '65.172.380', '0001-53', '52.061.387/0001-90', '2021-10-30', 'Valorização de resíduos para mitigação climática');

INSERT INTO contrib_co2 VALUES
    (246, '2021-12-20', 3500),
    (246, '2022-01-14', 4100),
    (246, '2021-12-31', 5300),
    (246, '2022-01-16', 8200),
    (246, '2022-01-06', 3800),
    (246, '2022-01-24', 12800);

INSERT INTO vinc_contrib_co2 VALUES
    (247, '75.893.062', '0001-33', '63.754.089/0001-00', '2025-04-04', 'Energia limpa para organizações sociais');

INSERT INTO contrib_co2 VALUES
    (247, '2025-06-16', 3500),
    (247, '2025-04-24', 8200),
    (247, '2025-05-06', 9400),
    (247, '2025-06-28', 3500),
    (247, '2025-04-04', 4100);

INSERT INTO vinc_contrib_co2 VALUES
    (248, '01.274.895', '0001-40', '68.532.497/0001-22', '2021-04-25', 'Plantio de árvores para compensação ambiental');

INSERT INTO contrib_co2 VALUES
    (248, '2021-04-29', 10500);

INSERT INTO vinc_contrib_co2 VALUES
    (249, '51.360.297', '0001-43', '37.186.429/0001-25', '2023-12-02', 'Transformação de resíduos em impacto positivo');

INSERT INTO contrib_co2 VALUES
    (249, '2024-02-01', 9400);

INSERT INTO vinc_contrib_co2 VALUES
    (250, '64.087.915', '0001-27', '52.061.387/0001-90', '2021-06-23', 'Restauração de nascentes e sequestro de carbono');

INSERT INTO contrib_co2 VALUES
    (250, '2021-07-24', 3500),
    (250, '2021-07-07', 4100),
    (250, '2021-09-06', 5500);

-- Obs. usamos o comando \copy do `psql` (roda no cliente) em vez do
-- comando `COPY` (que roda no servidor), pois este requer privilégios
-- de administrador e não permite caminhos relativos.
--
-- Obs. rode esse script de inserção na raiz do repositório, usando o `psql`.
--
-- Obs. DELETE está sendo usado para garantir idempotência do comando \copy.
DELETE FROM serv_nbs;
DELETE FROM prod_ncm;

\copy serv_nbs FROM 'db/nbs.csv' WITH DELIMITER AS ';' CSV HEADER;
\copy prod_ncm FROM 'db/ncm.csv' WITH DELIMITER AS ';' CSV HEADER;

INSERT INTO reg_leg VALUES
    ('3146206', 'if', 4079, 2015, '2026-12-22', NULL, '1.0901.51.24', NULL, NULL, NULL, 1.9794, 0.0067),
    ('43', 'if', 1553, 2016, '2017-05-04', NULL, NULL, '2921.19.12', NULL, NULL, 1.3134, 0.0105),
    ('4205407', 'if', 1880, 2022, '2020-10-17', NULL, NULL, '8528.49.90', NULL, NULL, 13.7124, 0.0198),
    ('4314902', 'multa', 2721, 2021, '2025-05-10', NULL, '1.0904.36.00', '0602.90.82', 103.82, 0.181, NULL, NULL),
    ('41', 'if', 79, 2015, '2025-02-03', '2029-06-15', NULL, NULL, NULL, NULL, 74.8158, 0.0444),
    ('43', 'if', 833, 2021, '2020-10-12', '2022-02-02', NULL, '4410.11.21', NULL, NULL, 2.7897, 0.0613),
    ('32', 'multa', 3680, 2018, '2019-03-21', NULL, NULL, '2836.20.10', 218.52, 0.1185, NULL, NULL),
    ('41', 'multa', 2540, 2022, '2026-06-18', NULL, NULL, NULL, 178.65, 0.2177, NULL, NULL),
    ('5300108', 'if', 2567, 2026, '2022-10-18', NULL, '1.0402.3', NULL, NULL, NULL, 1.0759, 0.0686),
    ('29', 'if', 1392, 2019, '2019-06-10', NULL, NULL, '1201.10.00', NULL, NULL, 2.5528, 0.0106),
    ('21', 'if', 2782, 2015, '2015-10-16', NULL, '1.0902.90.00', NULL, NULL, NULL, 2.3899, 0.0616),
    ('42', 'if', 477, 2016, '2016-09-01', NULL, '1.1106', '8439.10.30', NULL, NULL, 1.9072, 0.0197),
    ('3304557', 'if', 4982, 2024, '2016-01-21', NULL, NULL, NULL, NULL, NULL, 5.2632, 0.0305),
    ('3306305', 'multa', 4709, 2026, '2017-07-10', NULL, NULL, '0303.99.20', 8465.04, 0.1132, NULL, NULL),
    ('24', 'multa', 58, 2026, '2024-01-20', NULL, '1.2404.3', '5510.90.13', 171.73, 0.2315, NULL, NULL),
    ('3505906', 'if', 4355, 2019, '2020-12-17', NULL, '1.0105.60.00', '4411.12.90', NULL, NULL, 2.1594, 0.0307),
    ('13', 'if', 1743, 2020, '2016-05-28', NULL, '1.0401.49.00', '2841.90.19', NULL, NULL, 4.8178, 0.0101),
    ('4106902', 'multa', 3347, 2026, '2020-03-09', NULL, NULL, '2306.30.90', 147.88, 0.0266, NULL, NULL),
    ('26', 'if', 2922, 2026, '2015-11-15', NULL, NULL, NULL, NULL, NULL, 1.8352, 0.0433),
    ('5300108', 'if', 740, 2026, '2016-10-15', NULL, '1.1501.20.00', NULL, NULL, NULL, 2.8994, 0.0632),
    ('13', 'if', 3858, 2023, '2023-07-15', NULL, '1.0909', '3208.90.29', NULL, NULL, 2.5108, 0.017),
    ('3550308', 'if', 3527, 2021, '2021-09-18', NULL, '1.0102.53', NULL, NULL, NULL, 25.4094, 0.0065),
    ('32', 'multa', 4646, 2022, '2016-11-02', NULL, NULL, NULL, 157.75, 0.1506, NULL, NULL),
    ('32', 'if', 47, 2020, '2016-10-20', NULL, '1.1701.1', NULL, NULL, NULL, 1.0511, 0.0171),
    ('24', 'if', 3955, 2025, '2018-02-25', NULL, NULL, '9022.19.10', NULL, NULL, 3.034, 0.0448),
    ('31', 'multa', 3625, 2017, '2024-10-13', NULL, '1.0604.40.00', '2939.11.82', 11660.52, 0.1394, NULL, NULL),
    ('42', 'multa', 1478, 2021, '2026-11-16', NULL, NULL, NULL, 99.28, 0.0391, NULL, NULL),
    ('29', 'multa', 4744, 2017, '2023-06-12', NULL, NULL, '4907.00.90', 193.7, 0.23, NULL, NULL),
    ('33', 'multa', 4424, 2026, '2017-09-05', NULL, '1.0501.39.00', '1201.10.00', 161.18, 0.2278, NULL, NULL),
    ('3306305', 'if', 2424, 2020, '2026-02-01', NULL, '1.2403.2', '2914.71.00', NULL, NULL, 3.2313, 0.0768),
    ('31', 'if', 7, 2019, '2021-07-11', NULL, NULL, '8704.31.90', NULL, NULL, 4.3783, 0.0418),
    ('4208302', 'multa', 3992, 2017, '2025-10-17', '2026-01-22', '1.1405.50.00', NULL, 4917.53, 0.2452, NULL, NULL),
    ('3306305', 'if', 3032, 2024, '2016-07-21', NULL, '1.2001.40.00', NULL, NULL, NULL, 1.4436, 0.055),
    ('28', 'if', 2003, 2020, '2018-08-31', NULL, '1.0501.13.20', NULL, NULL, NULL, 5.5346, 0.0514),
    ('32', 'if', 2567, 2017, '2015-04-12', NULL, '1.1403.22', '5201.00.90', NULL, NULL, 15.6168, 0.0623),
    ('3106200', 'if', 3900, 2026, '2021-11-28', NULL, NULL, '2933.33.32', NULL, NULL, 2.2481, 0.0622),
    ('4205407', 'multa', 2946, 2016, '2019-03-04', NULL, '1.1509.00.00', '4007.00.1', 107.44, 0.2243, NULL, NULL),
    ('4205407', 'if', 1174, 2016, '2015-01-05', NULL, '1.0501.23', '8547.20.90', NULL, NULL, 2.9766, 0.0637),
    ('4208302', 'multa', 894, 2026, '2020-01-30', NULL, '1.1701.1', '0305.53.10', 165.73, 0.0432, NULL, NULL),
    ('26', 'multa', 3506, 2026, '2026-08-19', NULL, '1.0604.30.00', NULL, 248.12, 0.0827, NULL, NULL),
    ('41', 'multa', 3820, 2023, '2020-02-13', NULL, '1.1201.31.00', '8460.24.00', 44.91, 0.0457, NULL, NULL),
    ('41', 'if', 4506, 2019, '2023-11-04', NULL, NULL, NULL, NULL, NULL, 12.2463, 0.0513),
    ('3106200', 'multa', 1432, 2024, '2025-01-13', NULL, '1.1108.90.00', '8207.70.20', 179.75, 0.1431, NULL, NULL),
    ('3205309', 'multa', 2850, 2025, '2023-09-13', NULL, '1.1101.14.00', NULL, 100.68, 0.1998, NULL, NULL),
    ('3106200', 'multa', 4985, 2015, '2024-09-03', NULL, '1.0103', '8482.91.30', 102.11, 0.1689, NULL, NULL),
    ('3306305', 'if', 1877, 2026, '2016-05-02', NULL, '1.1803', NULL, NULL, NULL, 2.5444, 0.0196),
    ('26', 'if', 2460, 2022, '2016-12-19', '2017-07-12', NULL, '5603.12.40', NULL, NULL, 14.8856, 0.0339),
    ('29', 'multa', 3605, 2022, '2023-03-06', NULL, '1.1401', '7616.91.00', 78.7, 0.2173, NULL, NULL),
    ('29', 'if', 3396, 2022, '2019-01-27', NULL, NULL, NULL, NULL, NULL, 7.3352, 0.0474),
    ('3550308', 'if', 3010, 2022, '2024-12-16', '2030-10-07', NULL, NULL, NULL, NULL, 37.705, 0.0715),
    ('26', 'if', 1997, 2018, '2023-09-28', NULL, NULL, NULL, NULL, NULL, 161.5134, 0.007),
    ('3548906', 'multa', 2687, 2022, '2021-06-30', NULL, NULL, '0303.83.1', 1049.23, 0.1745, NULL, NULL),
    ('3146107', 'if', 564, 2019, '2018-02-14', NULL, NULL, NULL, NULL, NULL, 2.9293, 0.0524),
    ('42', 'if', 1635, 2017, '2016-12-08', NULL, NULL, '5211.32.00', NULL, NULL, 10.32, 0.0625),
    ('3106200', 'if', 2696, 2015, '2017-05-22', NULL, NULL, NULL, NULL, NULL, 2.263, 0.0211),
    ('5300108', 'multa', 4556, 2020, '2026-05-03', '2032-10-24', NULL, '3815.90.9', 88.55, 0.1554, NULL, NULL),
    ('3501905', 'if', 2243, 2016, '2022-10-07', NULL, NULL, NULL, NULL, NULL, 15.746, 0.0055),
    ('53', 'multa', 4803, 2022, '2025-08-25', NULL, '1.1409.2', '0303.39.00', 447.84, 0.1119, NULL, NULL),
    ('3106200', 'if', 3012, 2020, '2023-07-21', '2025-12-28', NULL, '2916.20.12', NULL, NULL, 3.9204, 0.0753),
    ('3501905', 'if', 1153, 2026, '2022-04-01', NULL, '1.1702.2', '3701.99.00', NULL, NULL, 5.4204, 0.0568),
    ('3106200', 'multa', 4005, 2019, '2017-03-18', NULL, NULL, '4005.10.10', 146.62, 0.2467, NULL, NULL),
    ('53', 'if', 4364, 2024, '2019-02-18', NULL, NULL, NULL, NULL, NULL, 0.6477, 0.05),
    ('4308250', 'if', 4799, 2022, '2017-09-26', NULL, '1.0106.32.00', NULL, NULL, NULL, 0.859, 0.0714),
    ('29', 'if', 1247, 2026, '2017-02-24', NULL, '1.0401.30.00', '8501.61.00', NULL, NULL, 1.258, 0.0306),
    ('4308250', 'if', 4067, 2016, '2020-04-23', NULL, NULL, '3003.10.13', NULL, NULL, 8.7169, 0.0098),
    ('4205407', 'if', 4168, 2015, '2020-03-19', '2025-01-30', NULL, NULL, NULL, NULL, 1.8309, 0.0461),
    ('41', 'if', 1829, 2026, '2022-09-05', '2024-01-22', '1.0403.33.00', NULL, NULL, NULL, 13.9905, 0.0504),
    ('24', 'if', 4350, 2021, '2023-05-06', '2023-08-28', NULL, NULL, NULL, NULL, 647.3389, 0.0428),
    ('3550308', 'multa', 741, 2025, '2020-01-26', '2024-08-30', '1.0504.31.00', NULL, 211.56, 0.0735, NULL, NULL),
    ('3548906', 'multa', 3977, 2017, '2021-09-22', NULL, NULL, '0804.20.20', 130.85, 0.2326, NULL, NULL),
    ('26', 'if', 2046, 2018, '2019-10-28', NULL, '1.1506.29.00', '8541.30.21', NULL, NULL, 3.4433, 0.0551),
    ('3501905', 'multa', 1610, 2017, '2016-12-30', NULL, NULL, NULL, 307.5, 0.1233, NULL, NULL),
    ('4308250', 'if', 1999, 2021, '2026-04-02', NULL, '1.1507.20.00', '2933.31.10', NULL, NULL, 4.1178, 0.0065),
    ('21', 'multa', 2785, 2016, '2020-09-29', NULL, NULL, NULL, 73.96, 0.0975, NULL, NULL),
    ('4208302', 'multa', 3885, 2018, '2025-07-01', NULL, NULL, '5306.20.00', 227.0, 0.1875, NULL, NULL),
    ('4314902', 'multa', 574, 2015, '2017-11-07', NULL, '1.1903', NULL, 130.06, 0.1164, NULL, NULL),
    ('43', 'multa', 190, 2017, '2023-04-12', NULL, '1.1403.22.12', '8433.30.00', 165.8, 0.2399, NULL, NULL),
    ('42', 'if', 878, 2018, '2019-06-16', NULL, '1.1106.33.00', NULL, NULL, NULL, 4.7879, 0.0215),
    ('3501905', 'multa', 4541, 2016, '2015-01-15', NULL, NULL, NULL, 187.75, 0.2232, NULL, NULL),
    ('3550308', 'if', 991, 2021, '2025-01-20', NULL, NULL, NULL, NULL, NULL, 3.3294, 0.0601),
    ('3550308', 'if', 3130, 2025, '2022-06-04', NULL, NULL, NULL, NULL, NULL, 1.8525, 0.0087),
    ('35', 'if', 4453, 2020, '2024-07-09', '2026-02-28', NULL, NULL, NULL, NULL, 4.499, 0.0658),
    ('13', 'multa', 600, 2021, '2017-02-23', NULL, '1.2001.50.00', '7806.00.10', 269.61, 0.0638, NULL, NULL),
    ('41', 'multa', 4054, 2016, '2016-07-10', NULL, '1.0102.69.00', '8708.10.00', 262.14, 0.0598, NULL, NULL),
    ('13', 'multa', 4751, 2016, '2021-03-21', NULL, NULL, '6104.52.00', 363.39, 0.1005, NULL, NULL),
    ('4205407', 'multa', 1804, 2023, '2015-12-02', NULL, NULL, '2937.90.40', 205.69, 0.1805, NULL, NULL),
    ('3505906', 'if', 2560, 2015, '2015-03-20', '2021-02-01', NULL, '3003.20.21', NULL, NULL, 3.6828, 0.002),
    ('42', 'if', 21, 2017, '2021-09-10', '2028-04-06', NULL, NULL, NULL, NULL, 3.6605, 0.0147),
    ('42', 'multa', 160, 2022, '2023-08-10', NULL, NULL, NULL, 163.15, 0.0611, NULL, NULL),
    ('3146206', 'multa', 4105, 2026, '2016-06-30', NULL, '1.0404.20.00', NULL, 143.24, 0.0918, NULL, NULL),
    ('33', 'if', 2301, 2024, '2018-11-15', NULL, '1.1402.2', NULL, NULL, NULL, 8.7468, 0.0775),
    ('41', 'if', 661, 2021, '2022-03-29', NULL, NULL, '3003.20.41', NULL, NULL, 1.2507, 0.05),
    ('3146206', 'multa', 1099, 2023, '2021-09-16', NULL, NULL, '2524.90.00', 118.31, 0.0231, NULL, NULL),
    ('33', 'multa', 3137, 2022, '2025-10-10', NULL, '1.2002.40.00', NULL, 987.51, 0.2151, NULL, NULL),
    ('3501905', 'multa', 748, 2016, '2020-05-03', '2026-08-06', NULL, NULL, 205.37, 0.236, NULL, NULL),
    ('4308250', 'if', 1887, 2024, '2015-07-20', NULL, NULL, NULL, NULL, NULL, 1.8172, 0.0365),
    ('3505906', 'multa', 4763, 2026, '2026-11-23', NULL, '1.1201.3', '8207.90.00', 126.77, 0.1993, NULL, NULL),
    ('1302603', 'if', 2791, 2021, '2019-08-27', NULL, '1.0401.17', NULL, NULL, NULL, 3.4403, 0.0572),
    ('4208302', 'if', 2831, 2019, '2017-10-16', NULL, '1.2301.94.00', '8471.60.6', NULL, NULL, 10.6064, 0.0266),
    ('5300108', 'if', 1535, 2018, '2026-03-10', NULL, '1.2502.10.00', NULL, NULL, NULL, 3.9917, 0.0642),
    ('31', 'multa', 4281, 2015, '2015-03-06', NULL, NULL, '2933.91.1', 118.87, 0.1309, NULL, NULL),
    ('24', 'multa', 4818, 2021, '2025-11-26', NULL, NULL, '2930.90.8', 348.19, 0.0849, NULL, NULL),
    ('3550308', 'multa', 2985, 2021, '2015-03-13', NULL, NULL, NULL, 417.96, 0.1347, NULL, NULL),
    ('3501905', 'if', 3990, 2026, '2024-10-23', NULL, NULL, NULL, NULL, NULL, 2.1327, 0.0688),
    ('3548906', 'multa', 4883, 2022, '2017-04-02', NULL, '1.0904.36.00', '7107.00.00', 200.81, 0.0279, NULL, NULL),
    ('3106200', 'if', 3149, 2022, '2026-01-31', '2031-05-03', NULL, NULL, NULL, NULL, 6.9817, 0.0155),
    ('3205309', 'multa', 995, 2023, '2017-07-04', NULL, '1.2601.90.00', '5603.14.40', 146.07, 0.1847, NULL, NULL),
    ('4205407', 'if', 3598, 2026, '2018-02-09', NULL, '1.1404.49.00', '2922.50.3', NULL, NULL, 326.3382, 0.0117),
    ('33', 'multa', 2000, 2015, '2024-04-25', '2028-07-03', NULL, NULL, 425.38, 0.1122, NULL, NULL),
    ('4314902', 'multa', 2080, 2018, '2022-10-16', NULL, NULL, '9007.10.00', 32.43, 0.0592, NULL, NULL),
    ('43', 'multa', 2040, 2021, '2023-01-23', NULL, NULL, '2306.90.10', 118.0, 0.159, NULL, NULL),
    ('3550308', 'if', 502, 2024, '2021-06-19', '2023-07-05', '1.0301.31.00', '2933.33.3', NULL, NULL, 7.0483, 0.0443),
    ('1302603', 'if', 1499, 2017, '2015-05-28', NULL, '1.1403.27.00', NULL, NULL, NULL, 6.4479, 0.0579),
    ('5300108', 'if', 2147, 2020, '2024-06-28', '2030-08-10', NULL, '2922.31.20', NULL, NULL, 0.8871, 0.0061),
    ('4205407', 'multa', 1709, 2026, '2026-07-05', NULL, NULL, NULL, 141.97, 0.1635, NULL, NULL),
    ('33', 'if', 590, 2019, '2015-07-18', NULL, NULL, '9403.50.00', NULL, NULL, 3.9594, 0.0365),
    ('32', 'multa', 713, 2017, '2025-03-22', NULL, NULL, NULL, 1854.61, 0.1352, NULL, NULL),
    ('3205309', 'multa', 1926, 2023, '2016-11-09', NULL, NULL, '2101.20.20', 98.46, 0.2462, NULL, NULL),
    ('51', 'if', 2872, 2023, '2015-12-18', NULL, '1.0301.21.00', '2921.51.90', NULL, NULL, 3.0301, 0.0548),
    ('35', 'multa', 3949, 2024, '2016-08-13', '2023-02-02', NULL, '8467.11.90', 193.03, 0.2115, NULL, NULL),
    ('3548906', 'if', 1458, 2022, '2026-10-11', NULL, NULL, NULL, NULL, NULL, 1.314, 0.0378),
    ('21', 'if', 1058, 2019, '2020-11-22', NULL, '1.1302.21.00', NULL, NULL, NULL, 2.3049, 0.0741),
    ('26', 'multa', 1067, 2018, '2023-08-01', NULL, NULL, '0410.90.00', 164.74, 0.1656, NULL, NULL),
    ('3501905', 'multa', 1736, 2022, '2016-02-11', NULL, '1.0401.17.20', NULL, 119.68, 0.0161, NULL, NULL),
    ('53', 'multa', 676, 2015, '2015-09-30', NULL, '1.0501.23.10', '7601.10.00', 134.69, 0.0595, NULL, NULL),
    ('2927408', 'if', 3628, 2017, '2018-04-07', NULL, '1.0502.11.30', '3003.20.49', NULL, NULL, 125.2315, 0.0711),
    ('3505906', 'if', 2867, 2025, '2017-03-12', '2022-09-22', '1.0401.17.20', '3004.90.74', NULL, NULL, 6.7514, 0.0343),
    ('2919306', 'multa', 1500, 2016, '2017-07-28', NULL, NULL, NULL, 470.71, 0.1851, NULL, NULL),
    ('24', 'if', 3953, 2022, '2015-04-27', NULL, NULL, NULL, NULL, NULL, 4.5326, 0.0632),
    ('29', 'multa', 4725, 2026, '2021-11-06', NULL, '1.1805.19.00', NULL, 102.71, 0.1316, NULL, NULL),
    ('3306305', 'if', 347, 2024, '2023-07-16', NULL, NULL, '3004.90.94', NULL, NULL, 4.6477, 0.0548),
    ('43', 'if', 4362, 2019, '2020-05-05', NULL, NULL, '5701.10.12', NULL, NULL, 68.6836, 0.076),
    ('28', 'if', 4446, 2020, '2015-07-16', NULL, NULL, NULL, NULL, NULL, 3.6024, 0.0193),
    ('4205407', 'multa', 2477, 2018, '2026-10-30', NULL, NULL, NULL, 95.39, 0.1375, NULL, NULL),
    ('53', 'if', 4010, 2025, '2025-10-21', NULL, NULL, NULL, NULL, NULL, 3.1883, 0.0309),
    ('3106200', 'if', 1317, 2022, '2016-11-17', NULL, '1.0502.32', '6003.40.00', NULL, NULL, 2.4619, 0.0677),
    ('31', 'multa', 3121, 2024, '2022-06-19', '2026-12-11', NULL, '2608.00.10', 548.03, 0.2388, NULL, NULL),
    ('28', 'if', 659, 2021, '2019-05-11', NULL, '1.1701.52.00', '2520.10.1', NULL, NULL, 6.2424, 0.0311),
    ('3146206', 'multa', 875, 2019, '2025-06-26', NULL, NULL, NULL, 149.81, 0.1017, NULL, NULL),
    ('51', 'if', 237, 2025, '2025-03-31', NULL, NULL, '3004.90.61', NULL, NULL, 3.932, 0.0014),
    ('3501905', 'if', 3775, 2019, '2025-03-04', NULL, NULL, '2933.49.20', NULL, NULL, 0.6162, 0.0783),
    ('4106902', 'if', 3058, 2023, '2022-01-26', NULL, '1.0905.2', '0504.00.1', NULL, NULL, 21.2721, 0.064),
    ('13', 'multa', 3233, 2016, '2025-02-27', NULL, '1.0103.30.00', NULL, 2612.75, 0.0405, NULL, NULL),
    ('41', 'if', 134, 2026, '2015-02-26', NULL, NULL, '0306.99.10', NULL, NULL, 1.2919, 0.0654),
    ('53', 'if', 2054, 2019, '2020-12-29', NULL, '1.2403', NULL, NULL, NULL, 2.4002, 0.0156),
    ('28', 'multa', 3157, 2016, '2017-04-01', NULL, NULL, NULL, 16993.12, 0.2076, NULL, NULL),
    ('26', 'multa', 1389, 2016, '2015-06-29', NULL, '1.1802.40.00', '8306.30.00', 177.79, 0.0468, NULL, NULL),
    ('31', 'multa', 3184, 2021, '2026-07-08', NULL, NULL, '9506.31.00', 94.07, 0.1698, NULL, NULL),
    ('29', 'if', 817, 2018, '2026-08-17', '2028-04-11', '1.2003.24.00', '2922.41.10', NULL, NULL, 5.9105, 0.0632),
    ('21', 'multa', 1076, 2026, '2017-07-23', NULL, '1.0107.50.00', NULL, 241.08, 0.1512, NULL, NULL),
    ('3146107', 'multa', 1509, 2017, '2016-03-24', NULL, NULL, '2919.10.00', 181.69, 0.0499, NULL, NULL),
    ('2919306', 'if', 2527, 2017, '2026-04-16', NULL, '1.0102.13.00', '8540.81.00', NULL, NULL, 5.156, 0.0123),
    ('3548906', 'multa', 3332, 2021, '2016-05-04', NULL, NULL, '8105.90.10', 60.71, 0.1346, NULL, NULL),
    ('4205407', 'multa', 1094, 2023, '2018-08-27', NULL, '1.2002.90.00', NULL, 112.51, 0.1196, NULL, NULL),
    ('5300108', 'if', 3940, 2021, '2017-02-13', NULL, NULL, NULL, NULL, NULL, 24.773, 0.0123),
    ('3205309', 'if', 63, 2025, '2021-01-05', NULL, '1.0604.40.00', NULL, NULL, NULL, 2.5872, 0.0291),
    ('21', 'multa', 2608, 2016, '2021-11-19', '2023-09-14', NULL, '4106.31.10', 180.56, 0.0525, NULL, NULL),
    ('5300108', 'if', 2466, 2015, '2025-08-26', NULL, NULL, '4011.50.00', NULL, NULL, 0.9924, 0.0588),
    ('3106200', 'if', 72, 2015, '2022-12-20', NULL, NULL, '8467.11.10', NULL, NULL, 9.4703, 0.0042),
    ('28', 'if', 1956, 2022, '2015-06-21', '2021-11-27', NULL, '5704.20.00', NULL, NULL, 6.3024, 0.0125),
    ('3205309', 'multa', 800, 2025, '2015-08-31', NULL, NULL, NULL, 96.28, 0.105, NULL, NULL),
    ('3306305', 'if', 733, 2022, '2026-01-05', '2027-05-18', NULL, NULL, NULL, NULL, 21.065, 0.0289),
    ('3306305', 'if', 2173, 2019, '2016-07-02', NULL, '1.1301', '8418.69.91', NULL, NULL, 7.8561, 0.0506),
    ('1302603', 'if', 3047, 2024, '2025-12-29', NULL, NULL, NULL, NULL, NULL, 2.6512, 0.0064),
    ('3146107', 'if', 744, 2016, '2025-03-14', NULL, NULL, NULL, NULL, NULL, 45.7596, 0.0536),
    ('3106200', 'if', 4623, 2015, '2016-06-05', '2022-09-17', '1.0103.20.00', '2939.11.91', NULL, NULL, 2.1998, 0.0232),
    ('2919306', 'if', 1567, 2025, '2026-08-30', NULL, NULL, '0305.32.90', NULL, NULL, 1.2492, 0.0351),
    ('5300108', 'if', 2917, 2015, '2020-12-06', '2025-04-08', '1.1201.11.00', '8482.40.00', NULL, NULL, 5.4653, 0.0751),
    ('3106200', 'if', 781, 2023, '2020-02-10', NULL, NULL, '9030.39.10', NULL, NULL, 5.2216, 0.0202),
    ('29', 'multa', 577, 2021, '2022-02-16', NULL, '1.1403.27.00', '8464.90.90', 6430.25, 0.0248, NULL, NULL),
    ('21', 'multa', 674, 2017, '2023-03-25', NULL, NULL, NULL, 104.37, 0.0268, NULL, NULL),
    ('21', 'if', 969, 2022, '2022-10-02', NULL, NULL, NULL, NULL, NULL, 4.3278, 0.0512),
    ('32', 'if', 91, 2020, '2018-03-23', NULL, '1.1703.3', '6402.99.90', NULL, NULL, 92.2026, 0.0684),
    ('4208302', 'if', 3192, 2019, '2019-08-15', NULL, NULL, NULL, NULL, NULL, 0.7969, 0.0072),
    ('28', 'multa', 1544, 2021, '2021-04-23', NULL, '1.0403.22.00', NULL, 65.2, 0.1613, NULL, NULL),
    ('4205407', 'multa', 4434, 2024, '2024-12-26', NULL, '1.2301.95.00', '5204.11.3', 194.93, 0.1611, NULL, NULL),
    ('51', 'if', 4652, 2018, '2024-05-16', NULL, '1.0504.44.00', '3804.00.1', NULL, NULL, 66.9046, 0.0617),
    ('3306305', 'if', 4312, 2025, '2021-08-05', NULL, NULL, NULL, NULL, NULL, 10.8373, 0.0689),
    ('3106200', 'multa', 1485, 2019, '2018-06-18', NULL, NULL, NULL, 119.42, 0.1124, NULL, NULL),
    ('53', 'multa', 78, 2016, '2023-11-24', NULL, '1.0901.51.22', '3808.94.11', 387.98, 0.1478, NULL, NULL),
    ('3106200', 'if', 4852, 2020, '2021-11-21', NULL, '1.1104.90.00', NULL, NULL, NULL, 11.3435, 0.012),
    ('3146107', 'multa', 4922, 2024, '2025-04-03', NULL, '1.1806.53.00', NULL, 2327.37, 0.1073, NULL, NULL),
    ('26', 'multa', 2186, 2024, '2025-01-12', NULL, NULL, '2105.00.90', 237.58, 0.1803, NULL, NULL),
    ('3505906', 'multa', 422, 2015, '2026-03-06', NULL, '1.0902.40.00', '6005.42.00', 184.77, 0.0158, NULL, NULL),
    ('13', 'multa', 2375, 2026, '2022-11-14', NULL, '1.0503.25.00', '8414.59.90', 76.11, 0.0358, NULL, NULL),
    ('3501905', 'multa', 763, 2021, '2022-01-05', NULL, '1.16', NULL, 247.54, 0.1168, NULL, NULL),
    ('51', 'if', 2011, 2022, '2017-09-11', NULL, '1.0504.13.00', NULL, NULL, NULL, 6.9297, 0.0681),
    ('4205407', 'if', 538, 2016, '2018-02-01', '2019-03-13', NULL, NULL, NULL, NULL, 3.6512, 0.0347),
    ('3146107', 'multa', 4009, 2015, '2024-05-18', NULL, '1.1101.13.00', NULL, 151.48, 0.0501, NULL, NULL),
    ('51', 'if', 4361, 2025, '2021-12-08', NULL, NULL, '2912.19.23', NULL, NULL, 1.1063, 0.0693),
    ('13', 'multa', 386, 2025, '2026-03-02', NULL, NULL, '0303.57.00', 166.39, 0.1243, NULL, NULL),
    ('4314902', 'if', 710, 2020, '2026-06-24', NULL, NULL, NULL, NULL, NULL, 10.4561, 0.0176),
    ('33', 'if', 4740, 2020, '2022-06-09', NULL, NULL, NULL, NULL, NULL, 0.877, 0.0454),
    ('31', 'if', 2716, 2019, '2018-04-10', '2019-04-21', NULL, '8459.69.00', NULL, NULL, 2.1323, 0.0444),
    ('13', 'if', 47, 2016, '2019-07-17', NULL, NULL, NULL, NULL, NULL, 3.5864, 0.0788),
    ('3306305', 'multa', 1454, 2019, '2020-12-10', NULL, '1.1404.42.00', '3003.20.69', 72.63, 0.1394, NULL, NULL),
    ('4106902', 'multa', 4785, 2020, '2022-11-10', NULL, '1.1805.31.00', '7202.60.00', 118.32, 0.1342, NULL, NULL),
    ('3146206', 'multa', 560, 2025, '2026-06-05', NULL, '1.1803.10.00', '8446.10.10', 154.88, 0.0233, NULL, NULL),
    ('3146107', 'if', 3184, 2016, '2016-01-18', NULL, '1.1806.10.00', NULL, NULL, NULL, 3.7667, 0.037),
    ('3505906', 'multa', 1542, 2018, '2015-11-12', '2017-01-24', '1.0202.00.00', NULL, 9869.43, 0.0537, NULL, NULL),
    ('3505906', 'if', 1499, 2021, '2018-09-20', NULL, NULL, '2933.33.6', NULL, NULL, 60.8629, 0.0015),
    ('2927408', 'if', 3943, 2017, '2015-05-04', NULL, NULL, '8422.20.00', NULL, NULL, 5.7838, 0.0752),
    ('29', 'if', 2799, 2018, '2021-01-08', NULL, '1.2401.00.00', NULL, NULL, NULL, 2.3451, 0.0324),
    ('42', 'multa', 3445, 2025, '2022-10-14', NULL, '1.1806.39.00', '2933.33.3', 51.65, 0.201, NULL, NULL),
    ('3146206', 'multa', 1719, 2020, '2017-01-02', NULL, '1.0401.12.90', NULL, 144.54, 0.0756, NULL, NULL),
    ('35', 'if', 3696, 2017, '2016-08-09', NULL, NULL, '2941.90.81', NULL, NULL, 4.407, 0.0744),
    ('42', 'multa', 3778, 2026, '2021-05-13', NULL, NULL, NULL, 316.2, 0.0915, NULL, NULL),
    ('3306305', 'if', 4469, 2022, '2023-06-03', NULL, NULL, '8528.71.1', NULL, NULL, 2.322, 0.0437),
    ('24', 'multa', 1782, 2023, '2022-10-23', '2027-10-25', NULL, '2914.62.00', 114.13, 0.077, NULL, NULL),
    ('28', 'if', 3313, 2017, '2026-10-31', NULL, NULL, NULL, NULL, NULL, 40.9759, 0.0088),
    ('4208302', 'multa', 3012, 2015, '2018-06-06', NULL, '1.0401.21', '7308.30.00', 79.46, 0.0588, NULL, NULL),
    ('4208302', 'if', 4059, 2020, '2017-12-13', NULL, NULL, '3506.91.10', NULL, NULL, 7.1093, 0.0356),
    ('35', 'if', 1436, 2024, '2025-12-26', NULL, NULL, NULL, NULL, NULL, 4.1006, 0.0283),
    ('4208302', 'multa', 3840, 2025, '2026-10-17', NULL, '1.1703.92.00', NULL, 120.67, 0.1825, NULL, NULL),
    ('4308250', 'if', 1495, 2019, '2016-06-10', NULL, '1.1703.9', '6809.11.00', NULL, NULL, 3.0159, 0.0781),
    ('31', 'if', 341, 2026, '2021-01-26', NULL, NULL, '6115.10.9', NULL, NULL, 4.2893, 0.0721),
    ('3501905', 'if', 4380, 2026, '2026-05-17', NULL, NULL, NULL, NULL, NULL, 6.7442, 0.0233),
    ('2919306', 'if', 2462, 2025, '2017-01-15', NULL, '1.1505.00.00', '9030.40.10', NULL, NULL, 13.1985, 0.0682),
    ('4205407', 'multa', 2668, 2020, '2026-06-25', NULL, NULL, NULL, 404.73, 0.1292, NULL, NULL),
    ('3306305', 'multa', 3534, 2016, '2016-06-23', NULL, '1.0604.90.00', '5113.00.20', 249.32, 0.1691, NULL, NULL),
    ('53', 'multa', 1513, 2024, '2016-05-06', NULL, NULL, NULL, 86.9, 0.1342, NULL, NULL),
    ('3304557', 'if', 1773, 2023, '2020-11-25', NULL, NULL, NULL, NULL, NULL, 8.5037, 0.0493),
    ('4308250', 'if', 3773, 2016, '2021-12-01', NULL, '1.2302.21.00', '9603.90.00', NULL, NULL, 7.0071, 0.0559),
    ('3550308', 'multa', 1983, 2022, '2019-07-06', '2025-05-19', NULL, NULL, 247.16, 0.2474, NULL, NULL),
    ('3306305', 'multa', 2410, 2018, '2020-06-16', NULL, '1.1403.24.00', NULL, 199.72, 0.1808, NULL, NULL),
    ('28', 'multa', 1372, 2023, '2022-09-27', NULL, '1.0107.50.00', '2926.90.24', 244.4, 0.0442, NULL, NULL),
    ('3146206', 'multa', 2230, 2015, '2024-10-19', '2027-02-11', NULL, NULL, 215.6, 0.0958, NULL, NULL),
    ('43', 'multa', 2376, 2022, '2015-03-29', NULL, NULL, '3801.90.00', 239.92, 0.0173, NULL, NULL),
    ('3146107', 'multa', 4603, 2019, '2018-04-13', NULL, NULL, NULL, 216.49, 0.1629, NULL, NULL),
    ('43', 'if', 4973, 2024, '2026-10-07', NULL, '1.2204.20.00', NULL, NULL, NULL, 1.0876, 0.0161),
    ('28', 'if', 3798, 2026, '2019-10-25', '2025-08-14', '1.1404', '8523.29.1', NULL, NULL, 1.1047, 0.0571),
    ('3505906', 'multa', 3277, 2017, '2021-05-29', NULL, '1.0102.35', NULL, 44.18, 0.0972, NULL, NULL),
    ('5300108', 'if', 385, 2016, '2021-12-13', NULL, '1.0503.11.00', '3203.00.29', NULL, NULL, 1.2217, 0.0535),
    ('32', 'multa', 4878, 2019, '2015-03-08', '2018-01-07', NULL, NULL, 515.19, 0.1531, NULL, NULL),
    ('41', 'if', 2404, 2017, '2015-11-08', NULL, NULL, NULL, NULL, NULL, 2.5016, 0.0343),
    ('51', 'if', 1622, 2024, '2021-05-16', NULL, NULL, NULL, NULL, NULL, 3.9195, 0.076),
    ('29', 'multa', 1351, 2020, '2025-05-06', NULL, '1.1402.13.00', NULL, 119.72, 0.1247, NULL, NULL),
    ('3146107', 'if', 2419, 2020, '2021-03-08', NULL, '1.0911.00.00', NULL, NULL, NULL, 1.147, 0.0446),
    ('3304557', 'if', 3853, 2021, '2025-05-22', NULL, '1.2001.3', '8711.90.00', NULL, NULL, 5.1882, 0.0064),
    ('26', 'if', 840, 2016, '2021-06-13', NULL, NULL, '2918.11.00', NULL, NULL, 1.5581, 0.0332),
    ('33', 'multa', 1888, 2024, '2016-10-02', NULL, NULL, '8302.30.00', 47.22, 0.1815, NULL, NULL),
    ('3146107', 'multa', 3326, 2023, '2025-08-22', '2031-03-12', '1.2201.30.00', NULL, 656.93, 0.0513, NULL, NULL),
    ('3146107', 'if', 1651, 2021, '2020-09-26', NULL, NULL, '2921.44.22', NULL, NULL, 12.394, 0.0423),
    ('29', 'multa', 3355, 2026, '2015-07-27', NULL, '1.1501', NULL, 34.67, 0.0438, NULL, NULL),
    ('29', 'if', 337, 2021, '2021-08-30', NULL, NULL, '3003.90.8', NULL, NULL, 3.0888, 0.058),
    ('2919306', 'if', 1301, 2017, '2021-07-02', '2022-07-04', NULL, NULL, NULL, NULL, 56.0858, 0.0271),
    ('3146107', 'if', 1606, 2020, '2017-04-14', NULL, '1.0402.11.90', NULL, NULL, NULL, 11.6876, 0.0413),
    ('43', 'if', 242, 2018, '2020-02-18', '2024-05-30', NULL, '0705.11.00', NULL, NULL, 6.8694, 0.0464),
    ('4314902', 'if', 2197, 2017, '2026-02-21', NULL, '1.0903.1', '2939.79.1', NULL, NULL, 6.647, 0.0344),
    ('2919306', 'if', 2985, 2020, '2019-09-12', NULL, '1.1404.22.00', NULL, NULL, NULL, 5.5347, 0.0384),
    ('13', 'if', 1262, 2017, '2019-01-06', NULL, NULL, NULL, NULL, NULL, 6.191, 0.0728),
    ('3146206', 'multa', 1057, 2021, '2025-01-06', NULL, NULL, NULL, 222.9, 0.2154, NULL, NULL),
    ('51', 'if', 941, 2024, '2021-01-23', NULL, '1.0403.19.00', '0302.89.41', NULL, NULL, 5.6254, 0.0547),
    ('28', 'multa', 4855, 2025, '2022-12-01', NULL, NULL, '4704.29.00', 374.84, 0.118, NULL, NULL),
    ('53', 'if', 135, 2017, '2018-03-27', NULL, NULL, NULL, NULL, NULL, 1.3009, 0.0104),
    ('3550308', 'if', 3651, 2017, '2018-10-31', NULL, NULL, '7317.00.90', NULL, NULL, 2.4557, 0.0432),
    ('3548906', 'if', 2029, 2021, '2015-03-04', NULL, '1.0502.13.20', NULL, NULL, NULL, 2.2291, 0.0192),
    ('24', 'if', 4242, 2016, '2016-05-12', NULL, NULL, '5107.10.1', NULL, NULL, 3.2731, 0.0014),
    ('3205309', 'multa', 4926, 2022, '2017-12-05', NULL, '1.0901.22.00', NULL, 110.79, 0.1195, NULL, NULL),
    ('33', 'multa', 596, 2017, '2020-06-28', NULL, NULL, NULL, 121.78, 0.0603, NULL, NULL),
    ('53', 'if', 4882, 2022, '2020-11-03', NULL, NULL, NULL, NULL, NULL, 0.7727, 0.049),
    ('41', 'if', 3797, 2015, '2015-04-24', NULL, NULL, NULL, NULL, NULL, 3.2865, 0.009),
    ('3146206', 'if', 116, 2018, '2026-12-15', NULL, '1.0901.51.22', '2933.32.00', NULL, NULL, 1.8391, 0.0198),
    ('28', 'multa', 4992, 2024, '2019-01-29', NULL, NULL, '8407.29.10', 93.78, 0.1391, NULL, NULL),
    ('5300108', 'multa', 1927, 2026, '2015-05-24', NULL, NULL, '7210.41.10', 75.76, 0.2266, NULL, NULL),
    ('3146107', 'multa', 2678, 2024, '2019-11-26', NULL, '1.2301.21.00', '9608.91.00', 159.72, 0.061, NULL, NULL),
    ('3146206', 'if', 2300, 2023, '2022-04-05', '2023-03-30', NULL, NULL, NULL, NULL, 1.8129, 0.0309),
    ('3501905', 'multa', 963, 2025, '2024-03-18', NULL, NULL, '6812.99.90', 60.23, 0.0768, NULL, NULL),
    ('42', 'if', 3755, 2025, '2021-02-01', NULL, NULL, NULL, NULL, NULL, 4.6179, 0.0605),
    ('3106200', 'multa', 3056, 2015, '2022-02-02', NULL, NULL, NULL, 105.49, 0.2078, NULL, NULL),
    ('3306305', 'multa', 265, 2022, '2018-02-15', NULL, '1.1801', NULL, 117.68, 0.2352, NULL, NULL),
    ('24', 'if', 2035, 2023, '2022-04-20', NULL, '1.1101.60.00', '2933.99.3', NULL, NULL, 0.9429, 0.0132),
    ('3205309', 'if', 3647, 2019, '2021-08-09', NULL, NULL, NULL, NULL, NULL, 9.1054, 0.0242),
    ('26', 'multa', 871, 2019, '2017-10-23', NULL, '1.0605.40.00', '3004.50.50', 2444.89, 0.2165, NULL, NULL),
    ('31', 'multa', 1371, 2020, '2015-03-25', NULL, '1.0401.11', NULL, 269.28, 0.2177, NULL, NULL),
    ('4308250', 'multa', 4843, 2015, '2018-05-15', NULL, NULL, NULL, 72.29, 0.0797, NULL, NULL),
    ('53', 'multa', 1851, 2021, '2026-08-03', NULL, NULL, NULL, 61.74, 0.1791, NULL, NULL),
    ('3501905', 'multa', 662, 2022, '2018-02-06', NULL, '1.0105.22.00', '3003.90.2', 91.9, 0.1426, NULL, NULL),
    ('4106902', 'multa', 3704, 2023, '2026-08-01', '2027-03-17', '1.1409', '6601.91.90', 82.88, 0.0803, NULL, NULL),
    ('4314902', 'multa', 377, 2018, '2023-06-18', NULL, NULL, '3907.10.20', 187.45, 0.1578, NULL, NULL),
    ('1302603', 'if', 4108, 2021, '2023-02-08', NULL, '1.2404.22.00', '3005.90.1', NULL, NULL, 14.0465, 0.0608),
    ('3306305', 'if', 2141, 2023, '2015-03-29', '2016-10-28', NULL, NULL, NULL, NULL, 4.1317, 0.0213),
    ('43', 'if', 4145, 2021, '2023-01-08', NULL, '1.2503.10.00', '2933.19.11', NULL, NULL, 11.4265, 0.036),
    ('35', 'if', 1128, 2022, '2015-04-22', NULL, NULL, NULL, NULL, NULL, 1.307, 0.0499),
    ('4308250', 'multa', 899, 2017, '2015-11-05', NULL, '1.0102.1', '8461.50.90', 63.95, 0.1321, NULL, NULL),
    ('13', 'if', 4148, 2016, '2020-09-24', NULL, NULL, '3827.69.00', NULL, NULL, 2.141, 0.0575),
    ('42', 'multa', 4050, 2017, '2019-04-19', '2024-11-06', NULL, '8455.21.90', 131.2, 0.0673, NULL, NULL),
    ('4308250', 'if', 4711, 2018, '2026-02-10', NULL, '1.0901.51.24', NULL, NULL, NULL, 85.6123, 0.0401),
    ('41', 'multa', 3041, 2015, '2021-09-08', NULL, '1.1104.10.00', NULL, 180.83, 0.1504, NULL, NULL),
    ('13', 'if', 2450, 2018, '2016-05-31', NULL, '1.2002.90.00', NULL, NULL, NULL, 6.9577, 0.0199),
    ('4308250', 'multa', 4427, 2017, '2026-06-05', NULL, NULL, '3907.10.3', 983.09, 0.0468, NULL, NULL),
    ('29', 'if', 4831, 2017, '2017-05-13', NULL, NULL, NULL, NULL, NULL, 12.6384, 0.0558),
    ('3304557', 'multa', 2472, 2020, '2015-01-28', NULL, '1.0901.22.00', NULL, 100.74, 0.231, NULL, NULL),
    ('28', 'multa', 542, 2021, '2019-06-11', '2019-10-08', NULL, '3702.54.19', 77.03, 0.0798, NULL, NULL),
    ('28', 'multa', 2018, 2017, '2023-12-27', NULL, NULL, NULL, 180.05, 0.0528, NULL, NULL),
    ('3106200', 'multa', 1787, 2017, '2024-07-10', NULL, NULL, '7216.33.00', 114.31, 0.1288, NULL, NULL),
    ('53', 'multa', 3228, 2018, '2017-05-31', NULL, '1.0502.13.20', '6006.41.00', 207.49, 0.127, NULL, NULL),
    ('4308250', 'if', 3210, 2024, '2020-01-05', NULL, NULL, '5516.93.00', NULL, NULL, 11.1791, 0.0308),
    ('26', 'multa', 3208, 2020, '2015-01-11', NULL, '1.1403.25.00', NULL, 173.4, 0.1256, NULL, NULL),
    ('3146206', 'multa', 474, 2017, '2024-01-20', NULL, '1.0106.22.00', '8518.40.00', 382.09, 0.0286, NULL, NULL),
    ('3548906', 'if', 3319, 2023, '2021-10-06', NULL, '1.0501.21.10', NULL, NULL, NULL, 1.0264, 0.0565),
    ('3146206', 'if', 4512, 2023, '2016-07-16', NULL, '1.2501.21.00', NULL, NULL, NULL, 54.691, 0.0779),
    ('4314902', 'if', 1406, 2015, '2015-11-09', NULL, '1.0304.90.00', NULL, NULL, NULL, 35.8164, 0.0642),
    ('3550308', 'if', 4736, 2024, '2016-05-15', NULL, NULL, '2905.22.30', NULL, NULL, 8.7207, 0.0542),
    ('3501905', 'multa', 1847, 2025, '2017-03-23', '2019-12-29', '1.0301.90.00', NULL, 442.97, 0.2245, NULL, NULL),
    ('3505906', 'multa', 2147, 2025, '2022-08-07', NULL, NULL, NULL, 201.15, 0.0932, NULL, NULL),
    ('5300108', 'multa', 3071, 2020, '2026-11-04', NULL, '1.1101.20.00', '2923.90.50', 250.41, 0.0653, NULL, NULL),
    ('24', 'multa', 4994, 2024, '2020-10-05', NULL, NULL, '6904.90.00', 93.56, 0.1274, NULL, NULL),
    ('3106200', 'multa', 3655, 2020, '2024-07-31', NULL, NULL, NULL, 409.68, 0.1775, NULL, NULL),
    ('3106200', 'multa', 351, 2021, '2016-12-21', NULL, NULL, '3301.19.90', 206.15, 0.1097, NULL, NULL),
    ('4106902', 'multa', 79, 2026, '2016-07-21', '2018-05-26', NULL, NULL, 166.9, 0.221, NULL, NULL),
    ('3146107', 'multa', 4420, 2025, '2016-06-16', '2017-04-25', NULL, NULL, 448.82, 0.2046, NULL, NULL),
    ('26', 'multa', 3671, 2024, '2018-06-30', NULL, NULL, '0303.81.90', 440.43, 0.1618, NULL, NULL),
    ('3146107', 'multa', 4651, 2017, '2026-10-23', NULL, '1.1801.11.00', '2931.90.45', 485.68, 0.0723, NULL, NULL),
    ('3306305', 'multa', 3959, 2019, '2018-10-17', '2024-01-23', NULL, '9608.99.8', 99.59, 0.011, NULL, NULL),
    ('26', 'multa', 2521, 2015, '2026-04-03', NULL, NULL, '0307.83.00', 175.18, 0.2034, NULL, NULL),
    ('35', 'multa', 1514, 2016, '2023-07-14', NULL, '1.0501.24.29', NULL, 181.82, 0.0631, NULL, NULL),
    ('3550308', 'multa', 857, 2023, '2020-03-11', NULL, '1.0801', NULL, 123.12, 0.0981, NULL, NULL),
    ('41', 'multa', 912, 2017, '2021-07-15', NULL, NULL, NULL, 182.36, 0.0689, NULL, NULL),
    ('41', 'if', 2852, 2015, '2021-08-23', NULL, NULL, '2009.41.00', NULL, NULL, 1.6443, 0.0489),
    ('2927408', 'multa', 1300, 2024, '2019-08-17', NULL, NULL, NULL, 148.47, 0.0463, NULL, NULL),
    ('33', 'if', 2948, 2025, '2015-02-22', NULL, NULL, '2905.44.00', NULL, NULL, 4.048, 0.0434),
    ('3146206', 'multa', 4368, 2024, '2021-06-17', NULL, NULL, NULL, 76.04, 0.2185, NULL, NULL),
    ('4314902', 'if', 4223, 2025, '2019-07-22', NULL, NULL, '3003.90.83', NULL, NULL, 1.5595, 0.0249),
    ('28', 'multa', 795, 2019, '2021-09-07', NULL, '1.1701.31.00', NULL, 213.46, 0.1477, NULL, NULL),
    ('3304557', 'if', 3009, 2015, '2020-10-29', '2024-07-31', NULL, NULL, NULL, NULL, 1.9316, 0.079),
    ('3146206', 'multa', 656, 2017, '2023-06-01', NULL, '1.0910.10.00', '0106.33.90', 92.07, 0.2148, NULL, NULL),
    ('4205407', 'multa', 588, 2024, '2022-05-28', NULL, NULL, NULL, 113.57, 0.1718, NULL, NULL),
    ('3550308', 'multa', 1660, 2025, '2018-12-13', NULL, '1.0802.20.00', NULL, 536.35, 0.0595, NULL, NULL),
    ('3146206', 'multa', 3242, 2022, '2019-04-10', NULL, NULL, '2930.30.12', 177.69, 0.1793, NULL, NULL),
    ('3106200', 'multa', 2431, 2023, '2015-09-26', NULL, '1.1805.14.00', NULL, 69.3, 0.1776, NULL, NULL),
    ('3304557', 'if', 3494, 2022, '2024-04-03', NULL, NULL, '6404.19.00', NULL, NULL, 0.3327, 0.043),
    ('3106200', 'if', 2052, 2026, '2023-09-27', NULL, '1.1103.10.00', '2939.79.11', NULL, NULL, 1.7877, 0.0531),
    ('33', 'multa', 1015, 2026, '2021-11-12', NULL, NULL, '4811.49.10', 137.73, 0.0765, NULL, NULL),
    ('32', 'multa', 3205, 2023, '2026-03-25', NULL, NULL, NULL, 173.33, 0.0222, NULL, NULL),
    ('41', 'if', 2629, 2026, '2017-09-21', NULL, '1.0504.45.10', '8452.90.91', NULL, NULL, 2.9022, 0.0302),
    ('3505906', 'multa', 3465, 2023, '2022-10-14', NULL, '1.1402.31.00', '4811.51.10', 190.58, 0.1699, NULL, NULL),
    ('3205309', 'multa', 2625, 2016, '2023-09-15', NULL, NULL, '2933.99.93', 208.46, 0.0827, NULL, NULL),
    ('3550308', 'if', 2507, 2023, '2026-04-10', NULL, '1.0903.3', NULL, NULL, NULL, 10.2287, 0.051),
    ('31', 'if', 4376, 2022, '2022-01-03', NULL, '1.1701.11.00', '7201.50.00', NULL, NULL, 0.8491, 0.0054),
    ('29', 'if', 299, 2017, '2022-06-03', NULL, NULL, '5702.31.00', NULL, NULL, 6.7459, 0.0341),
    ('3501905', 'if', 2892, 2019, '2023-10-14', NULL, NULL, NULL, NULL, NULL, 296.2814, 0.0502),
    ('4314902', 'if', 3533, 2015, '2025-02-10', NULL, '1.0501.39.00', NULL, NULL, NULL, 4.7859, 0.0318),
    ('41', 'multa', 4335, 2019, '2015-09-29', NULL, NULL, '8533.21.10', 600.49, 0.2322, NULL, NULL),
    ('2927408', 'multa', 4202, 2015, '2024-04-17', NULL, NULL, '3903.19.00', 58.14, 0.1404, NULL, NULL),
    ('41', 'multa', 1601, 2024, '2023-07-27', NULL, '1.0504.3', NULL, 124.17, 0.129, NULL, NULL),
    ('53', 'if', 1411, 2023, '2017-06-08', NULL, '1.1403.22.13', NULL, NULL, NULL, 11.906, 0.0723),
    ('1302603', 'multa', 2834, 2026, '2021-05-27', NULL, '1.0403.2', '6108.29.00', 557.02, 0.1862, NULL, NULL),
    ('35', 'if', 3571, 2019, '2023-07-22', NULL, NULL, NULL, NULL, NULL, 0.7308, 0.0687),
    ('4106902', 'multa', 3993, 2021, '2018-05-29', NULL, '1.0402.12.00', NULL, 1141.98, 0.1129, NULL, NULL),
    ('32', 'if', 553, 2022, '2025-05-15', NULL, '1.0501.13.10', '2839.19.00', NULL, NULL, 2.9779, 0.0519),
    ('3106200', 'if', 1800, 2025, '2024-10-31', NULL, NULL, '5208.52.00', NULL, NULL, 3.741, 0.0271),
    ('24', 'multa', 3856, 2023, '2016-03-07', NULL, '1.1402.31.00', '9017.80.10', 215.06, 0.1326, NULL, NULL),
    ('4208302', 'if', 2546, 2022, '2020-06-27', NULL, '1.0501.24.10', NULL, NULL, NULL, 9.215, 0.0167),
    ('3505906', 'if', 2966, 2025, '2026-02-26', NULL, NULL, NULL, NULL, NULL, 3.9949, 0.0558),
    ('3505906', 'multa', 2073, 2023, '2017-07-01', NULL, '1.2301.97.00', '8541.90.10', 1260.3, 0.187, NULL, NULL),
    ('3548906', 'multa', 2647, 2021, '2015-12-09', NULL, '1.0503.27.00', '0307.43.10', 2954.24, 0.1755, NULL, NULL),
    ('21', 'multa', 4192, 2019, '2023-06-05', NULL, '1.1002', NULL, 65.09, 0.0391, NULL, NULL),
    ('3205309', 'if', 4519, 2025, '2018-01-08', NULL, '1.2404.12.00', NULL, NULL, NULL, 40.6857, 0.0146),
    ('4314902', 'if', 1957, 2021, '2024-12-11', NULL, NULL, '9617.00.10', NULL, NULL, 17.3796, 0.0672),
    ('3304557', 'if', 2221, 2023, '2018-09-01', NULL, '1.0905.11.00', NULL, NULL, NULL, 2.3305, 0.0743),
    ('33', 'multa', 3084, 2023, '2017-10-26', NULL, NULL, '9401.61.00', 177.93, 0.1498, NULL, NULL),
    ('42', 'multa', 889, 2016, '2019-04-18', NULL, NULL, '6803.00.00', 199.09, 0.0259, NULL, NULL),
    ('3548906', 'if', 613, 2017, '2025-07-16', NULL, '1.0901.51', '2827.10.00', NULL, NULL, 2.5151, 0.0418),
    ('35', 'multa', 1009, 2017, '2020-11-04', NULL, '1.0403.21.90', '4802.69.99', 54.7, 0.2296, NULL, NULL),
    ('2927408', 'if', 4161, 2019, '2022-09-11', NULL, NULL, NULL, NULL, NULL, 12.2994, 0.0527),
    ('2927408', 'if', 4213, 2025, '2021-03-31', '2027-05-07', '1.1001.2', NULL, NULL, NULL, 11.5797, 0.0529),
    ('35', 'if', 4196, 2023, '2021-11-06', NULL, '1.1406.34.00', NULL, NULL, NULL, 2.322, 0.0731),
    ('5300108', 'if', 3405, 2017, '2015-11-21', NULL, '1.1502.50.00', NULL, NULL, NULL, 3.902, 0.0023),
    ('3505906', 'multa', 2680, 2026, '2018-01-07', NULL, NULL, '0302.71.00', 151.21, 0.0617, NULL, NULL),
    ('3550308', 'multa', 1016, 2023, '2026-05-21', '2028-04-06', '1.2501.21.00', '3907.99.11', 49.87, 0.2336, NULL, NULL),
    ('4205407', 'if', 354, 2023, '2026-06-19', NULL, '1.1402.31.00', '2934.99.26', NULL, NULL, 21.3313, 0.0369),
    ('3505906', 'multa', 604, 2025, '2023-05-16', NULL, NULL, '2508.60.00', 254.14, 0.2115, NULL, NULL),
    ('4308250', 'if', 1386, 2017, '2021-03-06', '2024-06-08', '1.1706.12.00', '0304.92.22', NULL, NULL, 4.3414, 0.0365),
    ('4314902', 'multa', 3741, 2025, '2026-04-08', NULL, '1.1001.12.90', '6903.20.30', 57.74, 0.1967, NULL, NULL),
    ('31', 'multa', 4433, 2024, '2021-07-10', NULL, NULL, '7203.90.00', 187.52, 0.0713, NULL, NULL),
    ('4208302', 'multa', 4210, 2026, '2016-08-04', NULL, NULL, '2827.49.29', 153.86, 0.0507, NULL, NULL),
    ('28', 'multa', 2529, 2016, '2015-03-21', NULL, NULL, NULL, 291.91, 0.2264, NULL, NULL),
    ('4106902', 'multa', 2463, 2015, '2025-05-08', NULL, NULL, NULL, 306.83, 0.1817, NULL, NULL),
    ('3106200', 'if', 448, 2023, '2022-09-11', NULL, NULL, NULL, NULL, NULL, 2.4153, 0.0581),
    ('32', 'multa', 3442, 2023, '2015-11-12', NULL, '1.0102.41.10', '0713.33.11', 159.33, 0.2457, NULL, NULL),
    ('4308250', 'multa', 32, 2026, '2019-03-30', NULL, '1.0901', '9028.90.90', 131.86, 0.0286, NULL, NULL),
    ('3146206', 'multa', 2885, 2025, '2025-12-01', NULL, '1.1703.3', NULL, 181.83, 0.1501, NULL, NULL),
    ('21', 'multa', 301, 2016, '2015-03-05', NULL, NULL, NULL, 167.02, 0.2416, NULL, NULL),
    ('13', 'if', 4091, 2016, '2015-08-03', NULL, NULL, NULL, NULL, NULL, 3.6706, 0.048),
    ('31', 'if', 4128, 2024, '2025-12-18', NULL, NULL, NULL, NULL, NULL, 2.8086, 0.0136),
    ('3501905', 'multa', 4802, 2016, '2016-06-07', NULL, '1.2404.32.00', '5103.10.00', 258.87, 0.0974, NULL, NULL),
    ('3548906', 'if', 4146, 2019, '2021-02-24', '2026-09-14', NULL, '4805.91.00', NULL, NULL, 7.6537, 0.0373),
    ('4208302', 'multa', 4270, 2026, '2017-12-12', NULL, NULL, '2937.22.90', 446.89, 0.2345, NULL, NULL),
    ('1302603', 'if', 1086, 2019, '2021-03-05', NULL, '1.1701.33.00', NULL, NULL, NULL, 4.2044, 0.0556),
    ('4205407', 'if', 1629, 2019, '2026-06-25', NULL, NULL, '8433.51.00', NULL, NULL, 21.9507, 0.0499),
    ('3146107', 'if', 600, 2019, '2017-12-29', NULL, NULL, NULL, NULL, NULL, 1.9896, 0.04),
    ('29', 'multa', 3865, 2016, '2026-01-31', NULL, NULL, '8106.10.00', 491.68, 0.0427, NULL, NULL),
    ('2919306', 'if', 2826, 2024, '2017-03-25', NULL, NULL, NULL, NULL, NULL, 4.0919, 0.0747),
    ('4308250', 'if', 2993, 2016, '2018-05-25', NULL, NULL, '8112.13.00', NULL, NULL, 1.22, 0.0421),
    ('4205407', 'multa', 4015, 2019, '2015-06-05', NULL, '1.1502.50.00', '3808.59.2', 207.74, 0.1416, NULL, NULL),
    ('35', 'if', 698, 2022, '2015-02-09', NULL, '1.0901.51.21', '6302.59.90', NULL, NULL, 3.4047, 0.0296),
    ('3548906', 'if', 3247, 2018, '2025-10-24', NULL, NULL, '3506.91.10', NULL, NULL, 8.4028, 0.0751),
    ('29', 'multa', 4275, 2026, '2026-02-12', NULL, NULL, NULL, 155.63, 0.1939, NULL, NULL),
    ('31', 'if', 1245, 2020, '2016-09-27', NULL, '1.1106', '0206.49.00', NULL, NULL, 342.921, 0.0134),
    ('31', 'if', 489, 2019, '2019-02-01', NULL, NULL, '8404.10.20', NULL, NULL, 3.985, 0.0799),
    ('3205309', 'multa', 4699, 2026, '2026-11-10', NULL, '1.0502.34.20', '3504.00.11', 270.71, 0.1611, NULL, NULL),
    ('35', 'if', 1483, 2026, '2023-04-26', NULL, NULL, NULL, NULL, NULL, 8.0947, 0.0261),
    ('3550308', 'if', 3770, 2025, '2017-05-27', NULL, NULL, '3003.20.94', NULL, NULL, 2.3009, 0.012),
    ('2927408', 'if', 2239, 2015, '2024-04-26', NULL, '1.0401.11.20', '5306.20.00', NULL, NULL, 3.0814, 0.0187),
    ('35', 'multa', 1666, 2026, '2022-11-03', NULL, '1.1101.16.00', NULL, 195.75, 0.2258, NULL, NULL),
    ('1302603', 'if', 3734, 2023, '2023-11-26', NULL, '1.1106.39.00', '8301.20.00', NULL, NULL, 2.013, 0.0382),
    ('42', 'multa', 1331, 2020, '2023-09-11', NULL, NULL, '3811.90.90', 253.92, 0.1022, NULL, NULL),
    ('2927408', 'multa', 960, 2020, '2025-08-27', NULL, NULL, NULL, 253.07, 0.0884, NULL, NULL),
    ('3304557', 'if', 2255, 2022, '2026-09-24', NULL, '1.1705.10.00', NULL, NULL, NULL, 1.5541, 0.0691),
    ('4106902', 'multa', 3392, 2020, '2022-10-14', NULL, '1.0501.14.20', NULL, 184.36, 0.1373, NULL, NULL),
    ('26', 'if', 2080, 2022, '2022-10-30', '2023-05-24', '1.1801.21.00', '8517.61.4', NULL, NULL, 5.1847, 0.069),
    ('1302603', 'if', 1694, 2020, '2015-01-18', NULL, '1.1805.2', '9006.53.10', NULL, NULL, 6.239, 0.0283),
    ('3505906', 'if', 2102, 2024, '2015-03-23', NULL, '1.1406.11.00', '8505.90.11', NULL, NULL, 2.2538, 0.0707),
    ('4308250', 'multa', 1688, 2023, '2017-10-26', NULL, NULL, '3002.42.60', 98.1, 0.2434, NULL, NULL),
    ('3205309', 'if', 2626, 2021, '2022-06-11', NULL, '1.2505', '3920.73.90', NULL, NULL, 1.7619, 0.0724),
    ('51', 'multa', 60, 2015, '2015-12-21', NULL, NULL, NULL, 455.09, 0.0359, NULL, NULL),
    ('4208302', 'if', 1474, 2020, '2021-08-09', '2026-04-17', NULL, NULL, NULL, NULL, 1.8734, 0.0798),
    ('35', 'if', 1872, 2018, '2016-10-27', NULL, NULL, '8448.39.22', NULL, NULL, 1.1093, 0.01),
    ('4308250', 'multa', 211, 2017, '2023-11-20', NULL, NULL, '8413.30.30', 155.89, 0.0819, NULL, NULL),
    ('29', 'multa', 3598, 2016, '2018-03-04', '2019-09-16', '1.0901.51.21', '8536.30.90', 73.05, 0.1774, NULL, NULL),
    ('3146107', 'multa', 2057, 2026, '2019-07-14', NULL, '1.0401.11.20', NULL, 186.95, 0.2484, NULL, NULL),
    ('29', 'if', 4335, 2016, '2020-06-26', NULL, NULL, NULL, NULL, NULL, 1.5254, 0.0732),
    ('32', 'multa', 2088, 2026, '2015-06-11', '2015-09-28', '1.0502.2', '2929.90.11', 148.37, 0.2273, NULL, NULL),
    ('29', 'if', 325, 2023, '2021-06-05', NULL, '1.0105.12.00', NULL, NULL, NULL, 5.9827, 0.0066),
    ('5300108', 'if', 3387, 2018, '2026-11-13', NULL, '1.1302.1', '8445.19.27', NULL, NULL, 1.0986, 0.0642),
    ('51', 'multa', 4462, 2021, '2022-06-18', NULL, '1.0502.24.59', NULL, 229.47, 0.0901, NULL, NULL),
    ('4308250', 'multa', 2791, 2015, '2026-12-05', NULL, NULL, NULL, 426.11, 0.0721, NULL, NULL),
    ('4308250', 'multa', 2798, 2016, '2016-12-27', NULL, NULL, '8544.19.90', 104.6, 0.0246, NULL, NULL),
    ('1302603', 'multa', 3900, 2015, '2024-01-08', NULL, '1.0502.14', '4302.19.10', 144.8, 0.211, NULL, NULL),
    ('3205309', 'if', 1790, 2020, '2022-03-20', NULL, NULL, NULL, NULL, NULL, 1.4444, 0.008),
    ('4308250', 'multa', 3320, 2019, '2024-03-26', '2029-06-28', '1.1403.2', '7202.11.00', 100.18, 0.0352, NULL, NULL),
    ('24', 'multa', 4179, 2025, '2015-11-27', NULL, '1.0605.90.00', NULL, 80.59, 0.2364, NULL, NULL),
    ('2919306', 'if', 441, 2021, '2026-08-21', NULL, '1.1901.30.00', '3004.20.7', NULL, NULL, 6.6158, 0.0199),
    ('53', 'multa', 2664, 2022, '2019-02-05', NULL, '1.0907.00.00', NULL, 109.96, 0.1412, NULL, NULL),
    ('3146107', 'multa', 819, 2019, '2026-09-01', NULL, '1.1408.15.00', '2929.90.50', 96.37, 0.1816, NULL, NULL),
    ('26', 'if', 4952, 2020, '2019-12-13', NULL, NULL, NULL, NULL, NULL, 4.6949, 0.0221),
    ('42', 'multa', 1465, 2016, '2022-04-05', NULL, '1.1701.11.00', NULL, 196.49, 0.0613, NULL, NULL),
    ('4205407', 'multa', 4350, 2025, '2017-02-20', NULL, '1.1704.20.00', NULL, 137.47, 0.1909, NULL, NULL),
    ('35', 'if', 3596, 2020, '2017-01-07', NULL, NULL, NULL, NULL, NULL, 0.6755, 0.0562),
    ('24', 'multa', 1550, 2016, '2021-09-11', NULL, NULL, '2934.20.34', 202.31, 0.2413, NULL, NULL),
    ('4208302', 'multa', 2593, 2018, '2017-02-23', NULL, '1.0901.51.25', '2903.83.00', 165.4, 0.1407, NULL, NULL),
    ('32', 'if', 4440, 2022, '2020-01-28', '2025-11-19', NULL, '2853.90.11', NULL, NULL, 6.0945, 0.0219),
    ('4208302', 'multa', 2848, 2015, '2016-02-24', NULL, NULL, '2904.10.19', 79.41, 0.1463, NULL, NULL),
    ('31', 'if', 1560, 2019, '2022-02-27', NULL, NULL, '3824.40.00', NULL, NULL, 5.4031, 0.0032),
    ('3501905', 'multa', 4209, 2021, '2025-10-09', NULL, NULL, '9104.00.00', 80.84, 0.1752, NULL, NULL),
    ('3106200', 'multa', 2934, 2022, '2024-09-02', NULL, '1.2003.26.10', NULL, 138.3, 0.1538, NULL, NULL),
    ('3505906', 'multa', 3721, 2023, '2026-02-01', NULL, '1.0604', NULL, 121.28, 0.0195, NULL, NULL),
    ('26', 'multa', 4954, 2020, '2018-01-13', NULL, '1.2301.1', '6205.90.10', 391.08, 0.0318, NULL, NULL),
    ('31', 'if', 4449, 2020, '2018-12-27', NULL, '1.1402', '2922.31.20', NULL, NULL, 2.4827, 0.031),
    ('1302603', 'if', 4924, 2020, '2023-06-08', NULL, '1.0102.42.20', NULL, NULL, NULL, 1.7658, 0.0177),
    ('51', 'multa', 1071, 2017, '2017-06-26', NULL, '1.02', NULL, 73.44, 0.0689, NULL, NULL),
    ('3106200', 'if', 3905, 2021, '2020-12-19', '2023-05-17', NULL, NULL, NULL, NULL, 1.0736, 0.0403),
    ('4208302', 'if', 2305, 2021, '2017-02-10', NULL, '1.0105.70.00', NULL, NULL, NULL, 2.1593, 0.0429),
    ('42', 'if', 2632, 2016, '2025-06-27', NULL, '1.2002.20.00', '3604.90.10', NULL, NULL, 13.874, 0.0571),
    ('28', 'multa', 4313, 2019, '2024-08-05', NULL, '1.0303.13.00', NULL, 146.17, 0.1154, NULL, NULL),
    ('26', 'multa', 431, 2018, '2022-05-25', NULL, '1.0502.22.10', NULL, 249.67, 0.0193, NULL, NULL),
    ('3106200', 'if', 4528, 2019, '2019-01-19', '2024-10-28', '1.0301.32.00', '8482.91.90', NULL, NULL, 3.0989, 0.0613),
    ('29', 'multa', 1991, 2018, '2017-06-06', NULL, '1.1107.20.00', '8468.20.00', 113.5, 0.0676, NULL, NULL),
    ('13', 'multa', 107, 2025, '2017-06-07', NULL, '1.0503.2', '8208.30.00', 108.52, 0.0721, NULL, NULL),
    ('1302603', 'multa', 2319, 2019, '2016-02-19', NULL, '1.0401.16.90', NULL, 47.95, 0.2293, NULL, NULL),
    ('3550308', 'if', 1228, 2026, '2021-01-08', NULL, '1.0105.90.00', NULL, NULL, NULL, 0.4098, 0.0645),
    ('4205407', 'multa', 4179, 2016, '2016-10-17', NULL, '1.2304.19.00', '6103.32.00', 224.57, 0.0294, NULL, NULL),
    ('1302603', 'if', 4884, 2018, '2020-08-29', NULL, '1.1901.10.00', '8901.20.00', NULL, NULL, 12.9044, 0.0517),
    ('4314902', 'multa', 3876, 2016, '2022-08-28', NULL, '1.0905.2', NULL, 195.53, 0.1415, NULL, NULL),
    ('3306305', 'multa', 2089, 2026, '2023-08-25', NULL, '1.2304.20.00', '8531.10.10', 101.39, 0.0518, NULL, NULL),
    ('3306305', 'multa', 3246, 2016, '2021-09-22', NULL, '1.1801.12.00', NULL, 175.29, 0.0964, NULL, NULL),
    ('13', 'multa', 3478, 2020, '2020-08-25', NULL, NULL, NULL, 157.22, 0.029, NULL, NULL),
    ('3306305', 'multa', 2587, 2023, '2015-03-26', NULL, NULL, NULL, 144.85, 0.1401, NULL, NULL),
    ('3146206', 'multa', 239, 2020, '2025-09-20', NULL, '1.2406.10.00', NULL, 232.4, 0.1045, NULL, NULL),
    ('1302603', 'if', 4608, 2016, '2022-08-02', NULL, '1.0503.21.00', NULL, NULL, NULL, 2.0779, 0.0784),
    ('3550308', 'if', 3210, 2018, '2025-07-28', NULL, NULL, NULL, NULL, NULL, 5.1872, 0.0289),
    ('29', 'multa', 4851, 2019, '2015-08-12', NULL, NULL, NULL, 136.03, 0.0172, NULL, NULL),
    ('32', 'multa', 307, 2022, '2024-09-07', NULL, '1.1401.15.00', '1905.40.00', 110.3, 0.0256, NULL, NULL),
    ('3548906', 'if', 2024, 2021, '2018-08-02', NULL, NULL, NULL, NULL, NULL, 1.4679, 0.0164),
    ('3306305', 'if', 1183, 2018, '2024-12-02', '2025-09-28', '1.1402.3', '2801.20.10', NULL, NULL, 8.3481, 0.0461),
    ('21', 'multa', 2227, 2020, '2019-12-19', NULL, NULL, NULL, 289.59, 0.012, NULL, NULL),
    ('4205407', 'if', 3111, 2021, '2020-12-15', '2022-02-28', '1.2502', '1004.90.00', NULL, NULL, 7.6784, 0.0428),
    ('41', 'if', 1040, 2017, '2024-07-24', NULL, NULL, NULL, NULL, NULL, 1.4037, 0.0387),
    ('3146107', 'if', 3913, 2017, '2023-12-04', NULL, '1.0402.90.00', '5407.72.00', NULL, NULL, 3.318, 0.0638),
    ('3306305', 'multa', 513, 2018, '2019-04-03', NULL, NULL, NULL, 87.98, 0.1229, NULL, NULL),
    ('35', 'if', 4547, 2024, '2026-04-14', NULL, '1.1402.31.00', NULL, NULL, NULL, 5.7369, 0.0772),
    ('31', 'multa', 1294, 2022, '2021-10-28', NULL, '1.0301.90.00', NULL, 88.26, 0.2463, NULL, NULL),
    ('3550308', 'multa', 1204, 2025, '2026-01-03', NULL, '1.1106.36.20', '0207.12.20', 66.44, 0.2127, NULL, NULL),
    ('3205309', 'multa', 3322, 2017, '2021-12-15', '2024-11-13', NULL, '2915.90.60', 77.56, 0.052, NULL, NULL),
    ('4106902', 'if', 3882, 2021, '2024-12-18', NULL, NULL, '3206.50.21', NULL, NULL, 3.8993, 0.0544),
    ('43', 'if', 2697, 2025, '2020-06-01', NULL, NULL, '2918.19.42', NULL, NULL, 2.021, 0.0586),
    ('4314902', 'multa', 4836, 2017, '2021-08-31', NULL, NULL, NULL, 1279.29, 0.0369, NULL, NULL),
    ('4106902', 'if', 614, 2024, '2018-01-24', NULL, NULL, '5603.91.10', NULL, NULL, 3.9194, 0.0324),
    ('1302603', 'multa', 2081, 2015, '2026-07-21', NULL, NULL, NULL, 183.23, 0.1396, NULL, NULL),
    ('51', 'if', 4608, 2025, '2018-12-31', NULL, NULL, '3824.99.13', NULL, NULL, 0.7187, 0.02),
    ('35', 'multa', 3793, 2023, '2019-01-26', NULL, '1.0301.10.00', NULL, 105.98, 0.0116, NULL, NULL),
    ('4106902', 'multa', 315, 2026, '2018-06-23', NULL, NULL, NULL, 49.55, 0.246, NULL, NULL),
    ('41', 'multa', 4176, 2020, '2025-06-26', NULL, '1.1401.13.00', NULL, 98.3, 0.1529, NULL, NULL),
    ('4106902', 'multa', 2684, 2023, '2017-04-16', NULL, '1.1703.21.00', '3913.90.90', 308.39, 0.031, NULL, NULL),
    ('51', 'multa', 1308, 2026, '2026-03-21', NULL, '1.2504.1', '5402.47.90', 129.66, 0.2016, NULL, NULL),
    ('26', 'if', 3222, 2016, '2018-12-18', NULL, '1.2508.00.00', NULL, NULL, NULL, 4.4374, 0.0159),
    ('4314902', 'multa', 50, 2026, '2020-12-01', '2025-01-08', NULL, '8453.80.00', 319.01, 0.2364, NULL, NULL),
    ('5300108', 'multa', 668, 2025, '2016-12-28', NULL, '1.1806.20.00', NULL, 103.92, 0.12, NULL, NULL),
    ('26', 'if', 2297, 2024, '2018-12-07', NULL, '1.2501.37.00', '8439.10.90', NULL, NULL, 3.0062, 0.0119),
    ('53', 'multa', 343, 2021, '2024-10-09', NULL, '1.1303.20.00', NULL, 331.45, 0.245, NULL, NULL),
    ('3501905', 'if', 721, 2017, '2026-03-08', NULL, NULL, '2909.44.11', NULL, NULL, 83.5755, 0.043),
    ('13', 'multa', 4417, 2019, '2016-05-05', NULL, '1.0607.00.00', NULL, 97.42, 0.1391, NULL, NULL),
    ('31', 'if', 4157, 2018, '2017-10-20', NULL, '1.0102.41.90', NULL, NULL, NULL, 2.5415, 0.0733),
    ('2919306', 'multa', 1752, 2019, '2023-03-21', NULL, NULL, NULL, 162.51, 0.1255, NULL, NULL),
    ('3306305', 'if', 3250, 2023, '2016-10-10', '2021-11-11', NULL, NULL, NULL, NULL, 2.7983, 0.0203),
    ('43', 'multa', 2156, 2025, '2015-12-13', NULL, NULL, NULL, 105.45, 0.1272, NULL, NULL),
    ('28', 'multa', 2123, 2017, '2015-07-18', NULL, NULL, NULL, 88.91, 0.0525, NULL, NULL),
    ('3306305', 'if', 4912, 2018, '2018-12-27', NULL, NULL, '6110.11.00', NULL, NULL, 4.4466, 0.0407),
    ('35', 'multa', 3739, 2017, '2026-10-07', NULL, '1.0504.45.10', '2846.90.10', 86.38, 0.0314, NULL, NULL),
    ('51', 'multa', 3106, 2023, '2016-01-16', NULL, NULL, NULL, 72.36, 0.0593, NULL, NULL),
    ('51', 'if', 370, 2023, '2021-11-30', '2022-11-20', '1.0401.90.00', NULL, NULL, NULL, 98.1248, 0.043),
    ('35', 'multa', 3045, 2020, '2021-06-29', NULL, NULL, NULL, 141.45, 0.0722, NULL, NULL),
    ('4314902', 'multa', 3981, 2015, '2020-05-07', NULL, '1.0106.3', NULL, 17.4, 0.0549, NULL, NULL),
    ('4308250', 'if', 762, 2021, '2024-04-25', NULL, '1.1107', '2204.10.90', NULL, NULL, 7.6687, 0.0079),
    ('3505906', 'multa', 226, 2023, '2015-02-12', NULL, NULL, '7607.11.90', 106.28, 0.1398, NULL, NULL),
    ('4308250', 'multa', 4113, 2023, '2021-05-05', NULL, NULL, '3808.59.24', 141.36, 0.2306, NULL, NULL),
    ('32', 'if', 3581, 2022, '2020-12-07', NULL, '1.1401', '5510.11.90', NULL, NULL, 2.5386, 0.0532),
    ('3146107', 'multa', 397, 2022, '2021-09-15', NULL, NULL, '8701.30.00', 220.9, 0.1677, NULL, NULL),
    ('3106200', 'multa', 2449, 2026, '2017-11-25', '2021-06-10', '1.0405.00.00', NULL, 60.5, 0.1593, NULL, NULL),
    ('3205309', 'if', 244, 2026, '2017-06-26', NULL, NULL, '9106.10.00', NULL, NULL, 0.6309, 0.0739),
    ('3146206', 'multa', 3181, 2019, '2015-02-05', NULL, '1.1302.11.00', '9022.90.10', 748.21, 0.0688, NULL, NULL),
    ('3548906', 'if', 2533, 2018, '2023-06-11', NULL, '1.0502', NULL, NULL, NULL, 4.3011, 0.0645),
    ('42', 'multa', 1669, 2022, '2016-04-08', '2021-09-15', NULL, '4820.90.00', 107.49, 0.212, NULL, NULL),
    ('41', 'if', 1219, 2026, '2026-06-17', NULL, '1.0102.42.10', '0208.10.00', NULL, NULL, 1.04, 0.0259),
    ('32', 'if', 3226, 2026, '2020-01-09', NULL, NULL, NULL, NULL, NULL, 2.3162, 0.0536),
    ('13', 'if', 2816, 2020, '2018-10-23', NULL, NULL, NULL, NULL, NULL, 6.3329, 0.0773),
    ('3548906', 'if', 2906, 2023, '2021-12-25', NULL, '1.0505.10.00', NULL, NULL, NULL, 4.0473, 0.0595),
    ('1302603', 'if', 3823, 2020, '2023-03-05', NULL, NULL, '2826.19.10', NULL, NULL, 3.4893, 0.0136),
    ('53', 'if', 4227, 2026, '2015-03-30', '2018-12-26', NULL, NULL, NULL, NULL, 53.7941, 0.0463),
    ('26', 'if', 2263, 2026, '2020-12-19', NULL, NULL, '0308.30.00', NULL, NULL, 1.9677, 0.006),
    ('42', 'if', 3523, 2020, '2017-05-28', NULL, NULL, '1604.32.00', NULL, NULL, 2.5242, 0.0727),
    ('3548906', 'if', 3207, 2015, '2020-06-14', NULL, '1.0901.51', '3808.59.23', NULL, NULL, 1.4537, 0.0496),
    ('13', 'if', 4729, 2015, '2026-01-23', NULL, NULL, '3004.39.35', NULL, NULL, 7.1447, 0.0388),
    ('3146206', 'multa', 184, 2020, '2026-05-01', '2030-05-03', NULL, '0306.93.00', 34.71, 0.0523, NULL, NULL),
    ('41', 'if', 3383, 2022, '2023-10-05', NULL, NULL, '4811.90.19', NULL, NULL, 0.9469, 0.0304),
    ('28', 'if', 3603, 2024, '2019-10-18', NULL, NULL, '8445.40.90', NULL, NULL, 1.8833, 0.0513),
    ('21', 'multa', 4710, 2022, '2021-01-02', NULL, NULL, '2922.29.1', 72.41, 0.0784, NULL, NULL),
    ('35', 'if', 4215, 2015, '2024-11-28', NULL, NULL, NULL, NULL, NULL, 17.0714, 0.0396),
    ('41', 'multa', 81, 2024, '2023-12-14', '2029-09-07', '1.1103.39.00', '2933.39.19', 486.94, 0.1933, NULL, NULL),
    ('13', 'if', 1651, 2025, '2023-12-31', NULL, '1.0103.42.00', NULL, NULL, NULL, 3.578, 0.0493),
    ('2919306', 'multa', 2013, 2024, '2017-07-01', '2018-08-10', NULL, NULL, 50.35, 0.1128, NULL, NULL),
    ('43', 'if', 4802, 2020, '2022-05-26', '2029-01-14', NULL, '1901.10.30', NULL, NULL, 3.0904, 0.0158),
    ('29', 'multa', 130, 2026, '2026-05-18', NULL, '1.0701.00.00', '3904.61.90', 30.15, 0.0877, NULL, NULL),
    ('41', 'multa', 3037, 2021, '2018-11-29', NULL, '1.1103.43.00', '8112.49.00', 201.73, 0.2181, NULL, NULL),
    ('24', 'if', 1668, 2024, '2018-05-05', NULL, '1.1402.14.00', '8112.59.00', NULL, NULL, 3.1261, 0.0641),
    ('43', 'multa', 4349, 2015, '2018-08-29', '2022-09-18', NULL, NULL, 424.63, 0.2274, NULL, NULL),
    ('2919306', 'if', 2134, 2019, '2015-03-08', NULL, '1.1106.31.00', NULL, NULL, NULL, 5.7605, 0.0578),
    ('33', 'multa', 345, 2025, '2022-03-07', NULL, '1.0102.52.20', '2916.19.22', 286.92, 0.063, NULL, NULL),
    ('4314902', 'multa', 607, 2021, '2025-11-18', NULL, '1.2301.15.00', '0802.51.00', 189.38, 0.1632, NULL, NULL),
    ('21', 'multa', 1668, 2022, '2019-10-28', NULL, NULL, NULL, 230.99, 0.0315, NULL, NULL),
    ('1302603', 'if', 4700, 2023, '2021-08-19', NULL, NULL, NULL, NULL, NULL, 0.9363, 0.0609),
    ('3501905', 'multa', 2267, 2019, '2024-06-22', NULL, NULL, '3206.19.10', 118.35, 0.1933, NULL, NULL),
    ('29', 'if', 2861, 2025, '2020-06-11', NULL, '1.2405', '2404.92.00', NULL, NULL, 1.6424, 0.0591),
    ('4205407', 'multa', 626, 2015, '2023-10-23', NULL, NULL, '4012.20.00', 58.24, 0.0597, NULL, NULL),
    ('13', 'multa', 4439, 2020, '2024-09-06', NULL, NULL, NULL, 172.77, 0.2185, NULL, NULL),
    ('32', 'multa', 1069, 2017, '2021-05-30', NULL, NULL, NULL, 331.07, 0.2092, NULL, NULL),
    ('53', 'multa', 3030, 2020, '2024-01-02', NULL, '1.1501', NULL, 263.99, 0.2396, NULL, NULL),
    ('3205309', 'multa', 1864, 2025, '2026-03-29', NULL, NULL, NULL, 253.37, 0.0319, NULL, NULL),
    ('4308250', 'multa', 3564, 2017, '2015-11-29', NULL, NULL, NULL, 161.08, 0.0103, NULL, NULL),
    ('41', 'if', 3750, 2015, '2024-02-05', NULL, NULL, '8708.40.80', NULL, NULL, 79.5631, 0.0765),
    ('4208302', 'if', 3700, 2017, '2026-11-15', NULL, '1.21', NULL, NULL, NULL, 6.1145, 0.0612),
    ('53', 'if', 819, 2023, '2023-01-01', NULL, NULL, '7108.11.00', NULL, NULL, 4.7057, 0.0447),
    ('5300108', 'multa', 3955, 2020, '2021-02-24', NULL, '1.1902.90.00', NULL, 85.41, 0.0118, NULL, NULL),
    ('32', 'multa', 4811, 2020, '2026-12-30', NULL, NULL, NULL, 34.42, 0.1629, NULL, NULL),
    ('4205407', 'multa', 4986, 2022, '2015-07-17', '2015-11-22', '1.1706.23.00', '8415.10.11', 113.48, 0.1076, NULL, NULL),
    ('33', 'multa', 2150, 2018, '2023-07-23', NULL, NULL, NULL, 360.35, 0.058, NULL, NULL),
    ('31', 'if', 3974, 2020, '2025-02-03', NULL, '1.1510.00.00', NULL, NULL, NULL, 2.7363, 0.0564),
    ('3205309', 'multa', 417, 2020, '2026-12-16', NULL, '1.1102.90.00', '2916.20.14', 131.46, 0.1897, NULL, NULL),
    ('13', 'multa', 2612, 2019, '2024-10-17', NULL, '1.1806.90.00', '0304.48.00', 90.86, 0.2175, NULL, NULL),
    ('43', 'if', 1259, 2019, '2020-10-29', NULL, '1.0103.42.00', '0305.49.90', NULL, NULL, 4.9636, 0.0464),
    ('2919306', 'multa', 3004, 2022, '2015-07-27', NULL, '1.1409.1', '9002.11.11', 28.42, 0.1085, NULL, NULL),
    ('43', 'if', 2397, 2025, '2025-01-27', NULL, '1.1403.24.00', '7607.19.90', NULL, NULL, 1.121, 0.0013),
    ('32', 'multa', 3849, 2022, '2017-12-09', NULL, '1.0909', '5402.47.10', 96.22, 0.0465, NULL, NULL),
    ('43', 'if', 4899, 2017, '2015-10-02', NULL, '1.1401', NULL, NULL, NULL, 4.1012, 0.0148),
    ('3501905', 'if', 480, 2017, '2022-06-18', NULL, '1.1201.31.00', NULL, NULL, NULL, 2.4761, 0.0308),
    ('13', 'if', 2366, 2025, '2019-04-29', NULL, '1.1106', NULL, NULL, NULL, 1.3256, 0.0148),
    ('4208302', 'multa', 3303, 2019, '2019-09-11', NULL, NULL, '8438.50.00', 110.03, 0.1477, NULL, NULL),
    ('4314902', 'if', 3059, 2022, '2022-11-05', '2026-08-27', NULL, '7319.40.00', NULL, NULL, 1.1743, 0.0186),
    ('3550308', 'if', 3684, 2026, '2023-12-09', NULL, '1.1301', NULL, NULL, NULL, 3.4573, 0.0577),
    ('4308250', 'if', 701, 2026, '2019-08-25', NULL, '1.2001.81.00', '7222.19.10', NULL, NULL, 2.2465, 0.0274),
    ('53', 'if', 2892, 2017, '2023-12-01', NULL, NULL, '8424.30.90', NULL, NULL, 4.504, 0.0193),
    ('35', 'multa', 1231, 2022, '2017-08-26', NULL, NULL, NULL, 498.75, 0.1995, NULL, NULL),
    ('1302603', 'if', 3283, 2020, '2020-07-15', NULL, '1.0803.00.00', NULL, NULL, NULL, 7.5957, 0.0587),
    ('4314902', 'multa', 1936, 2016, '2026-09-08', NULL, '1.0905.30.00', '5210.39.00', 112.48, 0.217, NULL, NULL),
    ('3548906', 'if', 557, 2018, '2015-08-16', NULL, '1.1701.34.00', NULL, NULL, NULL, 5.5889, 0.0087),
    ('51', 'multa', 1537, 2020, '2017-08-24', NULL, '1.1106.36.20', '8711.10.00', 212.41, 0.1564, NULL, NULL),
    ('1302603', 'multa', 1843, 2020, '2025-08-31', NULL, NULL, NULL, 205.67, 0.1346, NULL, NULL),
    ('51', 'multa', 2694, 2022, '2026-09-09', NULL, '1.1105.30.00', NULL, 83.12, 0.2141, NULL, NULL),
    ('4208302', 'if', 314, 2021, '2020-05-25', '2021-10-02', '1.0605.90.00', '7321.89.00', NULL, NULL, 3.2635, 0.0204),
    ('24', 'if', 1353, 2016, '2020-09-13', NULL, NULL, NULL, NULL, NULL, 57.4829, 0.0758),
    ('4208302', 'multa', 4985, 2025, '2017-04-25', NULL, '1.0102.61.00', '4401.21.00', 134.58, 0.2011, NULL, NULL),
    ('28', 'multa', 4997, 2026, '2018-06-21', NULL, '1.0102.35', NULL, 177.28, 0.1737, NULL, NULL),
    ('1302603', 'if', 879, 2026, '2019-09-09', NULL, '1.1409.2', '3004.90.99', NULL, NULL, 0.9882, 0.0566),
    ('3505906', 'multa', 4760, 2021, '2017-07-19', NULL, NULL, NULL, 177.15, 0.2219, NULL, NULL),
    ('3505906', 'multa', 1005, 2017, '2019-12-08', NULL, '1.0903.12.00', NULL, 120.06, 0.1477, NULL, NULL),
    ('29', 'multa', 2671, 2023, '2025-07-06', NULL, NULL, NULL, 213.36, 0.1436, NULL, NULL),
    ('2927408', 'multa', 3869, 2015, '2023-05-22', NULL, NULL, NULL, 174.99, 0.2397, NULL, NULL),
    ('21', 'if', 411, 2019, '2020-04-05', NULL, NULL, NULL, NULL, NULL, 3.5652, 0.0044),
    ('53', 'multa', 1373, 2021, '2017-08-10', NULL, NULL, '1515.90.90', 45.3, 0.066, NULL, NULL),
    ('4208302', 'multa', 1337, 2018, '2017-01-19', '2022-01-07', '1.2003.21', '8419.81.90', 301.35, 0.0799, NULL, NULL),
    ('4208302', 'multa', 3149, 2018, '2026-03-09', NULL, '1.0502.24.10', NULL, 254.94, 0.0991, NULL, NULL),
    ('3505906', 'multa', 2171, 2025, '2015-02-17', NULL, '1.0105.90.00', '2933.91.43', 302.81, 0.2158, NULL, NULL),
    ('2919306', 'if', 4000, 2023, '2020-01-01', NULL, '1.1102.10.00', '1302.31.00', NULL, NULL, 1.9539, 0.0543),
    ('33', 'if', 115, 2023, '2020-12-11', NULL, NULL, NULL, NULL, NULL, 1.1312, 0.0287),
    ('31', 'multa', 3061, 2017, '2022-09-26', NULL, '1.0106', NULL, 167.11, 0.0537, NULL, NULL),
    ('4208302', 'multa', 3091, 2023, '2026-09-04', NULL, '1.0904.35.00', '8543.70.39', 128.76, 0.1388, NULL, NULL),
    ('4208302', 'multa', 3316, 2015, '2019-08-10', '2022-09-30', NULL, NULL, 146.85, 0.1809, NULL, NULL),
    ('3548906', 'if', 3309, 2016, '2017-08-01', NULL, '1.1405.1', '3506.10.90', NULL, NULL, 3.0516, 0.0292),
    ('13', 'multa', 2523, 2022, '2020-06-13', NULL, '1.1703.31.00', NULL, 93.06, 0.2347, NULL, NULL),
    ('2919306', 'multa', 2568, 2018, '2016-01-07', NULL, '1.0901.51.16', '6911.10.10', 111.41, 0.095, NULL, NULL),
    ('3304557', 'multa', 1692, 2024, '2020-06-20', NULL, NULL, '2941.90.81', 49.62, 0.0957, NULL, NULL),
    ('31', 'if', 716, 2016, '2018-06-05', NULL, NULL, NULL, NULL, NULL, 1.4609, 0.0175),
    ('3205309', 'if', 1568, 2016, '2025-11-11', NULL, '1.1401.12.00', NULL, NULL, NULL, 43.5498, 0.0338),
    ('2927408', 'if', 3727, 2018, '2026-10-26', NULL, NULL, '8501.53.20', NULL, NULL, 5.071, 0.0025),
    ('33', 'if', 4485, 2021, '2019-12-03', NULL, '1.0402.12.00', NULL, NULL, NULL, 1.8191, 0.0434),
    ('53', 'if', 302, 2016, '2022-10-18', NULL, '1.1401.12.00', '8407.33.10', NULL, NULL, 6.3185, 0.0389),
    ('35', 'multa', 385, 2022, '2025-07-18', NULL, NULL, '2933.69.1', 158.19, 0.2349, NULL, NULL),
    ('3304557', 'if', 4823, 2025, '2020-09-04', NULL, NULL, '1515.90.10', NULL, NULL, 3.3166, 0.0555),
    ('3306305', 'multa', 2101, 2020, '2020-09-28', NULL, NULL, '6505.00.31', 438.52, 0.033, NULL, NULL),
    ('3106200', 'if', 1637, 2015, '2018-09-05', NULL, '1.0608', '2916.39.30', NULL, NULL, 4.884, 0.028),
    ('21', 'if', 2685, 2017, '2021-09-11', NULL, NULL, NULL, NULL, NULL, 31.0527, 0.0648),
    ('3501905', 'if', 3166, 2019, '2023-01-01', NULL, '1.2203', '2909.50.1', NULL, NULL, 4.7103, 0.0052),
    ('3306305', 'multa', 3915, 2017, '2025-12-03', NULL, '1.0903.31.00', '2920.90.41', 143.4, 0.1095, NULL, NULL),
    ('3304557', 'if', 1732, 2016, '2016-03-30', NULL, '1.1103.22.00', '5405.00.00', NULL, NULL, 10.5589, 0.0273),
    ('51', 'if', 558, 2015, '2017-08-12', NULL, NULL, '3002.12.12', NULL, NULL, 2.0629, 0.0306),
    ('32', 'if', 2568, 2019, '2022-11-19', NULL, NULL, NULL, NULL, NULL, 0.7445, 0.013),
    ('3205309', 'if', 4676, 2015, '2019-10-07', NULL, NULL, NULL, NULL, NULL, 12.4064, 0.0232),
    ('3306305', 'multa', 4078, 2017, '2015-01-16', NULL, '1.0106.1', '7324.29.00', 486.01, 0.1339, NULL, NULL),
    ('3306305', 'multa', 1159, 2025, '2025-09-04', NULL, '1.1801.1', NULL, 74.89, 0.0725, NULL, NULL),
    ('3306305', 'if', 2768, 2018, '2025-05-21', NULL, NULL, NULL, NULL, NULL, 1.2593, 0.0194),
    ('4106902', 'if', 3448, 2019, '2021-10-05', NULL, NULL, NULL, NULL, NULL, 15.3122, 0.0348),
    ('4308250', 'if', 3222, 2026, '2015-11-07', NULL, '1.2101.2', '2710.12.10', NULL, NULL, 3.5633, 0.0692),
    ('33', 'multa', 3432, 2018, '2024-03-16', NULL, NULL, '3402.39.20', 158.18, 0.054, NULL, NULL),
    ('3505906', 'if', 3220, 2025, '2025-06-22', NULL, '1.0403.12.00', '3808.62.10', NULL, NULL, 3.2127, 0.0652),
    ('2919306', 'multa', 2651, 2018, '2022-03-02', '2025-01-25', NULL, '8415.10.1', 256.04, 0.0282, NULL, NULL),
    ('4106902', 'if', 1372, 2015, '2016-09-14', NULL, NULL, '3812.39.1', NULL, NULL, 43.7062, 0.037),
    ('42', 'if', 2237, 2019, '2020-11-10', NULL, '1.0502.29.00', NULL, NULL, NULL, 4.2732, 0.0651),
    ('5300108', 'if', 1912, 2015, '2021-09-03', NULL, NULL, NULL, NULL, NULL, 1.5965, 0.0263),
    ('28', 'multa', 1088, 2021, '2022-07-20', NULL, NULL, '8507.10.90', 134.09, 0.1968, NULL, NULL),
    ('24', 'if', 2992, 2017, '2022-04-25', NULL, NULL, '2708.20.00', NULL, NULL, 7.5619, 0.0439),
    ('3550308', 'multa', 3084, 2025, '2025-05-05', NULL, '1.0901.51.16', NULL, 22.37, 0.1613, NULL, NULL),
    ('3146206', 'if', 1337, 2015, '2025-11-01', NULL, NULL, '8711.60.00', NULL, NULL, 346.8039, 0.0409),
    ('3146206', 'multa', 3309, 2018, '2020-08-24', NULL, NULL, NULL, 1005.0, 0.0926, NULL, NULL),
    ('2919306', 'multa', 2630, 2018, '2025-06-19', NULL, NULL, NULL, 56.17, 0.2176, NULL, NULL),
    ('1302603', 'if', 3831, 2025, '2023-08-05', NULL, '1.2403.3', NULL, NULL, NULL, 2.0897, 0.0093),
    ('1302603', 'multa', 3055, 2024, '2017-02-20', NULL, NULL, NULL, 493.32, 0.2052, NULL, NULL),
    ('29', 'multa', 3465, 2026, '2023-10-14', NULL, '1.1806', '9102.21.00', 100.79, 0.0936, NULL, NULL),
    ('13', 'if', 1205, 2016, '2022-06-05', NULL, NULL, NULL, NULL, NULL, 2.3639, 0.0465),
    ('4106902', 'if', 1196, 2023, '2019-04-17', NULL, '1.0903', '8452.90.89', NULL, NULL, 4.2458, 0.0314),
    ('3146107', 'if', 4201, 2023, '2020-08-04', '2027-03-15', '1.1806.39.00', NULL, NULL, NULL, 83.6295, 0.0268),
    ('24', 'if', 3073, 2024, '2021-03-05', NULL, '1.0303.20.00', '8214.10.00', NULL, NULL, 10.5319, 0.0222),
    ('2927408', 'multa', 1980, 2026, '2017-07-27', NULL, '1.1805.2', NULL, 141.86, 0.217, NULL, NULL),
    ('26', 'multa', 4403, 2022, '2016-01-11', NULL, '1.1703.99.00', NULL, 215.07, 0.0426, NULL, NULL),
    ('24', 'if', 4620, 2020, '2023-02-10', NULL, '1.0906.11.00', NULL, NULL, NULL, 7.5832, 0.0233),
    ('3306305', 'if', 810, 2015, '2026-09-08', NULL, NULL, '2930.90.37', NULL, NULL, 3.8055, 0.0172),
    ('3505906', 'if', 2850, 2021, '2015-04-05', NULL, NULL, '8505.20.90', NULL, NULL, 4.4745, 0.048),
    ('4205407', 'multa', 2092, 2020, '2024-12-11', NULL, '1.1806.62.00', NULL, 857.11, 0.0384, NULL, NULL),
    ('26', 'multa', 3189, 2024, '2020-03-12', NULL, '1.2003.24.00', '8462.32.00', 65.5, 0.0707, NULL, NULL),
    ('4106902', 'multa', 3552, 2023, '2022-10-18', NULL, '1.1401.11.00', NULL, 125.85, 0.1089, NULL, NULL),
    ('3550308', 'multa', 1192, 2016, '2024-03-08', NULL, NULL, NULL, 137.5, 0.014, NULL, NULL),
    ('41', 'multa', 4789, 2017, '2026-02-22', '2032-07-10', NULL, NULL, 64.08, 0.1151, NULL, NULL),
    ('3146206', 'if', 4514, 2020, '2016-03-11', NULL, '1.1703.32.00', '3808.92.19', NULL, NULL, 75.1022, 0.002),
    ('31', 'if', 1744, 2022, '2025-05-25', '2031-06-06', '1.0502.24.30', '8471.70.90', NULL, NULL, 3.1169, 0.0681),
    ('3106200', 'if', 3825, 2022, '2021-09-11', NULL, '1.2001.35.00', NULL, NULL, NULL, 1.2974, 0.0707),
    ('28', 'multa', 1640, 2020, '2022-01-06', NULL, NULL, NULL, 252.68, 0.2321, NULL, NULL),
    ('3205309', 'multa', 2923, 2025, '2021-06-18', NULL, '1.1001', '9504.40.00', 211.4, 0.1042, NULL, NULL),
    ('31', 'multa', 4833, 2022, '2019-01-02', NULL, '1.0102.12.00', '3916.10.00', 109.63, 0.1101, NULL, NULL),
    ('3550308', 'multa', 3271, 2023, '2022-02-22', NULL, NULL, '2614.00.10', 59.88, 0.0342, NULL, NULL),
    ('35', 'multa', 2721, 2017, '2024-01-26', '2028-10-01', '1.1901.10.00', NULL, 195.92, 0.0167, NULL, NULL),
    ('35', 'if', 2569, 2026, '2017-10-28', '2018-09-16', NULL, '8429.51.1', NULL, NULL, 8.7091, 0.0028),
    ('3548906', 'multa', 1966, 2020, '2015-01-14', NULL, '1.2003.29.00', NULL, 679.26, 0.0597, NULL, NULL),
    ('4308250', 'if', 1767, 2020, '2016-02-23', NULL, NULL, '3002.12.22', NULL, NULL, 9.0382, 0.0192),
    ('31', 'multa', 506, 2025, '2023-01-01', NULL, NULL, '8541.41.2', 477.58, 0.0976, NULL, NULL),
    ('1302603', 'if', 3898, 2015, '2018-08-20', NULL, NULL, '8418.91.00', NULL, NULL, 9.6575, 0.0354),
    ('26', 'multa', 3648, 2019, '2024-05-28', NULL, '1.2402.10.00', NULL, 203.07, 0.0757, NULL, NULL),
    ('3304557', 'multa', 2272, 2018, '2026-05-30', NULL, NULL, NULL, 334.92, 0.1741, NULL, NULL),
    ('3505906', 'if', 75, 2021, '2016-11-15', NULL, '1.0502.31.10', NULL, NULL, NULL, 6.3806, 0.0383),
    ('29', 'if', 3344, 2022, '2018-09-01', NULL, '1.1401.21.00', '7321.90.00', NULL, NULL, 3.6184, 0.0045),
    ('3205309', 'if', 844, 2023, '2024-06-16', NULL, '1.2501.1', '3806.10.00', NULL, NULL, 0.6249, 0.0249),
    ('51', 'if', 2453, 2019, '2019-07-10', '2025-01-16', '1.0502.24', NULL, NULL, NULL, 2.7468, 0.0572),
    ('3548906', 'multa', 1444, 2021, '2025-01-02', NULL, NULL, '7210.69.19', 142.29, 0.159, NULL, NULL),
    ('35', 'multa', 4218, 2015, '2015-01-27', '2019-04-01', NULL, NULL, 352.06, 0.2204, NULL, NULL),
    ('3304557', 'multa', 1668, 2017, '2017-11-16', NULL, NULL, NULL, 121.83, 0.1116, NULL, NULL),
    ('3146107', 'multa', 2674, 2026, '2017-08-20', NULL, NULL, NULL, 133.05, 0.0589, NULL, NULL),
    ('4106902', 'multa', 2637, 2023, '2022-04-24', '2024-09-16', '1.0102.41.90', NULL, 387.15, 0.1106, NULL, NULL),
    ('3146107', 'multa', 1223, 2021, '2018-04-02', NULL, NULL, NULL, 64.58, 0.204, NULL, NULL),
    ('1302603', 'if', 1734, 2017, '2022-09-08', NULL, '1.2003.29.00', NULL, NULL, NULL, 5.9662, 0.009),
    ('3205309', 'if', 3023, 2020, '2026-09-17', NULL, NULL, NULL, NULL, NULL, 0.8137, 0.04),
    ('3146206', 'multa', 2511, 2026, '2025-08-24', '2030-07-05', '1.2403.31.00', '9030.20.29', 345.62, 0.1923, NULL, NULL),
    ('21', 'multa', 3650, 2019, '2022-02-24', NULL, NULL, '1513.29.19', 207.51, 0.0151, NULL, NULL),
    ('51', 'multa', 706, 2024, '2020-01-25', NULL, '1.2501.1', NULL, 181.57, 0.0748, NULL, NULL),
    ('4308250', 'multa', 1796, 2024, '2019-03-20', NULL, '1.1805.50.00', NULL, 94.94, 0.2255, NULL, NULL),
    ('3146206', 'multa', 1528, 2020, '2015-03-08', NULL, NULL, NULL, 83.22, 0.2011, NULL, NULL),
    ('26', 'multa', 4580, 2017, '2023-11-06', NULL, '1.0701.00.00', NULL, 202.41, 0.0309, NULL, NULL),
    ('51', 'multa', 356, 2021, '2021-10-25', '2025-05-10', NULL, NULL, 254.57, 0.185, NULL, NULL),
    ('2927408', 'multa', 4812, 2016, '2016-08-06', '2020-07-19', NULL, NULL, 50.27, 0.0355, NULL, NULL),
    ('3146206', 'if', 2684, 2026, '2018-04-21', NULL, '1.0502.14.20', '5111.30.10', NULL, NULL, 17.151, 0.0766),
    ('3146107', 'if', 1496, 2021, '2017-08-15', NULL, '1.1105.42.00', NULL, NULL, NULL, 3.06, 0.0792),
    ('3146206', 'multa', 513, 2015, '2023-11-16', '2030-06-15', '1.2507.10.00', NULL, 470.37, 0.0318, NULL, NULL),
    ('4208302', 'if', 507, 2022, '2021-10-02', NULL, NULL, '1702.19.00', NULL, NULL, 3.7899, 0.006),
    ('4308250', 'multa', 1035, 2021, '2025-08-13', '2026-11-28', NULL, '8541.10.1', 234.12, 0.2045, NULL, NULL),
    ('33', 'multa', 1565, 2019, '2022-07-15', NULL, NULL, NULL, 154.03, 0.1725, NULL, NULL),
    ('4208302', 'multa', 2858, 2021, '2024-03-17', NULL, '1.1401.39.00', NULL, 198.39, 0.0155, NULL, NULL),
    ('3501905', 'if', 3009, 2026, '2025-01-20', '2026-09-22', NULL, '2930.90.13', NULL, NULL, 20.3414, 0.035),
    ('32', 'multa', 4441, 2026, '2020-07-04', NULL, '1.1401.1', '2915.70.40', 74.93, 0.0802, NULL, NULL),
    ('41', 'multa', 1017, 2018, '2018-12-04', NULL, '1.0501.14', '2929.90.60', 67.68, 0.0608, NULL, NULL),
    ('32', 'multa', 3208, 2025, '2023-11-27', '2030-06-26', '1.1405.12.00', NULL, 484.03, 0.1907, NULL, NULL),
    ('51', 'if', 1549, 2015, '2019-11-04', NULL, NULL, '0307.49.00', NULL, NULL, 7.1432, 0.0062),
    ('53', 'multa', 2380, 2020, '2023-10-29', '2024-09-07', '1.0901.32.00', '5606.00.00', 220.48, 0.1682, NULL, NULL),
    ('2919306', 'multa', 1865, 2016, '2023-05-03', NULL, '1.1106.43.00', '8532.30.90', 253.17, 0.224, NULL, NULL),
    ('4308250', 'multa', 1491, 2020, '2023-10-03', NULL, '1.2003.10.00', NULL, 239.95, 0.1981, NULL, NULL),
    ('4208302', 'multa', 52, 2024, '2026-02-23', NULL, '1.0608.90.00', NULL, 64.55, 0.1176, NULL, NULL),
    ('4308250', 'multa', 4231, 2023, '2020-10-02', NULL, NULL, '2710.19.99', 208.59, 0.164, NULL, NULL),
    ('5300108', 'multa', 3178, 2022, '2019-06-22', NULL, NULL, '5901.90.00', 96.26, 0.2286, NULL, NULL),
    ('21', 'multa', 2421, 2021, '2021-02-28', NULL, NULL, NULL, 101.17, 0.066, NULL, NULL),
    ('42', 'if', 1632, 2017, '2025-09-26', NULL, NULL, NULL, NULL, NULL, 291.1617, 0.0658),
    ('2927408', 'multa', 4179, 2025, '2025-06-15', '2029-04-16', '1.0403.23.00', '4102.21.00', 314.98, 0.0823, NULL, NULL),
    ('3205309', 'multa', 1623, 2021, '2017-03-18', '2020-01-05', '1.1801.2', NULL, 295.15, 0.0206, NULL, NULL),
    ('3304557', 'multa', 3176, 2017, '2017-02-19', NULL, NULL, '5604.90.90', 4036.9, 0.0243, NULL, NULL),
    ('53', 'if', 4697, 2021, '2024-04-15', NULL, '1.0502.24.20', NULL, NULL, NULL, 3.0784, 0.0528),
    ('42', 'multa', 334, 2015, '2017-02-05', NULL, '1.1404.2', '2919.90.50', 79.81, 0.1467, NULL, NULL),
    ('29', 'if', 643, 2016, '2023-10-26', '2026-01-06', NULL, NULL, NULL, NULL, 2.716, 0.0264),
    ('35', 'multa', 2554, 2020, '2021-10-22', NULL, NULL, '8534.00.39', 213.98, 0.0667, NULL, NULL),
    ('3205309', 'if', 871, 2017, '2022-12-02', NULL, '1.1506.22.00', '2933.91.8', NULL, NULL, 6.9254, 0.0702),
    ('41', 'if', 4192, 2023, '2019-05-14', '2024-12-20', '1.2405.90.00', NULL, NULL, NULL, 2.5498, 0.0413),
    ('4314902', 'if', 4609, 2024, '2024-04-27', NULL, NULL, NULL, NULL, NULL, 3.4604, 0.0714),
    ('4308250', 'multa', 4603, 2021, '2020-02-12', NULL, NULL, NULL, 123.93, 0.1193, NULL, NULL),
    ('4106902', 'multa', 4924, 2024, '2017-10-28', NULL, '1.1107.31.00', NULL, 247.52, 0.0134, NULL, NULL),
    ('2919306', 'if', 1551, 2016, '2018-07-09', NULL, NULL, NULL, NULL, NULL, 0.7289, 0.057),
    ('4106902', 'if', 2948, 2016, '2016-04-15', NULL, '1.1703.22.00', NULL, NULL, NULL, 3.8068, 0.007),
    ('4308250', 'if', 3797, 2024, '2023-06-03', NULL, '1.0702.00.00', '8545.11.00', NULL, NULL, 8.5704, 0.0247),
    ('3205309', 'if', 2630, 2022, '2018-05-30', '2022-01-01', NULL, '9031.49.90', NULL, NULL, 3.4566, 0.0257),
    ('21', 'if', 4221, 2021, '2019-05-11', NULL, NULL, '6111.20.00', NULL, NULL, 19.4685, 0.0182),
    ('3550308', 'if', 2952, 2021, '2020-04-18', NULL, NULL, NULL, NULL, NULL, 2.0271, 0.0019),
    ('3548906', 'if', 3308, 2025, '2015-03-26', NULL, '1.0401.11.11', '9507.10.00', NULL, NULL, 10.8382, 0.0329),
    ('3205309', 'multa', 4175, 2016, '2026-01-17', NULL, '1.0404.10.00', NULL, 121.27, 0.0498, NULL, NULL),
    ('13', 'multa', 4105, 2019, '2026-10-11', '2029-08-08', NULL, NULL, 199.4, 0.1002, NULL, NULL),
    ('3304557', 'if', 1224, 2015, '2018-09-24', NULL, '1.0506.00.00', NULL, NULL, NULL, 76.9447, 0.0121),
    ('24', 'if', 667, 2022, '2023-04-06', NULL, NULL, NULL, NULL, NULL, 104.0294, 0.0103),
    ('3505906', 'multa', 2452, 2026, '2025-09-11', NULL, '1.0905.40.00', NULL, 434.42, 0.0989, NULL, NULL),
    ('35', 'if', 2555, 2021, '2021-04-16', NULL, '1.0606.1', NULL, NULL, NULL, 3.6427, 0.0798),
    ('2919306', 'multa', 3935, 2016, '2019-11-12', NULL, NULL, NULL, 26.91, 0.1015, NULL, NULL),
    ('29', 'if', 171, 2023, '2017-03-21', '2020-10-13', NULL, '8443.32.59', NULL, NULL, 1.078, 0.0154),
    ('43', 'if', 1723, 2025, '2018-11-02', '2019-07-04', NULL, '3005.90.12', NULL, NULL, 3.2265, 0.0406),
    ('3205309', 'multa', 2896, 2016, '2021-05-29', NULL, NULL, NULL, 140.83, 0.0437, NULL, NULL),
    ('3106200', 'if', 606, 2018, '2023-04-15', NULL, '1.2502.30.00', '7410.11.90', NULL, NULL, 5.867, 0.03),
    ('3501905', 'multa', 1638, 2016, '2019-01-12', NULL, NULL, '0307.11.00', 470.55, 0.1938, NULL, NULL),
    ('3548906', 'multa', 1091, 2025, '2026-05-09', NULL, NULL, NULL, 116.07, 0.1516, NULL, NULL),
    ('24', 'multa', 1217, 2022, '2017-10-24', NULL, NULL, '1905.90.20', 95.25, 0.1557, NULL, NULL),
    ('33', 'multa', 4658, 2015, '2026-09-09', NULL, '1.1110.00.00', NULL, 291.61, 0.1487, NULL, NULL),
    ('29', 'multa', 1265, 2018, '2015-04-19', '2020-07-23', NULL, '4802.69.91', 100.93, 0.0759, NULL, NULL),
    ('51', 'multa', 4834, 2026, '2019-06-07', NULL, '1.1411.00.00', NULL, 172.16, 0.1462, NULL, NULL),
    ('35', 'if', 2527, 2024, '2025-06-29', NULL, NULL, '8541.21.91', NULL, NULL, 1.1739, 0.031),
    ('4208302', 'if', 3931, 2024, '2017-09-05', NULL, NULL, '2933.99.33', NULL, NULL, 1.0695, 0.0164),
    ('3205309', 'multa', 242, 2026, '2026-09-20', NULL, '1.0904.35.00', NULL, 1401.43, 0.1143, NULL, NULL),
    ('31', 'if', 1853, 2023, '2025-05-22', NULL, '1.1302', NULL, NULL, NULL, 8.8402, 0.0725),
    ('26', 'multa', 858, 2016, '2015-04-22', NULL, NULL, NULL, 281.28, 0.1496, NULL, NULL),
    ('41', 'multa', 4814, 2019, '2015-05-17', NULL, NULL, '3502.20.00', 97.02, 0.055, NULL, NULL),
    ('13', 'if', 3081, 2020, '2018-11-04', NULL, '1.0910.20.00', NULL, NULL, NULL, 0.7521, 0.0134),
    ('51', 'if', 4911, 2019, '2017-06-12', NULL, '1.1001.12', '3506.10.10', NULL, NULL, 3.0179, 0.0447),
    ('4208302', 'if', 1172, 2020, '2026-08-18', NULL, NULL, NULL, NULL, NULL, 7.7816, 0.01),
    ('42', 'multa', 405, 2026, '2018-06-18', NULL, '1.2405.12.00', NULL, 291.12, 0.0163, NULL, NULL),
    ('53', 'if', 4186, 2016, '2016-09-02', '2020-11-13', NULL, NULL, NULL, NULL, 60.4776, 0.067),
    ('32', 'multa', 2006, 2021, '2016-12-31', NULL, '1.1104.10.00', '2922.49.3', 140.17, 0.0285, NULL, NULL),
    ('31', 'multa', 1184, 2018, '2026-01-31', NULL, NULL, '4820.20.00', 155.93, 0.1547, NULL, NULL),
    ('3306305', 'if', 3119, 2025, '2024-11-04', NULL, NULL, NULL, NULL, NULL, 5.5497, 0.0177),
    ('13', 'if', 2196, 2015, '2025-01-04', NULL, NULL, NULL, NULL, NULL, 91.0433, 0.0382),
    ('4106902', 'multa', 3360, 2018, '2022-02-20', NULL, NULL, '3003.20.95', 303.51, 0.2402, NULL, NULL),
    ('3146206', 'if', 4263, 2023, '2022-07-20', NULL, '1.1806', '2919.90.20', NULL, NULL, 3.0132, 0.0754),
    ('3146206', 'multa', 824, 2018, '2026-03-08', NULL, NULL, '3904.10.90', 551.44, 0.0533, NULL, NULL),
    ('4208302', 'multa', 3512, 2016, '2026-11-25', NULL, '1.2204.10.00', '8416.10.00', 132.2, 0.0113, NULL, NULL),
    ('33', 'multa', 2328, 2020, '2025-07-14', NULL, NULL, NULL, 306.6, 0.0171, NULL, NULL),
    ('42', 'multa', 4326, 2024, '2020-04-21', NULL, '1.1403.29.00', '6004.10.92', 219.44, 0.173, NULL, NULL),
    ('1302603', 'if', 4563, 2019, '2021-01-24', NULL, NULL, NULL, NULL, NULL, 6.6447, 0.0139),
    ('2919306', 'multa', 221, 2026, '2020-09-15', NULL, '1.1703.10.00', '4009.32.10', 267.29, 0.2115, NULL, NULL),
    ('3548906', 'if', 2556, 2016, '2024-03-21', '2024-07-12', NULL, '2707.99.90', NULL, NULL, 3.1572, 0.0467),
    ('3205309', 'if', 253, 2026, '2018-11-07', NULL, NULL, '3812.39.19', NULL, NULL, 1.1598, 0.0046),
    ('24', 'multa', 2216, 2016, '2020-07-20', '2026-06-27', NULL, NULL, 70.44, 0.082, NULL, NULL),
    ('5300108', 'multa', 3260, 2022, '2020-07-08', NULL, NULL, '2915.39.41', 194.89, 0.2161, NULL, NULL),
    ('4208302', 'multa', 386, 2015, '2020-03-05', NULL, '1.2201.20.00', NULL, 99.02, 0.2401, NULL, NULL),
    ('3505906', 'if', 4765, 2018, '2018-02-03', NULL, '1.0908.00.00', NULL, NULL, NULL, 14.39, 0.0793),
    ('24', 'if', 1026, 2023, '2021-09-19', '2026-08-26', '1.0901.33.00', NULL, NULL, NULL, 1.2141, 0.0449),
    ('1302603', 'if', 770, 2019, '2024-01-13', '2028-03-08', '1.1403.22.1', NULL, NULL, NULL, 2.2627, 0.0151),
    ('1302603', 'multa', 1475, 2018, '2024-07-26', NULL, NULL, NULL, 328.55, 0.0146, NULL, NULL),
    ('31', 'if', 1787, 2022, '2018-08-18', NULL, '1.0501.12.10', NULL, NULL, NULL, 0.7949, 0.0621),
    ('35', 'if', 3571, 2026, '2018-03-29', NULL, '1.1806.63.00', NULL, NULL, NULL, 1.5459, 0.0148),
    ('4205407', 'if', 4548, 2026, '2017-09-21', NULL, '1.2205.1', '3006.50.00', NULL, NULL, 3.3276, 0.0563),
    ('42', 'multa', 4167, 2026, '2026-01-12', NULL, '1.0106.1', NULL, 208.24, 0.0322, NULL, NULL),
    ('2919306', 'if', 3212, 2018, '2026-07-05', NULL, NULL, '0713.50.10', NULL, NULL, 2.0004, 0.072),
    ('24', 'multa', 1841, 2018, '2026-01-22', NULL, '1.06', '0502.90.10', 88.89, 0.1365, NULL, NULL),
    ('32', 'if', 201, 2019, '2020-07-09', NULL, NULL, '4106.32.00', NULL, NULL, 66.4784, 0.0469),
    ('4308250', 'if', 3810, 2016, '2022-08-22', NULL, '1.0901.34.00', NULL, NULL, NULL, 2.5723, 0.0385),
    ('2919306', 'if', 3353, 2018, '2017-10-01', NULL, '1.0402.22.00', NULL, NULL, NULL, 36.3336, 0.0729),
    ('3304557', 'if', 368, 2024, '2026-07-05', '2026-09-10', '1.0602.23.00', '2933.39.49', NULL, NULL, 1.0261, 0.0779),
    ('53', 'multa', 1793, 2024, '2015-05-23', '2019-05-09', '1.1409.29.00', NULL, 1888.48, 0.1203, NULL, NULL),
    ('4208302', 'if', 1280, 2020, '2021-05-27', NULL, NULL, NULL, NULL, NULL, 0.3987, 0.0485),
    ('32', 'multa', 1117, 2018, '2021-02-05', NULL, '1.0103.10.00', NULL, 16.97, 0.1509, NULL, NULL),
    ('41', 'multa', 664, 2015, '2024-01-28', NULL, '1.1102.10.00', NULL, 104.16, 0.1737, NULL, NULL),
    ('4314902', 'multa', 3377, 2018, '2022-06-15', NULL, '1.0402.21.90', '5509.53.00', 268.78, 0.1376, NULL, NULL),
    ('3146206', 'multa', 2706, 2020, '2017-04-30', NULL, '1.1403.90.00', NULL, 62.51, 0.0837, NULL, NULL),
    ('3548906', 'multa', 698, 2021, '2017-07-03', '2021-07-29', NULL, '2831.90.90', 122.69, 0.2202, NULL, NULL),
    ('5300108', 'if', 4941, 2022, '2025-11-26', '2026-08-08', '1.1502.20.00', '6704.20.00', NULL, NULL, 1.7418, 0.0268),
    ('43', 'multa', 1725, 2016, '2021-12-23', NULL, '1.0901.5', '2710.19.11', 66.26, 0.0287, NULL, NULL),
    ('2919306', 'if', 1588, 2026, '2017-12-24', NULL, '1.2402.10.00', '7202.49.00', NULL, NULL, 17.4364, 0.0431),
    ('4308250', 'multa', 4327, 2019, '2025-05-26', NULL, NULL, NULL, 105.94, 0.0607, NULL, NULL),
    ('33', 'if', 1975, 2023, '2022-04-02', NULL, NULL, '3003.10.11', NULL, NULL, 0.7165, 0.0254),
    ('3146107', 'multa', 877, 2024, '2019-09-12', '2022-08-06', NULL, NULL, 308.11, 0.1095, NULL, NULL),
    ('26', 'multa', 4319, 2023, '2016-10-14', NULL, NULL, '2806.10.20', 3427.75, 0.1876, NULL, NULL),
    ('4106902', 'if', 2288, 2017, '2024-09-12', '2031-03-06', '1.0503.24.00', '4407.29.90', NULL, NULL, 2.8065, 0.0778),
    ('3205309', 'if', 3254, 2021, '2015-08-15', '2021-02-06', '1.0604.22.00', NULL, NULL, NULL, 1.9344, 0.0656),
    ('21', 'multa', 3895, 2022, '2024-04-13', NULL, '1.0901.51.23', '0301.94.10', 169.49, 0.1053, NULL, NULL),
    ('1302603', 'multa', 2139, 2018, '2025-02-27', '2029-07-28', '1.0403.1', NULL, 505.56, 0.2416, NULL, NULL),
    ('32', 'if', 1731, 2018, '2024-07-24', NULL, '1.0403.12.00', NULL, NULL, NULL, 3.3295, 0.0171),
    ('3501905', 'multa', 2202, 2015, '2024-12-17', NULL, '1.0102.61.00', NULL, 162.19, 0.035, NULL, NULL),
    ('42', 'multa', 2506, 2026, '2018-01-21', '2019-02-11', NULL, NULL, 118.81, 0.2344, NULL, NULL),
    ('26', 'if', 2467, 2022, '2015-10-02', NULL, '1.2501.2', '6112.11.00', NULL, NULL, 3.2816, 0.0492),
    ('3501905', 'if', 3180, 2025, '2016-09-07', NULL, '1.1403.29.00', '8451.40.2', NULL, NULL, 4.0898, 0.0755),
    ('3146107', 'if', 4639, 2018, '2016-10-12', '2021-07-08', NULL, '8514.90.00', NULL, NULL, 1.7845, 0.0257),
    ('41', 'if', 4999, 2024, '2019-10-25', NULL, NULL, '9025.11.1', NULL, NULL, 10.6901, 0.0376),
    ('3146107', 'multa', 4494, 2018, '2016-12-21', '2018-08-24', '1.1701.34.00', '1507.90.19', 393.39, 0.22, NULL, NULL),
    ('4205407', 'if', 30, 2020, '2021-03-29', NULL, '1.0202.00.00', '7207.19.00', NULL, NULL, 4.149, 0.0757),
    ('32', 'if', 3242, 2022, '2024-01-31', NULL, NULL, '3701.20.10', NULL, NULL, 0.3085, 0.0167),
    ('4106902', 'if', 4071, 2018, '2016-11-05', NULL, '1.1805.11.00', NULL, NULL, NULL, 1.9154, 0.0583),
    ('13', 'if', 4305, 2024, '2023-08-05', NULL, '1.0402.23.00', NULL, NULL, NULL, 67.3285, 0.0306),
    ('4205407', 'if', 2926, 2016, '2019-08-28', NULL, NULL, NULL, NULL, NULL, 1.587, 0.0418),
    ('3304557', 'if', 2472, 2026, '2021-05-27', NULL, NULL, '8445.40.11', NULL, NULL, 3.2798, 0.0737),
    ('32', 'if', 883, 2017, '2024-09-16', NULL, '1.1401', '9007.20.90', NULL, NULL, 7.209, 0.0341),
    ('4205407', 'if', 2823, 2022, '2018-03-20', NULL, '1.0502.23', '5804.10.90', NULL, NULL, 117.8658, 0.0358),
    ('21', 'multa', 368, 2026, '2022-05-16', NULL, '1.0502.21', NULL, 89.99, 0.1218, NULL, NULL),
    ('3304557', 'if', 3241, 2020, '2018-07-07', NULL, '1.1401.2', '2916.13.10', NULL, NULL, 6.3929, 0.0153),
    ('4308250', 'multa', 2089, 2019, '2026-11-03', NULL, NULL, NULL, 67.05, 0.155, NULL, NULL),
    ('3106200', 'if', 2633, 2022, '2021-10-19', '2026-04-23', '1.0501.24.2', '8465.96.00', NULL, NULL, 1.3188, 0.01),
    ('32', 'multa', 2415, 2017, '2023-03-12', '2029-06-10', '1.0904', NULL, 114.19, 0.1092, NULL, NULL),
    ('2919306', 'multa', 692, 2020, '2022-02-14', NULL, '1.1409.22.00', NULL, 1017.95, 0.1941, NULL, NULL),
    ('13', 'multa', 4445, 2017, '2018-06-01', NULL, '1.1106.3', NULL, 119.15, 0.0134, NULL, NULL),
    ('13', 'multa', 1759, 2024, '2019-11-25', '2020-07-20', NULL, NULL, 100.42, 0.182, NULL, NULL),
    ('53', 'if', 3875, 2023, '2017-06-28', NULL, NULL, NULL, NULL, NULL, 61.9229, 0.0092),
    ('2919306', 'multa', 835, 2022, '2022-04-10', NULL, '1.1105.20.00', '3907.29.12', 946.78, 0.0297, NULL, NULL),
    ('3146206', 'if', 3589, 2021, '2019-06-09', NULL, '1.0910', NULL, NULL, NULL, 3.646, 0.0668),
    ('33', 'multa', 3987, 2021, '2016-11-30', NULL, '1.1107.3', NULL, 112.22, 0.0496, NULL, NULL),
    ('13', 'if', 3945, 2016, '2017-02-13', NULL, NULL, NULL, NULL, NULL, 3.3795, 0.0533),
    ('28', 'if', 1908, 2018, '2020-08-31', NULL, '1.0106.32.00', '6101.20.00', NULL, NULL, 2.2265, 0.014),
    ('4314902', 'multa', 2788, 2026, '2015-01-01', '2021-10-25', '1.0910.10.00', '8456.30.90', 121.71, 0.1429, NULL, NULL),
    ('3550308', 'multa', 486, 2015, '2018-10-09', NULL, NULL, NULL, 189.96, 0.0375, NULL, NULL),
    ('41', 'multa', 3506, 2017, '2015-10-31', NULL, NULL, NULL, 150.27, 0.146, NULL, NULL),
    ('21', 'if', 2248, 2021, '2022-07-13', NULL, '1.0906.90.00', '6204.21.00', NULL, NULL, 6.7184, 0.0173),
    ('3550308', 'if', 1888, 2019, '2024-05-31', NULL, '1.0401.41.00', NULL, NULL, NULL, 6.1613, 0.0277),
    ('4208302', 'if', 106, 2023, '2024-04-03', NULL, NULL, NULL, NULL, NULL, 2.4976, 0.0377),
    ('3548906', 'multa', 3769, 2021, '2022-02-06', '2023-10-09', NULL, NULL, 1749.24, 0.056, NULL, NULL),
    ('4314902', 'multa', 3145, 2025, '2016-06-07', NULL, '1.2201.12.00', '2841.90.8', 188.74, 0.2241, NULL, NULL),
    ('2927408', 'if', 45, 2019, '2020-04-19', NULL, NULL, NULL, NULL, NULL, 166.4555, 0.0545),
    ('35', 'multa', 4592, 2025, '2019-03-22', '2020-09-30', NULL, NULL, 63.8, 0.037, NULL, NULL),
    ('28', 'if', 1670, 2015, '2016-10-11', '2018-05-18', '1.0501.19.00', '8536.30.10', NULL, NULL, 82.4421, 0.0016),
    ('43', 'if', 2711, 2019, '2018-05-03', NULL, NULL, NULL, NULL, NULL, 3.0914, 0.0042),
    ('3550308', 'multa', 656, 2017, '2018-08-23', NULL, NULL, NULL, 421.89, 0.0886, NULL, NULL),
    ('3501905', 'multa', 2528, 2021, '2019-10-19', NULL, '1.0502.23.20', NULL, 69.46, 0.1583, NULL, NULL),
    ('53', 'if', 3673, 2019, '2020-04-25', NULL, NULL, '2939.59.10', NULL, NULL, 38.6857, 0.0611),
    ('42', 'multa', 3973, 2019, '2022-11-05', NULL, NULL, NULL, 63.16, 0.2029, NULL, NULL),
    ('29', 'if', 1382, 2021, '2018-03-05', NULL, '1.0501.12.10', '3507.10.00', NULL, NULL, 2.3601, 0.0774),
    ('4106902', 'if', 1855, 2024, '2022-07-14', NULL, '1.0103.41.00', '8538.10.00', NULL, NULL, 1.7864, 0.0395),
    ('4308250', 'multa', 3882, 2024, '2018-04-16', NULL, NULL, NULL, 91.43, 0.1645, NULL, NULL),
    ('3550308', 'multa', 2335, 2018, '2022-04-07', '2026-07-24', '1.0504.12.00', '9022.12.00', 475.73, 0.1902, NULL, NULL),
    ('4205407', 'multa', 3203, 2025, '2016-02-24', NULL, NULL, '1508.90.00', 104.99, 0.103, NULL, NULL),
    ('24', 'if', 82, 2018, '2019-07-01', NULL, '1.1402.1', '2933.29.25', NULL, NULL, 6.08, 0.0151),
    ('3304557', 'if', 2297, 2018, '2019-07-31', NULL, NULL, '3911.20.00', NULL, NULL, 4.3635, 0.0521),
    ('3146107', 'multa', 1321, 2019, '2026-06-16', NULL, NULL, NULL, 191.36, 0.245, NULL, NULL),
    ('3146107', 'multa', 3034, 2015, '2019-12-29', NULL, '1.0504.2', '3701.10.21', 137.4, 0.0196, NULL, NULL),
    ('3550308', 'if', 3133, 2023, '2015-12-22', '2022-06-03', NULL, '9102.19.00', NULL, NULL, 1.5799, 0.0049),
    ('2927408', 'if', 1186, 2026, '2019-11-28', NULL, NULL, '0713.33.9', NULL, NULL, 2.7277, 0.0648),
    ('3205309', 'multa', 927, 2026, '2025-08-04', NULL, '1.0401.15.20', NULL, 375.92, 0.2425, NULL, NULL),
    ('3306305', 'if', 1924, 2017, '2017-12-10', NULL, NULL, NULL, NULL, NULL, 5.0033, 0.075),
    ('31', 'multa', 3187, 2025, '2019-04-11', NULL, NULL, NULL, 603.63, 0.1889, NULL, NULL),
    ('3306305', 'if', 2425, 2025, '2021-10-03', NULL, NULL, '7407.10.10', NULL, NULL, 2.8495, 0.0106),
    ('35', 'if', 1211, 2018, '2024-02-07', NULL, NULL, '9028.90.10', NULL, NULL, 1.1692, 0.0656),
    ('2927408', 'if', 3432, 2024, '2021-05-18', NULL, NULL, '8711.50.00', NULL, NULL, 13.7829, 0.0502),
    ('21', 'multa', 3862, 2020, '2021-07-11', '2026-10-27', NULL, NULL, 403.51, 0.0802, NULL, NULL),
    ('3306305', 'multa', 4949, 2017, '2017-01-12', NULL, '1.0501.21.20', '8441.90.00', 233.7, 0.0484, NULL, NULL),
    ('4308250', 'multa', 1864, 2018, '2021-11-10', NULL, NULL, '3004.49.30', 52.77, 0.1876, NULL, NULL),
    ('24', 'multa', 3429, 2018, '2019-07-15', NULL, NULL, '9014.20.20', 62.55, 0.0961, NULL, NULL),
    ('35', 'if', 3043, 2018, '2021-01-06', NULL, '1.1805.31.00', NULL, NULL, NULL, 10.3699, 0.0433),
    ('3548906', 'if', 2323, 2023, '2017-12-23', NULL, NULL, '8517.61.91', NULL, NULL, 1.562, 0.0034),
    ('32', 'if', 805, 2023, '2024-09-11', NULL, '1.1501.10.00', NULL, NULL, NULL, 5.7259, 0.0239),
    ('29', 'multa', 2007, 2023, '2016-11-28', NULL, '1.0103', NULL, 43.84, 0.1433, NULL, NULL),
    ('3550308', 'multa', 3404, 2016, '2019-08-22', NULL, NULL, '5205.14.00', 145.17, 0.1519, NULL, NULL),
    ('3306305', 'multa', 3549, 2018, '2024-07-21', NULL, NULL, NULL, 141.58, 0.0548, NULL, NULL),
    ('33', 'multa', 3315, 2022, '2015-10-22', NULL, NULL, NULL, 227.17, 0.214, NULL, NULL),
    ('35', 'multa', 4351, 2024, '2025-09-29', NULL, NULL, NULL, 183.2, 0.23, NULL, NULL),
    ('3501905', 'if', 1609, 2025, '2015-06-29', NULL, '1.0502.14.52', '2925.12.00', NULL, NULL, 2.3289, 0.0563),
    ('1302603', 'multa', 2196, 2016, '2021-10-05', NULL, NULL, '8903.99.00', 174.93, 0.026, NULL, NULL),
    ('35', 'multa', 2566, 2017, '2024-12-07', NULL, '1.0107.60.00', NULL, 185.84, 0.2367, NULL, NULL),
    ('43', 'if', 1812, 2020, '2021-09-26', NULL, NULL, '5402.11.00', NULL, NULL, 1.5256, 0.0549),
    ('3501905', 'if', 1950, 2024, '2019-09-13', '2021-11-22', NULL, NULL, NULL, NULL, 1.3979, 0.0373),
    ('53', 'if', 1367, 2022, '2015-04-08', '2017-07-11', '1.0901.51.22', '8544.49.00', NULL, NULL, 4.3888, 0.0154),
    ('3548906', 'if', 894, 2018, '2018-04-11', NULL, NULL, '3808.99.11', NULL, NULL, 4.4387, 0.035),
    ('53', 'if', 2240, 2025, '2020-09-13', NULL, NULL, NULL, NULL, NULL, 25.9497, 0.0242),
    ('13', 'multa', 1546, 2018, '2015-03-10', NULL, NULL, '2941.10.90', 48.51, 0.1813, NULL, NULL),
    ('3205309', 'multa', 4666, 2017, '2024-09-06', NULL, NULL, '7318.15.00', 86.49, 0.1885, NULL, NULL),
    ('28', 'if', 3258, 2019, '2016-06-15', NULL, '1.0906.40.00', '8506.60.10', NULL, NULL, 8.6782, 0.0132),
    ('41', 'multa', 2596, 2017, '2020-08-25', '2022-07-17', '1.1803.2', '2820.90.30', 142.91, 0.2114, NULL, NULL),
    ('3106200', 'multa', 973, 2023, '2022-03-06', NULL, NULL, '8451.40.21', 631.35, 0.1504, NULL, NULL),
    ('53', 'multa', 1451, 2015, '2025-06-04', NULL, NULL, NULL, 299.48, 0.0497, NULL, NULL),
    ('35', 'if', 3426, 2026, '2016-11-18', NULL, NULL, NULL, NULL, NULL, 15.6011, 0.0418),
    ('33', 'multa', 3806, 2015, '2022-07-11', NULL, '1.1805.31.00', NULL, 68.03, 0.1428, NULL, NULL),
    ('32', 'multa', 2209, 2017, '2015-11-16', NULL, NULL, NULL, 141.82, 0.0193, NULL, NULL),
    ('3550308', 'multa', 3842, 2017, '2022-07-19', NULL, NULL, '8705.20.00', 55.55, 0.1249, NULL, NULL),
    ('24', 'multa', 2792, 2020, '2023-05-29', NULL, '1.2205.11.00', NULL, 575.75, 0.1343, NULL, NULL),
    ('3146206', 'if', 4308, 2020, '2015-09-13', NULL, '1.0502.12.20', '3816.00.19', NULL, NULL, 2.7996, 0.0108),
    ('3501905', 'multa', 1085, 2019, '2023-02-13', NULL, NULL, NULL, 94.63, 0.1264, NULL, NULL),
    ('26', 'if', 3190, 2024, '2023-05-21', NULL, NULL, NULL, NULL, NULL, 2.12, 0.0777),
    ('32', 'if', 854, 2024, '2015-08-19', NULL, NULL, NULL, NULL, NULL, 10.6597, 0.0043),
    ('2919306', 'multa', 755, 2022, '2015-12-30', NULL, NULL, '0805.10.00', 54.3, 0.2166, NULL, NULL),
    ('2919306', 'if', 2032, 2020, '2020-05-15', NULL, '1.2404.22.00', NULL, NULL, NULL, 1.6192, 0.0495),
    ('2919306', 'if', 3899, 2025, '2017-06-19', '2021-04-01', '1.0401.16.90', NULL, NULL, NULL, 98.2898, 0.0494),
    ('5300108', 'if', 2597, 2022, '2024-07-13', NULL, NULL, NULL, NULL, NULL, 2.9611, 0.0259),
    ('3304557', 'multa', 1446, 2018, '2015-01-03', NULL, '1.0905.21.00', NULL, 134.1, 0.0992, NULL, NULL),
    ('4314902', 'multa', 4313, 2016, '2015-06-14', NULL, '1.2502.10.00', NULL, 324.44, 0.1898, NULL, NULL),
    ('26', 'multa', 142, 2016, '2016-08-08', NULL, NULL, NULL, 388.51, 0.0388, NULL, NULL),
    ('32', 'if', 893, 2024, '2020-11-14', NULL, NULL, '0207.14.39', NULL, NULL, 2.0637, 0.0025),
    ('53', 'if', 4402, 2016, '2022-08-14', NULL, '1.1801.2', '0210.12.00', NULL, NULL, 5.1527, 0.0276),
    ('3106200', 'if', 2271, 2023, '2022-07-06', NULL, '1.1404.1', '8504.50.90', NULL, NULL, 8.5753, 0.0059),
    ('2919306', 'multa', 2959, 2020, '2022-10-04', NULL, '1.1702.10.00', '8541.30.2', 197.91, 0.1672, NULL, NULL),
    ('3501905', 'if', 2235, 2016, '2023-12-13', NULL, NULL, NULL, NULL, NULL, 17.4808, 0.0616),
    ('53', 'multa', 3341, 2016, '2016-10-01', NULL, '1.1409', '0804.50.10', 165.64, 0.1302, NULL, NULL),
    ('41', 'if', 874, 2026, '2020-08-23', NULL, '1.0402.13', '8449.00.20', NULL, NULL, 2.1328, 0.0103),
    ('29', 'multa', 1038, 2022, '2016-03-01', NULL, NULL, '7226.91.00', 233.02, 0.1634, NULL, NULL),
    ('24', 'if', 2958, 2016, '2023-04-28', NULL, '1.1805.2', NULL, NULL, NULL, 6.8047, 0.0127),
    ('35', 'multa', 3287, 2016, '2023-06-21', NULL, NULL, NULL, 224.85, 0.137, NULL, NULL),
    ('2919306', 'if', 1560, 2026, '2019-07-20', NULL, NULL, NULL, NULL, NULL, 9.5193, 0.0095),
    ('4314902', 'multa', 1490, 2023, '2025-07-08', NULL, '1.1106.90.00', NULL, 5826.83, 0.0621, NULL, NULL),
    ('2919306', 'multa', 1428, 2017, '2017-10-16', NULL, NULL, '3808.62.90', 127.16, 0.2047, NULL, NULL),
    ('43', 'multa', 785, 2022, '2022-01-21', '2023-08-11', '1.1504.00.00', NULL, 126.25, 0.1597, NULL, NULL),
    ('4205407', 'if', 1731, 2023, '2020-04-01', NULL, NULL, NULL, NULL, NULL, 13.5591, 0.0647),
    ('31', 'if', 1527, 2019, '2018-10-08', NULL, '1.1403.22.11', NULL, NULL, NULL, 44.72, 0.0329),
    ('1302603', 'if', 146, 2019, '2020-12-24', NULL, '1.1403.29.00', NULL, NULL, NULL, 8.5064, 0.0089),
    ('33', 'multa', 2609, 2018, '2016-11-26', NULL, '1.2001.34.20', NULL, 75.58, 0.1212, NULL, NULL),
    ('3205309', 'if', 2464, 2024, '2016-11-25', NULL, '1.0903.21.00', '0208.30.00', NULL, NULL, 10.8748, 0.0471),
    ('3550308', 'multa', 467, 2021, '2023-09-28', NULL, '1.1806.53.00', NULL, 85.61, 0.0435, NULL, NULL),
    ('4106902', 'multa', 3135, 2019, '2024-06-02', NULL, '1.0401.17', '8479.89.21', 440.78, 0.07, NULL, NULL),
    ('3550308', 'if', 3186, 2022, '2017-04-05', '2020-01-12', NULL, NULL, NULL, NULL, 3.3702, 0.0388),
    ('3501905', 'if', 1017, 2023, '2018-09-29', NULL, NULL, '8701.93.00', NULL, NULL, 4.0427, 0.0486),
    ('21', 'if', 2667, 2022, '2017-05-01', NULL, NULL, '8468.80.90', NULL, NULL, 2.3041, 0.0028),
    ('26', 'multa', 471, 2016, '2020-03-19', NULL, '1.0904.39.00', NULL, 84.55, 0.0104, NULL, NULL),
    ('3304557', 'multa', 518, 2023, '2023-08-14', NULL, NULL, '8471.60.6', 856.81, 0.0969, NULL, NULL),
    ('24', 'multa', 2949, 2025, '2020-04-08', NULL, '1.1413.00.00', NULL, 278.17, 0.2144, NULL, NULL),
    ('4314902', 'if', 1208, 2025, '2016-11-02', NULL, '1.1302.22.00', NULL, NULL, NULL, 4.4958, 0.0327),
    ('4205407', 'multa', 1481, 2022, '2023-04-26', NULL, NULL, NULL, 217.04, 0.0519, NULL, NULL),
    ('31', 'if', 3019, 2022, '2016-10-15', NULL, NULL, '3913.90.30', NULL, NULL, 8.0463, 0.0561),
    ('3146107', 'if', 3332, 2015, '2024-05-12', NULL, NULL, NULL, NULL, NULL, 2.6612, 0.0268),
    ('21', 'if', 4753, 2023, '2021-05-13', NULL, '1.2507.90.00', NULL, NULL, NULL, 4.6798, 0.0703),
    ('3550308', 'if', 4188, 2016, '2023-07-16', NULL, '1.0502.19.00', '2933.91.33', NULL, NULL, 1.4223, 0.0279),
    ('43', 'multa', 527, 2021, '2018-06-14', NULL, '1.0906.20.00', NULL, 39.75, 0.0358, NULL, NULL),
    ('42', 'if', 4667, 2019, '2024-12-24', NULL, '1.1201.50.00', NULL, NULL, NULL, 0.7838, 0.0246),
    ('28', 'if', 1267, 2015, '2024-05-02', NULL, '1.1806.59.00', NULL, NULL, NULL, 6.7271, 0.0412),
    ('29', 'multa', 1678, 2019, '2020-05-18', NULL, NULL, NULL, 220.14, 0.1903, NULL, NULL),
    ('28', 'multa', 533, 2026, '2015-06-12', '2022-02-24', '1.1105', NULL, 486.76, 0.02, NULL, NULL),
    ('2927408', 'multa', 4070, 2020, '2016-11-19', NULL, NULL, '8202.99.90', 38.54, 0.1593, NULL, NULL),
    ('21', 'multa', 2597, 2022, '2016-01-19', NULL, NULL, '2933.39.29', 36.14, 0.0367, NULL, NULL),
    ('3146206', 'multa', 4190, 2017, '2024-11-12', NULL, '1.1402.22.00', NULL, 281.78, 0.1492, NULL, NULL),
    ('3304557', 'if', 1177, 2023, '2018-12-30', NULL, '1.1103.43.00', '2843.29.90', NULL, NULL, 0.624, 0.0175),
    ('41', 'multa', 4367, 2016, '2015-01-12', NULL, NULL, '3208.20.19', 628.78, 0.2071, NULL, NULL),
    ('3304557', 'if', 1504, 2023, '2020-09-18', NULL, NULL, '8454.90.10', NULL, NULL, 3.2859, 0.0783),
    ('3548906', 'multa', 2527, 2023, '2017-04-14', '2019-07-08', '1.1402.90.00', '6115.10.1', 174.17, 0.0958, NULL, NULL),
    ('29', 'if', 3650, 2015, '2022-06-03', NULL, NULL, '2915.39.91', NULL, NULL, 11.6094, 0.0766),
    ('21', 'if', 4438, 2023, '2016-03-13', NULL, NULL, NULL, NULL, NULL, 8.8113, 0.0117),
    ('1302603', 'if', 3010, 2022, '2025-02-12', NULL, NULL, NULL, NULL, NULL, 6.4793, 0.0017),
    ('33', 'multa', 2937, 2017, '2025-10-21', NULL, '1.1408.12.00', NULL, 608.56, 0.0104, NULL, NULL),
    ('43', 'if', 3505, 2025, '2017-04-16', NULL, NULL, NULL, NULL, NULL, 1.4692, 0.0416),
    ('4205407', 'if', 3573, 2024, '2016-07-02', NULL, NULL, '3003.39.26', NULL, NULL, 1.0525, 0.021),
    ('3501905', 'multa', 1086, 2020, '2022-09-28', '2028-06-12', '1.2501.21.00', NULL, 126.02, 0.1775, NULL, NULL),
    ('3501905', 'if', 4366, 2018, '2015-01-15', NULL, '1.0105', '8541.21.20', NULL, NULL, 4.1621, 0.0545),
    ('2919306', 'if', 1828, 2020, '2022-02-14', '2026-09-06', '1.0505.10.00', '4418.91.00', NULL, NULL, 27.0055, 0.0635),
    ('33', 'multa', 3900, 2025, '2018-04-26', NULL, '1.1108', '8457.20.90', 145.76, 0.2319, NULL, NULL),
    ('26', 'if', 2927, 2023, '2017-03-01', NULL, '1.2501.12.00', '0102.39.90', NULL, NULL, 1.2076, 0.0285),
    ('4205407', 'multa', 2435, 2023, '2025-09-04', NULL, NULL, NULL, 59.44, 0.0512, NULL, NULL),
    ('3306305', 'multa', 2172, 2022, '2016-05-18', NULL, NULL, '2820.10.90', 86.08, 0.1159, NULL, NULL),
    ('2919306', 'if', 3481, 2021, '2024-06-25', NULL, '1.1801.12.00', NULL, NULL, NULL, 2.7206, 0.0648),
    ('2927408', 'if', 4284, 2018, '2021-04-20', '2026-04-30', '1.1404.12.00', NULL, NULL, NULL, 7.9222, 0.0314),
    ('2919306', 'if', 282, 2026, '2024-05-01', NULL, NULL, '8425.11.00', NULL, NULL, 2.5495, 0.066),
    ('4308250', 'multa', 1748, 2021, '2019-12-31', NULL, NULL, NULL, 171.09, 0.0205, NULL, NULL),
    ('3550308', 'if', 3543, 2022, '2025-08-25', NULL, NULL, NULL, NULL, NULL, 6.9479, 0.0471),
    ('42', 'if', 3609, 2021, '2019-02-26', NULL, '1.2201.30.00', '8472.90.91', NULL, NULL, 0.5294, 0.0586),
    ('3205309', 'multa', 85, 2017, '2020-08-04', NULL, NULL, '9030.84.20', 427.74, 0.2414, NULL, NULL),
    ('3106200', 'if', 3490, 2020, '2016-07-25', '2022-03-11', NULL, NULL, NULL, NULL, 0.6711, 0.0571),
    ('42', 'multa', 324, 2026, '2022-02-01', NULL, '1.0902', NULL, 86.45, 0.168, NULL, NULL),
    ('3146107', 'multa', 4576, 2019, '2024-03-17', NULL, NULL, '5205.48.00', 102.59, 0.1923, NULL, NULL),
    ('35', 'multa', 3204, 2023, '2026-06-19', NULL, '1.05', '4810.13.89', 270.49, 0.0307, NULL, NULL),
    ('33', 'multa', 1175, 2017, '2020-08-17', NULL, NULL, NULL, 168.52, 0.2411, NULL, NULL),
    ('29', 'if', 1739, 2025, '2019-02-14', NULL, '1.2404.33.00', NULL, NULL, NULL, 4.9699, 0.0155),
    ('3146206', 'if', 2502, 2023, '2024-03-04', NULL, NULL, '8479.89.99', NULL, NULL, 2.2862, 0.0606),
    ('4308250', 'multa', 1086, 2021, '2019-06-15', NULL, NULL, NULL, 49.41, 0.052, NULL, NULL),
    ('33', 'multa', 1054, 2025, '2020-02-18', NULL, '1.0602.33.00', NULL, 162.65, 0.1332, NULL, NULL),
    ('5300108', 'if', 413, 2017, '2023-02-07', NULL, '1.19', '5407.71.00', NULL, NULL, 26.6066, 0.0154),
    ('41', 'if', 536, 2022, '2024-04-03', NULL, NULL, NULL, NULL, NULL, 2.6813, 0.0559),
    ('28', 'multa', 3177, 2015, '2025-12-12', NULL, '1.1803.22.00', NULL, 288.73, 0.1605, NULL, NULL),
    ('43', 'multa', 824, 2022, '2018-08-23', NULL, NULL, NULL, 1876.24, 0.1727, NULL, NULL),
    ('32', 'multa', 1045, 2024, '2026-08-29', NULL, '1.1401.21.00', NULL, 250.91, 0.0683, NULL, NULL),
    ('2919306', 'multa', 3562, 2021, '2025-08-19', NULL, '1.0901.51.16', '0302.52.00', 184.98, 0.0339, NULL, NULL),
    ('3550308', 'multa', 789, 2018, '2021-05-15', '2023-07-15', NULL, NULL, 109.37, 0.0377, NULL, NULL),
    ('53', 'multa', 1893, 2022, '2022-03-05', NULL, '1.2602', '8802.30.2', 182.0, 0.1382, NULL, NULL),
    ('4308250', 'if', 4850, 2024, '2016-04-20', NULL, '1.0403.39.00', '3907.10.31', NULL, NULL, 3.0593, 0.073),
    ('3304557', 'multa', 4453, 2025, '2015-12-06', NULL, NULL, NULL, 263.87, 0.0669, NULL, NULL),
    ('26', 'if', 4380, 2019, '2015-07-12', '2019-04-01', NULL, NULL, NULL, NULL, 5.1266, 0.0648),
    ('21', 'multa', 4356, 2022, '2025-04-26', NULL, '1.1102.20.00', NULL, 140.67, 0.0653, NULL, NULL),
    ('3106200', 'multa', 1453, 2017, '2017-03-08', NULL, '1.1201.40.00', NULL, 133.84, 0.0972, NULL, NULL),
    ('43', 'if', 788, 2024, '2022-08-10', NULL, NULL, NULL, NULL, NULL, 1.6131, 0.0614),
    ('3306305', 'if', 4121, 2024, '2015-01-01', '2020-04-10', NULL, '3603.60.00', NULL, NULL, 16.8411, 0.0083),
    ('53', 'multa', 1027, 2016, '2025-11-18', NULL, '1.1703.92.00', '4403.41.00', 377.7, 0.1451, NULL, NULL),
    ('32', 'multa', 3471, 2023, '2022-05-23', NULL, '1.1109.20.00', '8716.31.00', 41.61, 0.229, NULL, NULL),
    ('4308250', 'multa', 3819, 2021, '2022-05-05', NULL, '1.01', NULL, 192.28, 0.2413, NULL, NULL),
    ('3505906', 'if', 3860, 2019, '2016-09-13', NULL, '1.0503.2', NULL, NULL, NULL, 3.1931, 0.0254),
    ('24', 'if', 3688, 2015, '2016-12-31', NULL, NULL, NULL, NULL, NULL, 11.7351, 0.0193),
    ('4308250', 'multa', 4032, 2026, '2016-05-14', NULL, NULL, '1604.17.00', 119.75, 0.0168, NULL, NULL),
    ('3146206', 'if', 4660, 2022, '2019-03-01', NULL, NULL, NULL, NULL, NULL, 0.3055, 0.0196),
    ('24', 'if', 4255, 2025, '2015-09-09', NULL, '1.2001.32.00', NULL, NULL, NULL, 9.8655, 0.0109),
    ('5300108', 'if', 1614, 2019, '2023-10-17', NULL, NULL, '8521.10.89', NULL, NULL, 2.7309, 0.0525),
    ('4314902', 'if', 4964, 2021, '2026-01-16', NULL, NULL, '3507.90.24', NULL, NULL, 2.5866, 0.0356),
    ('3106200', 'multa', 1064, 2021, '2023-04-26', NULL, '1.0401.12', '8525.50.24', 140.22, 0.1321, NULL, NULL),
    ('3106200', 'if', 677, 2024, '2019-06-01', '2025-05-01', NULL, NULL, NULL, NULL, 52.5702, 0.0301),
    ('29', 'if', 1551, 2025, '2023-06-08', NULL, NULL, '2924.19.39', NULL, NULL, 2.264, 0.0051),
    ('2919306', 'if', 2817, 2025, '2026-11-17', NULL, NULL, '6704.90.00', NULL, NULL, 0.8161, 0.0578),
    ('3306305', 'multa', 575, 2015, '2020-06-20', '2023-03-12', NULL, '5516.43.00', 102.52, 0.1281, NULL, NULL),
    ('3501905', 'multa', 425, 2024, '2021-05-26', NULL, '1.0401.16.90', '3917.10.10', 141.36, 0.1787, NULL, NULL),
    ('42', 'if', 829, 2023, '2018-07-15', NULL, NULL, '4810.14.8', NULL, NULL, 12.7821, 0.0038),
    ('24', 'multa', 2882, 2018, '2019-05-10', NULL, NULL, '9303.10.00', 196.27, 0.2117, NULL, NULL),
    ('51', 'if', 4622, 2022, '2025-09-29', NULL, NULL, NULL, NULL, NULL, 11.1408, 0.0345),
    ('4208302', 'multa', 3443, 2016, '2026-10-08', NULL, '1.1104.10.00', '3824.99.25', 396.75, 0.2408, NULL, NULL),
    ('24', 'if', 1395, 2015, '2026-10-06', '2032-05-15', NULL, '2921.59.29', NULL, NULL, 5.7834, 0.0747),
    ('4205407', 'multa', 171, 2018, '2021-03-15', NULL, '1.2205.12.00', NULL, 72.21, 0.1872, NULL, NULL),
    ('13', 'multa', 1101, 2019, '2018-09-22', NULL, '1.2406.10.00', NULL, 211.74, 0.216, NULL, NULL),
    ('3550308', 'multa', 2439, 2024, '2016-04-03', NULL, NULL, NULL, 2030.87, 0.0518, NULL, NULL),
    ('41', 'multa', 1154, 2017, '2023-03-06', '2023-11-05', '1.1406.1', '0402.29.20', 127.72, 0.1559, NULL, NULL),
    ('4208302', 'if', 41, 2020, '2020-03-10', NULL, NULL, NULL, NULL, NULL, 1.2502, 0.024),
    ('3106200', 'if', 3844, 2015, '2026-09-01', '2027-03-25', '1.2503.20.00', '5206.42.00', NULL, NULL, 1.958, 0.0471),
    ('33', 'multa', 3200, 2016, '2018-07-10', NULL, '1.1403.22.90', '3004.20.1', 17.82, 0.0534, NULL, NULL),
    ('3548906', 'if', 1543, 2024, '2016-05-28', NULL, '1.0106.19.00', NULL, NULL, NULL, 3.6118, 0.0149),
    ('24', 'multa', 4415, 2021, '2018-01-30', NULL, '1.2407.00.00', '2933.39.32', 243.43, 0.0543, NULL, NULL),
    ('28', 'if', 1595, 2023, '2016-03-13', NULL, NULL, NULL, NULL, NULL, 168.6938, 0.0126),
    ('51', 'if', 2313, 2020, '2018-02-23', NULL, '1.0501.2', '2933.59.2', NULL, NULL, 3.6426, 0.0364),
    ('3106200', 'multa', 1872, 2025, '2021-06-20', NULL, '1.1805.62.00', NULL, 341.98, 0.1537, NULL, NULL),
    ('3306305', 'if', 4865, 2016, '2020-11-06', '2021-12-09', NULL, NULL, NULL, NULL, 17.5129, 0.0765),
    ('4205407', 'if', 3212, 2018, '2022-07-04', NULL, NULL, NULL, NULL, NULL, 14.7901, 0.0387),
    ('3205309', 'multa', 4845, 2019, '2025-06-09', '2029-08-02', NULL, '2905.11.00', 5941.93, 0.1417, NULL, NULL),
    ('4205407', 'if', 1773, 2024, '2019-04-06', '2022-05-20', NULL, '2606.00.12', NULL, NULL, 14.0868, 0.0364),
    ('24', 'if', 4343, 2019, '2024-03-26', NULL, NULL, NULL, NULL, NULL, 3.7727, 0.0188),
    ('3550308', 'if', 4347, 2018, '2016-05-23', NULL, NULL, '8515.19.00', NULL, NULL, 0.8241, 0.0616),
    ('4106902', 'if', 851, 2022, '2018-10-27', NULL, NULL, '8443.32.22', NULL, NULL, 3.0326, 0.0792),
    ('43', 'multa', 2770, 2023, '2015-03-18', NULL, NULL, '2924.29.43', 502.07, 0.166, NULL, NULL),
    ('3501905', 'if', 2960, 2019, '2025-02-20', NULL, '1.0102.90.00', '7215.90.10', NULL, NULL, 1.23, 0.0264),
    ('24', 'if', 2324, 2016, '2015-10-30', NULL, '1.1507.90.00', NULL, NULL, NULL, 0.799, 0.0596),
    ('26', 'multa', 824, 2016, '2021-10-20', NULL, '1.1106.36.10', '8452.21.10', 500.25, 0.0908, NULL, NULL),
    ('51', 'multa', 2541, 2019, '2018-03-29', NULL, NULL, NULL, 69.67, 0.2072, NULL, NULL),
    ('5300108', 'if', 1488, 2023, '2025-07-30', NULL, NULL, '7017.20.00', NULL, NULL, 2.7503, 0.033),
    ('35', 'multa', 3401, 2020, '2023-12-19', NULL, '1.0102.90.00', NULL, 130.33, 0.2048, NULL, NULL),
    ('4314902', 'if', 2198, 2018, '2016-06-01', NULL, NULL, NULL, NULL, NULL, 1.0423, 0.0658),
    ('4314902', 'multa', 3613, 2021, '2015-06-08', NULL, '1.1406.20.00', '2924.29.15', 454.13, 0.2168, NULL, NULL),
    ('3304557', 'multa', 2709, 2025, '2015-11-14', NULL, NULL, '7304.29.10', 82.63, 0.2115, NULL, NULL),
    ('3550308', 'multa', 4775, 2018, '2018-12-21', NULL, '1.1801', '2933.91.53', 6651.89, 0.1872, NULL, NULL),
    ('31', 'multa', 976, 2024, '2020-11-28', NULL, NULL, NULL, 120.38, 0.0451, NULL, NULL),
    ('4308250', 'multa', 236, 2022, '2016-03-03', NULL, NULL, NULL, 199.39, 0.2421, NULL, NULL),
    ('24', 'multa', 3159, 2021, '2021-11-06', NULL, '1.0502.11.10', '8501.52.90', 123.78, 0.1784, NULL, NULL),
    ('3205309', 'if', 4432, 2020, '2016-11-12', NULL, NULL, NULL, NULL, NULL, 2.7042, 0.0308),
    ('31', 'if', 395, 2017, '2024-11-04', NULL, NULL, NULL, NULL, NULL, 2.3351, 0.0115),
    ('13', 'multa', 3761, 2015, '2021-01-22', NULL, NULL, '4823.69.00', 301.87, 0.0889, NULL, NULL),
    ('3146206', 'multa', 4507, 2017, '2017-01-27', NULL, '1.0104.00.00', '8448.19.00', 190.39, 0.0397, NULL, NULL),
    ('4208302', 'if', 2908, 2018, '2021-05-24', NULL, NULL, NULL, NULL, NULL, 2.3619, 0.0725),
    ('2919306', 'multa', 2862, 2021, '2023-05-28', NULL, '1.1806.59.00', NULL, 117.04, 0.0318, NULL, NULL),
    ('3146107', 'multa', 4980, 2020, '2021-08-03', NULL, '1.0106.22.00', NULL, 43.82, 0.1769, NULL, NULL),
    ('4314902', 'if', 2057, 2023, '2019-02-17', NULL, '1.0503.25.00', '3823.19.90', NULL, NULL, 62.0561, 0.034),
    ('4308250', 'if', 1214, 2020, '2015-12-14', NULL, '1.0903.34.00', '6902.10.18', NULL, NULL, 1.0005, 0.077),
    ('3548906', 'if', 565, 2019, '2020-07-25', NULL, NULL, '4418.89.00', NULL, NULL, 1.838, 0.051),
    ('53', 'multa', 2990, 2024, '2020-03-01', NULL, '1.0106.2', NULL, 162.43, 0.1251, NULL, NULL),
    ('3505906', 'if', 4865, 2019, '2015-01-09', '2017-09-30', '1.0105.90.00', NULL, NULL, NULL, 1.4821, 0.0257),
    ('43', 'if', 1690, 2015, '2019-06-28', NULL, '1.1806.20.00', '2912.12.00', NULL, NULL, 2.7312, 0.0543),
    ('42', 'multa', 2376, 2025, '2018-08-22', NULL, NULL, NULL, 71.22, 0.029, NULL, NULL),
    ('51', 'multa', 2075, 2021, '2022-04-15', '2027-05-25', NULL, '8408.10.90', 117.02, 0.0207, NULL, NULL),
    ('53', 'multa', 2662, 2023, '2015-10-07', NULL, '1.2204.10.00', NULL, 21.15, 0.198, NULL, NULL),
    ('1302603', 'if', 1241, 2026, '2025-07-25', NULL, '1.1803', '2936.29.19', NULL, NULL, 2.126, 0.0618),
    ('26', 'multa', 1878, 2023, '2023-11-27', NULL, '1.1402.14.00', NULL, 74.55, 0.1816, NULL, NULL),
    ('21', 'multa', 4057, 2026, '2026-03-22', NULL, NULL, '2934.30.20', 229.47, 0.0833, NULL, NULL),
    ('3501905', 'if', 1423, 2025, '2024-04-28', NULL, NULL, NULL, NULL, NULL, 1.5422, 0.008),
    ('41', 'multa', 4471, 2015, '2020-02-09', NULL, '1.0403.19.00', '3004.49.90', 366.73, 0.1201, NULL, NULL),
    ('2919306', 'if', 967, 2023, '2017-05-23', NULL, NULL, '2924.29.32', NULL, NULL, 1.201, 0.0731),
    ('5300108', 'multa', 2567, 2019, '2018-09-10', NULL, NULL, NULL, 70.44, 0.0878, NULL, NULL),
    ('13', 'multa', 4655, 2019, '2021-12-11', NULL, '1.1401.14.00', '8549.11.00', 220.67, 0.197, NULL, NULL),
    ('3106200', 'if', 245, 2022, '2016-10-08', NULL, NULL, '4704.21.00', NULL, NULL, 1.4969, 0.0756),
    ('35', 'multa', 2316, 2017, '2017-07-06', NULL, '1.1105.70.00', '4410.19.19', 4275.06, 0.1204, NULL, NULL),
    ('35', 'multa', 950, 2016, '2021-07-23', NULL, NULL, NULL, 80.8, 0.2342, NULL, NULL),
    ('3304557', 'if', 537, 2024, '2018-02-03', NULL, NULL, NULL, NULL, NULL, 3.2352, 0.064),
    ('29', 'multa', 926, 2017, '2020-02-10', NULL, '1.1201.33.00', NULL, 2334.65, 0.2344, NULL, NULL),
    ('13', 'multa', 3511, 2025, '2026-03-19', NULL, NULL, NULL, 535.04, 0.1208, NULL, NULL),
    ('33', 'multa', 679, 2019, '2023-04-27', '2028-07-03', NULL, NULL, 113.42, 0.1398, NULL, NULL),
    ('51', 'multa', 1356, 2020, '2019-04-04', NULL, NULL, NULL, 319.66, 0.2033, NULL, NULL),
    ('13', 'if', 1789, 2016, '2018-04-10', NULL, NULL, NULL, NULL, NULL, 99.2239, 0.009),
    ('29', 'if', 3400, 2017, '2015-01-14', NULL, '1.1201.31.00', '0306.19.90', NULL, NULL, 5.413, 0.0597),
    ('35', 'if', 2630, 2022, '2025-08-31', NULL, NULL, '3824.99.35', NULL, NULL, 7.3341, 0.0507),
    ('51', 'multa', 4123, 2017, '2018-10-20', NULL, NULL, '3906.90.19', 161.92, 0.1039, NULL, NULL),
    ('35', 'multa', 4866, 2025, '2015-09-20', '2020-01-28', '1.0102.3', '6111.30.00', 371.78, 0.1989, NULL, NULL),
    ('43', 'multa', 2991, 2018, '2017-11-07', '2023-06-14', NULL, NULL, 402.06, 0.0941, NULL, NULL),
    ('1302603', 'multa', 442, 2026, '2024-02-22', NULL, '1.0501.21', '2931.41.00', 212.23, 0.0732, NULL, NULL),
    ('35', 'multa', 3826, 2024, '2023-08-21', NULL, NULL, '5906.99.00', 133.52, 0.2053, NULL, NULL),
    ('3106200', 'multa', 1021, 2019, '2018-03-17', NULL, '1.0901.90.00', NULL, 280.65, 0.2138, NULL, NULL),
    ('3550308', 'multa', 656, 2016, '2021-09-03', NULL, '1.2501.32.00', NULL, 101.42, 0.1284, NULL, NULL),
    ('33', 'multa', 2466, 2025, '2019-07-09', NULL, '1.2204.30.00', '3824.99.6', 145.18, 0.2384, NULL, NULL),
    ('5300108', 'multa', 705, 2023, '2015-10-10', '2018-12-05', '1.0107.50.00', NULL, 285.3, 0.234, NULL, NULL),
    ('13', 'if', 3458, 2015, '2021-12-07', NULL, NULL, NULL, NULL, NULL, 2.4372, 0.0504),
    ('2927408', 'if', 4196, 2022, '2018-05-27', NULL, NULL, NULL, NULL, NULL, 4.4957, 0.0231),
    ('3550308', 'if', 374, 2018, '2020-11-12', NULL, '1.0401.15.20', '6804.22.11', NULL, NULL, 4.6634, 0.0164),
    ('35', 'if', 122, 2015, '2019-03-02', NULL, NULL, NULL, NULL, NULL, 9.1522, 0.0334),
    ('3205309', 'multa', 3077, 2023, '2019-06-15', NULL, '1.2203.20.00', '8428.90.10', 154.41, 0.2336, NULL, NULL),
    ('3550308', 'multa', 3718, 2015, '2017-05-07', NULL, NULL, NULL, 125.1, 0.0867, NULL, NULL),
    ('41', 'multa', 1493, 2015, '2023-09-20', NULL, '1.0906.1', '9032.89.25', 92.93, 0.0107, NULL, NULL),
    ('53', 'multa', 153, 2026, '2026-06-14', NULL, NULL, NULL, 326.58, 0.0173, NULL, NULL),
    ('53', 'multa', 4508, 2023, '2017-06-24', NULL, '1.0502.33.10', '8432.80.00', 132.33, 0.2098, NULL, NULL),
    ('31', 'if', 4059, 2016, '2021-08-16', '2022-01-14', '1.2001.31.20', '3816.00.12', NULL, NULL, 2.532, 0.0375),
    ('3146107', 'if', 4747, 2018, '2024-12-25', NULL, NULL, NULL, NULL, NULL, 14.7703, 0.026),
    ('3146107', 'multa', 4422, 2016, '2020-05-21', '2021-06-24', NULL, '2009.89.21', 62.94, 0.2229, NULL, NULL),
    ('13', 'if', 149, 2026, '2019-12-11', NULL, NULL, NULL, NULL, NULL, 1.5021, 0.0018),
    ('4205407', 'if', 2152, 2022, '2023-04-09', NULL, '1.1303.10.00', NULL, NULL, NULL, 7.1985, 0.0747),
    ('3146206', 'multa', 1184, 2022, '2019-09-19', '2024-04-23', NULL, '3402.39.90', 1153.67, 0.1537, NULL, NULL),
    ('3106200', 'multa', 636, 2025, '2021-05-19', NULL, '1.0501.13', '2208.20.00', 142.43, 0.0895, NULL, NULL),
    ('5300108', 'if', 2374, 2024, '2020-06-14', '2022-02-16', NULL, NULL, NULL, NULL, 6.079, 0.0276),
    ('13', 'if', 735, 2016, '2017-09-22', NULL, '1.0901.40.00', '8504.23.00', NULL, NULL, 4.9633, 0.0397),
    ('33', 'multa', 959, 2015, '2024-03-13', NULL, '1.2203', NULL, 197.16, 0.1606, NULL, NULL),
    ('24', 'if', 1417, 2020, '2019-09-08', NULL, '1.1502.50.00', NULL, NULL, NULL, 2.3695, 0.069),
    ('5300108', 'multa', 4255, 2026, '2020-02-19', '2020-05-11', NULL, NULL, 92.36, 0.0665, NULL, NULL),
    ('24', 'multa', 33, 2021, '2019-02-04', NULL, NULL, '8106.10.00', 453.1, 0.0979, NULL, NULL),
    ('51', 'multa', 4224, 2022, '2025-11-08', NULL, NULL, NULL, 114.71, 0.1151, NULL, NULL),
    ('43', 'multa', 4458, 2023, '2022-04-02', NULL, NULL, '5516.24.00', 256.05, 0.119, NULL, NULL),
    ('4208302', 'multa', 3918, 2019, '2018-03-18', NULL, '1.2402', '2921.19.3', 61.26, 0.1569, NULL, NULL),
    ('35', 'if', 245, 2024, '2023-06-30', NULL, NULL, '5510.12.11', NULL, NULL, 1.4697, 0.0351),
    ('4208302', 'multa', 725, 2015, '2026-05-31', NULL, '1.1806.62.00', '4301.80.00', 118.25, 0.1252, NULL, NULL),
    ('26', 'if', 560, 2020, '2026-12-30', NULL, '1.0502.3', '7502.10.10', NULL, NULL, 2.8682, 0.0553),
    ('32', 'multa', 3326, 2020, '2024-08-02', NULL, '1.0604.2', '8529.90.90', 70.94, 0.2325, NULL, NULL),
    ('51', 'if', 2549, 2018, '2021-08-14', NULL, '1.0501.12.20', '8702.20.00', NULL, NULL, 1.5957, 0.0255),
    ('13', 'multa', 1962, 2024, '2015-04-08', '2021-10-02', NULL, NULL, 245.98, 0.113, NULL, NULL),
    ('3146107', 'multa', 451, 2021, '2026-06-08', NULL, NULL, '4706.93.00', 60.8, 0.0807, NULL, NULL),
    ('28', 'multa', 4045, 2015, '2026-06-12', NULL, '1.0405.00.00', '2933.59.32', 200.35, 0.2238, NULL, NULL),
    ('3306305', 'if', 3623, 2023, '2016-02-24', NULL, '1.2001.34.20', NULL, NULL, NULL, 40.8965, 0.0605),
    ('42', 'if', 3986, 2017, '2019-08-30', NULL, '1.2601.90.00', '2922.15.00', NULL, NULL, 33.641, 0.0256),
    ('4106902', 'if', 279, 2025, '2016-12-20', NULL, NULL, NULL, NULL, NULL, 2.1005, 0.0628),
    ('3548906', 'multa', 1682, 2022, '2021-03-19', '2021-06-23', '1.0502.23.10', '8413.30.90', 221.11, 0.1096, NULL, NULL),
    ('35', 'if', 1070, 2018, '2020-12-01', NULL, '1.0601.10.00', '8471.90.1', NULL, NULL, 5.6566, 0.0152),
    ('3306305', 'multa', 2887, 2026, '2017-12-31', NULL, NULL, NULL, 91.26, 0.1556, NULL, NULL),
    ('53', 'multa', 1951, 2024, '2019-05-09', NULL, '1.0402.23.00', NULL, 119.67, 0.1661, NULL, NULL),
    ('31', 'if', 4367, 2020, '2025-12-07', NULL, '1.1201', NULL, NULL, NULL, 19.6988, 0.0737),
    ('2919306', 'if', 3720, 2017, '2018-08-09', NULL, NULL, NULL, NULL, NULL, 2.3849, 0.065),
    ('29', 'if', 4297, 2025, '2020-12-04', NULL, '1.2507', NULL, NULL, NULL, 124.8826, 0.022),
    ('33', 'if', 4722, 2022, '2016-06-02', NULL, '1.0402.11.10', NULL, NULL, NULL, 26.7684, 0.0559),
    ('4205407', 'multa', 1041, 2023, '2020-07-11', NULL, NULL, '2903.48.00', 160.25, 0.0628, NULL, NULL),
    ('42', 'if', 4102, 2025, '2018-04-04', NULL, '1.1402.11.00', NULL, NULL, NULL, 2.4546, 0.0257),
    ('26', 'if', 3880, 2020, '2017-10-09', NULL, '1.1201.40.00', '6108.19.00', NULL, NULL, 5.499, 0.0181),
    ('1302603', 'multa', 4775, 2023, '2024-10-10', NULL, NULL, NULL, 163.64, 0.1741, NULL, NULL),
    ('3550308', 'if', 4712, 2023, '2018-02-04', NULL, NULL, NULL, NULL, NULL, 5.6829, 0.0426),
    ('42', 'multa', 904, 2021, '2019-06-30', NULL, '1.1408.1', '7501.20.00', 163.02, 0.1889, NULL, NULL),
    ('29', 'if', 4173, 2025, '2023-11-15', NULL, NULL, '6216.00.00', NULL, NULL, 6.6087, 0.077),
    ('4106902', 'multa', 3571, 2016, '2016-12-27', NULL, '1.2001.33.00', '0304.69.00', 53.89, 0.0797, NULL, NULL),
    ('42', 'multa', 2161, 2023, '2017-02-20', NULL, NULL, '6306.40.10', 2368.93, 0.0269, NULL, NULL),
    ('31', 'multa', 3870, 2025, '2018-02-12', NULL, '1.0502.12', NULL, 99.3, 0.0779, NULL, NULL),
    ('4106902', 'if', 1265, 2022, '2017-01-01', NULL, '1.0103.41.00', NULL, NULL, NULL, 1.8578, 0.0551),
    ('51', 'multa', 4876, 2026, '2021-01-06', NULL, '1.1903.20.00', '6104.43.00', 216.47, 0.2235, NULL, NULL),
    ('3146206', 'if', 4939, 2021, '2018-01-28', '2019-06-17', '1.0502.13.10', '8528.71.90', NULL, NULL, 2.0238, 0.0561),
    ('2927408', 'if', 2110, 2015, '2019-02-18', '2022-02-23', NULL, '2207.20.19', NULL, NULL, 4.774, 0.0253),
    ('31', 'multa', 3344, 2016, '2018-02-19', NULL, '1.2504.22.00', '3305.90.00', 119.33, 0.205, NULL, NULL),
    ('4208302', 'if', 1238, 2019, '2022-03-09', NULL, '1.1404.30.00', '3204.90.00', NULL, NULL, 4.3302, 0.0446),
    ('41', 'if', 365, 2026, '2025-01-08', NULL, NULL, '8457.30.10', NULL, NULL, 5.2835, 0.0401),
    ('3501905', 'if', 4729, 2015, '2023-08-11', NULL, NULL, '3808.92.95', NULL, NULL, 2.3365, 0.0753),
    ('3205309', 'if', 1823, 2017, '2017-12-14', NULL, NULL, '8411.11.00', NULL, NULL, 4.3418, 0.0302),
    ('3146107', 'multa', 4826, 2022, '2025-08-22', NULL, '1.1403.22.11', NULL, 480.18, 0.098, NULL, NULL),
    ('3146107', 'if', 1789, 2022, '2024-07-18', NULL, NULL, NULL, NULL, NULL, 3.8724, 0.0545),
    ('3550308', 'multa', 4027, 2015, '2019-05-28', NULL, '1.2302.2', '7304.29.31', 137.94, 0.1201, NULL, NULL),
    ('3205309', 'if', 3933, 2025, '2024-09-11', NULL, '1.0504.45.20', NULL, NULL, NULL, 6.8362, 0.0335),
    ('26', 'if', 1871, 2019, '2025-03-07', NULL, NULL, NULL, NULL, NULL, 4.8024, 0.0025),
    ('3205309', 'multa', 4479, 2019, '2024-03-05', NULL, '1.1201.3', '2309.90.60', 54.86, 0.1215, NULL, NULL),
    ('51', 'if', 1478, 2015, '2025-12-27', NULL, '1.2304.11.00', '8539.31.31', NULL, NULL, 8.3992, 0.079),
    ('21', 'multa', 4101, 2018, '2021-12-17', NULL, '1.1301', NULL, 318.97, 0.1342, NULL, NULL),
    ('4314902', 'if', 346, 2025, '2022-09-20', '2023-01-22', NULL, NULL, NULL, NULL, 1.736, 0.0043),
    ('3550308', 'multa', 3560, 2024, '2021-10-17', NULL, '1.2301.96.00', NULL, 188.78, 0.0518, NULL, NULL),
    ('3304557', 'multa', 2924, 2018, '2021-10-10', NULL, NULL, '8450.11.00', 250.87, 0.0457, NULL, NULL),
    ('4205407', 'if', 94, 2021, '2026-07-20', NULL, '1.0303.20.00', '6813.81.90', NULL, NULL, 4.0844, 0.0187),
    ('24', 'if', 3372, 2022, '2026-04-07', NULL, NULL, NULL, NULL, NULL, 1.5486, 0.049),
    ('3146206', 'if', 1929, 2019, '2022-08-29', NULL, '1.1505.00.00', '3005.90.20', NULL, NULL, 3.4285, 0.0694),
    ('3501905', 'multa', 676, 2017, '2019-04-13', NULL, '1.0502.12.20', NULL, 327.46, 0.2068, NULL, NULL),
    ('3304557', 'if', 849, 2016, '2020-01-29', NULL, NULL, '2204.30.00', NULL, NULL, 27.4806, 0.0767),
    ('4314902', 'if', 2194, 2015, '2026-02-23', NULL, '1.1103.90.00', NULL, NULL, NULL, 5.3111, 0.0649),
    ('41', 'if', 869, 2016, '2019-01-31', NULL, NULL, '0702.00.00', NULL, NULL, 2.179, 0.0479),
    ('3106200', 'if', 3093, 2021, '2018-09-18', NULL, '1.0501.23.20', '2903.71.00', NULL, NULL, 100.5743, 0.0523),
    ('4205407', 'multa', 466, 2017, '2023-07-09', NULL, '1.0904.34.00', NULL, 230.99, 0.1929, NULL, NULL),
    ('35', 'if', 1998, 2017, '2015-01-04', NULL, '1.1403.21.10', '5510.12.12', NULL, NULL, 4.6794, 0.0482),
    ('3304557', 'multa', 514, 2019, '2016-05-20', NULL, '1.0901.52.10', NULL, 86.36, 0.1381, NULL, NULL),
    ('3146206', 'multa', 1836, 2017, '2025-12-19', NULL, '1.1101.60.00', NULL, 9418.06, 0.1654, NULL, NULL),
    ('43', 'if', 215, 2020, '2024-11-05', NULL, '1.0304.20.00', '3002.49.99', NULL, NULL, 4.3051, 0.0386),
    ('21', 'if', 2033, 2020, '2025-07-17', NULL, NULL, NULL, NULL, NULL, 3.4857, 0.015),
    ('32', 'if', 2589, 2024, '2019-11-13', NULL, '1.0905.13.00', NULL, NULL, NULL, 2.9548, 0.0138),
    ('41', 'if', 767, 2026, '2015-02-08', '2019-12-09', NULL, '8448.20.10', NULL, NULL, 490.2306, 0.0431),
    ('4314902', 'multa', 1252, 2019, '2015-08-13', NULL, '1.1805.31.00', NULL, 277.76, 0.1563, NULL, NULL),
    ('43', 'multa', 1636, 2026, '2016-11-18', NULL, '1.2405.14.00', '2103.30.10', 9822.37, 0.0829, NULL, NULL),
    ('3106200', 'multa', 4401, 2020, '2016-05-24', NULL, '1.0105.30.00', NULL, 183.74, 0.2121, NULL, NULL),
    ('32', 'if', 1433, 2021, '2019-06-29', NULL, '1.2001.34.30', NULL, NULL, NULL, 4.827, 0.0377),
    ('3205309', 'multa', 3743, 2025, '2019-02-09', NULL, '1.2504.11.00', NULL, 149.05, 0.0139, NULL, NULL),
    ('28', 'if', 4520, 2017, '2023-08-25', NULL, NULL, NULL, NULL, NULL, 2.8402, 0.0591),
    ('13', 'if', 3679, 2024, '2022-09-16', '2028-04-19', NULL, '4404.10.00', NULL, NULL, 1.1436, 0.0133),
    ('3106200', 'multa', 1981, 2022, '2025-07-13', NULL, NULL, NULL, 151.52, 0.2349, NULL, NULL),
    ('26', 'if', 2452, 2021, '2022-02-21', NULL, '1.0605.90.00', '7208.38.10', NULL, NULL, 2.3854, 0.0659),
    ('1302603', 'if', 4462, 2023, '2020-03-30', '2021-04-09', NULL, NULL, NULL, NULL, 2.5124, 0.0454),
    ('29', 'multa', 793, 2020, '2015-11-15', NULL, NULL, '7019.69.00', 263.27, 0.1864, NULL, NULL),
    ('2927408', 'if', 1541, 2024, '2024-07-14', NULL, '1.1106.35.00', '2824.90.10', NULL, NULL, 3.0075, 0.0478),
    ('3505906', 'multa', 4217, 2022, '2016-09-13', NULL, '1.0903.36.00', NULL, 171.27, 0.0387, NULL, NULL),
    ('1302603', 'if', 284, 2015, '2019-03-01', NULL, NULL, NULL, NULL, NULL, 6.6362, 0.0043),
    ('4205407', 'multa', 749, 2018, '2017-10-02', NULL, NULL, '8540.71.00', 250.75, 0.2328, NULL, NULL),
    ('43', 'if', 480, 2024, '2024-03-01', NULL, '1.2201.1', '4004.00.00', NULL, NULL, 1.3828, 0.0085),
    ('26', 'multa', 4897, 2017, '2025-02-22', NULL, '1.2403.22.00', NULL, 453.4, 0.1535, NULL, NULL),
    ('3306305', 'if', 868, 2020, '2015-02-06', NULL, NULL, NULL, NULL, NULL, 7.1241, 0.0633),
    ('4208302', 'if', 3473, 2019, '2015-06-22', '2017-09-21', '1.1404.2', NULL, NULL, NULL, 1.6222, 0.0475),
    ('35', 'multa', 4758, 2021, '2015-05-31', NULL, '1.0102.80.00', '5407.41.00', 120.42, 0.1369, NULL, NULL),
    ('21', 'multa', 2902, 2024, '2015-11-13', NULL, NULL, '7605.11.10', 184.27, 0.1463, NULL, NULL),
    ('3550308', 'if', 2790, 2018, '2020-01-23', NULL, NULL, NULL, NULL, NULL, 2.6677, 0.073),
    ('21', 'multa', 3155, 2016, '2020-03-15', NULL, NULL, '8506.10.20', 120.21, 0.0705, NULL, NULL),
    ('5300108', 'if', 4392, 2024, '2018-12-26', NULL, NULL, NULL, NULL, NULL, 5.0083, 0.0472),
    ('43', 'multa', 1076, 2021, '2026-10-22', NULL, '1.2502.10.00', NULL, 49.14, 0.1425, NULL, NULL),
    ('26', 'multa', 3087, 2017, '2017-10-25', NULL, NULL, '3507.90.4', 222.03, 0.1479, NULL, NULL),
    ('3548906', 'multa', 3623, 2021, '2022-09-01', NULL, '1.1506', '9018.14.10', 198.74, 0.0296, NULL, NULL),
    ('1302603', 'if', 2901, 2016, '2019-10-14', NULL, '1.1404.13.00', '5514.12.00', NULL, NULL, 138.1439, 0.0744),
    ('32', 'multa', 828, 2020, '2021-04-19', NULL, NULL, NULL, 139.36, 0.1677, NULL, NULL),
    ('3501905', 'multa', 1284, 2020, '2023-10-13', NULL, NULL, '8504.32.21', 122.49, 0.11, NULL, NULL),
    ('2919306', 'if', 925, 2015, '2016-08-19', '2019-04-24', NULL, NULL, NULL, NULL, 5.7996, 0.0403),
    ('4314902', 'if', 3917, 2016, '2018-02-19', NULL, NULL, NULL, NULL, NULL, 1.4347, 0.0586),
    ('32', 'if', 306, 2023, '2021-07-06', NULL, NULL, NULL, NULL, NULL, 29.8955, 0.0514),
    ('4308250', 'if', 4615, 2023, '2025-07-31', NULL, NULL, '2701.12.00', NULL, NULL, 8.3685, 0.0228),
    ('2919306', 'multa', 3885, 2021, '2015-05-16', NULL, '1.1803.21.00', '8431.10.90', 192.64, 0.2152, NULL, NULL),
    ('3505906', 'if', 4707, 2018, '2024-02-28', NULL, NULL, '8708.94.1', NULL, NULL, 3.3499, 0.0012),
    ('3550308', 'if', 2501, 2015, '2024-12-09', NULL, NULL, '8421.29.1', NULL, NULL, 2.1967, 0.0559),
    ('4208302', 'multa', 906, 2020, '2018-07-22', NULL, NULL, NULL, 146.39, 0.1418, NULL, NULL),
    ('4205407', 'multa', 1566, 2022, '2018-02-07', NULL, NULL, '3702.44.21', 192.4, 0.0126, NULL, NULL),
    ('3550308', 'if', 1038, 2024, '2022-02-11', NULL, NULL, '2903.94.00', NULL, NULL, 1.9636, 0.0229),
    ('24', 'multa', 4280, 2020, '2018-03-13', NULL, '1.0105', '2905.39.10', 185.11, 0.2014, NULL, NULL),
    ('32', 'if', 2246, 2023, '2017-10-17', NULL, NULL, NULL, NULL, NULL, 109.2529, 0.066),
    ('3304557', 'multa', 3062, 2025, '2018-12-06', NULL, '1.0301.90.00', '8424.30.30', 152.97, 0.1356, NULL, NULL),
    ('3501905', 'if', 998, 2026, '2015-12-13', NULL, '1.0605.20.00', NULL, NULL, NULL, 3.427, 0.0567),
    ('3505906', 'multa', 3537, 2015, '2018-09-05', NULL, '1.0105.21.00', '6004.10.94', 145.9, 0.0174, NULL, NULL),
    ('3205309', 'if', 2543, 2018, '2017-12-28', NULL, NULL, '3504.00.19', NULL, NULL, 11.1774, 0.0071),
    ('31', 'if', 4647, 2023, '2016-08-22', NULL, NULL, NULL, NULL, NULL, 9.5644, 0.0585),
    ('31', 'if', 2102, 2017, '2015-11-04', NULL, '1.0402.39.00', NULL, NULL, NULL, 2.355, 0.0018),
    ('4106902', 'if', 1184, 2026, '2020-01-03', NULL, NULL, NULL, NULL, NULL, 3.2273, 0.0769),
    ('51', 'if', 1668, 2022, '2025-12-11', NULL, NULL, '2921.19.14', NULL, NULL, 3.9928, 0.0261),
    ('3548906', 'if', 3836, 2024, '2022-04-17', NULL, NULL, NULL, NULL, NULL, 7.7892, 0.0587),
    ('41', 'multa', 2074, 2017, '2023-04-30', NULL, NULL, '8703.23.90', 101.42, 0.2348, NULL, NULL),
    ('35', 'multa', 2742, 2019, '2021-01-26', NULL, NULL, NULL, 211.67, 0.2456, NULL, NULL),
    ('3548906', 'if', 4502, 2025, '2017-05-26', NULL, '1.2304.1', NULL, NULL, NULL, 10.7666, 0.0664),
    ('43', 'if', 4871, 2025, '2018-11-20', NULL, '1.1201.34.00', NULL, NULL, NULL, 0.8245, 0.0376),
    ('3548906', 'if', 4359, 2023, '2018-05-18', NULL, NULL, NULL, NULL, NULL, 3.9712, 0.0559),
    ('5300108', 'multa', 4224, 2025, '2015-07-25', NULL, NULL, '8482.99.90', 85.38, 0.2229, NULL, NULL),
    ('5300108', 'multa', 1536, 2024, '2021-07-13', NULL, NULL, '2903.77.36', 247.43, 0.1289, NULL, NULL),
    ('3205309', 'if', 4218, 2017, '2016-01-23', '2020-11-10', '1.1703.2', '0207.14.12', NULL, NULL, 1.9829, 0.0692),
    ('3146107', 'if', 451, 2026, '2021-12-21', '2024-09-17', '1.1405.60.00', NULL, NULL, NULL, 3.176, 0.0255),
    ('3505906', 'multa', 4662, 2025, '2026-02-14', NULL, NULL, NULL, 75.04, 0.1123, NULL, NULL),
    ('31', 'multa', 2268, 2015, '2020-02-25', NULL, '1.0504.21.00', '7307.19.90', 147.1, 0.0463, NULL, NULL),
    ('33', 'multa', 3560, 2017, '2022-11-27', NULL, NULL, '6815.20.00', 120.89, 0.0152, NULL, NULL),
    ('32', 'multa', 1969, 2024, '2016-02-10', '2016-12-18', NULL, '3824.99.71', 110.16, 0.2105, NULL, NULL),
    ('35', 'if', 976, 2017, '2015-08-18', NULL, '1.1401.12.00', NULL, NULL, NULL, 4.9735, 0.0408),
    ('28', 'multa', 2165, 2023, '2015-11-28', '2022-06-14', NULL, '2702.20.00', 393.37, 0.0372, NULL, NULL),
    ('32', 'if', 1124, 2018, '2020-11-18', NULL, '1.0502.24.51', NULL, NULL, NULL, 0.7518, 0.0132),
    ('4106902', 'if', 1304, 2024, '2026-04-26', NULL, '1.0205.00.00', '8515.21.00', NULL, NULL, 2.5478, 0.0442),
    ('3146107', 'if', 4161, 2022, '2022-05-15', '2025-11-22', '1.0402.3', '2825.10.20', NULL, NULL, 2.6215, 0.0466),
    ('13', 'multa', 1176, 2015, '2020-04-06', NULL, '1.0906.90.00', NULL, 47.42, 0.1153, NULL, NULL),
    ('3501905', 'multa', 1324, 2023, '2022-09-25', NULL, NULL, NULL, 301.84, 0.1384, NULL, NULL),
    ('2919306', 'multa', 2213, 2017, '2025-12-10', NULL, NULL, '9032.89.2', 114.57, 0.1928, NULL, NULL),
    ('28', 'multa', 3089, 2016, '2022-07-08', NULL, NULL, NULL, 306.09, 0.0555, NULL, NULL),
    ('4208302', 'multa', 4489, 2017, '2015-01-10', NULL, NULL, NULL, 243.38, 0.1673, NULL, NULL),
    ('4208302', 'multa', 3013, 2018, '2020-08-16', NULL, NULL, NULL, 245.9, 0.0235, NULL, NULL),
    ('3146107', 'if', 2115, 2018, '2026-09-01', NULL, NULL, NULL, NULL, NULL, 5.657, 0.0276),
    ('3550308', 'multa', 4685, 2025, '2022-04-15', NULL, '1.1401.39.00', '6005.90.10', 221.73, 0.1097, NULL, NULL),
    ('2919306', 'multa', 3052, 2017, '2016-05-18', NULL, NULL, NULL, 143.72, 0.1533, NULL, NULL),
    ('3106200', 'multa', 1914, 2016, '2019-07-02', NULL, '1.1403.26.00', '4820.30.00', 191.59, 0.0137, NULL, NULL),
    ('5300108', 'if', 1656, 2018, '2020-07-08', NULL, '1.1402.22.00', '8457.30.10', NULL, NULL, 8.5569, 0.0332),
    ('4106902', 'multa', 1043, 2017, '2026-08-01', NULL, '1.0602.31.00', NULL, 114.03, 0.1626, NULL, NULL),
    ('33', 'if', 2042, 2021, '2026-07-04', NULL, NULL, NULL, NULL, NULL, 4.0753, 0.07),
    ('2927408', 'multa', 990, 2020, '2021-07-29', NULL, '1.0105.2', '2940.00.21', 253.46, 0.0828, NULL, NULL),
    ('4208302', 'multa', 3298, 2021, '2018-10-30', NULL, NULL, '4911.91.00', 264.14, 0.1631, NULL, NULL),
    ('3505906', 'if', 4198, 2025, '2017-10-09', NULL, '1.0904.2', '3808.99.19', NULL, NULL, 3.0086, 0.066),
    ('13', 'multa', 3883, 2022, '2022-11-25', NULL, '1.1108.20.00', '2925.29.90', 389.69, 0.0712, NULL, NULL),
    ('3106200', 'if', 4746, 2015, '2022-04-19', NULL, NULL, '2931.90.69', NULL, NULL, 4.378, 0.019),
    ('31', 'multa', 2268, 2022, '2020-12-26', NULL, NULL, NULL, 133.89, 0.1903, NULL, NULL),
    ('2919306', 'multa', 1990, 2024, '2020-02-26', NULL, NULL, NULL, 169.47, 0.1407, NULL, NULL),
    ('3505906', 'if', 3749, 2015, '2018-05-03', NULL, NULL, '3002.42.40', NULL, NULL, 2.8052, 0.0654),
    ('51', 'if', 209, 2026, '2017-09-05', NULL, '1.1903.20.00', '2903.99.3', NULL, NULL, 1.5877, 0.075),
    ('32', 'if', 1643, 2016, '2022-06-27', NULL, NULL, '1404.90.10', NULL, NULL, 0.7272, 0.0679),
    ('3304557', 'if', 2556, 2020, '2026-11-20', NULL, '1.1401.39.00', NULL, NULL, NULL, 1.646, 0.0229),
    ('51', 'multa', 2249, 2020, '2019-06-22', NULL, NULL, '2827.39.95', 155.74, 0.1308, NULL, NULL),
    ('41', 'multa', 2735, 2025, '2015-02-10', NULL, NULL, NULL, 75.97, 0.1766, NULL, NULL),
    ('3304557', 'multa', 3199, 2022, '2016-09-05', NULL, NULL, NULL, 81.49, 0.2297, NULL, NULL),
    ('3106200', 'multa', 3311, 2024, '2025-08-22', NULL, '1.1107.33.00', NULL, 212.26, 0.2119, NULL, NULL),
    ('4106902', 'multa', 3072, 2017, '2022-09-03', NULL, NULL, NULL, 130.6, 0.2473, NULL, NULL),
    ('3550308', 'multa', 4660, 2018, '2025-09-27', NULL, NULL, '9013.10.90', 148.21, 0.2306, NULL, NULL),
    ('3306305', 'multa', 1563, 2021, '2023-08-29', '2029-06-18', '1.0102.1', NULL, 741.16, 0.1383, NULL, NULL),
    ('3146206', 'if', 121, 2016, '2025-11-07', NULL, '1.1410.90.00', '0305.72.00', NULL, NULL, 5.7018, 0.0614),
    ('3501905', 'if', 4106, 2025, '2025-07-01', NULL, NULL, NULL, NULL, NULL, 1.4, 0.0215),
    ('21', 'multa', 4506, 2021, '2025-06-17', '2026-10-14', '1.1104', '3702.44.21', 247.75, 0.0822, NULL, NULL),
    ('4205407', 'if', 2064, 2015, '2017-09-07', NULL, NULL, NULL, NULL, NULL, 2.5406, 0.0301),
    ('41', 'multa', 1954, 2017, '2017-06-13', NULL, NULL, '6913.10.00', 163.82, 0.0933, NULL, NULL),
    ('26', 'multa', 4353, 2023, '2023-12-31', NULL, '1.0102.35.10', '8007.00.20', 144.82, 0.0289, NULL, NULL),
    ('3306305', 'if', 2770, 2024, '2024-11-10', NULL, '1.0107.20.00', '8403.10.90', NULL, NULL, 12.5737, 0.0685),
    ('4208302', 'multa', 2521, 2016, '2019-11-11', '2023-08-07', '1.0502.14.52', '8112.99.00', 135.0, 0.1447, NULL, NULL),
    ('5300108', 'if', 4666, 2020, '2020-04-07', NULL, '1.0501.11.10', '2834.10.10', NULL, NULL, 55.2374, 0.027),
    ('4308250', 'multa', 687, 2018, '2017-01-28', NULL, NULL, '8447.90.90', 103.35, 0.1144, NULL, NULL),
    ('35', 'if', 2518, 2016, '2022-05-11', NULL, NULL, '8525.60.10', NULL, NULL, 4.4006, 0.0762),
    ('3205309', 'multa', 4344, 2025, '2021-12-18', NULL, '1.0102.5', NULL, 115.89, 0.0876, NULL, NULL),
    ('3505906', 'if', 191, 2025, '2024-12-23', NULL, NULL, '7605.21.10', NULL, NULL, 2.1408, 0.0073),
    ('3548906', 'multa', 506, 2022, '2022-11-10', NULL, '1.0402.21.20', '1511.10.00', 61.75, 0.078, NULL, NULL),
    ('4308250', 'if', 2000, 2018, '2018-08-14', NULL, '1.1201.40.00', '7110.39.00', NULL, NULL, 3.1116, 0.0479),
    ('3146206', 'multa', 4294, 2022, '2019-10-14', NULL, NULL, NULL, 640.66, 0.0388, NULL, NULL),
    ('4314902', 'multa', 1368, 2016, '2019-01-06', NULL, '1.0502.14.40', NULL, 21833.61, 0.2009, NULL, NULL),
    ('3306305', 'if', 4240, 2016, '2018-11-15', NULL, NULL, NULL, NULL, NULL, 4.0582, 0.0547),
    ('35', 'if', 1582, 2015, '2016-08-18', NULL, '1.1701.90.00', NULL, NULL, NULL, 1.6801, 0.0017),
    ('3106200', 'if', 2141, 2024, '2015-11-06', '2016-12-13', NULL, NULL, NULL, NULL, 13.2364, 0.0572),
    ('24', 'multa', 4141, 2026, '2016-07-20', NULL, '1.1806.82.00', '4009.21.10', 133.07, 0.0326, NULL, NULL),
    ('3306305', 'multa', 771, 2021, '2016-08-13', NULL, NULL, NULL, 167.93, 0.1299, NULL, NULL),
    ('33', 'if', 383, 2026, '2020-07-25', NULL, NULL, NULL, NULL, NULL, 3.0224, 0.0704),
    ('31', 'multa', 1158, 2022, '2018-10-08', NULL, '1.0501.32.00', '8524.92.00', 99.02, 0.0693, NULL, NULL),
    ('5300108', 'if', 4492, 2022, '2016-09-29', NULL, '1.2506.00.00', '8536.69.10', NULL, NULL, 2.2541, 0.0688),
    ('4208302', 'multa', 1125, 2023, '2016-02-08', NULL, NULL, NULL, 188.26, 0.1508, NULL, NULL),
    ('26', 'if', 3445, 2025, '2025-10-15', '2029-04-08', NULL, '2914.22.20', NULL, NULL, 6.7142, 0.0655),
    ('3146206', 'multa', 2513, 2023, '2024-02-04', NULL, '1.0301.3', '2933.99.59', 220.21, 0.011, NULL, NULL),
    ('4314902', 'multa', 2680, 2024, '2024-01-21', NULL, '1.1803.10.00', NULL, 119.99, 0.1093, NULL, NULL),
    ('3146107', 'if', 1783, 2022, '2017-02-09', NULL, NULL, NULL, NULL, NULL, 0.8858, 0.0428),
    ('3106200', 'if', 4708, 2017, '2019-06-17', '2020-03-17', '1.1303', NULL, NULL, NULL, 3.3998, 0.076),
    ('3205309', 'multa', 1488, 2025, '2023-01-26', NULL, '1.2404.19.00', NULL, 157.12, 0.0318, NULL, NULL),
    ('28', 'multa', 2724, 2022, '2016-12-18', NULL, NULL, NULL, 168.92, 0.0563, NULL, NULL),
    ('33', 'if', 2241, 2017, '2024-02-08', NULL, NULL, NULL, NULL, NULL, 2.2853, 0.0355),
    ('3306305', 'if', 3475, 2025, '2023-08-21', NULL, NULL, '8518.21.00', NULL, NULL, 4.7825, 0.0027),
    ('3501905', 'multa', 725, 2017, '2019-07-16', NULL, NULL, NULL, 99.27, 0.0132, NULL, NULL),
    ('4308250', 'if', 4745, 2025, '2026-01-17', NULL, NULL, '3909.40.91', NULL, NULL, 1.8412, 0.0604),
    ('4314902', 'if', 2031, 2017, '2025-07-30', NULL, '1.0505.10.00', NULL, NULL, NULL, 1.8757, 0.0466),
    ('43', 'multa', 3525, 2025, '2017-08-11', NULL, NULL, NULL, 67.78, 0.0745, NULL, NULL),
    ('33', 'multa', 4935, 2017, '2025-08-03', NULL, '1.0101.2', '2933.91.33', 1809.99, 0.1883, NULL, NULL),
    ('35', 'if', 4936, 2018, '2018-02-27', NULL, NULL, NULL, NULL, NULL, 57.6813, 0.0612),
    ('42', 'multa', 1981, 2021, '2020-01-08', NULL, '1.0502.24.20', NULL, 356.64, 0.0858, NULL, NULL),
    ('3505906', 'if', 4818, 2021, '2023-05-08', NULL, NULL, '8703.21.00', NULL, NULL, 4.0082, 0.0386),
    ('21', 'if', 3938, 2016, '2023-01-24', NULL, NULL, '2936.29.40', NULL, NULL, 0.6749, 0.0161),
    ('42', 'if', 3291, 2016, '2016-04-05', NULL, NULL, '6208.92.00', NULL, NULL, 2.4209, 0.0416),
    ('26', 'multa', 4259, 2024, '2023-01-10', NULL, NULL, NULL, 115.59, 0.2189, NULL, NULL),
    ('3306305', 'if', 4233, 2025, '2021-04-30', NULL, NULL, NULL, NULL, NULL, 1.2548, 0.0308),
    ('4314902', 'multa', 576, 2025, '2022-11-04', '2023-01-29', NULL, NULL, 83.79, 0.1212, NULL, NULL),
    ('26', 'multa', 4456, 2016, '2016-02-22', NULL, '1.0401.22.00', NULL, 168.21, 0.2468, NULL, NULL),
    ('21', 'multa', 2064, 2016, '2019-03-21', NULL, NULL, NULL, 281.99, 0.1601, NULL, NULL),
    ('3106200', 'if', 164, 2017, '2015-10-18', '2020-03-20', '1.1412.00.00', '4107.12.20', NULL, NULL, 4.1299, 0.0287),
    ('41', 'multa', 4806, 2016, '2015-12-07', NULL, NULL, NULL, 331.99, 0.2448, NULL, NULL),
    ('43', 'multa', 4249, 2015, '2021-10-03', NULL, NULL, NULL, 360.1, 0.1506, NULL, NULL),
    ('51', 'multa', 2241, 2021, '2022-03-03', '2027-05-16', '1.0502.2', NULL, 210.36, 0.0906, NULL, NULL),
    ('35', 'if', 2541, 2024, '2022-10-05', NULL, NULL, NULL, NULL, NULL, 5.176, 0.0231),
    ('3306305', 'multa', 3287, 2022, '2015-11-28', NULL, NULL, NULL, 173.59, 0.2386, NULL, NULL),
    ('41', 'multa', 1733, 2024, '2026-07-04', NULL, '1.0102.3', '1212.94.00', 940.3, 0.1287, NULL, NULL),
    ('3550308', 'multa', 57, 2015, '2015-07-02', NULL, '1.2504.21.00', NULL, 339.6, 0.2315, NULL, NULL),
    ('43', 'multa', 1643, 2017, '2025-01-14', NULL, NULL, NULL, 474.42, 0.1734, NULL, NULL),
    ('2919306', 'multa', 3212, 2025, '2022-09-26', NULL, NULL, NULL, 226.15, 0.159, NULL, NULL),
    ('3304557', 'if', 3811, 2016, '2025-02-17', NULL, '1.1706.24.00', NULL, NULL, NULL, 1.6863, 0.0118),
    ('3306305', 'multa', 420, 2021, '2020-10-20', NULL, NULL, NULL, 193.47, 0.0768, NULL, NULL),
    ('31', 'if', 637, 2015, '2019-08-02', NULL, '1.0102.35.30', '2901.23.00', NULL, NULL, 91.0074, 0.0758),
    ('3550308', 'if', 1527, 2024, '2016-09-23', NULL, NULL, NULL, NULL, NULL, 0.8249, 0.0634),
    ('24', 'if', 4946, 2015, '2020-10-09', NULL, NULL, '8701.95.90', NULL, NULL, 5.4236, 0.0065),
    ('32', 'if', 4898, 2021, '2024-11-04', NULL, '1.0107.30.00', '3004.90.36', NULL, NULL, 4.0347, 0.0433),
    ('1302603', 'if', 31, 2026, '2015-11-22', NULL, NULL, NULL, NULL, NULL, 6.364, 0.0296),
    ('4106902', 'multa', 4549, 2018, '2021-12-29', NULL, '1.1404.1', NULL, 39.95, 0.0921, NULL, NULL),
    ('32', 'if', 1073, 2019, '2020-03-10', '2026-06-23', NULL, NULL, NULL, NULL, 4.0764, 0.0116),
    ('3146107', 'multa', 1992, 2026, '2015-06-19', NULL, NULL, NULL, 171.24, 0.0114, NULL, NULL),
    ('28', 'multa', 169, 2016, '2020-02-04', NULL, '1.1406.33.00', NULL, 124.95, 0.2147, NULL, NULL),
    ('3306305', 'multa', 1830, 2022, '2023-07-19', NULL, '1.0904.37.00', '8112.41.00', 228.33, 0.1314, NULL, NULL),
    ('3146107', 'if', 1625, 2024, '2021-09-18', NULL, '1.0910.90.00', NULL, NULL, NULL, 1.0839, 0.0445),
    ('4106902', 'if', 601, 2018, '2016-07-14', NULL, NULL, '3824.99.61', NULL, NULL, 74.4081, 0.0318),
    ('26', 'if', 3805, 2025, '2018-03-10', NULL, '1.20', NULL, NULL, NULL, 1.1742, 0.0376),
    ('4106902', 'if', 274, 2021, '2022-09-02', NULL, '1.1501.30.00', '2922.49.69', NULL, NULL, 54.3445, 0.0044),
    ('4314902', 'if', 3126, 2023, '2019-10-03', NULL, NULL, NULL, NULL, NULL, 1.4804, 0.0357),
    ('31', 'if', 3806, 2017, '2021-03-26', NULL, NULL, NULL, NULL, NULL, 2.8217, 0.0213),
    ('3505906', 'if', 3715, 2025, '2020-07-11', NULL, NULL, '8502.13.90', NULL, NULL, 2.4817, 0.0605),
    ('1302603', 'if', 379, 2017, '2023-07-08', NULL, NULL, '2902.50.00', NULL, NULL, 4.1293, 0.0424),
    ('41', 'if', 4723, 2021, '2015-04-28', NULL, '1.0401.42.00', '9702.10.00', NULL, NULL, 24.2865, 0.0044),
    ('32', 'multa', 3703, 2018, '2018-01-18', NULL, NULL, '3102.29.10', 119.02, 0.1314, NULL, NULL),
    ('24', 'if', 2799, 2023, '2018-02-17', NULL, NULL, NULL, NULL, NULL, 6.7957, 0.0358),
    ('51', 'multa', 62, 2022, '2021-12-01', NULL, NULL, NULL, 15.21, 0.1851, NULL, NULL),
    ('2919306', 'if', 4122, 2018, '2016-12-09', NULL, NULL, NULL, NULL, NULL, 4.5565, 0.0397),
    ('26', 'multa', 3802, 2021, '2021-09-18', NULL, '1.1001.11.00', NULL, 65.36, 0.1224, NULL, NULL),
    ('3501905', 'if', 4366, 2017, '2019-10-26', '2022-09-15', '1.11', '7209.18.00', NULL, NULL, 3.4773, 0.0499),
    ('33', 'multa', 4441, 2025, '2017-11-12', '2020-04-30', '1.1801.11.00', NULL, 108.22, 0.2452, NULL, NULL),
    ('3501905', 'if', 4764, 2024, '2026-04-29', NULL, '1.0403.24.00', '8703.23.90', NULL, NULL, 6.8295, 0.0108),
    ('26', 'multa', 3365, 2019, '2024-04-10', NULL, NULL, NULL, 154.08, 0.0905, NULL, NULL),
    ('51', 'multa', 3491, 2023, '2021-12-10', NULL, NULL, '5206.22.00', 111.48, 0.0572, NULL, NULL),
    ('3146206', 'if', 3805, 2024, '2025-04-14', NULL, NULL, NULL, NULL, NULL, 2.2394, 0.0166),
    ('24', 'if', 1692, 2021, '2026-11-29', '2033-05-17', NULL, '7217.10.90', NULL, NULL, 3.6347, 0.0151),
    ('13', 'multa', 4941, 2025, '2023-08-16', NULL, '1.0502.11.20', '0207.54.00', 15.63, 0.1775, NULL, NULL),
    ('3106200', 'if', 1254, 2024, '2018-02-03', NULL, NULL, '9028.30.39', NULL, NULL, 6.1295, 0.0202),
    ('3146206', 'if', 3810, 2024, '2024-02-05', NULL, '1.0401.15', '8802.20.10', NULL, NULL, 2.8208, 0.0204),
    ('3505906', 'multa', 708, 2020, '2023-05-29', NULL, '1.2402.10.00', NULL, 210.55, 0.1498, NULL, NULL),
    ('42', 'multa', 3878, 2020, '2025-06-10', '2026-06-23', NULL, '3911.10.2', 321.78, 0.0739, NULL, NULL),
    ('28', 'if', 3208, 2022, '2015-02-20', NULL, NULL, '2930.90.85', NULL, NULL, 1.818, 0.0439),
    ('3505906', 'multa', 2823, 2015, '2025-10-05', NULL, '1.1805.14.00', NULL, 177.71, 0.2256, NULL, NULL),
    ('3548906', 'if', 2906, 2026, '2023-09-25', NULL, NULL, '2508.40.90', NULL, NULL, 4.4551, 0.0145),
    ('53', 'if', 3088, 2016, '2015-01-29', NULL, '1.0609.00.00', '4802.62.99', NULL, NULL, 7.8062, 0.075),
    ('4314902', 'multa', 2806, 2021, '2019-03-15', NULL, '1.2205.19.00', NULL, 439.5, 0.1416, NULL, NULL),
    ('42', 'multa', 3645, 2015, '2025-02-03', NULL, '1.0107.30.00', '0304.72.00', 930.69, 0.2155, NULL, NULL),
    ('1302603', 'if', 1785, 2026, '2015-05-26', NULL, '1.2404.39.00', '3824.99.87', NULL, NULL, 0.9173, 0.0196),
    ('3146206', 'multa', 402, 2020, '2023-08-06', NULL, NULL, NULL, 176.09, 0.1313, NULL, NULL),
    ('51', 'multa', 3016, 2016, '2016-09-10', NULL, '1.0301.90.00', '8506.10.32', 782.25, 0.142, NULL, NULL),
    ('3205309', 'if', 1868, 2026, '2025-07-22', NULL, '1.2302.22.00', NULL, NULL, NULL, 1.3443, 0.0722),
    ('3106200', 'multa', 693, 2026, '2024-12-30', NULL, NULL, NULL, 193.7, 0.2036, NULL, NULL),
    ('41', 'multa', 1849, 2024, '2025-02-18', NULL, '1.0501.39.00', NULL, 313.46, 0.0647, NULL, NULL),
    ('3550308', 'if', 4036, 2018, '2022-12-30', NULL, '1.2003.29.00', NULL, NULL, NULL, 2.5332, 0.074),
    ('2927408', 'multa', 931, 2015, '2015-07-02', NULL, NULL, '2921.19.41', 78.22, 0.0918, NULL, NULL),
    ('28', 'multa', 2203, 2021, '2015-10-22', NULL, NULL, NULL, 1905.29, 0.0125, NULL, NULL),
    ('24', 'multa', 4985, 2025, '2022-12-21', NULL, NULL, NULL, 201.16, 0.0647, NULL, NULL),
    ('31', 'if', 4524, 2026, '2019-07-24', '2025-09-21', '1.0910.20.00', '5604.90.22', NULL, NULL, 3.8266, 0.0538),
    ('3548906', 'if', 3227, 2015, '2022-06-30', NULL, NULL, NULL, NULL, NULL, 5.6042, 0.0305),
    ('26', 'if', 173, 2015, '2024-05-23', NULL, '1.01', NULL, NULL, NULL, 38.5251, 0.0765),
    ('4208302', 'multa', 4275, 2017, '2022-08-28', NULL, '1.1405.11.00', '2933.29.2', 382.1, 0.0905, NULL, NULL),
    ('3304557', 'multa', 4848, 2017, '2017-08-03', NULL, NULL, '3004.90.32', 110.75, 0.1912, NULL, NULL),
    ('4106902', 'if', 4863, 2015, '2015-09-04', NULL, '1.0604.40.00', NULL, NULL, NULL, 15.9822, 0.0617),
    ('4308250', 'multa', 4561, 2018, '2019-09-24', NULL, NULL, NULL, 391.0, 0.1009, NULL, NULL),
    ('3205309', 'if', 1510, 2023, '2026-01-06', NULL, '1.1903.12.00', NULL, NULL, NULL, 3.0364, 0.0344),
    ('3146107', 'multa', 3207, 2025, '2026-02-12', NULL, NULL, NULL, 109.47, 0.1964, NULL, NULL),
    ('26', 'multa', 1777, 2017, '2017-05-06', NULL, NULL, '2917.39.40', 317.46, 0.1998, NULL, NULL),
    ('3505906', 'multa', 4421, 2022, '2026-02-06', NULL, NULL, '3922.20.00', 223.43, 0.1527, NULL, NULL),
    ('32', 'multa', 841, 2017, '2023-02-25', NULL, '1.0503.24.00', NULL, 119.2, 0.2152, NULL, NULL),
    ('13', 'multa', 4322, 2017, '2022-04-24', '2026-02-18', NULL, '0602.40.00', 137.53, 0.1244, NULL, NULL),
    ('1302603', 'multa', 4099, 2026, '2025-06-05', NULL, '1.0102.35.20', '3905.91.90', 220.57, 0.2395, NULL, NULL),
    ('4308250', 'multa', 2651, 2019, '2021-11-19', NULL, '1.0106.60.00', '1602.32.10', 614.1, 0.146, NULL, NULL),
    ('42', 'multa', 1117, 2026, '2023-06-06', NULL, NULL, '8704.32.90', 327.97, 0.1838, NULL, NULL),
    ('51', 'multa', 3537, 2016, '2020-04-26', NULL, NULL, NULL, 94.86, 0.0802, NULL, NULL),
    ('24', 'multa', 4069, 2025, '2015-05-07', NULL, NULL, '2933.91.12', 74.98, 0.1534, NULL, NULL),
    ('41', 'multa', 1619, 2018, '2026-06-26', '2031-03-20', '1.1409.23.00', NULL, 178.12, 0.1193, NULL, NULL),
    ('3304557', 'if', 1890, 2024, '2016-03-02', NULL, NULL, NULL, NULL, NULL, 4.9169, 0.0697),
    ('3304557', 'multa', 2798, 2020, '2024-04-17', '2025-06-28', NULL, '2908.19.29', 236.37, 0.1707, NULL, NULL),
    ('33', 'multa', 769, 2019, '2025-05-10', NULL, '1.0801', '6212.10.00', 229.13, 0.1657, NULL, NULL),
    ('21', 'if', 4035, 2017, '2019-10-23', '2021-12-05', NULL, NULL, NULL, NULL, 3.2244, 0.0464),
    ('24', 'if', 369, 2015, '2017-03-27', NULL, NULL, NULL, NULL, NULL, 4.062, 0.068),
    ('5300108', 'if', 4364, 2026, '2025-03-08', NULL, '1.1802.50.00', NULL, NULL, NULL, 1.7051, 0.0014),
    ('4208302', 'if', 3459, 2017, '2018-01-17', NULL, '1.1806', NULL, NULL, NULL, 3.4374, 0.0373),
    ('3306305', 'multa', 1918, 2021, '2017-02-13', '2019-04-15', '1.15', NULL, 76.32, 0.1517, NULL, NULL),
    ('4205407', 'multa', 1266, 2015, '2022-12-08', '2023-03-09', '1.1404.21.00', '2207.10.10', 164.04, 0.1313, NULL, NULL),
    ('4308250', 'multa', 4268, 2022, '2026-09-02', NULL, '1.1408.12.00', NULL, 1110.77, 0.1467, NULL, NULL),
    ('43', 'multa', 2131, 2017, '2025-10-19', NULL, NULL, NULL, 69.26, 0.0172, NULL, NULL),
    ('4208302', 'if', 4100, 2024, '2026-07-30', NULL, NULL, '2939.11.32', NULL, NULL, 1.2707, 0.0169),
    ('3304557', 'if', 4359, 2020, '2022-10-07', NULL, '1.1502.10.00', NULL, NULL, NULL, 3.8856, 0.0231),
    ('32', 'if', 4907, 2018, '2022-08-31', NULL, NULL, '2937.23.51', NULL, NULL, 4.5466, 0.0618),
    ('4205407', 'if', 459, 2017, '2018-10-21', NULL, NULL, NULL, NULL, NULL, 3.9496, 0.0524),
    ('3550308', 'if', 337, 2023, '2024-11-08', '2031-09-04', '1.0905.21.00', '0106.33.10', NULL, NULL, 4.0612, 0.0719),
    ('33', 'multa', 663, 2026, '2018-11-04', NULL, '1.0103.41.00', '5513.21.00', 234.63, 0.2025, NULL, NULL),
    ('13', 'multa', 925, 2023, '2026-04-01', NULL, NULL, '3904.50.90', 64.08, 0.0935, NULL, NULL),
    ('26', 'multa', 851, 2021, '2017-02-09', '2017-10-13', NULL, '7219.31.00', 179.18, 0.142, NULL, NULL),
    ('32', 'if', 2983, 2026, '2023-02-18', NULL, '1.1405.21.00', '4008.29.00', NULL, NULL, 5.439, 0.0454),
    ('29', 'if', 3488, 2024, '2021-09-02', NULL, NULL, NULL, NULL, NULL, 11.4425, 0.0246),
    ('4314902', 'multa', 2496, 2026, '2021-11-20', NULL, '1.1805.62.00', '9032.89.82', 40.82, 0.1964, NULL, NULL),
    ('28', 'multa', 4021, 2021, '2019-07-21', NULL, '1.0505.10.00', NULL, 95.26, 0.0868, NULL, NULL),
    ('4314902', 'if', 955, 2018, '2021-01-06', NULL, NULL, '7326.20.00', NULL, NULL, 2.8135, 0.0218),
    ('1302603', 'multa', 2689, 2017, '2022-07-31', NULL, '1.0501.25.00', NULL, 255.97, 0.0241, NULL, NULL),
    ('42', 'if', 719, 2019, '2023-10-17', NULL, NULL, NULL, NULL, NULL, 7.4134, 0.0273),
    ('5300108', 'multa', 730, 2019, '2019-08-05', NULL, '1.0501.24.10', NULL, 352.92, 0.0302, NULL, NULL),
    ('3146107', 'if', 4542, 2016, '2020-09-20', '2026-07-07', NULL, NULL, NULL, NULL, 1.3014, 0.0553),
    ('3205309', 'if', 3237, 2022, '2015-02-07', NULL, NULL, NULL, NULL, NULL, 2.7991, 0.0581),
    ('31', 'if', 4494, 2023, '2019-05-29', '2019-08-21', '1.0901.51', NULL, NULL, NULL, 5.6262, 0.0582),
    ('4314902', 'multa', 4398, 2025, '2023-01-15', '2029-06-30', NULL, NULL, 259.85, 0.1318, NULL, NULL),
    ('43', 'if', 4611, 2018, '2016-12-02', NULL, NULL, NULL, NULL, NULL, 2.7084, 0.0245),
    ('53', 'if', 2047, 2024, '2022-12-22', NULL, NULL, NULL, NULL, NULL, 5.4476, 0.0564),
    ('21', 'if', 2519, 2015, '2019-03-31', NULL, NULL, '8509.40.10', NULL, NULL, 3.088, 0.0291),
    ('3548906', 'multa', 1955, 2022, '2017-03-30', NULL, '1.2304.20.00', NULL, 319.48, 0.0234, NULL, NULL),
    ('35', 'multa', 4371, 2019, '2016-02-19', NULL, NULL, '9003.11.00', 304.98, 0.2191, NULL, NULL),
    ('4208302', 'multa', 1464, 2017, '2017-11-09', NULL, '1.0501.24.2', '8007.00.90', 118.76, 0.1697, NULL, NULL),
    ('41', 'multa', 3237, 2015, '2022-03-18', NULL, '1.1806.90.00', '8462.49.00', 102.39, 0.2092, NULL, NULL),
    ('32', 'if', 3630, 2023, '2017-11-15', NULL, '1.1201.3', NULL, NULL, NULL, 0.4432, 0.0118),
    ('24', 'if', 1145, 2016, '2018-05-05', NULL, NULL, NULL, NULL, NULL, 12.2728, 0.0648),
    ('3548906', 'multa', 372, 2023, '2020-07-23', NULL, NULL, '8707.90.10', 113.51, 0.1042, NULL, NULL),
    ('1302603', 'multa', 1984, 2025, '2026-07-24', NULL, '1.0401.15.20', NULL, 103.23, 0.2166, NULL, NULL),
    ('2919306', 'multa', 4852, 2021, '2018-01-28', '2024-06-12', NULL, '5513.21.00', 293.7, 0.2018, NULL, NULL),
    ('3501905', 'if', 3018, 2015, '2015-09-02', NULL, '1.1501.10.00', '2106.90.90', NULL, NULL, 106.4393, 0.0771),
    ('32', 'if', 3331, 2017, '2025-01-07', NULL, '1.02', '2914.40.10', NULL, NULL, 2.4689, 0.0307),
    ('43', 'multa', 628, 2021, '2022-05-23', NULL, '1.1805.50.00', NULL, 172.23, 0.1974, NULL, NULL),
    ('43', 'if', 1048, 2025, '2017-05-11', NULL, '1.2003.26.90', NULL, NULL, NULL, 3.2767, 0.0238),
    ('29', 'multa', 2882, 2021, '2024-08-05', NULL, '1.1202.10.00', NULL, 93.82, 0.1909, NULL, NULL),
    ('3505906', 'if', 1690, 2015, '2026-02-11', NULL, NULL, NULL, NULL, NULL, 7.1479, 0.0635),
    ('3505906', 'multa', 1423, 2022, '2017-08-22', NULL, NULL, '8473.40.90', 245.76, 0.071, NULL, NULL),
    ('2927408', 'multa', 2778, 2021, '2017-11-19', NULL, '1.0501.2', '4902.90.00', 132.51, 0.1287, NULL, NULL),
    ('5300108', 'if', 1599, 2017, '2021-05-10', NULL, '1.0102.52.10', NULL, NULL, NULL, 4.8099, 0.0405),
    ('32', 'if', 702, 2024, '2026-02-17', NULL, '1.1805.3', '8479.89.11', NULL, NULL, 4.7015, 0.0367),
    ('3505906', 'multa', 305, 2023, '2022-01-16', NULL, NULL, NULL, 303.77, 0.1491, NULL, NULL),
    ('42', 'if', 4978, 2017, '2025-09-19', '2029-06-10', '1.0504.43.00', NULL, NULL, NULL, 45.9843, 0.028),
    ('3304557', 'multa', 3700, 2021, '2022-04-20', NULL, '1.0102.13.00', '2931.59.1', 288.11, 0.2418, NULL, NULL),
    ('2919306', 'if', 731, 2017, '2025-06-03', NULL, NULL, NULL, NULL, NULL, 480.1423, 0.0643),
    ('41', 'if', 2719, 2017, '2024-04-02', NULL, '1.2203.10.00', NULL, NULL, NULL, 6.6233, 0.0634),
    ('5300108', 'multa', 1044, 2020, '2020-09-26', NULL, NULL, NULL, 164.77, 0.0161, NULL, NULL),
    ('2927408', 'if', 3126, 2021, '2015-05-02', NULL, NULL, NULL, NULL, NULL, 0.5423, 0.008),
    ('3146107', 'if', 2447, 2018, '2025-05-23', '2029-07-28', NULL, NULL, NULL, NULL, 2.1113, 0.0781),
    ('3146206', 'multa', 4714, 2023, '2018-12-04', NULL, NULL, NULL, 102.59, 0.1532, NULL, NULL),
    ('1302603', 'multa', 3405, 2022, '2018-01-07', NULL, '1.0901.29.00', '8431.31.10', 96.41, 0.1496, NULL, NULL),
    ('26', 'if', 4045, 2019, '2020-01-05', NULL, NULL, NULL, NULL, NULL, 132.7954, 0.0452),
    ('13', 'if', 1765, 2018, '2021-12-02', NULL, NULL, '1401.10.00', NULL, NULL, 2.3009, 0.0469),
    ('26', 'multa', 706, 2026, '2024-08-27', '2029-08-27', '1.0201.00.00', NULL, 407.53, 0.2495, NULL, NULL),
    ('53', 'multa', 2488, 2017, '2023-05-25', NULL, NULL, '9028.30.31', 5020.64, 0.234, NULL, NULL),
    ('33', 'if', 183, 2016, '2026-03-23', '2029-02-18', NULL, '2930.30.22', NULL, NULL, 1.4771, 0.0178),
    ('43', 'multa', 3292, 2017, '2019-02-11', NULL, '1.0502.31.10', '2922.39.2', 217.88, 0.0269, NULL, NULL),
    ('4106902', 'multa', 793, 2016, '2023-10-28', NULL, '1.1301', NULL, 89.65, 0.2466, NULL, NULL),
    ('13', 'multa', 2960, 2016, '2019-11-23', NULL, NULL, NULL, 591.5, 0.1346, NULL, NULL),
    ('3106200', 'if', 2696, 2023, '2015-04-17', NULL, '1.0401.2', '4203.30.00', NULL, NULL, 0.3974, 0.0674),
    ('26', 'multa', 2211, 2020, '2016-10-08', '2023-05-27', '1.0102.41', NULL, 118.44, 0.0346, NULL, NULL),
    ('3501905', 'if', 852, 2016, '2023-02-08', NULL, '1.0903.22.00', NULL, NULL, NULL, 2.6314, 0.0622),
    ('28', 'if', 3836, 2026, '2020-04-12', '2026-06-26', '1.0901.51.24', '3702.53.00', NULL, NULL, 2.5033, 0.0043),
    ('3306305', 'multa', 3557, 2020, '2021-03-14', NULL, NULL, '8409.99.59', 349.71, 0.2369, NULL, NULL),
    ('4314902', 'multa', 3581, 2016, '2023-12-02', NULL, '1.2405', NULL, 113.65, 0.0531, NULL, NULL),
    ('53', 'if', 4056, 2020, '2024-01-09', '2027-01-09', NULL, '8477.59.1', NULL, NULL, 2.6243, 0.0733),
    ('31', 'multa', 2510, 2016, '2024-06-16', NULL, '1.0504.49.00', NULL, 300.7, 0.1509, NULL, NULL),
    ('4106902', 'if', 1485, 2026, '2017-05-19', NULL, '1.0502.24', '2929.90.39', NULL, NULL, 2.8845, 0.0123),
    ('42', 'multa', 1272, 2026, '2015-04-25', NULL, '1.0402.3', NULL, 194.58, 0.1972, NULL, NULL),
    ('3304557', 'if', 918, 2023, '2016-02-25', NULL, '1.0904.36.00', NULL, NULL, NULL, 2.6731, 0.0505),
    ('2927408', 'multa', 441, 2017, '2018-06-30', NULL, NULL, NULL, 71.72, 0.2351, NULL, NULL),
    ('3548906', 'multa', 4294, 2018, '2026-01-07', NULL, NULL, NULL, 115.69, 0.2061, NULL, NULL),
    ('51', 'multa', 4575, 2019, '2023-09-15', NULL, '1.2602.90.00', '4303.90.00', 96.1, 0.0929, NULL, NULL),
    ('3548906', 'if', 4688, 2026, '2018-05-15', NULL, '1.0401.12.20', '2920.90.32', NULL, NULL, 3.7795, 0.0528),
    ('33', 'if', 2393, 2026, '2015-04-05', NULL, NULL, '3209.10.20', NULL, NULL, 4.0644, 0.0298),
    ('3146206', 'if', 3790, 2016, '2018-01-13', '2021-02-19', '1.0401.4', '3901.20.2', NULL, NULL, 2.0533, 0.0729),
    ('3501905', 'if', 2771, 2018, '2017-12-30', '2018-08-08', NULL, NULL, NULL, NULL, 2.3908, 0.0686),
    ('24', 'multa', 568, 2017, '2025-06-16', '2028-04-12', '1.0901.52', NULL, 316.72, 0.0645, NULL, NULL),
    ('42', 'if', 517, 2020, '2022-11-03', NULL, '1.0605.20.00', '5514.43.00', NULL, NULL, 3.0842, 0.077),
    ('24', 'multa', 1544, 2023, '2021-01-12', NULL, NULL, NULL, 196.09, 0.0488, NULL, NULL),
    ('3146206', 'if', 3007, 2017, '2021-01-25', NULL, '1.1801.2', NULL, NULL, NULL, 3.0046, 0.0431),
    ('3146206', 'multa', 1103, 2021, '2022-12-17', NULL, NULL, NULL, 168.2, 0.1286, NULL, NULL),
    ('41', 'if', 2839, 2016, '2025-05-15', NULL, '1.1702.90.00', NULL, NULL, NULL, 7.0544, 0.0684),
    ('51', 'if', 1608, 2026, '2019-05-25', NULL, NULL, NULL, NULL, NULL, 4.5872, 0.0317),
    ('21', 'multa', 1927, 2022, '2021-05-10', NULL, '1.0504.12.00', '2933.21.2', 178.98, 0.1157, NULL, NULL),
    ('41', 'if', 3100, 2025, '2021-07-28', NULL, NULL, '2934.20.31', NULL, NULL, 4.6711, 0.011),
    ('4314902', 'multa', 999, 2025, '2022-05-05', NULL, '1.2406', '5911.32.00', 154.11, 0.1073, NULL, NULL),
    ('3205309', 'multa', 2355, 2019, '2024-11-13', NULL, NULL, NULL, 65.96, 0.0487, NULL, NULL),
    ('35', 'if', 65, 2017, '2024-09-10', NULL, '1.1701.1', '2922.49.59', NULL, NULL, 3.9496, 0.0344),
    ('28', 'multa', 4867, 2017, '2017-06-16', NULL, '1.0303.14.00', NULL, 113.23, 0.1927, NULL, NULL),
    ('3550308', 'if', 726, 2026, '2015-12-12', NULL, NULL, '2903.11.20', NULL, NULL, 9.5051, 0.0173),
    ('3205309', 'if', 2912, 2019, '2022-07-01', NULL, NULL, '2403.91.00', NULL, NULL, 7.3554, 0.0168),
    ('53', 'if', 4456, 2016, '2018-08-08', NULL, NULL, '6405.10.10', NULL, NULL, 1.4967, 0.0604),
    ('41', 'if', 2963, 2024, '2018-11-16', NULL, '1.1806.52.00', '5513.11.00', NULL, NULL, 5.4369, 0.0012),
    ('3306305', 'if', 4232, 2018, '2016-03-19', NULL, '1.0403', '6104.19.90', NULL, NULL, 4.1113, 0.0744),
    ('4208302', 'if', 661, 2025, '2024-04-14', '2030-06-06', '1.0401.11.19', '4412.10.00', NULL, NULL, 1.7998, 0.0534),
    ('21', 'multa', 1916, 2021, '2015-02-14', NULL, '1.0102.61.00', '5212.12.00', 410.05, 0.0939, NULL, NULL),
    ('28', 'if', 1797, 2019, '2024-07-22', '2029-06-26', NULL, NULL, NULL, NULL, 0.4533, 0.0334),
    ('3146206', 'multa', 2856, 2021, '2022-02-04', NULL, '1.0402.21.10', NULL, 248.37, 0.2093, NULL, NULL),
    ('3146206', 'multa', 3812, 2024, '2023-12-03', NULL, '1.0504.45.10', '8507.10.90', 92.13, 0.1801, NULL, NULL),
    ('29', 'multa', 2894, 2015, '2017-05-28', NULL, NULL, '8903.12.00', 416.4, 0.0837, NULL, NULL),
    ('21', 'if', 739, 2025, '2015-01-19', NULL, '1.0401.16.20', NULL, NULL, NULL, 17.3613, 0.0521),
    ('51', 'if', 680, 2022, '2015-09-18', NULL, NULL, NULL, NULL, NULL, 1.9313, 0.0278),
    ('42', 'if', 4999, 2021, '2021-02-05', NULL, NULL, '7315.82.00', NULL, NULL, 1.1156, 0.0661),
    ('3205309', 'multa', 464, 2025, '2022-12-16', NULL, '1.1001.22.00', '8412.31.90', 39.03, 0.0404, NULL, NULL),
    ('32', 'multa', 2349, 2023, '2020-08-29', NULL, NULL, NULL, 127.92, 0.1741, NULL, NULL),
    ('3550308', 'multa', 4041, 2023, '2023-04-19', NULL, NULL, NULL, 78.56, 0.1898, NULL, NULL),
    ('28', 'multa', 4541, 2025, '2021-06-13', NULL, '1.1202.10.00', '9006.91.10', 4819.11, 0.1174, NULL, NULL),
    ('3548906', 'multa', 456, 2024, '2026-09-01', NULL, NULL, '7110.19.90', 164.17, 0.1727, NULL, NULL),
    ('3505906', 'multa', 4271, 2019, '2017-08-08', '2018-06-23', NULL, NULL, 132.1, 0.159, NULL, NULL),
    ('41', 'multa', 1010, 2016, '2025-09-13', NULL, '1.0102.20.00', '8477.10.29', 123.37, 0.1674, NULL, NULL),
    ('4208302', 'multa', 1418, 2024, '2019-02-24', '2019-07-03', '1.2001.32.00', '0105.11.90', 313.85, 0.1319, NULL, NULL),
    ('3146206', 'multa', 2171, 2021, '2020-02-24', NULL, '1.1301.40.00', '7407.29.2', 338.68, 0.1672, NULL, NULL),
    ('3548906', 'multa', 2990, 2022, '2024-05-11', NULL, NULL, NULL, 602.12, 0.1034, NULL, NULL),
    ('1302603', 'multa', 2874, 2024, '2017-12-16', NULL, '1.1401.16.00', NULL, 477.02, 0.095, NULL, NULL),
    ('3304557', 'multa', 966, 2024, '2019-10-03', '2024-12-28', '1.1706.1', NULL, 300.93, 0.2364, NULL, NULL),
    ('4208302', 'multa', 2820, 2020, '2026-07-01', '2027-08-28', '1.0403.23.00', NULL, 108.35, 0.1098, NULL, NULL),
    ('4106902', 'multa', 78, 2018, '2023-09-28', NULL, NULL, NULL, 148.4, 0.1538, NULL, NULL),
    ('5300108', 'if', 1197, 2021, '2017-11-07', '2023-06-09', NULL, NULL, NULL, NULL, 7.5672, 0.0619),
    ('4308250', 'if', 3319, 2019, '2018-07-12', NULL, NULL, '8461.90.90', NULL, NULL, 4.6183, 0.078),
    ('4106902', 'multa', 460, 2019, '2016-08-07', NULL, '1.0904', NULL, 143.73, 0.1222, NULL, NULL),
    ('3146206', 'if', 689, 2020, '2023-01-15', '2025-10-29', '1.2501.32.00', '2931.59.13', NULL, NULL, 4.378, 0.0366),
    ('3548906', 'multa', 3995, 2015, '2022-12-31', NULL, '1.0602.29.00', '2609.00.00', 135.49, 0.0326, NULL, NULL),
    ('3205309', 'multa', 1802, 2026, '2024-04-28', NULL, '1.0106.12.00', NULL, 258.17, 0.0701, NULL, NULL),
    ('3146107', 'multa', 2781, 2023, '2015-10-29', NULL, '1.0502.11.10', NULL, 702.13, 0.1382, NULL, NULL),
    ('5300108', 'if', 4637, 2016, '2021-05-08', NULL, NULL, NULL, NULL, NULL, 3.1077, 0.0152),
    ('28', 'if', 159, 2020, '2015-05-03', NULL, NULL, NULL, NULL, NULL, 9.6826, 0.0531),
    ('1302603', 'multa', 3203, 2018, '2020-09-05', NULL, '1.0502.24.52', '2930.90.31', 68.26, 0.0332, NULL, NULL),
    ('42', 'if', 1757, 2021, '2015-12-02', NULL, NULL, NULL, NULL, NULL, 1.5033, 0.0169),
    ('1302603', 'if', 3917, 2026, '2016-05-17', NULL, '1.2504.11.00', NULL, NULL, NULL, 1.9619, 0.0282),
    ('35', 'if', 4526, 2015, '2018-05-29', '2020-04-07', NULL, NULL, NULL, NULL, 0.9653, 0.0625),
    ('2919306', 'if', 556, 2020, '2017-11-09', NULL, NULL, '5513.21.00', NULL, NULL, 71.6637, 0.0517),
    ('3505906', 'multa', 930, 2015, '2022-02-23', NULL, '1.0905.1', NULL, 257.88, 0.1551, NULL, NULL),
    ('51', 'if', 4577, 2024, '2016-04-08', NULL, NULL, NULL, NULL, NULL, 1.6646, 0.0462),
    ('4106902', 'if', 2525, 2017, '2015-10-23', NULL, NULL, NULL, NULL, NULL, 3.5615, 0.0169),
    ('1302603', 'if', 2568, 2016, '2016-02-22', NULL, '1.2302', '5801.26.00', NULL, NULL, 2.3285, 0.0609),
    ('3550308', 'multa', 4119, 2025, '2020-08-26', NULL, '1.2303.00.00', NULL, 225.93, 0.0693, NULL, NULL),
    ('24', 'if', 1884, 2023, '2024-05-14', NULL, '1.1502.50.00', '9102.12.10', NULL, NULL, 3.8137, 0.0763),
    ('3550308', 'multa', 1197, 2015, '2019-09-16', '2020-01-11', NULL, NULL, 219.85, 0.0582, NULL, NULL),
    ('28', 'multa', 814, 2016, '2024-11-15', NULL, '1.2504.2', '0714.10.00', 277.45, 0.0919, NULL, NULL),
    ('4314902', 'if', 4063, 2017, '2024-12-21', '2025-07-30', NULL, NULL, NULL, NULL, 8.6669, 0.0464),
    ('3548906', 'if', 1846, 2024, '2023-12-30', NULL, '1.0105.60.00', NULL, NULL, NULL, 2.0728, 0.0271),
    ('3146107', 'if', 1478, 2019, '2015-02-05', NULL, '1.0304.10.00', '6802.29.00', NULL, NULL, 6.1721, 0.0018),
    ('3505906', 'if', 1275, 2021, '2022-01-20', '2025-01-18', NULL, NULL, NULL, NULL, 15.8161, 0.0038),
    ('1302603', 'if', 2534, 2019, '2020-10-20', NULL, NULL, NULL, NULL, NULL, 124.466, 0.0221),
    ('43', 'if', 1064, 2017, '2016-04-06', NULL, '1.20', '4105.10.10', NULL, NULL, 0.7806, 0.0255),
    ('3146107', 'multa', 3117, 2017, '2015-11-07', NULL, NULL, '1604.14.20', 91.94, 0.2172, NULL, NULL),
    ('3306305', 'multa', 2500, 2022, '2019-06-02', '2019-12-18', '1.1702.10.00', '3912.31.11', 312.59, 0.0791, NULL, NULL),
    ('3550308', 'if', 4384, 2025, '2020-11-26', NULL, NULL, NULL, NULL, NULL, 9.7123, 0.0579),
    ('2927408', 'multa', 955, 2018, '2019-07-24', NULL, NULL, NULL, 258.93, 0.1884, NULL, NULL),
    ('42', 'multa', 182, 2024, '2021-04-18', NULL, NULL, NULL, 437.65, 0.0795, NULL, NULL),
    ('4205407', 'multa', 1701, 2018, '2023-12-27', NULL, NULL, NULL, 129.06, 0.091, NULL, NULL),
    ('32', 'multa', 3496, 2023, '2017-06-15', NULL, NULL, NULL, 501.53, 0.1793, NULL, NULL),
    ('4208302', 'multa', 1376, 2026, '2016-10-21', '2022-04-01', '1.2001.10.00', NULL, 44.87, 0.1622, NULL, NULL),
    ('3550308', 'multa', 2979, 2024, '2023-10-12', NULL, '1.0102.90.00', '8445.40.39', 112.9, 0.219, NULL, NULL),
    ('3146206', 'if', 3220, 2017, '2018-08-14', NULL, '1.0904.22.00', NULL, NULL, NULL, 9.0256, 0.0365),
    ('3106200', 'if', 1614, 2015, '2020-07-25', '2024-02-21', '1.1701.34.00', NULL, NULL, NULL, 16.3813, 0.0389),
    ('4308250', 'if', 1110, 2016, '2023-09-03', NULL, '1.1108.90.00', NULL, NULL, NULL, 4.1027, 0.0796),
    ('3550308', 'multa', 2305, 2022, '2026-06-08', NULL, NULL, NULL, 425.81, 0.0921, NULL, NULL),
    ('53', 'if', 1522, 2018, '2022-03-31', NULL, '1.1202.20.00', '7409.31.1', NULL, NULL, 2.3598, 0.0608),
    ('3505906', 'multa', 3245, 2016, '2016-12-12', NULL, NULL, '2933.99.95', 360.06, 0.1789, NULL, NULL),
    ('3501905', 'multa', 223, 2024, '2025-02-20', NULL, '1.0608.20.00', '2502.00.00', 215.13, 0.0517, NULL, NULL),
    ('43', 'if', 4739, 2015, '2023-03-23', NULL, NULL, NULL, NULL, NULL, 5.988, 0.0319),
    ('4205407', 'if', 4760, 2025, '2020-04-26', '2021-01-20', NULL, NULL, NULL, NULL, 5.8062, 0.0083),
    ('3304557', 'if', 4568, 2019, '2017-01-24', NULL, '1.2204', NULL, NULL, NULL, 1.8176, 0.0526),
    ('28', 'if', 295, 2019, '2023-09-05', NULL, '1.22', NULL, NULL, NULL, 94.9834, 0.0444),
    ('4314902', 'multa', 2130, 2015, '2015-02-21', NULL, '1.2201', '3901.90.30', 76.4, 0.1676, NULL, NULL),
    ('3146206', 'multa', 2407, 2020, '2021-09-10', NULL, NULL, '2917.11.20', 137.73, 0.1085, NULL, NULL),
    ('2919306', 'multa', 3177, 2017, '2017-07-16', '2018-05-03', NULL, '8001.20.00', 310.52, 0.1857, NULL, NULL),
    ('4314902', 'multa', 427, 2022, '2019-06-27', '2024-07-02', NULL, '8413.60.11', 87.16, 0.1599, NULL, NULL),
    ('3505906', 'multa', 3726, 2024, '2017-07-11', NULL, NULL, '7013.22.00', 111.87, 0.2176, NULL, NULL),
    ('32', 'multa', 639, 2025, '2025-01-14', NULL, NULL, '0303.89.6', 66.47, 0.181, NULL, NULL),
    ('42', 'multa', 2118, 2020, '2021-08-05', NULL, NULL, NULL, 51.09, 0.0634, NULL, NULL),
    ('3306305', 'multa', 1907, 2023, '2018-12-25', NULL, NULL, '6307.20.00', 91.32, 0.1847, NULL, NULL),
    ('26', 'multa', 3369, 2023, '2023-09-22', '2025-07-21', '1.1107.33.00', NULL, 219.14, 0.0485, NULL, NULL),
    ('1302603', 'if', 118, 2023, '2024-09-28', NULL, NULL, '8607.19.90', NULL, NULL, 0.6685, 0.0798),
    ('43', 'multa', 1600, 2020, '2019-02-21', NULL, '1.0401.11.19', NULL, 154.55, 0.0365, NULL, NULL),
    ('3550308', 'multa', 764, 2021, '2025-06-06', NULL, NULL, '4407.29.70', 36.68, 0.2396, NULL, NULL),
    ('3146107', 'multa', 3829, 2024, '2022-03-07', NULL, NULL, NULL, 160.1, 0.2404, NULL, NULL),
    ('3548906', 'if', 391, 2019, '2021-11-28', NULL, '1.0902.90.00', NULL, NULL, NULL, 4.5269, 0.0293),
    ('5300108', 'if', 169, 2023, '2024-07-07', NULL, NULL, NULL, NULL, NULL, 0.8638, 0.0607),
    ('5300108', 'multa', 4758, 2024, '2021-05-04', NULL, '1.0102.41.10', NULL, 63.22, 0.0912, NULL, NULL),
    ('5300108', 'multa', 172, 2024, '2016-07-06', NULL, '1.2404.1', NULL, 363.74, 0.0426, NULL, NULL),
    ('32', 'if', 743, 2024, '2024-06-06', NULL, '1.0101', NULL, NULL, NULL, 2.8021, 0.01),
    ('4106902', 'if', 4541, 2025, '2026-04-13', NULL, '1.16', NULL, NULL, NULL, 14.4795, 0.0363),
    ('29', 'multa', 788, 2016, '2018-03-08', '2020-03-17', NULL, NULL, 123.43, 0.1513, NULL, NULL),
    ('53', 'if', 4, 2021, '2024-11-27', NULL, '1.0501.19.00', '4501.90.00', NULL, NULL, 4.101, 0.0062),
    ('3146206', 'multa', 1613, 2021, '2024-10-08', NULL, '1.0403.11.90', NULL, 132.41, 0.1795, NULL, NULL),
    ('2927408', 'if', 981, 2022, '2015-11-26', NULL, '1.0903.32.00', '0802.92.00', NULL, NULL, 4.129, 0.0694),
    ('3306305', 'if', 3055, 2023, '2019-10-10', NULL, NULL, '3921.14.00', NULL, NULL, 2.7427, 0.065),
    ('4208302', 'multa', 3082, 2015, '2022-01-04', NULL, NULL, '0305.31.00', 78.21, 0.0726, NULL, NULL),
    ('24', 'if', 1453, 2026, '2018-07-27', NULL, '1.2405.13.00', '5503.20.90', NULL, NULL, 114.5337, 0.0064),
    ('42', 'if', 321, 2025, '2023-08-02', NULL, '1.1401.12.00', '5504.10.00', NULL, NULL, 1.6749, 0.0076),
    ('4106902', 'multa', 4012, 2017, '2017-10-30', NULL, NULL, NULL, 210.26, 0.1417, NULL, NULL),
    ('4208302', 'if', 290, 2025, '2023-02-03', NULL, '1.2204.30.00', '5701.10.20', NULL, NULL, 11.2254, 0.0348),
    ('3304557', 'if', 3894, 2024, '2024-12-27', NULL, NULL, NULL, NULL, NULL, 7.1369, 0.0672),
    ('42', 'multa', 4894, 2024, '2016-03-07', '2016-07-24', '1.1502.30.00', NULL, 154.37, 0.0942, NULL, NULL),
    ('26', 'multa', 3920, 2017, '2016-04-19', NULL, NULL, '8444.00.90', 267.25, 0.0114, NULL, NULL),
    ('53', 'multa', 4136, 2019, '2026-09-10', NULL, NULL, '7304.41.10', 49.25, 0.1829, NULL, NULL),
    ('26', 'multa', 1087, 2016, '2019-07-19', NULL, '1.0505.30.00', '8506.10.39', 90.93, 0.0963, NULL, NULL),
    ('53', 'multa', 4197, 2025, '2020-10-09', '2024-04-07', '1.1507', NULL, 111.93, 0.1888, NULL, NULL),
    ('32', 'if', 1789, 2023, '2016-05-15', NULL, NULL, NULL, NULL, NULL, 13.4556, 0.0633),
    ('3306305', 'if', 1305, 2022, '2018-06-26', NULL, '1.1403.22.1', NULL, NULL, NULL, 9.2617, 0.0431),
    ('3146206', 'if', 3262, 2024, '2023-02-28', NULL, '1.1404.19.00', '3907.10.91', NULL, NULL, 12.0955, 0.0109),
    ('4314902', 'multa', 4259, 2019, '2020-06-27', '2020-09-22', '1.1402.3', '2934.91.2', 175.58, 0.138, NULL, NULL),
    ('3205309', 'multa', 2823, 2023, '2017-07-03', NULL, NULL, '6101.90.90', 215.39, 0.1315, NULL, NULL),
    ('3146206', 'multa', 2669, 2021, '2015-06-15', '2016-12-08', NULL, '3822.19.40', 147.69, 0.1971, NULL, NULL),
    ('3550308', 'if', 4087, 2015, '2017-10-15', '2018-04-08', '1.2405.12.00', NULL, NULL, NULL, 1.1894, 0.0767),
    ('53', 'multa', 3185, 2024, '2025-09-24', NULL, NULL, '2827.49.19', 354.42, 0.2304, NULL, NULL),
    ('51', 'if', 878, 2015, '2021-01-05', NULL, NULL, '8414.80.38', NULL, NULL, 12.9542, 0.0514),
    ('35', 'multa', 4393, 2021, '2015-04-01', NULL, NULL, NULL, 463.0, 0.1206, NULL, NULL),
    ('4308250', 'multa', 3857, 2019, '2024-11-13', NULL, '1.1406.39.00', '8517.62.73', 183.68, 0.0118, NULL, NULL),
    ('33', 'if', 4383, 2023, '2021-09-22', NULL, NULL, '3926.90.61', NULL, NULL, 6.9245, 0.0761),
    ('3304557', 'multa', 2589, 2022, '2026-08-31', NULL, '1.2204.20.00', NULL, 674.12, 0.0861, NULL, NULL),
    ('4106902', 'if', 1846, 2020, '2016-01-09', NULL, '1.0401.12.10', '2841.50.15', NULL, NULL, 1.6035, 0.0476),
    ('4208302', 'if', 3827, 2020, '2016-05-04', NULL, '1.0502.21.30', '2933.69.19', NULL, NULL, 3.6645, 0.0433),
    ('31', 'if', 3321, 2021, '2024-06-04', '2026-10-28', NULL, NULL, NULL, NULL, 7.266, 0.0209),
    ('42', 'multa', 2767, 2022, '2016-04-27', NULL, '1.0404.10.00', '3003.39.91', 163.81, 0.1813, NULL, NULL),
    ('4205407', 'if', 3466, 2019, '2018-08-03', NULL, NULL, NULL, NULL, NULL, 0.7553, 0.0215),
    ('21', 'if', 4260, 2025, '2024-11-13', NULL, NULL, NULL, NULL, NULL, 2.2602, 0.0787),
    ('21', 'if', 1903, 2025, '2024-09-29', NULL, NULL, '8472.90.40', NULL, NULL, 3.9411, 0.0489),
    ('21', 'multa', 817, 2021, '2019-12-30', NULL, '1.0403.13', NULL, 492.63, 0.0778, NULL, NULL),
    ('3550308', 'if', 2354, 2022, '2015-02-15', NULL, '1.1805.39.00', NULL, NULL, NULL, 1.2754, 0.0396),
    ('3146107', 'if', 4556, 2017, '2016-01-01', NULL, NULL, NULL, NULL, NULL, 6.2782, 0.0599),
    ('35', 'multa', 2865, 2015, '2020-05-29', '2022-08-01', NULL, NULL, 188.54, 0.1472, NULL, NULL),
    ('5300108', 'if', 3189, 2016, '2022-09-03', NULL, NULL, NULL, NULL, NULL, 3.0437, 0.0668),
    ('3304557', 'if', 4564, 2016, '2025-01-24', NULL, NULL, '5516.33.00', NULL, NULL, 3.1952, 0.0211),
    ('3106200', 'if', 3198, 2016, '2016-08-23', NULL, '1.1403.22.21', NULL, NULL, NULL, 3.4632, 0.0514),
    ('2919306', 'multa', 4094, 2022, '2020-03-05', NULL, '1.2301.97.00', NULL, 184.29, 0.1474, NULL, NULL),
    ('42', 'if', 1539, 2016, '2023-08-07', NULL, NULL, '8704.21.30', NULL, NULL, 1.3152, 0.0628),
    ('3306305', 'if', 500, 2020, '2023-08-18', NULL, '1.2603.00.00', NULL, NULL, NULL, 1.9954, 0.0347),
    ('3550308', 'multa', 3800, 2019, '2018-01-13', '2018-04-05', '1.1801.2', '8428.39.30', 179.73, 0.1597, NULL, NULL),
    ('2919306', 'if', 2916, 2024, '2018-12-30', NULL, NULL, '4002.99.90', NULL, NULL, 1.1188, 0.0579),
    ('4205407', 'multa', 325, 2024, '2023-04-21', '2027-08-15', '1.0602.32.00', '2909.44.13', 303.81, 0.1209, NULL, NULL),
    ('28', 'multa', 2589, 2016, '2016-06-21', NULL, NULL, NULL, 367.43, 0.1862, NULL, NULL),
    ('3146107', 'if', 2937, 2020, '2020-07-30', NULL, '1.1701.11.00', NULL, NULL, NULL, 6.6101, 0.0221),
    ('33', 'multa', 3914, 2019, '2022-08-29', '2027-02-23', NULL, '2905.19.94', 316.39, 0.1815, NULL, NULL),
    ('3106200', 'multa', 977, 2026, '2017-08-30', NULL, '1.1001.50.00', '2930.90.19', 1793.12, 0.1908, NULL, NULL),
    ('32', 'multa', 1027, 2025, '2026-03-30', NULL, '1.0402.32.00', '9304.00.90', 52.56, 0.1492, NULL, NULL),
    ('51', 'multa', 376, 2023, '2018-07-18', NULL, '1.1406.12.00', '2804.30.00', 262.91, 0.2457, NULL, NULL),
    ('41', 'if', 563, 2017, '2019-09-04', NULL, NULL, NULL, NULL, NULL, 1.5421, 0.0702),
    ('3146206', 'if', 1273, 2017, '2022-06-24', NULL, '1.0504.23.00', '6804.22.11', NULL, NULL, 1.1697, 0.0028),
    ('41', 'if', 2090, 2020, '2020-05-19', NULL, NULL, NULL, NULL, NULL, 0.8179, 0.0336),
    ('3304557', 'if', 1500, 2015, '2024-10-31', '2027-08-15', '1.1706.21.00', NULL, NULL, NULL, 1.671, 0.0011),
    ('3106200', 'if', 2147, 2025, '2025-09-08', '2030-06-27', '1.0501.21.10', '8708.50.80', NULL, NULL, 2.4297, 0.0653),
    ('3205309', 'if', 116, 2016, '2022-09-16', NULL, '1.1805.1', NULL, NULL, NULL, 3.4183, 0.0698),
    ('3304557', 'multa', 2352, 2024, '2024-01-03', NULL, NULL, NULL, 3025.74, 0.023, NULL, NULL),
    ('26', 'multa', 1641, 2018, '2024-09-20', NULL, NULL, '2811.22.20', 82.17, 0.1089, NULL, NULL),
    ('4314902', 'if', 3751, 2015, '2015-09-21', '2016-09-08', NULL, '8452.90.92', NULL, NULL, 6.6611, 0.0451),
    ('3505906', 'if', 535, 2021, '2022-03-07', NULL, '1.1901.20.00', NULL, NULL, NULL, 9.2821, 0.0773),
    ('4208302', 'if', 4508, 2024, '2024-02-14', NULL, '1.0402.13.20', NULL, NULL, NULL, 4.5136, 0.0345),
    ('3146107', 'if', 1242, 2023, '2020-11-07', NULL, '1.0101.12.00', NULL, NULL, NULL, 3.1238, 0.0482),
    ('33', 'multa', 474, 2023, '2020-06-04', NULL, NULL, NULL, 292.63, 0.0403, NULL, NULL),
    ('2927408', 'multa', 3455, 2015, '2024-09-17', NULL, '1.0502.14.10', NULL, 103.23, 0.152, NULL, NULL),
    ('1302603', 'multa', 4111, 2023, '2017-07-25', NULL, '1.1411.00.00', '7306.90.20', 183.63, 0.1033, NULL, NULL),
    ('21', 'if', 4089, 2024, '2015-07-04', NULL, NULL, '8208.20.00', NULL, NULL, 2.0883, 0.0717),
    ('29', 'if', 116, 2018, '2026-12-26', NULL, '1.2302', NULL, NULL, NULL, 3.8644, 0.0134),
    ('29', 'if', 1624, 2020, '2021-12-13', NULL, '1.0504.13.00', '3003.90.47', NULL, NULL, 3.0744, 0.0302),
    ('28', 'multa', 3304, 2025, '2024-07-29', NULL, NULL, NULL, 75.67, 0.2394, NULL, NULL),
    ('3146107', 'if', 3563, 2026, '2016-12-09', NULL, '1.2404.11.00', '7207.19.00', NULL, NULL, 4.0154, 0.046),
    ('3505906', 'multa', 1859, 2017, '2021-05-27', NULL, NULL, NULL, 72.5, 0.203, NULL, NULL),
    ('26', 'if', 3983, 2020, '2024-05-31', '2024-08-18', NULL, '8534.00.5', NULL, NULL, 8.5548, 0.0584),
    ('53', 'if', 4175, 2020, '2021-07-18', '2025-04-07', NULL, '0302.51.00', NULL, NULL, 0.7874, 0.0372),
    ('4314902', 'multa', 1825, 2026, '2015-08-02', NULL, '1.0401.21.90', '2909.49.23', 91.58, 0.2497, NULL, NULL),
    ('3304557', 'multa', 2780, 2024, '2026-05-03', NULL, NULL, NULL, 202.12, 0.1672, NULL, NULL),
    ('51', 'if', 2788, 2025, '2020-02-14', NULL, '1.1703.92.00', NULL, NULL, NULL, 2.9198, 0.0112),
    ('4106902', 'if', 2045, 2015, '2023-01-26', NULL, NULL, NULL, NULL, NULL, 16.3051, 0.0056),
    ('3146107', 'if', 3119, 2023, '2016-12-11', NULL, '1.1802.50.00', '3004.90.97', NULL, NULL, 59.7516, 0.0141),
    ('28', 'if', 4060, 2019, '2020-04-11', NULL, '1.1106.4', NULL, NULL, NULL, 7.3871, 0.0302),
    ('3548906', 'if', 4761, 2022, '2021-11-30', NULL, '1.0401.17', NULL, NULL, NULL, 1.9104, 0.0569),
    ('33', 'if', 1198, 2019, '2017-06-09', NULL, '1.0103.4', NULL, NULL, NULL, 37.4326, 0.0504),
    ('4106902', 'multa', 2769, 2019, '2021-05-27', NULL, '1.0403.21', '2844.43.30', 108.52, 0.1922, NULL, NULL),
    ('3106200', 'if', 483, 2024, '2017-10-28', NULL, NULL, NULL, NULL, NULL, 3.1997, 0.0617),
    ('42', 'if', 1383, 2022, '2020-10-03', '2025-03-02', '1.2301.11.00', '0305.72.00', NULL, NULL, 0.8699, 0.0347),
    ('3146206', 'multa', 40, 2024, '2025-02-18', NULL, NULL, '4406.91.00', 297.58, 0.2205, NULL, NULL),
    ('3304557', 'multa', 329, 2022, '2019-04-12', NULL, '1.2406', '3003.20.41', 83.2, 0.1629, NULL, NULL),
    ('29', 'if', 2274, 2018, '2026-07-20', NULL, NULL, '1901.90.90', NULL, NULL, 8.4473, 0.0506),
    ('3106200', 'if', 3139, 2015, '2018-04-03', NULL, '1.2504.2', '2711.21.00', NULL, NULL, 7.653, 0.0489),
    ('4314902', 'if', 4866, 2023, '2023-06-20', NULL, NULL, NULL, NULL, NULL, 3.2371, 0.0435),
    ('53', 'multa', 718, 2023, '2025-03-22', '2028-10-20', NULL, '2904.20.10', 3348.47, 0.1522, NULL, NULL),
    ('4106902', 'multa', 944, 2026, '2016-02-21', NULL, '1.0501.14.30', '2830.10.10', 189.34, 0.0577, NULL, NULL),
    ('13', 'multa', 2120, 2021, '2026-04-23', NULL, '1.1404.1', NULL, 172.11, 0.0986, NULL, NULL),
    ('53', 'if', 2022, 2024, '2018-02-20', NULL, '1.1413.00.00', NULL, NULL, NULL, 22.5813, 0.0563),
    ('26', 'if', 1378, 2018, '2023-06-03', NULL, '1.0502.32.20', NULL, NULL, NULL, 1.2254, 0.0479),
    ('51', 'if', 4162, 2020, '2022-03-25', NULL, NULL, '8429.52.20', NULL, NULL, 72.1806, 0.0078),
    ('3548906', 'if', 146, 2020, '2015-06-30', NULL, NULL, NULL, NULL, NULL, 1.8555, 0.0308),
    ('13', 'if', 4266, 2019, '2026-12-29', NULL, NULL, '8414.80.33', NULL, NULL, 2.8828, 0.0782),
    ('42', 'if', 242, 2017, '2024-02-07', NULL, '1.0501.14.20', '9032.89.90', NULL, NULL, 4.7886, 0.0398),
    ('3501905', 'multa', 1510, 2017, '2023-07-13', '2025-09-29', '1.0901.34.00', NULL, 87.16, 0.0606, NULL, NULL),
    ('13', 'multa', 4972, 2016, '2017-03-25', '2019-12-13', '1.1701.11.00', '0210.11.00', 153.26, 0.2306, NULL, NULL),
    ('4308250', 'if', 732, 2023, '2019-05-10', NULL, NULL, '0305.20.90', NULL, NULL, 61.8169, 0.0022),
    ('42', 'if', 1934, 2025, '2026-07-03', NULL, NULL, '2941.30.10', NULL, NULL, 4.575, 0.0279),
    ('26', 'multa', 4083, 2015, '2022-09-08', NULL, NULL, NULL, 53.06, 0.2162, NULL, NULL),
    ('4208302', 'if', 4944, 2023, '2024-10-14', NULL, '1.1106.36', '3204.18.30', NULL, NULL, 5.5152, 0.011),
    ('3205309', 'multa', 4080, 2018, '2015-09-12', '2020-02-02', '1.0903.22.00', NULL, 49.64, 0.1631, NULL, NULL),
    ('29', 'if', 4989, 2024, '2022-12-14', '2026-11-10', NULL, NULL, NULL, NULL, 1.9287, 0.0076),
    ('32', 'if', 784, 2023, '2021-04-29', NULL, NULL, '8708.30.11', NULL, NULL, 1.1404, 0.016),
    ('26', 'multa', 3506, 2017, '2024-10-16', NULL, NULL, NULL, 118.11, 0.017, NULL, NULL),
    ('29', 'if', 367, 2022, '2020-09-16', NULL, '1.0105.90.00', NULL, NULL, NULL, 6.3346, 0.0331),
    ('24', 'multa', 1850, 2016, '2015-12-05', NULL, '1.2304.1', NULL, 283.83, 0.1676, NULL, NULL),
    ('28', 'if', 4796, 2022, '2015-10-03', '2016-09-22', NULL, NULL, NULL, NULL, 1.4373, 0.033),
    ('3501905', 'if', 4503, 2022, '2023-07-08', NULL, NULL, '3808.93.51', NULL, NULL, 3.2586, 0.0549),
    ('3505906', 'if', 4932, 2017, '2018-11-17', NULL, NULL, '1904.20.00', NULL, NULL, 3.4738, 0.0726),
    ('33', 'if', 2349, 2026, '2023-01-18', NULL, '1.1401.15.00', NULL, NULL, NULL, 10.1293, 0.0734),
    ('3106200', 'if', 3463, 2019, '2016-05-06', NULL, NULL, '0302.83.10', NULL, NULL, 50.3804, 0.031),
    ('13', 'multa', 799, 2026, '2024-08-30', NULL, NULL, NULL, 411.45, 0.0826, NULL, NULL),
    ('35', 'multa', 701, 2021, '2022-02-28', NULL, '1.2301.13.00', '3003.90.56', 245.96, 0.2207, NULL, NULL),
    ('2919306', 'multa', 4296, 2018, '2017-12-04', '2022-03-25', '1.2301.91.00', '9503.00.50', 222.66, 0.0924, NULL, NULL),
    ('3550308', 'multa', 2330, 2023, '2021-12-31', '2028-01-10', '1.0502.14.20', NULL, 609.83, 0.0336, NULL, NULL),
    ('5300108', 'multa', 160, 2023, '2025-04-20', NULL, NULL, '2306.10.00', 121.56, 0.1711, NULL, NULL),
    ('26', 'if', 2674, 2023, '2019-01-26', NULL, '1.0504.11.00', '2908.19.19', NULL, NULL, 28.2469, 0.0032),
    ('21', 'multa', 2771, 2018, '2020-04-25', '2024-01-05', NULL, NULL, 52.67, 0.0577, NULL, NULL),
    ('33', 'multa', 584, 2023, '2018-02-08', '2018-10-14', NULL, NULL, 143.5, 0.2247, NULL, NULL),
    ('53', 'multa', 1903, 2025, '2017-10-08', NULL, '1.1501.20.00', '2917.39.20', 208.96, 0.0456, NULL, NULL),
    ('1302603', 'multa', 2470, 2023, '2022-02-25', NULL, NULL, NULL, 43.96, 0.109, NULL, NULL),
    ('33', 'if', 755, 2015, '2018-12-08', NULL, NULL, NULL, NULL, NULL, 3.8571, 0.0011),
    ('26', 'multa', 3057, 2019, '2023-12-11', NULL, '1.1107.20.00', NULL, 193.32, 0.1511, NULL, NULL),
    ('3205309', 'if', 3486, 2017, '2020-04-30', NULL, NULL, NULL, NULL, NULL, 10.5558, 0.0694),
    ('31', 'if', 1005, 2024, '2016-01-12', NULL, '1.0501.25.00', NULL, NULL, NULL, 3.4227, 0.0525),
    ('2919306', 'if', 2473, 2019, '2024-08-30', NULL, NULL, NULL, NULL, NULL, 4.469, 0.0418),
    ('3501905', 'multa', 1313, 2022, '2019-02-24', NULL, NULL, NULL, 195.03, 0.076, NULL, NULL),
    ('3146107', 'if', 1568, 2021, '2015-11-27', NULL, NULL, NULL, NULL, NULL, 1.3901, 0.0308),
    ('3304557', 'multa', 411, 2026, '2018-06-27', NULL, '1.1402.21.00', '9024.80.11', 265.62, 0.1981, NULL, NULL),
    ('4308250', 'multa', 4621, 2017, '2024-02-25', NULL, NULL, NULL, 567.38, 0.1977, NULL, NULL),
    ('32', 'multa', 2638, 2023, '2023-08-20', NULL, '1.0906.11.00', '2912.60.00', 224.8, 0.2344, NULL, NULL),
    ('3106200', 'if', 1752, 2021, '2026-06-12', NULL, '1.1414.00.00', NULL, NULL, NULL, 0.9544, 0.0095),
    ('4205407', 'if', 1121, 2018, '2020-09-27', NULL, NULL, '0210.99.30', NULL, NULL, 2.6168, 0.0201),
    ('43', 'if', 4745, 2017, '2018-11-26', NULL, NULL, NULL, NULL, NULL, 1.8893, 0.0488),
    ('1302603', 'if', 2428, 2024, '2016-05-19', NULL, NULL, '1208.10.00', NULL, NULL, 5.753, 0.0384),
    ('29', 'if', 2529, 2016, '2016-06-27', '2021-12-03', '1.0502.12.10', '3103.90.11', NULL, NULL, 5.181, 0.0621),
    ('3505906', 'multa', 3732, 2025, '2021-01-06', NULL, '1.2001.34.20', '0309.10.00', 39.36, 0.186, NULL, NULL),
    ('3550308', 'multa', 2449, 2017, '2026-03-27', NULL, '1.1703.22.00', NULL, 229.13, 0.2317, NULL, NULL),
    ('3106200', 'multa', 4872, 2025, '2018-01-31', NULL, '1.1103', '2922.41.90', 5618.1, 0.0211, NULL, NULL),
    ('31', 'if', 3814, 2017, '2018-07-12', NULL, '1.1104.10.00', '2934.30.20', NULL, NULL, 3.0217, 0.0505),
    ('31', 'if', 3444, 2017, '2017-05-16', NULL, NULL, NULL, NULL, NULL, 94.6521, 0.047),
    ('3304557', 'if', 4085, 2025, '2025-09-13', NULL, NULL, NULL, NULL, NULL, 1.724, 0.0766),
    ('26', 'if', 4202, 2020, '2018-09-04', NULL, '1.1701.31.00', '4301.10.00', NULL, NULL, 2.2426, 0.0162),
    ('3146107', 'if', 2119, 2015, '2025-03-09', NULL, '1.22', NULL, NULL, NULL, 4.1913, 0.0291),
    ('4308250', 'if', 1867, 2025, '2018-10-06', NULL, '1.0401.2', '8504.40.21', NULL, NULL, 9.0596, 0.0752),
    ('51', 'if', 1829, 2016, '2021-06-09', NULL, '1.1901.10.00', '8547.20.90', NULL, NULL, 0.5298, 0.0358),
    ('3205309', 'if', 4978, 2022, '2019-10-24', NULL, '1.1103.3', '2933.69.16', NULL, NULL, 10.9503, 0.0721),
    ('13', 'if', 2509, 2019, '2019-06-19', NULL, NULL, NULL, NULL, NULL, 13.7938, 0.0583),
    ('32', 'if', 2429, 2017, '2024-12-15', NULL, '1.1302.11.00', '2837.20.12', NULL, NULL, 2.8077, 0.0763),
    ('13', 'multa', 4575, 2024, '2015-12-10', '2022-09-26', NULL, '8705.40.00', 67.33, 0.2353, NULL, NULL),
    ('3550308', 'multa', 2336, 2020, '2026-03-15', NULL, NULL, NULL, 26.67, 0.1921, NULL, NULL),
    ('3304557', 'if', 2175, 2015, '2019-09-24', NULL, NULL, '7108.11.00', NULL, NULL, 4.4525, 0.0361),
    ('3205309', 'if', 1587, 2024, '2018-10-01', NULL, '1.0501.14.51', '2934.91.11', NULL, NULL, 3.2148, 0.0655),
    ('28', 'multa', 2002, 2020, '2025-08-29', NULL, '1.1507.20.00', '7506.20.00', 166.43, 0.2013, NULL, NULL),
    ('4205407', 'if', 3025, 2026, '2024-06-12', NULL, '1.0502.31.20', NULL, NULL, NULL, 2.8925, 0.0057),
    ('3304557', 'if', 93, 2021, '2026-02-10', NULL, NULL, NULL, NULL, NULL, 1.0425, 0.0175),
    ('3501905', 'multa', 1776, 2026, '2019-07-30', NULL, NULL, '7219.32.00', 367.06, 0.0491, NULL, NULL),
    ('4106902', 'if', 1939, 2022, '2018-11-24', NULL, '1.2503', '3004.90.51', NULL, NULL, 4.7047, 0.065),
    ('3304557', 'multa', 483, 2026, '2016-08-22', NULL, '1.2002.10.00', NULL, 253.33, 0.0224, NULL, NULL),
    ('43', 'if', 4411, 2023, '2016-04-18', NULL, '1.0402.3', '0303.41.00', NULL, NULL, 1.3033, 0.0405),
    ('3505906', 'if', 1379, 2023, '2021-07-22', '2027-10-26', NULL, '3920.62.9', NULL, NULL, 1.386, 0.0369),
    ('4208302', 'if', 220, 2020, '2026-09-17', '2027-06-28', NULL, NULL, NULL, NULL, 36.1016, 0.0686),
    ('4314902', 'multa', 1106, 2026, '2020-03-18', NULL, '1.1803.22.00', NULL, 144.36, 0.1616, NULL, NULL),
    ('4314902', 'multa', 199, 2021, '2016-11-06', NULL, NULL, NULL, 203.38, 0.2173, NULL, NULL),
    ('24', 'multa', 3331, 2019, '2026-03-08', NULL, '1.0502.12.10', '6909.12.10', 125.1, 0.2493, NULL, NULL),
    ('13', 'multa', 1082, 2019, '2021-01-25', NULL, NULL, '2931.90.41', 174.81, 0.0947, NULL, NULL),
    ('24', 'if', 617, 2020, '2020-02-28', NULL, NULL, '2103.90.2', NULL, NULL, 15.5248, 0.0113),
    ('4106902', 'if', 1387, 2023, '2020-06-15', NULL, '1.0403.11', '2845.10.00', NULL, NULL, 3.0926, 0.024),
    ('24', 'if', 4998, 2020, '2025-06-03', NULL, NULL, '2939.69.21', NULL, NULL, 1.9153, 0.0461),
    ('4205407', 'if', 3565, 2015, '2026-03-16', NULL, NULL, '8506.60.10', NULL, NULL, 11.6157, 0.0048),
    ('13', 'if', 158, 2019, '2018-05-09', NULL, '1.0901.51.25', '2916.19.11', NULL, NULL, 4.0015, 0.0427),
    ('5300108', 'if', 3979, 2017, '2016-06-18', NULL, '1.1806.51.00', '5601.30.90', NULL, NULL, 2.5393, 0.0015),
    ('3304557', 'multa', 1708, 2016, '2016-08-22', NULL, NULL, '3923.50.00', 220.85, 0.2485, NULL, NULL),
    ('51', 'multa', 4716, 2025, '2025-02-22', NULL, NULL, NULL, 222.18, 0.2299, NULL, NULL),
    ('28', 'if', 483, 2021, '2026-01-02', NULL, '1.0403.31.00', NULL, NULL, NULL, 3.3636, 0.0622),
    ('53', 'multa', 3547, 2024, '2019-01-28', NULL, '1.1706', NULL, 288.3, 0.0143, NULL, NULL),
    ('13', 'multa', 2661, 2019, '2025-12-18', NULL, '1.1401.31.00', '9030.40.20', 75.74, 0.1839, NULL, NULL),
    ('3106200', 'if', 3622, 2019, '2016-03-15', NULL, NULL, '2918.99.2', NULL, NULL, 0.495, 0.0292),
    ('51', 'multa', 3982, 2021, '2019-11-21', NULL, NULL, '2843.90.11', 301.72, 0.0679, NULL, NULL),
    ('3106200', 'multa', 4822, 2025, '2019-02-24', NULL, NULL, NULL, 224.28, 0.1281, NULL, NULL),
    ('29', 'if', 4527, 2023, '2017-05-26', '2017-12-19', NULL, '4410.19.1', NULL, NULL, 197.9802, 0.0082),
    ('33', 'multa', 1713, 2015, '2019-02-25', '2022-10-30', NULL, NULL, 114.16, 0.2129, NULL, NULL),
    ('3548906', 'if', 1937, 2018, '2015-07-27', NULL, NULL, NULL, NULL, NULL, 3.5603, 0.0345),
    ('3550308', 'multa', 4332, 2026, '2021-10-25', NULL, NULL, NULL, 130.3, 0.1246, NULL, NULL),
    ('32', 'multa', 4407, 2015, '2015-08-13', NULL, '1.2003.21.90', NULL, 1972.4, 0.1271, NULL, NULL),
    ('4308250', 'multa', 777, 2020, '2015-02-22', NULL, '1.0902.40.00', '7505.11.2', 90.8, 0.0251, NULL, NULL),
    ('3548906', 'if', 1276, 2017, '2024-01-18', NULL, NULL, '3204.11.00', NULL, NULL, 2.7362, 0.0554),
    ('28', 'if', 4583, 2018, '2022-11-05', NULL, NULL, '8501.10.21', NULL, NULL, 4.0992, 0.0655),
    ('3304557', 'if', 3128, 2019, '2021-03-05', NULL, NULL, '9015.10.00', NULL, NULL, 2.3427, 0.0113),
    ('32', 'if', 198, 2024, '2024-07-25', NULL, '1.0401.15', '2922.49.59', NULL, NULL, 9.2367, 0.0462),
    ('3146107', 'if', 2243, 2018, '2021-09-17', NULL, NULL, '8461.50.20', NULL, NULL, 9.1427, 0.0089),
    ('31', 'multa', 3569, 2022, '2019-05-22', '2022-12-04', '1.1202', '3004.20.92', 91.03, 0.2001, NULL, NULL),
    ('4208302', 'if', 21, 2020, '2025-10-03', NULL, NULL, '4802.56.93', NULL, NULL, 1.2445, 0.0316),
    ('3205309', 'multa', 2061, 2017, '2026-10-21', '2026-12-29', '1.1401.14.00', NULL, 341.05, 0.0801, NULL, NULL),
    ('3501905', 'multa', 3175, 2024, '2026-08-25', NULL, '1.0901.52.30', '5703.39.00', 251.41, 0.0478, NULL, NULL),
    ('3146107', 'multa', 3799, 2016, '2018-08-16', NULL, '1.0502.13', NULL, 125.8, 0.1133, NULL, NULL),
    ('41', 'if', 4522, 2023, '2018-04-26', NULL, NULL, '5514.49.00', NULL, NULL, 75.2575, 0.0108),
    ('4106902', 'multa', 2907, 2016, '2016-01-30', NULL, '1.10', '3507.90.2', 30.2, 0.2019, NULL, NULL),
    ('3304557', 'multa', 2432, 2024, '2020-08-28', NULL, NULL, '3921.90.20', 130.19, 0.1782, NULL, NULL),
    ('53', 'multa', 4264, 2015, '2017-04-13', NULL, '1.0609.00.00', '8467.29.99', 268.83, 0.1291, NULL, NULL),
    ('3306305', 'multa', 527, 2016, '2021-05-14', NULL, NULL, NULL, 46.67, 0.2035, NULL, NULL),
    ('21', 'multa', 49, 2023, '2019-03-22', NULL, NULL, NULL, 26.47, 0.1441, NULL, NULL),
    ('1302603', 'multa', 4410, 2026, '2024-04-04', NULL, '1.1405.11.00', NULL, 312.07, 0.0308, NULL, NULL),
    ('4208302', 'if', 1364, 2025, '2021-10-28', NULL, NULL, '8432.31.90', NULL, NULL, 4.1885, 0.0278),
    ('26', 'multa', 3586, 2018, '2020-03-20', NULL, '1.0901.32.00', NULL, 332.67, 0.2465, NULL, NULL),
    ('3205309', 'if', 4948, 2025, '2015-04-25', NULL, '1.1201.12.00', '8482.50.90', NULL, NULL, 0.4559, 0.0396),
    ('4106902', 'if', 547, 2026, '2017-08-24', NULL, NULL, '2905.31.00', NULL, NULL, 5.3114, 0.0469),
    ('33', 'multa', 86, 2015, '2025-03-16', NULL, NULL, '5211.42.90', 48.26, 0.2396, NULL, NULL),
    ('3106200', 'if', 68, 2019, '2015-09-16', NULL, NULL, NULL, NULL, NULL, 2.7783, 0.0154),
    ('33', 'if', 1047, 2025, '2021-09-05', NULL, NULL, '1701.13.00', NULL, NULL, 1.3107, 0.0244),
    ('2919306', 'if', 1838, 2015, '2016-12-11', NULL, '1.1406.11.00', '2812.15.00', NULL, NULL, 21.0244, 0.0099),
    ('3106200', 'multa', 2541, 2017, '2018-10-18', NULL, NULL, '3825.20.00', 259.98, 0.1321, NULL, NULL),
    ('29', 'multa', 1688, 2015, '2018-11-11', NULL, '1.1805.62.00', '2922.19.31', 64.1, 0.2462, NULL, NULL),
    ('4314902', 'multa', 4918, 2017, '2015-03-06', NULL, NULL, NULL, 106.75, 0.0335, NULL, NULL),
    ('3306305', 'if', 604, 2015, '2025-12-30', NULL, '1.2404.19.00', NULL, NULL, NULL, 6.5206, 0.0117),
    ('24', 'multa', 930, 2025, '2025-05-13', NULL, '1.2304.11.00', '5704.10.00', 847.22, 0.026, NULL, NULL),
    ('2919306', 'multa', 498, 2024, '2018-05-10', NULL, '1.1105.60.00', '1603.00.00', 90.28, 0.2086, NULL, NULL),
    ('2927408', 'multa', 932, 2024, '2015-12-31', NULL, NULL, '7202.91.00', 3690.83, 0.0953, NULL, NULL),
    ('3106200', 'multa', 387, 2018, '2025-07-21', NULL, NULL, NULL, 102.13, 0.1415, NULL, NULL),
    ('2927408', 'if', 4630, 2024, '2022-09-20', NULL, '1.0901.52.40', NULL, NULL, NULL, 0.8577, 0.0321),
    ('2927408', 'if', 4779, 2026, '2024-05-18', NULL, '1.0106', NULL, NULL, NULL, 3.9481, 0.0498),
    ('3505906', 'if', 2970, 2021, '2018-01-16', NULL, '1.1401.13.00', NULL, NULL, NULL, 43.9256, 0.0176),
    ('51', 'multa', 3746, 2019, '2026-07-30', NULL, '1.1507', NULL, 69.57, 0.2309, NULL, NULL),
    ('3548906', 'if', 4946, 2022, '2017-06-03', '2018-02-28', '1.1701.40.00', '0301.11.10', NULL, NULL, 4.4589, 0.0084),
    ('35', 'if', 1243, 2023, '2022-12-08', NULL, NULL, NULL, NULL, NULL, 4.5785, 0.0148),
    ('2927408', 'if', 3696, 2021, '2025-11-22', NULL, '1.2504.22.00', NULL, NULL, NULL, 14.6432, 0.0603),
    ('3501905', 'if', 803, 2019, '2021-10-27', NULL, NULL, '1103.20.00', NULL, NULL, 6.6553, 0.0141),
    ('43', 'multa', 3730, 2022, '2026-03-31', NULL, NULL, '2931.90.4', 135.76, 0.1229, NULL, NULL),
    ('31', 'if', 2144, 2023, '2025-06-08', NULL, NULL, NULL, NULL, NULL, 1.2288, 0.0463),
    ('32', 'multa', 1227, 2026, '2016-08-16', NULL, NULL, NULL, 137.67, 0.073, NULL, NULL),
    ('4106902', 'if', 1323, 2024, '2023-05-15', NULL, '1.0802.10.00', '8535.40.10', NULL, NULL, 30.6514, 0.0668),
    ('4314902', 'if', 3994, 2026, '2016-09-23', NULL, '1.1805.32.00', '5202.91.00', NULL, NULL, 13.7133, 0.0054),
    ('35', 'multa', 267, 2023, '2016-03-09', NULL, '1.1405', '2909.60.11', 121.35, 0.034, NULL, NULL),
    ('35', 'multa', 1070, 2017, '2017-03-26', '2022-10-21', '1.0402.14.00', NULL, 88.78, 0.1993, NULL, NULL),
    ('21', 'multa', 4859, 2016, '2026-10-17', NULL, '1.16', NULL, 82.0, 0.1307, NULL, NULL),
    ('3106200', 'if', 3377, 2016, '2016-08-15', NULL, '1.0403.13', '2934.91.11', NULL, NULL, 99.8805, 0.007),
    ('13', 'if', 258, 2015, '2026-06-16', NULL, '1.1102.60.00', NULL, NULL, NULL, 2.1112, 0.079),
    ('53', 'multa', 2367, 2022, '2023-01-29', NULL, '1.0106.12.00', '8512.10.00', 4045.41, 0.1802, NULL, NULL),
    ('29', 'multa', 2439, 2022, '2025-12-15', '2029-06-05', '1.2301.12.00', NULL, 128.15, 0.2402, NULL, NULL),
    ('32', 'multa', 2354, 2025, '2026-03-17', NULL, '1.1901.10.00', NULL, 280.58, 0.0369, NULL, NULL),
    ('24', 'multa', 1109, 2017, '2016-06-11', NULL, NULL, '6213.20.00', 41.51, 0.1026, NULL, NULL),
    ('29', 'multa', 756, 2020, '2016-12-12', NULL, '1.1106.4', '5209.21.00', 59.2, 0.1888, NULL, NULL),
    ('13', 'if', 2974, 2016, '2018-09-11', NULL, '1.1704', NULL, NULL, NULL, 2.2544, 0.0473),
    ('3146107', 'if', 1781, 2025, '2015-07-18', NULL, NULL, NULL, NULL, NULL, 2.4385, 0.0671),
    ('1302603', 'if', 562, 2015, '2025-01-02', '2031-09-03', '1.2001.40.00', '3701.30.90', NULL, NULL, 1.8802, 0.037),
    ('5300108', 'if', 3160, 2020, '2025-10-23', NULL, '1.0608', '3006.30.18', NULL, NULL, 4.4028, 0.045),
    ('3550308', 'if', 1795, 2017, '2020-05-17', NULL, '1.1401.29.00', NULL, NULL, NULL, 15.3039, 0.032),
    ('3505906', 'multa', 1600, 2021, '2018-09-17', NULL, '1.1302.23.00', NULL, 291.97, 0.2012, NULL, NULL),
    ('13', 'multa', 2805, 2023, '2019-07-23', NULL, NULL, '0302.89.36', 86.41, 0.0959, NULL, NULL),
    ('32', 'multa', 2199, 2017, '2017-02-28', NULL, NULL, '0805.29.00', 6539.06, 0.2022, NULL, NULL),
    ('4208302', 'multa', 1381, 2022, '2017-11-15', '2019-04-16', NULL, NULL, 155.53, 0.0724, NULL, NULL),
    ('26', 'if', 3508, 2019, '2015-01-29', NULL, NULL, NULL, NULL, NULL, 3.6412, 0.0626),
    ('3550308', 'multa', 28, 2020, '2025-02-20', NULL, '1.0101.29.00', NULL, 457.69, 0.154, NULL, NULL),
    ('3106200', 'if', 3303, 2023, '2016-01-28', NULL, NULL, '3301.90.40', NULL, NULL, 17.2618, 0.0084),
    ('24', 'multa', 3568, 2020, '2016-12-24', '2018-06-05', NULL, '6104.49.00', 104.07, 0.0853, NULL, NULL),
    ('3306305', 'if', 2729, 2019, '2019-08-10', NULL, '1.0904.22.00', '9506.32.00', NULL, NULL, 5.8831, 0.0087),
    ('42', 'multa', 4020, 2023, '2018-12-17', NULL, '1.1703.31.00', '2904.34.00', 29.64, 0.2237, NULL, NULL),
    ('28', 'multa', 4903, 2017, '2026-05-27', NULL, '1.1409.30.00', NULL, 114.87, 0.0482, NULL, NULL),
    ('4208302', 'if', 25, 2016, '2018-12-04', NULL, '1.2301.94.00', NULL, NULL, NULL, 20.579, 0.0498),
    ('5300108', 'if', 4031, 2026, '2017-05-29', NULL, '1.1103.23.00', '3402.90.11', NULL, NULL, 6.6567, 0.0738),
    ('32', 'if', 3729, 2018, '2019-07-01', NULL, NULL, '5509.22.00', NULL, NULL, 2.9375, 0.0797),
    ('3146206', 'if', 4303, 2021, '2016-10-01', NULL, '1.1806.70.00', '0805.10.00', NULL, NULL, 1.3769, 0.0347),
    ('3550308', 'if', 3457, 2022, '2022-02-06', NULL, '1.1402.3', NULL, NULL, NULL, 4.1963, 0.0279),
    ('3304557', 'multa', 3807, 2017, '2018-02-09', NULL, '1.1106.34.00', NULL, 217.44, 0.2412, NULL, NULL),
    ('4205407', 'multa', 2955, 2020, '2025-09-10', NULL, NULL, '3003.90.78', 87.49, 0.1113, NULL, NULL),
    ('21', 'if', 2431, 2021, '2026-07-14', NULL, '1.1403.24.00', '8406.90.29', NULL, NULL, 33.1399, 0.0779),
    ('4106902', 'if', 4620, 2023, '2026-04-12', NULL, NULL, '3405.90.00', NULL, NULL, 0.5227, 0.023),
    ('3205309', 'if', 650, 2026, '2023-04-04', NULL, '1.0501.12.10', '3402.39.30', NULL, NULL, 9.3584, 0.0314),
    ('35', 'multa', 3994, 2022, '2017-11-29', NULL, NULL, NULL, 95.81, 0.0495, NULL, NULL),
    ('4208302', 'if', 4737, 2017, '2022-11-15', NULL, NULL, NULL, NULL, NULL, 3.33, 0.0463),
    ('4308250', 'multa', 3683, 2024, '2019-08-08', '2024-04-18', NULL, '2933.99.45', 104.81, 0.2425, NULL, NULL),
    ('4308250', 'multa', 1022, 2022, '2015-12-27', NULL, '1.0904.39.00', '3301.29.15', 156.31, 0.2017, NULL, NULL),
    ('35', 'multa', 4947, 2026, '2018-01-11', NULL, NULL, NULL, 45.74, 0.2332, NULL, NULL),
    ('3146107', 'if', 3533, 2016, '2020-07-16', NULL, '1.2403.31.00', '5510.90.11', NULL, NULL, 1.2177, 0.0755),
    ('3304557', 'if', 2766, 2020, '2025-06-23', NULL, '1.0502.14.90', '3701.30.50', NULL, NULL, 5.2486, 0.0201),
    ('3501905', 'multa', 4950, 2018, '2024-12-03', NULL, NULL, NULL, 86.66, 0.1439, NULL, NULL),
    ('53', 'multa', 837, 2015, '2026-01-27', '2031-03-18', NULL, '9026.80.00', 119.8, 0.1597, NULL, NULL),
    ('24', 'multa', 3742, 2021, '2018-10-12', NULL, NULL, NULL, 2889.64, 0.2484, NULL, NULL),
    ('4106902', 'if', 635, 2018, '2024-08-05', NULL, NULL, '4009.11.00', NULL, NULL, 5.1074, 0.0526),
    ('2919306', 'multa', 2712, 2016, '2015-04-05', '2017-09-04', NULL, '8607.11.20', 51.85, 0.1307, NULL, NULL),
    ('13', 'if', 4207, 2021, '2016-06-28', '2018-12-15', NULL, '5608.90.00', NULL, NULL, 2.5393, 0.0417),
    ('32', 'if', 2266, 2015, '2022-04-29', NULL, NULL, '0208.40.00', NULL, NULL, 2.3827, 0.0102),
    ('4205407', 'multa', 759, 2022, '2016-08-08', '2021-12-09', NULL, '8443.99.12', 212.8, 0.2215, NULL, NULL),
    ('4314902', 'if', 4092, 2016, '2019-04-19', '2021-06-28', '1.1902.10.00', '7411.22.90', NULL, NULL, 11.4968, 0.0343),
    ('3106200', 'multa', 1527, 2024, '2019-08-26', NULL, '1.0901.52.30', '2939.11.81', 49.1, 0.1902, NULL, NULL),
    ('21', 'if', 330, 2018, '2020-09-14', '2022-06-01', NULL, NULL, NULL, NULL, 1.9205, 0.003),
    ('3548906', 'multa', 757, 2017, '2024-08-09', NULL, NULL, '8607.11.10', 3093.82, 0.0966, NULL, NULL),
    ('3550308', 'multa', 1187, 2021, '2016-07-10', NULL, '1.2502.10.00', NULL, 152.51, 0.1513, NULL, NULL),
    ('28', 'if', 1969, 2015, '2025-07-06', NULL, '1.0502.23.10', NULL, NULL, NULL, 18.4036, 0.0093),
    ('32', 'if', 1513, 2021, '2026-12-02', '2030-04-13', '1.0501.1', NULL, NULL, NULL, 3.565, 0.0443),
    ('4106902', 'multa', 2266, 2026, '2024-10-31', NULL, '1.0102.52', NULL, 471.33, 0.0187, NULL, NULL),
    ('3146107', 'if', 2352, 2016, '2021-07-09', '2024-03-21', '1.1303', '2934.91.33', NULL, NULL, 3.1784, 0.0433),
    ('2919306', 'if', 3979, 2015, '2026-03-31', NULL, NULL, '4202.91.00', NULL, NULL, 4.0881, 0.0167),
    ('26', 'multa', 3220, 2025, '2016-01-06', NULL, NULL, NULL, 282.8, 0.0471, NULL, NULL),
    ('3306305', 'multa', 3432, 2017, '2025-07-04', NULL, '1.0403.21', '8409.91.40', 253.44, 0.0343, NULL, NULL),
    ('2919306', 'multa', 4623, 2015, '2019-02-01', NULL, NULL, NULL, 192.74, 0.0305, NULL, NULL),
    ('32', 'multa', 4657, 2019, '2022-09-15', NULL, '1.1406.39.00', NULL, 286.47, 0.0513, NULL, NULL),
    ('3550308', 'multa', 3800, 2026, '2021-06-04', NULL, '1.1303.20.00', '2909.49.50', 193.86, 0.2354, NULL, NULL),
    ('5300108', 'multa', 4239, 2016, '2017-02-17', NULL, NULL, NULL, 125.27, 0.161, NULL, NULL),
    ('3306305', 'if', 4664, 2021, '2026-08-18', NULL, '1.1103.22.00', NULL, NULL, NULL, 4.1398, 0.0747),
    ('42', 'multa', 2106, 2019, '2015-04-10', NULL, NULL, '8480.71.00', 637.2, 0.0333, NULL, NULL),
    ('4308250', 'if', 4800, 2015, '2022-01-03', '2023-06-07', '1.0102.41.10', '8708.95.22', NULL, NULL, 3.2781, 0.0354),
    ('29', 'if', 1260, 2024, '2015-01-12', NULL, '1.1401.1', '2930.20.21', NULL, NULL, 3.8714, 0.0512),
    ('3146206', 'multa', 1174, 2026, '2017-04-06', NULL, NULL, '8105.90.90', 119.97, 0.1568, NULL, NULL),
    ('2927408', 'if', 3734, 2017, '2020-03-02', NULL, NULL, '9021.29.00', NULL, NULL, 3.3223, 0.0159),
    ('4106902', 'if', 1946, 2021, '2019-06-02', NULL, '1.2402', '8522.90.00', NULL, NULL, 7.2824, 0.0712),
    ('29', 'multa', 2361, 2020, '2018-11-20', NULL, '1.0506.00.00', NULL, 104.56, 0.0922, NULL, NULL),
    ('4208302', 'multa', 1123, 2019, '2025-09-14', NULL, '1.0103', NULL, 173.38, 0.2287, NULL, NULL),
    ('35', 'multa', 680, 2017, '2025-06-11', NULL, NULL, NULL, 79.29, 0.1799, NULL, NULL),
    ('3146107', 'if', 2226, 2015, '2017-03-09', NULL, '1.0107.20.00', NULL, NULL, NULL, 2.3017, 0.0778),
    ('35', 'if', 332, 2015, '2015-08-15', '2017-12-19', '1.2001.3', '9021.10.9', NULL, NULL, 2.4079, 0.0796),
    ('4208302', 'multa', 4281, 2018, '2016-09-29', NULL, NULL, '2914.22.10', 204.17, 0.119, NULL, NULL),
    ('2927408', 'multa', 1737, 2024, '2019-03-19', '2023-11-30', NULL, NULL, 41.1, 0.0319, NULL, NULL),
    ('3548906', 'if', 2418, 2020, '2017-06-23', NULL, '1.1403.22.13', NULL, NULL, NULL, 5.8195, 0.035),
    ('3548906', 'multa', 3526, 2021, '2022-02-01', NULL, NULL, '5603.13.20', 292.07, 0.067, NULL, NULL),
    ('26', 'multa', 1093, 2023, '2022-10-23', NULL, NULL, NULL, 84.43, 0.2391, NULL, NULL),
    ('41', 'multa', 1301, 2017, '2015-09-19', NULL, NULL, '8471.80.00', 201.57, 0.1823, NULL, NULL),
    ('24', 'multa', 2296, 2022, '2016-03-11', '2020-06-22', '1.1805.19.00', NULL, 182.66, 0.1589, NULL, NULL),
    ('4314902', 'multa', 1079, 2023, '2021-08-08', NULL, '1.0504.42.00', '5209.42.90', 271.0, 0.2339, NULL, NULL),
    ('24', 'multa', 3453, 2022, '2023-03-23', NULL, '1.1001.12', '4005.91.10', 45.14, 0.0146, NULL, NULL),
    ('2927408', 'multa', 4787, 2022, '2026-11-27', NULL, NULL, '8501.34.11', 164.28, 0.0927, NULL, NULL),
    ('4314902', 'if', 1804, 2017, '2024-08-20', NULL, NULL, '2611.00.00', NULL, NULL, 0.9365, 0.0189),
    ('3205309', 'multa', 3043, 2015, '2025-07-14', NULL, NULL, '2921.19.22', 155.92, 0.1579, NULL, NULL),
    ('35', 'if', 352, 2016, '2026-12-01', NULL, NULL, NULL, NULL, NULL, 1.6563, 0.0703),
    ('29', 'if', 1680, 2023, '2019-04-06', NULL, NULL, NULL, NULL, NULL, 6.6154, 0.0776),
    ('24', 'if', 800, 2016, '2019-05-02', NULL, '1.1403.26.00', '1302.11.90', NULL, NULL, 3.2388, 0.0194),
    ('2919306', 'if', 1495, 2024, '2024-08-20', NULL, '1.0102.5', '2922.19.91', NULL, NULL, 2.68, 0.0333),
    ('3205309', 'multa', 2266, 2017, '2022-09-08', NULL, NULL, NULL, 190.49, 0.1229, NULL, NULL),
    ('53', 'if', 4642, 2019, '2019-09-29', '2023-02-27', '1.1403.2', NULL, NULL, NULL, 92.6324, 0.0353),
    ('42', 'multa', 3465, 2017, '2025-06-12', '2031-09-08', NULL, NULL, 2977.25, 0.1186, NULL, NULL),
    ('4205407', 'if', 4373, 2025, '2024-06-22', '2025-12-11', NULL, NULL, NULL, NULL, 2.0391, 0.0449),
    ('3505906', 'multa', 570, 2020, '2017-05-17', NULL, '1.1903', '2915.11.00', 91.84, 0.1914, NULL, NULL),
    ('4308250', 'if', 4068, 2026, '2026-03-08', '2031-05-01', NULL, '2934.10.90', NULL, NULL, 3.8528, 0.0705),
    ('35', 'if', 1920, 2025, '2018-10-11', NULL, '1.0904', NULL, NULL, NULL, 6.6585, 0.0203),
    ('32', 'if', 4550, 2024, '2024-09-28', NULL, '1.0501.21.20', '8467.29.91', NULL, NULL, 3.7567, 0.0746),
    ('4308250', 'multa', 4197, 2021, '2016-03-27', NULL, NULL, NULL, 200.04, 0.1566, NULL, NULL),
    ('13', 'multa', 20, 2019, '2024-04-07', NULL, '1.0602.33.00', '3907.10.49', 410.95, 0.1768, NULL, NULL),
    ('3306305', 'if', 3327, 2015, '2019-04-10', NULL, NULL, '2921.59.2', NULL, NULL, 2.4857, 0.0402),
    ('4205407', 'if', 415, 2025, '2016-08-15', NULL, '1.1402.2', '8463.20.91', NULL, NULL, 1.1541, 0.0506),
    ('1302603', 'multa', 971, 2022, '2026-02-08', NULL, '1.0901.31.00', '2904.10.52', 410.86, 0.1985, NULL, NULL),
    ('4208302', 'if', 2250, 2015, '2015-03-03', '2019-04-22', NULL, NULL, NULL, NULL, 2.1722, 0.0354),
    ('51', 'if', 4110, 2023, '2018-10-18', NULL, NULL, NULL, NULL, NULL, 35.5147, 0.0612),
    ('3304557', 'multa', 1395, 2019, '2024-03-16', NULL, NULL, '2934.99.43', 158.07, 0.2204, NULL, NULL),
    ('3205309', 'if', 1412, 2015, '2022-02-21', NULL, NULL, '8460.29.00', NULL, NULL, 3.9089, 0.0791),
    ('4106902', 'if', 3692, 2019, '2020-04-26', NULL, NULL, NULL, NULL, NULL, 7.4118, 0.0634),
    ('26', 'multa', 661, 2026, '2021-06-20', NULL, NULL, '3214.10.20', 133.61, 0.1289, NULL, NULL),
    ('43', 'multa', 571, 2019, '2023-05-31', NULL, '1.2304.20.00', NULL, 124.99, 0.0665, NULL, NULL),
    ('31', 'if', 950, 2015, '2017-10-20', NULL, '1.0905.23.00', '7318.22.00', NULL, NULL, 54.4958, 0.0333),
    ('3304557', 'if', 563, 2022, '2026-09-05', NULL, '1.0501.23', NULL, NULL, NULL, 1.7698, 0.0522),
    ('24', 'multa', 1241, 2023, '2021-01-06', NULL, NULL, '5513.49.90', 324.72, 0.1485, NULL, NULL),
    ('3304557', 'if', 4184, 2017, '2025-08-25', NULL, NULL, NULL, NULL, NULL, 2.9886, 0.011),
    ('32', 'multa', 2411, 2021, '2020-02-20', NULL, '1.1901.30.00', NULL, 139.98, 0.1843, NULL, NULL),
    ('2919306', 'multa', 3003, 2026, '2023-11-22', NULL, NULL, '2914.69.20', 248.34, 0.0833, NULL, NULL),
    ('3146206', 'multa', 2066, 2017, '2019-02-26', NULL, NULL, NULL, 122.19, 0.1052, NULL, NULL),
    ('3548906', 'multa', 4780, 2026, '2021-08-12', NULL, NULL, NULL, 179.73, 0.2442, NULL, NULL),
    ('5300108', 'if', 1730, 2017, '2015-12-18', NULL, '1.0304.20.00', '8523.29.1', NULL, NULL, 7.3155, 0.0644),
    ('4205407', 'multa', 2707, 2025, '2024-04-11', NULL, '1.0501.14.40', '2933.21.10', 331.0, 0.1156, NULL, NULL),
    ('3205309', 'if', 4199, 2021, '2017-10-11', NULL, '1.0909', '6113.00.00', NULL, NULL, 3.5678, 0.0713),
    ('42', 'multa', 4934, 2026, '2017-11-11', NULL, '1.0906.20.00', NULL, 371.03, 0.0135, NULL, NULL),
    ('32', 'if', 1477, 2025, '2017-01-22', NULL, NULL, NULL, NULL, NULL, 8.8392, 0.0626),
    ('32', 'multa', 1996, 2017, '2021-04-29', NULL, '1.2404.39.00', '6802.92.00', 45.53, 0.0699, NULL, NULL),
    ('13', 'multa', 185, 2016, '2016-07-04', '2020-12-30', NULL, '2920.29.10', 130.21, 0.1696, NULL, NULL),
    ('3306305', 'multa', 3726, 2020, '2023-02-04', NULL, NULL, NULL, 56.29, 0.2099, NULL, NULL),
    ('3304557', 'multa', 1524, 2022, '2021-05-21', '2023-12-02', '1.0404.20.00', '6212.30.00', 33.18, 0.2216, NULL, NULL),
    ('3146206', 'multa', 1243, 2023, '2020-08-08', NULL, NULL, '3004.90.19', 521.09, 0.2019, NULL, NULL),
    ('4314902', 'multa', 1346, 2021, '2026-12-05', NULL, '1.1806.8', '3911.90.2', 425.38, 0.0374, NULL, NULL);

INSERT INTO inst_cient VALUES
    ('58.826.745/0001-34', 'Universidade de São Paulo', 'Praça da Sé', 33, '00000-001', '3550308'),
    ('37.669.280/0001-29', 'Universidade Federal de São Carlos', 'Rodovia Carlos Vignon', 767, '13769-020', '3548906'),
    ('11.679.309/0001-01', 'Instituto de Pesquisa FioCruz', 'Avenida Pinheiro', 88, '01473-394', '3550308'),
    ('53.396.825/0001-34', 'Laboratório de Pesquisa A.K.L.', 'Rua Sésamo', 35, '39445-014', '3106200'),
    ('09.850.333/0001-77', 'Universidade Federal do Rio de Janeiro', 'Avenida Laerte', 56, '38997-345', '3304557'),
    ('87.888.161/0001-65', 'Unidade Científica do Norte', 'Rua Corrêa', 1048, '69994-295', '1302603'),
    ('00.001.333/0001-99', 'Universidade Federal da Bahia', 'Rua Roberto Peixoto', 444, '43144-383', '2927408'),
    ('54.777.163/0001-46', 'Universidade Federal de Minas Gerais', 'Rodovia Afonso Pena', 998, '39802-120', '3106200');

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
    ('54.777.163/0001-46', 'Andamento das metas da ONU');

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
    ('54.777.163/0001-46', 'Andamento das metas da ONU', 'Léo Moura');

INSERT INTO relatorio VALUES
    (1, '2023-05-31', NULL, '48.603.715', '0001-45', '54.777.163/0001-46', 'Andamento das metas da ONU', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (1, '3908.10.14', 0.0385, 11477),
    (1, '9027.90.99', 0.0484, 400),
    (1, '8422.30.23', 0.2373, 2096),
    (1, '1901.90.10', 0.205, 7497),
    (1, '8407.10.00', 0.1796, 10550),
    (1, '2916.19.21', 0.1508, 1995),
    (1, '7304.29.90', 0.1396, 2115),
    (1, '3809.93.90', 0.009, 400),
    (1, '3006.30.12', 0.1936, 400),
    (1, '3004.39.18', 0.0784, 9932),
    (1, '2935.90.94', 0.1437, 8376),
    (1, '4811.49.90', 0.1302, 4510),
    (1, '3004.20.29', 0.1037, 3414),
    (1, '7302.10.90', 0.2017, 13561),
    (1, '7208.53.00', 0.0123, 400);

INSERT INTO relatorio_serv VALUES
    (1, '1.0105.21.00', '2023-06-03T13:32:01', 0.4037),
    (1, '1.1404.49.00', '2023-06-29T15:16:53', 0.2111),
    (1, '1.01', '2023-06-24T04:27:59', 0.1666),
    (1, '1.1103.43.00', '2023-06-03T01:10:27', 0.5771),
    (1, '1.1406.20.00', '2023-06-27T14:30:23', 0.5417),
    (1, '1.1403.22.21', '2023-06-06T15:15:41', 0.5213),
    (1, '1.0502.23.10', '2023-06-10T23:00:20', 0.4608),
    (1, '1.1403.22.90', '2023-06-01T21:14:20', 0.3523);

INSERT INTO relatorio VALUES
    (2, '2021-08-28', '2024-05-22', '51.360.297', '0001-43', '37.669.280/0001-29', 'Emissões em microempresas', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (2, '3806.90.12', 0.0286, 400),
    (2, '8471.60.59', 0.0075, 11895),
    (2, '4911.99.00', 0.0215, 6325),
    (2, '8542.32.9', 0.0395, 2452),
    (2, '7208.51.00', 0.016, 400),
    (2, '6306.22.00', 0.0139, 7215),
    (2, '6310.10.00', 0.0149, 6777),
    (2, '6902.10.19', 0.008, 400),
    (2, '4411.13.10', 0.0023, 642),
    (2, '2934.99.24', 0.0151, 667),
    (2, '2921.51.33', 0.0421, 9657),
    (2, '8411.91.00', 0.0099, 583);

INSERT INTO relatorio_serv VALUES
    (2, '1.0903.21.00', '2021-09-22T14:11:37', 0.0107),
    (2, '1.1103.3', '2021-09-27T03:18:13', 0.0739),
    (2, '1.1408.15.00', '2021-09-10T17:02:48', 0.0176),
    (2, '1.0901.5', '2021-09-13T06:22:20', 0.0065),
    (2, '1.2502.10.00', '2021-09-10T21:08:57', 0.0254),
    (2, '1.0401.11', '2021-09-11T17:09:25', 0.0535),
    (2, '1.0504.1', '2021-09-13T01:44:09', 0.0064),
    (2, '1.0601', '2021-09-27T01:11:12', 0.0142),
    (2, '1.0501.14.5', '2021-09-17T19:59:47', 0.0331),
    (2, '1.0903.22.00', '2021-09-10T20:10:21', 0.0088),
    (2, '1.07', '2021-09-05T03:32:28', 0.0182),
    (2, '1.1805.14.00', '2021-09-11T16:28:51', 0.0088),
    (2, '1.2001.31.10', '2021-09-29T05:13:20', 0.0198),
    (2, '1.2403.22.00', '2021-09-27T05:32:24', 0.026),
    (2, '1.0904.22.00', '2021-09-11T09:08:28', 0.0413);

INSERT INTO relatorio VALUES
    (3, '2022-07-06', '2026-02-20', '12.905.674', '0001-18', '54.777.163/0001-46', 'Andamento das metas da ONU', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (3, '6903.90.91', 0.0735, 2775),
    (3, '8504.23.00', 0.1275, 5065),
    (3, '8523.52.90', 0.0397, 821),
    (3, '2933.72.10', 0.0551, 4112),
    (3, '8501.40.29', 0.2416, 6660),
    (3, '3827.20.00', 0.1939, 5877),
    (3, '0306.19.90', 0.556, 1433),
    (3, '7607.11.20', 0.2374, 7356),
    (3, '8443.99.90', 0.1173, 1038),
    (3, '3004.10.19', 0.163, 5326),
    (3, '2939.61.00', 0.1117, 11020),
    (3, '2910.20.00', 0.0925, 2736),
    (3, '6812.99.90', 0.0699, 3520),
    (3, '2921.19.49', 0.0205, 400);

INSERT INTO relatorio_serv VALUES
    (3, '1.0901.51.22', '2022-08-07T12:02:26', 0.0245),
    (3, '1.0502.34.51', '2022-08-10T08:02:54', 0.3454),
    (3, '1.1101.15.00', '2022-08-27T14:50:28', 0.4017);

INSERT INTO relatorio VALUES
    (4, '2024-01-13', '2026-05-19', '13.690.872', '0001-54', '54.777.163/0001-46', 'Andamento das metas da ONU', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (4, '3803.00.90', 0.0391, 2684),
    (4, '9031.49.20', 0.0847, 12836),
    (4, '3004.39.3', 0.1011, 400),
    (4, '2843.90.40', 0.0937, 10152),
    (4, '3204.15.10', 0.0561, 400),
    (4, '4107.12.20', 0.0231, 400),
    (4, '0401.10.10', 0.0417, 400),
    (4, '0305.53.90', 0.0094, 500),
    (4, '2909.60.1', 0.0625, 8780),
    (4, '2909.49.24', 0.0551, 8296),
    (4, '4810.19.81', 0.0199, 3969),
    (4, '8473.30.90', 0.0697, 3896);

INSERT INTO relatorio_serv VALUES
    (4, '1.0605.90.00', '2024-02-12T08:18:47', 0.2002),
    (4, '1.10', '2024-02-24T23:40:53', 0.074),
    (4, '1.2403.32.00', '2024-02-23T05:24:24', 0.1374),
    (4, '1.0602.90.00', '2024-02-22T07:38:32', 0.044),
    (4, '1.0504.45.10', '2024-02-02T01:24:02', 0.0654),
    (4, '1.1806.53.00', '2024-02-26T00:23:50', 0.2168),
    (4, '1.2404.1', '2024-02-07T12:44:04', 0.1015),
    (4, '1.1506.2', '2024-02-02T12:26:50', 0.1707);

INSERT INTO relatorio VALUES
    (5, '2025-04-11', '2025-09-11', '13.690.872', '0001-54', '53.396.825/0001-34', 'Formas de reduzir o impacto de emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (5, '5603.12.40', 0.0068, 4207),
    (5, '8537.10.1', 1.0832, 9429),
    (5, '5204.11.1', 0.0652, 400),
    (5, '9701.91.00', 1.2202, 4403),
    (5, '8536.90.40', 0.1471, 9853);

INSERT INTO relatorio_serv VALUES
    (5, '1.0501.23.10', '2025-05-14T02:04:22', 0.1855),
    (5, '1.1502.90.00', '2025-05-24T08:58:32', 0.1799),
    (5, '1.1102', '2025-05-30T18:16:13', 0.2856),
    (5, '1.2101.22.00', '2025-05-29T11:49:18', 0.0393),
    (5, '1.0502.34.10', '2025-05-01T10:46:00', 0.2505),
    (5, '1.2404.31.00', '2025-05-20T00:56:19', 0.0938),
    (5, '1.0502.12', '2025-05-18T10:41:07', 0.1792),
    (5, '1.0403.11.90', '2025-05-25T00:10:40', 0.0615),
    (5, '1.0402', '2025-05-24T03:41:14', 0.3506),
    (5, '1.0907.00.00', '2025-05-19T05:46:01', 0.0408),
    (5, '1.0502.14.5', '2025-05-01T08:09:16', 0.2837);

INSERT INTO relatorio VALUES
    (6, '2026-02-05', '2026-06-01', '48.603.715', '0001-78', '54.777.163/0001-46', 'Andamento das metas da ONU', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (6, '0302.44.00', 0.1235, 8115),
    (6, '3920.99.50', 0.0498, 12317),
    (6, '3827.40.00', 0.0811, 400),
    (6, '7202.49.00', 0.0839, 4017),
    (6, '3907.29.99', 0.0215, 1561),
    (6, '6402.91.90', 0.0337, 400),
    (6, '8457.30.10', 0.0841, 1123),
    (6, '3824.99.21', 0.0911, 10270),
    (6, '4401.39.00', 0.0258, 400),
    (6, '5209.21.00', 0.1768, 6353),
    (6, '2933.59.12', 0.0203, 400),
    (6, '8448.32.40', 0.1508, 2200),
    (6, '5515.22.00', 0.0306, 400),
    (6, '2530.90.10', 0.0284, 12907);

INSERT INTO relatorio_serv VALUES
    (6, '1.1410.10.00', '2026-03-17T06:50:16', 0.0223),
    (6, '1.2301', '2026-03-08T21:05:26', 0.1903),
    (6, '1.0903.33.00', '2026-03-22T18:43:03', 0.1094),
    (6, '1.1406.12.00', '2026-03-05T18:40:13', 0.116),
    (6, '1.0503.23.00', '2026-03-14T18:48:08', 0.331),
    (6, '1.0403.12.00', '2026-03-15T22:17:27', 0.0961),
    (6, '1.1805.3', '2026-03-14T21:27:52', 0.7935),
    (6, '1.1806.82.00', '2026-03-23T03:45:00', 0.1413),
    (6, '1.1901.50.00', '2026-03-03T21:55:29', 0.1031),
    (6, '1.0403.21.10', '2026-03-10T11:43:23', 0.0714),
    (6, '1.1105.30.00', '2026-03-02T17:54:43', 0.1446),
    (6, '1.0901.52.40', '2026-03-04T07:38:09', 0.0707);

INSERT INTO relatorio VALUES
    (7, '2025-08-12', '2025-11-22', '65.172.380', '0001-61', '54.777.163/0001-46', 'O capitalismo como motor da exploração dos recursos naturais', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (7, '8428.20.90', 0.2457, 400),
    (7, '6902.20.92', 0.7987, 6159),
    (7, '2918.29.50', 0.0219, 8100),
    (7, '1518.00.90', 0.0648, 400),
    (7, '5206.11.00', 0.0823, 400),
    (7, '0305.51.00', 0.2706, 7870),
    (7, '5402.61.90', 0.0826, 1488),
    (7, '8538.10.00', 0.3715, 1267),
    (7, '4011.80.20', 0.0377, 400),
    (7, '2933.91.81', 0.2683, 6982);

INSERT INTO relatorio VALUES
    (8, '2021-11-17', NULL, '20.978.635', '0001-10', '54.777.163/0001-46', 'O capitalismo como motor da exploração dos recursos naturais', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (8, '2930.90.72', 0.9487, 6259),
    (8, '9105.91.00', 0.007, 400),
    (8, '1004.90.00', 0.006, 6331),
    (8, '3903.11.20', 0.0009, 6128),
    (8, '3003.49.40', 0.0548, 15485),
    (8, '2937.23.51', 0.0258, 5771),
    (8, '8543.70.9', 0.0113, 1859),
    (8, '2922.19.59', 0.0219, 3852),
    (8, '8422.30.29', 0.0174, 400),
    (8, '0910.91.00', 0.0021, 4495),
    (8, '8467.99.00', 0.0009, 15785),
    (8, '9025.11.1', 0.0135, 5073),
    (8, '9706.10.00', 0.0298, 7497),
    (8, '2841.90.29', 0.0062, 400),
    (8, '5206.21.00', 0.0001, 6245),
    (8, '2930.90.83', 0.0831, 497),
    (8, '6102.30.00', 0.0133, 400),
    (8, '8215.99.10', 0.0015, 5891),
    (8, '2924.29.69', 0.0207, 400),
    (8, '2930.90.84', 0.0079, 740),
    (8, '7410.11.19', 0.0248, 7578),
    (8, '8478.90.00', 0.0236, 1429),
    (8, '8465.92.19', 0.0249, 1977);

INSERT INTO relatorio VALUES
    (9, '2024-03-27', NULL, '45.690.123', '0001-36', '87.888.161/0001-65', 'Impacto de atividades agropecuárias na Amazônia', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (9, '2922.49.61', 1.8173, 8519),
    (9, '2710.91.20', 0.0617, 14867),
    (9, '5407.61.00', 0.1931, 6806),
    (9, '4002.20.10', 0.0905, 400),
    (9, '5510.12.90', 0.0196, 400),
    (9, '3808.93.27', 0.2436, 400),
    (9, '0210.99.19', 0.1678, 400),
    (9, '4418.21.00', 0.0272, 12031);

INSERT INTO relatorio_serv VALUES
    (9, '1.2404.31.00', '2024-04-26T14:27:42', 2.0763),
    (9, '1.1108.30.00', '2024-04-15T06:43:07', 0.0212),
    (9, '1.1101.14.00', '2024-04-06T23:20:40', 0.0041),
    (9, '1.1401.1', '2024-04-11T00:58:44', 0.0659),
    (9, '1.1105.59.00', '2024-04-09T11:07:05', 0.151),
    (9, '1.1703.9', '2024-04-04T11:04:56', 0.0648),
    (9, '1.2505.20.00', '2024-04-19T11:26:03', 0.0203),
    (9, '1.2406.90.00', '2024-04-11T05:12:51', 0.0732),
    (9, '1.1107.32.00', '2024-04-21T14:01:28', 0.0869),
    (9, '1.2501.39.00', '2024-04-23T15:55:48', 0.0137),
    (9, '1.1801.21.00', '2024-04-06T13:06:02', 0.1183),
    (9, '1.1102.40.00', '2024-04-18T09:06:40', 0.0032),
    (9, '1.2501.1', '2024-04-08T03:57:14', 0.0968),
    (9, '1.0904.32.00', '2024-04-22T08:02:52', 0.023);

INSERT INTO relatorio VALUES
    (10, '2022-02-20', '2022-04-20', '20.978.635', '0001-10', '53.396.825/0001-34', 'Formas de reduzir o impacto de emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (10, '8454.30.90', 1.8691, 400),
    (10, '8414.80.32', 0.0252, 400),
    (10, '8805.21.00', 0.0593, 400),
    (10, '4911.99.00', 0.0896, 8258),
    (10, '2915.39.93', 0.0221, 2455),
    (10, '2930.20.21', 0.0452, 9035),
    (10, '3604.10.00', 0.1181, 5493),
    (10, '2802.00.00', 0.2774, 5623),
    (10, '2937.23.91', 0.0719, 14628),
    (10, '3204.18.20', 0.0051, 3235),
    (10, '2926.90.96', 0.0962, 6015),
    (10, '4810.13.9', 0.0664, 400),
    (10, '8410.13.00', 0.1249, 8222),
    (10, '2008.97.10', 0.011, 3532),
    (10, '5404.12.00', 0.0412, 3388),
    (10, '4104.11.12', 0.0056, 5442);

INSERT INTO relatorio VALUES
    (11, '2023-07-13', '2025-11-14', '79.821.563', '0001-00', '58.826.745/0001-34', 'Emissões a alto nível', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (11, '8211.92.10', 8.3991, 4231),
    (11, '3910.00.12', 0.011, 2485),
    (11, '8481.20.1', 0.3209, 6697),
    (11, '2933.91.79', 0.093, 7816),
    (11, '8517.61.91', 1.0026, 9434),
    (11, '9306.29.00', 0.0209, 7369),
    (11, '2916.20.90', 0.3267, 400),
    (11, '4418.89.00', 0.3668, 9794),
    (11, '7312.90.00', 0.0061, 3256),
    (11, '0305.31.00', 0.4844, 2733),
    (11, '8421.29.11', 0.173, 1061),
    (11, '5101.30.00', 0.2559, 12984),
    (11, '1003.90.10', 0.4754, 9964),
    (11, '1515.90.2', 0.1593, 6879),
    (11, '7202.11.00', 0.1653, 400);

INSERT INTO relatorio_serv VALUES
    (11, '1.0901', '2023-08-02T19:14:12', 6.3561),
    (11, '1.1201', '2023-08-06T22:13:13', 0.0172),
    (11, '1.0901.51.29', '2023-08-27T11:37:34', 0.0615),
    (11, '1.0502.14.40', '2023-08-06T00:39:59', 0.2097),
    (11, '1.0901.40.00', '2023-08-07T16:56:11', 0.0289),
    (11, '1.0903.11.00', '2023-08-13T10:34:30', 0.415),
    (11, '1.2001.40.00', '2023-08-24T19:50:57', 0.6965),
    (11, '1.1001.12', '2023-08-28T06:45:21', 0.0862);

INSERT INTO relatorio VALUES
    (12, '2022-09-19', '2024-09-17', '48.603.715', '0001-78', '54.777.163/0001-46', 'Andamento das metas da ONU', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (12, '4802.58.99', 0.1002, 5651),
    (12, '8422.30.2', 0.0654, 2046),
    (12, '3906.90.51', 0.0123, 3837),
    (12, '8545.19.10', 0.0955, 6234),
    (12, '7309.00.90', 0.0151, 7175),
    (12, '2933.91.81', 0.0742, 2818),
    (12, '0707.00.00', 0.0405, 6425),
    (12, '8505.19.90', 0.0264, 3921),
    (12, '6305.10.00', 0.0183, 4624),
    (12, '5402.31.90', 0.1089, 6921);

INSERT INTO relatorio_serv VALUES
    (12, '1.0501.13', '2022-10-01T03:26:13', 0.0692),
    (12, '1.1103.22.00', '2022-10-23T20:09:23', 0.0312),
    (12, '1.1703.2', '2022-10-25T16:29:24', 0.1234),
    (12, '1.06', '2022-10-28T00:42:48', 0.0147),
    (12, '1.2001.81.00', '2022-10-23T13:41:56', 0.0601),
    (12, '1.0604.40.00', '2022-10-28T00:21:27', 0.0382),
    (12, '1.1705', '2022-10-13T20:54:09', 0.0913);

INSERT INTO relatorio VALUES
    (13, '2024-10-09', '2025-08-13', '01.274.895', '0001-40', '37.669.280/0001-29', 'Pesquisa de campo em emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (13, '2008.19.00', 0.0867, 3609);

INSERT INTO relatorio_serv VALUES
    (13, '1.2301.92.00', '2024-11-19T10:09:51', 0.0035),
    (13, '1.1404.13.00', '2024-11-29T09:58:43', 0.1561),
    (13, '1.0303', '2024-11-05T18:50:22', 0.0091),
    (13, '1.1101.90.00', '2024-11-07T11:46:22', 0.109),
    (13, '1.0902.30.00', '2024-11-15T11:02:50', 0.0038),
    (13, '1.0403.2', '2024-11-22T19:49:33', 0.0589),
    (13, '1.2404.13.00', '2024-11-03T22:15:16', 0.0733),
    (13, '1.2304', '2024-11-03T21:36:14', 0.1027),
    (13, '1.2501.11.00', '2024-11-15T15:34:41', 0.0915),
    (13, '1.0301.32.00', '2024-11-11T22:19:18', 0.0494),
    (13, '1.0107.90.00', '2024-11-19T04:41:03', 0.1058),
    (13, '1.1507', '2024-11-25T04:31:50', 0.0422),
    (13, '1.0504.45', '2024-11-22T22:36:03', 0.0221),
    (13, '1.0403.23.00', '2024-11-20T16:00:46', 0.0194),
    (13, '1.0903.38.00', '2024-11-10T21:43:34', 0.061),
    (13, '1.0602.31.00', '2024-11-19T17:34:08', 0.155),
    (13, '1.0502.14.59', '2024-11-10T21:04:30', 0.0107),
    (13, '1.2301.21.00', '2024-11-05T20:47:02', 0.1446),
    (13, '1.2205.19.00', '2024-11-02T06:45:52', 0.0204);

INSERT INTO relatorio VALUES
    (14, '2025-03-08', NULL, '01.274.895', '0001-40', '37.669.280/0001-29', 'Emissões em microempresas', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (14, '0705.21.00', 0.2494, 9994),
    (14, '3004.20.63', 0.1928, 6771),
    (14, '8472.90.9', 0.0667, 6434);

INSERT INTO relatorio_serv VALUES
    (14, '1.0501.14.20', '2025-04-22T21:19:32', 0.0427),
    (14, '1.0106.12.00', '2025-04-17T22:30:58', 0.0659),
    (14, '1.0502.12', '2025-04-22T17:20:56', 0.0555),
    (14, '1.2503.10.00', '2025-04-02T11:58:37', 0.0356),
    (14, '1.0402.12.00', '2025-04-23T05:44:35', 0.1474),
    (14, '1.0502.24.52', '2025-04-24T19:29:00', 0.0599),
    (14, '1.1107.90.00', '2025-04-12T06:03:51', 0.0578),
    (14, '1.0501.21.20', '2025-04-12T15:04:24', 0.045),
    (14, '1.1105.90.00', '2025-04-19T09:31:55', 0.0376),
    (14, '1.1406.34.00', '2025-04-14T03:31:56', 0.0732),
    (14, '1.02', '2025-04-06T15:31:03', 0.0516),
    (14, '1.0504.3', '2025-04-04T16:14:33', 0.1147),
    (14, '1.1201.12.00', '2025-04-24T03:36:01', 0.0558),
    (14, '1.2404.33.00', '2025-04-24T17:19:44', 0.0568),
    (14, '1.1506.21.00', '2025-04-23T21:27:20', 0.31),
    (14, '1.1405.12.00', '2025-04-08T00:37:07', 0.0488),
    (14, '1.2403', '2025-04-18T04:48:49', 0.0783),
    (14, '1.1109.30.00', '2025-04-09T05:55:12', 0.0319),
    (14, '1.0102.4', '2025-04-16T08:03:58', 0.0057),
    (14, '1.0106.50.00', '2025-04-03T00:20:54', 0.1547),
    (14, '1.1109.20.00', '2025-04-01T06:56:49', 0.0771),
    (14, '1.1805.24.00', '2025-04-20T00:08:26', 0.1951),
    (14, '1.1803.10.00', '2025-04-25T07:32:52', 0.1944),
    (14, '1.0501.23.10', '2025-04-25T05:51:21', 0.1878);

INSERT INTO relatorio VALUES
    (15, '2022-10-29', '2025-06-04', '64.087.915', '0001-27', '37.669.280/0001-29', 'Pesquisa de campo em emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (15, '0308.22.00', 0.0167, 400),
    (15, '0801.32.00', 0.0023, 1169),
    (15, '8431.42.00', 0.0, 4880);

INSERT INTO relatorio_serv VALUES
    (15, '1.2301.12.00', '2022-11-05T13:57:04', 1.3381),
    (15, '1.2404.13.00', '2022-11-06T18:45:21', 0.015),
    (15, '1.0602.32.00', '2022-11-19T22:53:36', 0.0481),
    (15, '1.2205.14.00', '2022-11-08T12:50:29', 0.0058),
    (15, '1.0401.19.00', '2022-11-06T17:36:44', 0.0522),
    (15, '1.1202.90.00', '2022-11-04T16:38:30', 0.1235),
    (15, '1.2501.1', '2022-11-04T10:40:24', 0.0499),
    (15, '1.2602.10.00', '2022-11-17T09:09:12', 0.0225),
    (15, '1.0602.10.00', '2022-11-15T03:51:28', 0.002),
    (15, '1.0401.11.11', '2022-11-01T02:13:03', 0.017),
    (15, '1.1408.15.00', '2022-11-25T15:43:25', 0.0295),
    (15, '1.2205.1', '2022-11-17T16:49:58', 0.0167),
    (15, '1.0502.14.20', '2022-11-07T10:01:54', 0.0023),
    (15, '1.2302', '2022-11-28T17:44:39', 0.01),
    (15, '1.0401.30.00', '2022-11-04T18:22:57', 0.0657),
    (15, '1.1802.30.00', '2022-11-11T21:15:39', 0.022),
    (15, '1.2204.10.00', '2022-11-28T01:07:00', 0.057),
    (15, '1.1401.29.00', '2022-11-20T08:59:56', 0.0387),
    (15, '1.2001.3', '2022-11-12T03:37:45', 0.0014),
    (15, '1.1806.6', '2022-11-21T20:59:00', 0.0011),
    (15, '1.0905.12.00', '2022-11-15T06:35:30', 0.0121),
    (15, '1.1103.36.10', '2022-11-14T08:56:10', 0.0315);

INSERT INTO relatorio VALUES
    (16, '2025-01-02', '2025-03-19', '12.905.674', '0001-18', '53.396.825/0001-34', 'Formas de reduzir o impacto de emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (16, '8467.22.00', 0.9803, 400),
    (16, '8212.10.10', 0.4984, 400),
    (16, '8473.50.50', 0.6608, 400),
    (16, '6108.21.00', 1.2317, 13207),
    (16, '5704.20.00', 0.467, 12036),
    (16, '0305.32.10', 0.257, 5630),
    (16, '2839.90.20', 1.1437, 5699),
    (16, '7114.11.00', 0.5209, 6946),
    (16, '8430.69.1', 0.2758, 400),
    (16, '3004.90.94', 2.4478, 400);

INSERT INTO relatorio_serv VALUES
    (16, '1.1409.22.00', '2025-02-17T00:44:33', 0.0966),
    (16, '1.1409', '2025-02-07T09:20:45', 0.0972),
    (16, '1.0506.00.00', '2025-02-07T23:17:59', 0.3544),
    (16, '1.0401.17.90', '2025-02-24T07:24:54', 0.3581);

INSERT INTO relatorio VALUES
    (17, '2026-01-04', NULL, '79.821.563', '0001-65', '58.826.745/0001-34', 'Emissões a alto nível', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (17, '8445.19.23', 0.2667, 10521),
    (17, '9024.80.29', 0.1542, 400),
    (17, '5309.21.00', 0.1022, 2740),
    (17, '2921.51.3', 0.0546, 400),
    (17, '0703.10.2', 0.2591, 5317),
    (17, '4418.30.00', 0.0195, 9076),
    (17, '8433.20.10', 0.0618, 3699),
    (17, '6909.12.20', 0.1197, 8581),
    (17, '0812.90.00', 0.3652, 10863),
    (17, '8539.90.20', 0.1811, 11886),
    (17, '8474.90.00', 0.0708, 3666),
    (17, '8545.90.20', 0.0119, 9820),
    (17, '3004.39.82', 0.0355, 14464),
    (17, '8521.10.8', 0.1703, 7614),
    (17, '8207.19.90', 0.15, 4753),
    (17, '8431.49.21', 0.0326, 1720);

INSERT INTO relatorio_serv VALUES
    (17, '1.1402.11.00', '2026-02-20T09:12:15', 0.0332),
    (17, '1.0504.11.00', '2026-02-08T07:43:23', 0.077),
    (17, '1.1703.2', '2026-02-15T08:31:50', 0.0339),
    (17, '1.2101.10.00', '2026-02-06T02:19:42', 0.0074);

INSERT INTO relatorio VALUES
    (18, '2025-10-23', NULL, '09.723.145', '0001-56', '54.777.163/0001-46', 'O capitalismo como motor da exploração dos recursos naturais', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (18, '0802.11.00', 5.7474, 2567),
    (18, '9018.31.19', 0.0067, 5515),
    (18, '7804.20.00', 0.0425, 400),
    (18, '4817.10.00', 0.0015, 1416),
    (18, '2841.69.30', 0.2086, 7276),
    (18, '2924.29.64', 0.2118, 6949),
    (18, '8502.39.00', 0.0019, 4269),
    (18, '8430.41.20', 0.1722, 400),
    (18, '5603.11.40', 0.0179, 6929),
    (18, '2909.19.90', 0.5482, 400),
    (18, '8412.10.00', 0.0839, 400);

INSERT INTO relatorio VALUES
    (19, '2026-01-09', '2026-04-04', '01.274.895', '0001-40', '37.669.280/0001-29', 'Emissões em microempresas', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (19, '2926.90.24', 0.2713, 7761),
    (19, '6902.10.19', 0.6846, 400);

INSERT INTO relatorio_serv VALUES
    (19, '1.1109.30.00', '2026-02-04T23:13:33', 0.0869),
    (19, '1.0403.39.00', '2026-02-14T06:05:56', 0.1731),
    (19, '1.1706.22.00', '2026-02-15T09:07:25', 0.2148),
    (19, '1.0107.20.00', '2026-02-02T15:05:11', 0.0285),
    (19, '1.1803.29.00', '2026-02-27T20:24:18', 0.1296),
    (19, '1.2406', '2026-02-13T16:14:44', 0.1565),
    (19, '1.1404.4', '2026-02-19T00:54:20', 0.1171),
    (19, '1.2205.13.00', '2026-02-19T05:21:32', 0.2997),
    (19, '1.2502.30.00', '2026-02-10T04:08:12', 0.2151),
    (19, '1.1704.10.00', '2026-02-26T17:11:56', 0.1676),
    (19, '1.1409.90.00', '2026-02-27T17:54:19', 0.4542),
    (19, '1.0402.13.20', '2026-02-14T19:40:26', 0.7678),
    (19, '1.0502.32.10', '2026-02-10T04:57:37', 0.4849),
    (19, '1.1105.59.00', '2026-02-04T14:43:45', 0.1728),
    (19, '1.0905.70.00', '2026-02-11T05:31:58', 0.2774),
    (19, '1.1805.3', '2026-02-21T07:44:29', 0.0666),
    (19, '1.0502.14.90', '2026-02-15T17:28:11', 0.136),
    (19, '1.0502.3', '2026-02-05T03:11:08', 0.447),
    (19, '1.0803.00.00', '2026-02-23T15:31:16', 0.1386),
    (19, '1.1302.23.00', '2026-02-06T01:15:45', 0.1537),
    (19, '1.0403.29.00', '2026-02-18T00:16:05', 0.0581),
    (19, '1.2003.23.00', '2026-02-07T19:08:35', 0.0894),
    (19, '1.1201.34.00', '2026-02-13T09:38:54', 0.1089),
    (19, '1.1002.20.00', '2026-02-15T03:38:27', 0.222),
    (19, '1.2405.12.00', '2026-02-26T00:32:24', 0.0667),
    (19, '1.2001.50.00', '2026-02-02T14:04:20', 0.1494),
    (19, '1.0501.24.21', '2026-02-14T07:56:52', 0.1208);

INSERT INTO relatorio VALUES
    (20, '2024-07-25', '2026-04-30', '09.723.145', '0001-93', '11.679.309/0001-01', 'Impacto de programas de incentivo fiscal na redução de emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (20, '3006.92.00', 0.5412, 3848),
    (20, '4011.20.90', 1.0091, 7721),
    (20, '2937.29.3', 2.6231, 7039),
    (20, '8703.60.00', 0.4725, 8026),
    (20, '0302.82.00', 1.1483, 2617),
    (20, '2933.91.4', 1.0171, 9683),
    (20, '2602.00.90', 1.9085, 13181),
    (20, '2905.19.21', 0.3755, 4395),
    (20, '2904.10.19', 0.0163, 400),
    (20, '0511.99.99', 1.4158, 400);

INSERT INTO relatorio_serv VALUES
    (20, '1.2003.29.00', '2024-08-06T16:18:41', 5.8093),
    (20, '1.2001.34.20', '2024-08-26T12:06:30', 1.0563),
    (20, '1.1401.3', '2024-08-05T20:45:10', 0.1779),
    (20, '1.0402.19.00', '2024-08-07T16:42:10', 0.7728),
    (20, '1.2201.20.00', '2024-08-21T04:37:03', 0.1123),
    (20, '1.1701.90.00', '2024-08-19T03:36:23', 1.7873),
    (20, '1.1903.1', '2024-08-24T04:15:02', 0.7485),
    (20, '1.1201', '2024-08-10T05:13:23', 2.1987),
    (20, '1.1502.20.00', '2024-08-02T12:41:58', 0.2556),
    (20, '1.0501.21.20', '2024-08-16T22:59:11', 0.1308),
    (20, '1.0901.31.00', '2024-08-16T22:14:52', 1.7542),
    (20, '1.0504.44.00', '2024-08-24T09:44:34', 1.9279);

INSERT INTO relatorio VALUES
    (21, '2024-06-11', NULL, '33.738.001', '0001-77', '00.001.333/0001-99', 'Tipos de emissão em empresas de refinaria', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (21, '3824.84.00', 2.0128, 4774),
    (21, '7320.20.90', 0.6934, 10999),
    (21, '9021.39.40', 1.9736, 400),
    (21, '8523.49.20', 1.4465, 11363),
    (21, '8457.20.90', 0.3181, 1107),
    (21, '2915.90.41', 2.8877, 400),
    (21, '9307.00.00', 2.2748, 400),
    (21, '1008.40.10', 0.7291, 3244),
    (21, '2930.40.90', 0.2217, 2981),
    (21, '8542.39.31', 0.4343, 1296),
    (21, '3004.39.15', 1.7934, 7400),
    (21, '2930.90.11', 0.9108, 1026);

INSERT INTO relatorio_serv VALUES
    (21, '1.1805.31.00', '2024-07-07T07:32:03', 1.6674),
    (21, '1.0601.90.00', '2024-07-27T19:04:58', 3.5927),
    (21, '1.1106.4', '2024-07-17T09:53:02', 0.9323);

INSERT INTO relatorio VALUES
    (22, '2021-11-30', NULL, '75.893.062', '0001-33', '53.396.825/0001-34', 'Formas de reduzir o impacto de emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (22, '2915.39.51', 0.1497, 400),
    (22, '9012.90.10', 0.0754, 3238),
    (22, '8425.31.10', 0.1489, 7292);

INSERT INTO relatorio_serv VALUES
    (22, '1.2001.3', '2021-12-08T02:18:07', 0.1601),
    (22, '1.2404.31.00', '2021-12-26T21:15:05', 0.0273),
    (22, '1.0901.52.40', '2021-12-25T02:05:51', 0.1393),
    (22, '1.2601.40.00', '2021-12-04T07:31:52', 0.1442),
    (22, '1.0906.12.00', '2021-12-06T08:53:06', 0.0392),
    (22, '1.1409.90.00', '2021-12-04T08:11:23', 0.1003),
    (22, '1.1107.32.00', '2021-12-26T14:22:47', 0.3357),
    (22, '1.0101', '2021-12-03T07:35:47', 0.0998),
    (22, '1.1801.21.00', '2021-12-25T23:50:12', 0.0327),
    (22, '1.2507', '2021-12-09T11:05:45', 0.1873),
    (22, '1.2402.20.00', '2021-12-14T09:28:11', 0.2055),
    (22, '1.1101.20.00', '2021-12-02T20:14:31', 0.1723),
    (22, '1.0105.22.00', '2021-12-28T01:28:57', 0.118),
    (22, '1.0608.20.00', '2021-12-12T15:05:04', 0.2261);

INSERT INTO relatorio VALUES
    (23, '2026-01-09', '2026-03-03', '01.274.895', '0001-40', '11.679.309/0001-01', 'Análise de emissões em São Paulo na última década', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (23, '8806.29.00', 0.5219, 1420),
    (23, '9025.19.10', 0.2209, 6529),
    (23, '2907.19.90', 0.3571, 2348);

INSERT INTO relatorio_serv VALUES
    (23, '1.1805.2', '2026-02-11T12:47:28', 0.5295),
    (23, '1.0904.34.00', '2026-02-15T07:58:47', 0.2922),
    (23, '1.1806.6', '2026-02-01T02:19:24', 1.2219),
    (23, '1.0106.3', '2026-02-14T17:00:40', 0.7606),
    (23, '1.0501.14.20', '2026-02-09T18:12:24', 0.0253),
    (23, '1.0502.3', '2026-02-17T08:38:44', 0.1234),
    (23, '1.2304.19.00', '2026-02-11T10:46:10', 0.7673),
    (23, '1.0502.32.20', '2026-02-20T11:30:50', 0.0429),
    (23, '1.0102.53.10', '2026-02-08T19:12:50', 0.4419),
    (23, '1.1405.60.00', '2026-02-22T18:03:34', 0.7711),
    (23, '1.0504.32.00', '2026-02-27T15:12:21', 0.2644),
    (23, '1.1103.36.20', '2026-02-17T21:16:29', 0.0156),
    (23, '1.0102.20.00', '2026-02-06T22:13:41', 0.3618);

INSERT INTO relatorio VALUES
    (24, '2025-12-23', '2026-04-16', '33.738.001', '0001-77', '00.001.333/0001-99', 'Tipos de emissão em empresas de refinaria', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (24, '2931.41.00', 0.3165, 560),
    (24, '1211.50.00', 0.3017, 1256),
    (24, '2924.29.43', 0.2422, 12433),
    (24, '8443.19.90', 0.0383, 3360),
    (24, '4407.99.90', 0.1008, 715),
    (24, '2710.12.30', 0.0684, 2899),
    (24, '7215.90.10', 0.2488, 3705),
    (24, '2909.49.29', 0.0162, 14984),
    (24, '8716.40.00', 0.8641, 4909),
    (24, '3808.93.33', 0.0654, 400),
    (24, '8511.50.10', 0.1125, 400);

INSERT INTO relatorio VALUES
    (25, '2024-12-08', NULL, '48.912.037', '0001-38', '37.669.280/0001-29', 'Pesquisa de campo em emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (25, '2937.29.39', 0.689, 5817),
    (25, '4707.90.00', 0.0034, 7965),
    (25, '2925.29.23', 0.0059, 1965),
    (25, '1701.12.00', 0.0027, 6304),
    (25, '8433.40.00', 0.009, 5029),
    (25, '2808.00.20', 0.0012, 400),
    (25, '2301.20.10', 0.0505, 400),
    (25, '2843.90.11', 0.0142, 3946),
    (25, '3303.00.10', 0.0052, 3212),
    (25, '8901.20.00', 0.099, 3357),
    (25, '8527.12.00', 0.0019, 400),
    (25, '8517.62.29', 0.0001, 5158),
    (25, '2931.49.16', 0.045, 9459),
    (25, '7004.20.00', 0.0522, 11227);

INSERT INTO relatorio_serv VALUES
    (25, '1.1805.39.00', '2025-01-23T02:56:05', 0.0629),
    (25, '1.0901.51.29', '2025-01-05T13:54:48', 0.0),
    (25, '1.1103.39.00', '2025-01-18T08:42:30', 0.0021),
    (25, '1.1107.39.00', '2025-01-14T19:44:32', 0.0139);

INSERT INTO relatorio VALUES
    (26, '2024-08-05', '2026-02-22', '79.821.563', '0001-00', '58.826.745/0001-34', 'Emissões e as metas da ONU', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (26, '5205.43.00', 1.2962, 2365),
    (26, '3808.93.27', 0.0458, 400),
    (26, '9021.31.90', 0.0147, 400),
    (26, '3906.90.12', 0.0049, 8256),
    (26, '2903.41.00', 0.0072, 3116),
    (26, '8422.30.21', 0.1011, 400),
    (26, '4802.20.90', 0.1443, 400),
    (26, '1513.19.00', 0.0122, 4942),
    (26, '8448.32.19', 0.0184, 3573),
    (26, '2918.99.94', 0.0116, 5173),
    (26, '9018.39.21', 0.0067, 1214),
    (26, '4820.30.00', 0.084, 4044),
    (26, '8445.19.23', 0.0278, 400);

INSERT INTO relatorio_serv VALUES
    (26, '1.1802.40.00', '2024-09-29T04:36:28', 2.3909),
    (26, '1.1701.90.00', '2024-09-02T18:42:31', 0.1485),
    (26, '1.0403.19.00', '2024-09-27T05:43:50', 0.3343),
    (26, '1.0602.2', '2024-09-18T00:42:57', 0.0929),
    (26, '1.1405.2', '2024-09-14T23:51:12', 0.0066),
    (26, '1.1107.3', '2024-09-07T09:27:27', 0.018),
    (26, '1.1107.20.00', '2024-09-25T20:16:45', 0.1441),
    (26, '1.0501.24.2', '2024-09-04T06:47:15', 0.0013),
    (26, '1.0502.24.10', '2024-09-03T23:12:40', 0.0678),
    (26, '1.1901.50.00', '2024-09-25T15:01:52', 0.0072),
    (26, '1.2205.1', '2024-09-18T14:53:12', 0.0202),
    (26, '1.0801', '2024-09-02T11:26:59', 0.051),
    (26, '1.1403.23.00', '2024-09-21T07:01:52', 0.0951),
    (26, '1.0502.34.59', '2024-09-27T10:32:17', 0.1418);

INSERT INTO relatorio VALUES
    (27, '2024-04-08', '2026-02-12', '01.274.895', '0001-23', '58.826.745/0001-34', 'Impacto das técnicas de produção em emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (27, '7403.11.00', 0.2208, 5380),
    (27, '2915.39.6', 0.341, 6327),
    (27, '8205.90.00', 0.1039, 400),
    (27, '6301.20.00', 0.2016, 9458),
    (27, '3808.92.91', 0.0333, 4275),
    (27, '5210.11.00', 0.5149, 931),
    (27, '1504.10.11', 0.1888, 400),
    (27, '2921.49.90', 0.0783, 3400),
    (27, '8479.89.22', 0.2224, 16365),
    (27, '8906.10.00', 0.1096, 8618),
    (27, '7209.16.00', 0.1805, 400),
    (27, '9403.91.00', 0.1413, 5421),
    (27, '8409.99.51', 0.6086, 400),
    (27, '7213.10.00', 0.9184, 3467),
    (27, '7601.20.00', 0.2075, 4077),
    (27, '6208.19.00', 0.308, 9244),
    (27, '6802.93.10', 0.2883, 9264);

INSERT INTO relatorio_serv VALUES
    (27, '1.2501.2', '2024-05-07T20:12:41', 0.2123),
    (27, '1.1001.1', '2024-05-26T13:38:30', 0.7033),
    (27, '1.0502.34.5', '2024-05-27T01:14:50', 0.7852);

INSERT INTO relatorio VALUES
    (28, '2023-11-06', NULL, '51.360.297', '0001-43', '58.826.745/0001-34', 'Emissões e as metas da ONU', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (28, '3701.30.29', 1.6157, 10292),
    (28, '8443.39.30', 4.4266, 464),
    (28, '1517.10.00', 4.1105, 11071),
    (28, '6901.00.00', 2.7688, 400),
    (28, '8308.10.00', 2.0092, 8740),
    (28, '2940.00.29', 3.7825, 1560);

INSERT INTO relatorio_serv VALUES
    (28, '1.1703.3', '2023-12-03T06:22:28', 2.0936),
    (28, '1.0101.22.00', '2023-12-26T22:39:58', 2.2823),
    (28, '1.0102.52', '2023-12-18T12:03:56', 2.0127),
    (28, '1.0401.21', '2023-12-28T06:21:23', 0.324),
    (28, '1.2501.39.00', '2023-12-14T13:13:36', 0.3402),
    (28, '1.0905.22.00', '2023-12-08T17:12:26', 0.7401),
    (28, '1.0502.24.40', '2023-12-29T17:47:11', 0.3098),
    (28, '1.0501.21.30', '2023-12-06T06:32:07', 6.2431),
    (28, '1.0801.20.00', '2023-12-14T08:02:14', 0.3961),
    (28, '1.0106.31.00', '2023-12-30T03:10:58', 3.2704),
    (28, '1.1401.31.00', '2023-12-02T20:20:18', 3.5316),
    (28, '1.1501.20.00', '2023-12-05T05:37:03', 1.4297),
    (28, '1.0102.51.00', '2023-12-07T09:11:16', 1.2852);

INSERT INTO relatorio VALUES
    (29, '2024-11-01', '2026-04-12', '39.605.871', '0001-83', '11.679.309/0001-01', 'Impacto de programas de incentivo fiscal na redução de emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (29, '2930.90.72', 0.0352, 400),
    (29, '6108.91.00', 0.0878, 13097),
    (29, '4802.40.90', 0.0491, 2475),
    (29, '0810.90.1', 0.0484, 3039),
    (29, '6804.10.00', 0.0171, 2488),
    (29, '0804.30.00', 0.0133, 400),
    (29, '2843.29.90', 0.1027, 400),
    (29, '0306.12.00', 0.0578, 3128),
    (29, '9027.90.99', 0.0928, 3469),
    (29, '8418.69.31', 0.0447, 402),
    (29, '3004.90.39', 0.1255, 4176),
    (29, '9021.29.00', 0.0563, 5219),
    (29, '7217.30.90', 0.1193, 5749),
    (29, '3920.61.00', 0.0352, 2657),
    (29, '6115.99.00', 0.142, 6002),
    (29, '2931.46.00', 0.2786, 4404),
    (29, '2932.19.20', 0.1542, 425);

INSERT INTO relatorio_serv VALUES
    (29, '1.1806.8', '2024-12-07T18:35:08', 0.0045),
    (29, '1.2301.12.00', '2024-12-05T22:09:08', 0.0285);

INSERT INTO relatorio VALUES
    (30, '2023-09-20', NULL, '64.087.915', '0001-27', '37.669.280/0001-29', 'Pesquisa de campo em emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (30, '2934.99.29', 0.0697, 400),
    (30, '2822.00.90', 0.0014, 400),
    (30, '7210.69.1', 0.002, 6798);

INSERT INTO relatorio_serv VALUES
    (30, '1.1401.12.00', '2023-10-22T18:18:24', 4.4372),
    (30, '1.1406', '2023-10-05T12:02:25', 0.0621),
    (30, '1.2404.33.00', '2023-10-07T04:14:28', 0.8429),
    (30, '1.1702.90.00', '2023-10-19T11:17:55', 0.0299),
    (30, '1.0901.3', '2023-10-03T17:08:44', 0.0188),
    (30, '1.0501.24.21', '2023-10-30T00:16:59', 0.0005),
    (30, '1.0401.1', '2023-10-06T08:49:40', 0.3226),
    (30, '1.0402.11', '2023-10-14T00:45:21', 0.0896),
    (30, '1.0602.2', '2023-10-23T19:33:07', 0.1998),
    (30, '1.08', '2023-10-24T13:04:58', 0.003);

INSERT INTO relatorio VALUES
    (31, '2023-11-18', NULL, '48.912.037', '0001-48', '11.679.309/0001-01', 'Impacto de programas de incentivo fiscal na redução de emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (31, '2917.39.1', 1.7077, 5422),
    (31, '8481.80.21', 0.0328, 6607),
    (31, '1207.29.00', 0.022, 8802),
    (31, '9307.00.00', 0.005, 400),
    (31, '2930.90.84', 0.0307, 400),
    (31, '2925.19.10', 0.2694, 400),
    (31, '3701.10.21', 0.0562, 2249),
    (31, '8511.10.00', 0.0659, 2146),
    (31, '3301.29.11', 0.0739, 400),
    (31, '7409.19.00', 0.0013, 2526),
    (31, '9111.20.90', 0.1709, 400),
    (31, '5509.52.00', 0.0307, 12515),
    (31, '9403.20.90', 0.1085, 8041),
    (31, '2922.50.32', 0.0102, 4317),
    (31, '1213.00.00', 0.0056, 400);

INSERT INTO relatorio_serv VALUES
    (31, '1.1701.21.00', '2023-12-02T00:20:45', 0.7933),
    (31, '1.0906.30.00', '2023-12-30T18:25:29', 0.0017),
    (31, '1.0904.35.00', '2023-12-16T18:30:56', 0.0242);

INSERT INTO relatorio VALUES
    (32, '2022-06-18', '2024-09-27', '28.659.130', '0001-07', '58.826.745/0001-34', 'Emissões a alto nível', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (32, '8443.99.21', 0.1798, 400),
    (32, '8409.91.11', 0.3407, 400);

INSERT INTO relatorio_serv VALUES
    (32, '1.1405.50.00', '2022-07-12T05:40:55', 0.1071),
    (32, '1.0503.25.00', '2022-07-15T03:11:30', 0.0467),
    (32, '1.0402.19.00', '2022-07-12T23:59:17', 0.0329),
    (32, '1.0901.51.23', '2022-07-12T16:42:19', 0.1145),
    (32, '1.1105.41.00', '2022-07-01T15:19:05', 0.1192),
    (32, '1.0102.42.20', '2022-07-11T18:20:47', 0.0062),
    (32, '1.1502.20.00', '2022-07-28T21:14:49', 0.3498),
    (32, '1.0506.00.00', '2022-07-09T04:12:13', 0.1719),
    (32, '1.1702.90.00', '2022-07-02T16:04:11', 0.0614),
    (32, '1.0502.14.59', '2022-07-18T01:08:28', 0.0583),
    (32, '1.2504.11.00', '2022-07-02T00:32:35', 0.2836),
    (32, '1.1402.13.00', '2022-07-01T13:12:13', 0.0354),
    (32, '1.0905.40.00', '2022-07-30T14:08:56', 0.0701),
    (32, '1.0107.40.00', '2022-07-28T04:52:50', 0.2491),
    (32, '1.1404.13.00', '2022-07-13T00:24:16', 0.0793),
    (32, '1.0107', '2022-07-24T09:37:56', 0.1563),
    (32, '1.0401.21', '2022-07-05T08:03:52', 0.0148),
    (32, '1.2204.10.00', '2022-07-03T13:06:11', 0.2688),
    (32, '1.0502.12.30', '2022-07-25T05:54:47', 0.5304),
    (32, '1.1103.33.00', '2022-07-15T03:46:12', 0.1023),
    (32, '1.2003.2', '2022-07-26T08:18:24', 0.1387),
    (32, '1.1403.22', '2022-07-18T06:49:46', 0.0036),
    (32, '1.0904.21.00', '2022-07-29T04:38:09', 0.137),
    (32, '1.1802.40.00', '2022-07-16T10:22:20', 0.1437),
    (32, '1.0501.12', '2022-07-07T01:33:30', 0.3882),
    (32, '1.0901.35.00', '2022-07-18T18:57:39', 0.6659),
    (32, '1.2407.00.00', '2022-07-20T13:16:06', 0.3634),
    (32, '1.0403.32.00', '2022-07-23T12:52:39', 0.2925),
    (32, '1.0304.90.00', '2022-07-06T23:48:04', 0.0766),
    (32, '1.0501.29.00', '2022-07-21T04:16:52', 0.1559),
    (32, '1.0403.39.00', '2022-07-15T04:18:47', 0.3907),
    (32, '1.0106.22.00', '2022-07-15T07:08:34', 0.1176),
    (32, '1.0106.13.00', '2022-07-14T02:19:18', 0.3496),
    (32, '1.0502.23.20', '2022-07-25T23:16:28', 0.0694);

INSERT INTO relatorio VALUES
    (33, '2023-05-14', '2026-04-15', '64.087.915', '0001-27', '58.826.745/0001-34', 'Emissões e as metas da ONU', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (33, '2933.79.10', 0.5215, 400);

INSERT INTO relatorio_serv VALUES
    (33, '1.1405.11.00', '2023-06-11T23:13:50', 3.4327),
    (33, '1.1106.36.90', '2023-06-06T02:02:04', 0.0652),
    (33, '1.03', '2023-06-04T00:31:14', 0.0752),
    (33, '1.1402.31.00', '2023-06-10T18:43:36', 0.0738),
    (33, '1.2406.90.00', '2023-06-14T13:58:54', 0.04),
    (33, '1.2301.15.00', '2023-06-04T12:14:52', 0.1014),
    (33, '1.1801.2', '2023-06-23T14:41:38', 0.1061),
    (33, '1.08', '2023-06-13T17:07:46', 0.0678),
    (33, '1.2501.37.00', '2023-06-05T19:56:24', 0.0018),
    (33, '1.0906.20.00', '2023-06-22T04:16:39', 0.0671),
    (33, '1.1406.33.00', '2023-06-26T14:19:17', 0.1447),
    (33, '1.1405.22.00', '2023-06-18T21:17:41', 0.1896),
    (33, '1.0903.37.00', '2023-06-09T09:02:14', 0.0756),
    (33, '1.2403.19.00', '2023-06-11T12:06:06', 0.2106),
    (33, '1.0103', '2023-06-12T02:17:10', 0.0058),
    (33, '1.1705', '2023-06-20T17:22:41', 0.1842),
    (33, '1.1705.20.00', '2023-06-01T07:35:08', 0.0367),
    (33, '1.0903.22.00', '2023-06-04T01:59:03', 0.0143),
    (33, '1.2101.21.00', '2023-06-29T16:19:06', 0.3212),
    (33, '1.0502.32', '2023-06-08T15:31:14', 0.0054),
    (33, '1.0501.23.20', '2023-06-02T15:30:22', 0.1443);

INSERT INTO relatorio VALUES
    (34, '2021-10-06', NULL, '71.498.635', '0001-06', '58.826.745/0001-34', 'Emissões e as metas da ONU', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (34, '8413.60.19', 0.5472, 9612),
    (34, '6804.22.11', 0.2852, 3458),
    (34, '9030.20.29', 0.1132, 7315),
    (34, '9006.59.40', 0.2814, 1782),
    (34, '8704.23.40', 0.1756, 6020),
    (34, '3001.90.3', 0.051, 4783),
    (34, '8422.30.23', 0.5519, 693),
    (34, '0406.90.90', 0.1913, 8620),
    (34, '5007.10.90', 0.1203, 10472),
    (34, '2941.90.9', 0.6744, 2717),
    (34, '9101.99.00', 0.0009, 7933),
    (34, '3201.90.11', 1.3378, 11487);

INSERT INTO relatorio_serv VALUES
    (34, '1.0903.34.00', '2021-11-10T23:19:57', 0.2621),
    (34, '1.0402.3', '2021-11-04T23:53:42', 1.558);

INSERT INTO relatorio VALUES
    (35, '2025-11-01', '2026-02-27', '79.821.563', '0001-65', '58.826.745/0001-34', 'Impacto das técnicas de produção em emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (35, '3209.90.1', 0.0561, 5597),
    (35, '2710.19.92', 0.0129, 1300),
    (35, '4811.90.19', 4.409, 400),
    (35, '2824.90.10', 1.1292, 400),
    (35, '3102.60.00', 0.9118, 5664),
    (35, '5904.90.00', 0.9448, 4327),
    (35, '1515.90.2', 1.8114, 10378),
    (35, '6206.20.00', 0.9083, 6371),
    (35, '3401.20.90', 0.9462, 6196),
    (35, '7612.90.90', 0.5954, 7621),
    (35, '0813.20.20', 2.3913, 5380),
    (35, '0502.90.10', 0.8433, 400),
    (35, '8525.89.22', 1.8651, 575),
    (35, '7318.15.00', 0.2791, 400),
    (35, '3907.10.9', 0.8528, 20419),
    (35, '7208.27.90', 1.5113, 5986),
    (35, '6403.20.00', 0.4735, 7370);

INSERT INTO relatorio VALUES
    (36, '2023-06-09', '2025-01-21', '01.274.895', '0001-13', '54.777.163/0001-46', 'Andamento das metas da ONU', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (36, '9305.20.00', 0.5385, 3554),
    (36, '2710.19.94', 0.871, 7761),
    (36, '2840.30.00', 0.5153, 9197),
    (36, '8421.99.10', 1.8547, 9412),
    (36, '0507.90.00', 1.9408, 6054),
    (36, '8443.91.10', 0.1396, 6980),
    (36, '1102.20.00', 0.7326, 400),
    (36, '3824.99.21', 1.0226, 400),
    (36, '2712.20.00', 0.995, 400),
    (36, '2921.51.3', 2.5285, 3688),
    (36, '8407.29.10', 0.5502, 12458),
    (36, '8548.00.10', 1.1255, 400),
    (36, '7020.00.90', 0.1298, 4537),
    (36, '9018.31.90', 0.8917, 9791),
    (36, '2914.29.90', 1.379, 400),
    (36, '2833.29.60', 0.7336, 8651),
    (36, '2921.43.1', 0.6802, 9981),
    (36, '4003.00.00', 2.1534, 9980),
    (36, '5208.21.00', 0.4433, 400),
    (36, '2933.72.20', 0.5329, 6921),
    (36, '4822.10.00', 1.3591, 400);

INSERT INTO relatorio_serv VALUES
    (36, '1.2403.2', '2023-07-14T18:30:34', 0.8277),
    (36, '1.0501.22.20', '2023-07-03T14:08:02', 0.5483),
    (36, '1.0401.15.20', '2023-07-14T22:09:28', 0.5795);

INSERT INTO relatorio VALUES
    (37, '2021-06-26', NULL, '45.690.123', '0001-36', '87.888.161/0001-65', 'Impacto de atividades agropecuárias na Amazônia', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (37, '2916.32.10', 1.5255, 5724),
    (37, '2005.59.00', 0.1592, 2639),
    (37, '2924.19.19', 0.028, 2054),
    (37, '6903.20.10', 0.0005, 6824),
    (37, '8428.90.30', 0.0681, 400),
    (37, '3701.10.29', 0.0649, 11477),
    (37, '8535.30.23', 0.0023, 9300);

INSERT INTO relatorio_serv VALUES
    (37, '1.2505.20.00', '2021-07-04T15:23:42', 2.5),
    (37, '1.1703.22.00', '2021-07-08T14:40:17', 0.5925),
    (37, '1.0503.2', '2021-07-05T02:52:52', 0.0667),
    (37, '1.0401.4', '2021-07-14T04:20:39', 0.036),
    (37, '1.0903.34.00', '2021-07-12T18:06:56', 0.0403);

INSERT INTO relatorio VALUES
    (38, '2022-10-07', '2024-05-13', '79.821.563', '0001-00', '87.888.161/0001-65', 'Impacto de atividades agropecuárias na Amazônia', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (38, '0511.99.9', 1.0384, 8630),
    (38, '8409.99.30', 0.0014, 400),
    (38, '2916.19.23', 0.2039, 400),
    (38, '9025.19.10', 0.0566, 7407),
    (38, '8541.10.11', 0.0107, 10755);

INSERT INTO relatorio_serv VALUES
    (38, '1.1404.1', '2022-11-29T14:09:22', 1.145),
    (38, '1.2504', '2022-11-27T02:13:35', 0.0423),
    (38, '1.1103.36', '2022-11-28T07:18:36', 0.0147),
    (38, '1.0402.29.00', '2022-11-04T16:23:49', 0.0024),
    (38, '1.1901.40.00', '2022-11-14T14:34:52', 0.0092),
    (38, '1.0502.11', '2022-11-06T03:25:36', 0.0097),
    (38, '1.1402.32.00', '2022-11-02T09:35:23', 0.0082),
    (38, '1.1405.12.00', '2022-11-23T23:54:38', 0.0114),
    (38, '1.0503.90.00', '2022-11-25T01:44:35', 0.0219),
    (38, '1.1106.39.00', '2022-11-20T03:57:53', 0.0123),
    (38, '1.1806.61.00', '2022-11-16T10:29:51', 0.0002),
    (38, '1.0401.19.00', '2022-11-15T12:02:04', 0.0039),
    (38, '1.0901.21.00', '2022-11-20T21:33:35', 0.0001),
    (38, '1.1806.31.00', '2022-11-29T11:41:43', 0.0176),
    (38, '1.0801.10.00', '2022-11-21T08:04:10', 0.0516);

INSERT INTO relatorio VALUES
    (39, '2024-09-09', NULL, '13.690.872', '0001-54', '54.777.163/0001-46', 'Andamento das metas da ONU', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (39, '9018.49.19', 0.2762, 5973),
    (39, '7305.39.00', 0.3009, 10129),
    (39, '9010.60.00', 0.3322, 5591),
    (39, '2931.41.00', 0.7985, 897),
    (39, '3906.90.62', 0.0815, 400),
    (39, '3824.99.82', 0.3039, 400),
    (39, '6101.90.90', 0.7549, 400);

INSERT INTO relatorio_serv VALUES
    (39, '1.1403.22.22', '2024-10-07T05:35:09', 0.1074),
    (39, '1.0401.21.10', '2024-10-25T23:15:25', 0.2949),
    (39, '1.1704.20.00', '2024-10-22T04:38:42', 0.3693),
    (39, '1.1402.11.00', '2024-10-07T01:42:51', 0.1077),
    (39, '1.1502.10.00', '2024-10-06T06:50:48', 0.1256),
    (39, '1.0909', '2024-10-10T06:57:24', 0.048),
    (39, '1.0602.33.00', '2024-10-24T03:33:51', 0.1923),
    (39, '1.2205.13.00', '2024-10-03T18:28:07', 0.1773);

INSERT INTO relatorio VALUES
    (40, '2024-06-25', '2025-08-06', '09.723.145', '0001-93', '11.679.309/0001-01', 'Análise de emissões em São Paulo na última década', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (40, '9025.11.91', 0.4549, 1065),
    (40, '8418.29.00', 1.1889, 3922),
    (40, '3004.39.99', 2.5835, 5161),
    (40, '8467.21.00', 1.3575, 400),
    (40, '4810.31.10', 1.4665, 1308);

INSERT INTO relatorio_serv VALUES
    (40, '1.0101.2', '2024-07-24T09:58:34', 0.6601),
    (40, '1.1106.31.00', '2024-07-29T02:58:37', 0.1514),
    (40, '1.1804.00.00', '2024-07-26T07:42:28', 0.3496),
    (40, '1.0501.22.30', '2024-07-15T08:56:22', 0.084),
    (40, '1.1406.12.00', '2024-07-15T06:33:11', 0.4835),
    (40, '1.0502.21.30', '2024-07-13T04:44:22', 0.4447),
    (40, '1.06', '2024-07-21T21:20:01', 0.2601),
    (40, '1.1403.30.00', '2024-07-30T14:59:54', 0.4423),
    (40, '1.2205.12.00', '2024-07-05T04:44:24', 1.2003),
    (40, '1.0901.5', '2024-07-03T22:23:18', 0.447),
    (40, '1.0102.12.00', '2024-07-04T19:10:34', 0.5516);

INSERT INTO relatorio VALUES
    (41, '2022-09-27', NULL, '75.893.062', '0001-33', '54.777.163/0001-46', 'Andamento das metas da ONU', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (41, '0303.55.00', 0.5084, 8784),
    (41, '3003.90.79', 0.515, 10600);

INSERT INTO relatorio_serv VALUES
    (41, '1.2101.22.00', '2022-10-11T03:27:41', 0.3246),
    (41, '1.1401.11.00', '2022-10-27T18:48:20', 0.096),
    (41, '1.0501.22.10', '2022-10-14T01:29:20', 0.1296),
    (41, '1.0502.34.5', '2022-10-07T06:20:57', 0.0855),
    (41, '1.2205.20.00', '2022-10-09T15:32:57', 0.1639),
    (41, '1.1506.90.00', '2022-10-03T14:43:56', 0.037),
    (41, '1.1404.13.00', '2022-10-03T16:31:14', 0.4129),
    (41, '1.1103.36.10', '2022-10-25T10:21:53', 0.1041),
    (41, '1.1701.29.00', '2022-10-13T20:11:16', 0.4625),
    (41, '1.0609.00.00', '2022-10-12T06:18:34', 0.0452),
    (41, '1.1401', '2022-10-17T07:33:45', 0.0266),
    (41, '1.2003.23.00', '2022-10-29T15:29:07', 0.0975),
    (41, '1.0502.12.30', '2022-10-18T07:37:40', 0.0576),
    (41, '1.0502.21.30', '2022-10-14T17:45:31', 0.0627),
    (41, '1.1101.16.00', '2022-10-01T23:51:10', 0.1627),
    (41, '1.2303.00.00', '2022-10-14T06:03:27', 0.2591),
    (41, '1.1803', '2022-10-12T05:34:28', 0.7748),
    (41, '1.2301.94.00', '2022-10-05T23:03:14', 0.6091),
    (41, '1.1202.20.00', '2022-10-28T21:31:50', 0.1018),
    (41, '1.1705.10.00', '2022-10-26T18:16:23', 0.0171),
    (41, '1.0801', '2022-10-14T08:23:05', 0.2931),
    (41, '1.1903.12.00', '2022-10-23T23:32:21', 0.1041),
    (41, '1.1106.32.00', '2022-10-02T02:39:40', 0.2254),
    (41, '1.0501.21.20', '2022-10-10T04:06:34', 0.1209),
    (41, '1.1801.21.00', '2022-10-07T00:49:01', 0.5118),
    (41, '1.2503.10.00', '2022-10-09T00:35:36', 0.4608),
    (41, '1.1401.17.00', '2022-10-22T10:08:53', 0.0231),
    (41, '1.0106', '2022-10-30T13:04:42', 0.2826),
    (41, '1.2304.20.00', '2022-10-19T12:01:54', 0.0139),
    (41, '1.0602.10.00', '2022-10-05T19:47:01', 0.2512),
    (41, '1.2002.10.00', '2022-10-30T00:14:25', 0.3669),
    (41, '1.2404.11.00', '2022-10-10T15:22:42', 0.0364),
    (41, '1.2403', '2022-10-24T21:47:53', 0.3908),
    (41, '1.0905.22.00', '2022-10-05T04:37:44', 0.0816),
    (41, '1.0106.31.00', '2022-10-17T11:42:57', 0.1174),
    (41, '1.0504.43.00', '2022-10-03T17:19:27', 0.0185),
    (41, '1.2301.96.00', '2022-10-04T20:53:53', 0.0126),
    (41, '1.0904.39.00', '2022-10-16T19:44:12', 0.1297);

INSERT INTO relatorio VALUES
    (42, '2024-02-03', NULL, '18.024.935', '0001-76', '37.669.280/0001-29', 'Pesquisa de campo em emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (42, '8542.32.21', 0.7491, 5138),
    (42, '3806.90.11', 0.0111, 994),
    (42, '3901.90.90', 0.0227, 5449),
    (42, '3906.90.21', 0.0241, 3095),
    (42, '2918.22.20', 0.0252, 400),
    (42, '4810.19.10', 0.0164, 8135),
    (42, '8517.62.94', 0.0471, 1734),
    (42, '2932.99.99', 0.0127, 1217),
    (42, '3503.00.1', 0.0056, 1359);

INSERT INTO relatorio VALUES
    (43, '2026-02-01', NULL, '12.905.674', '0001-18', '54.777.163/0001-46', 'Andamento das metas da ONU', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (43, '3909.20.19', 3.9313, 9222),
    (43, '3304.10.00', 0.8718, 3744),
    (43, '3907.99.9', 1.2465, 9779),
    (43, '3822.90.00', 0.7436, 10470),
    (43, '5206.14.00', 2.6761, 512),
    (43, '8541.10.99', 1.2512, 6667),
    (43, '5308.20.00', 4.5696, 4238),
    (43, '7507.12.00', 0.9767, 3615),
    (43, '3206.11.30', 1.0633, 2970),
    (43, '0306.19.10', 0.2682, 2543),
    (43, '2306.41.00', 0.7681, 1213),
    (43, '0306.34.00', 0.2485, 400),
    (43, '1207.40.10', 2.1848, 400),
    (43, '3824.99.62', 1.0005, 400),
    (43, '8542.33.90', 0.6493, 7753),
    (43, '9303.10.00', 3.3495, 7371),
    (43, '3909.20.1', 0.8979, 11172),
    (43, '5502.10.00', 1.0981, 684),
    (43, '6805.30.10', 0.5169, 7041);

INSERT INTO relatorio_serv VALUES
    (43, '1.0901.51.21', '2026-03-30T16:47:58', 0.1711),
    (43, '1.1107.90.00', '2026-03-15T00:07:31', 1.0304),
    (43, '1.0502.24.5', '2026-03-28T05:48:43', 0.491);

INSERT INTO relatorio VALUES
    (44, '2024-12-18', NULL, '09.723.145', '0001-78', '09.850.333/0001-77', 'Emissões: e eu com isso?', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (44, '4010.12.00', 1.69, 7723),
    (44, '7409.40.19', 0.0353, 6963),
    (44, '2940.00.94', 0.0018, 4658),
    (44, '8479.81.90', 0.1518, 3545),
    (44, '6402.91.10', 0.0002, 7315),
    (44, '8460.19.00', 0.1193, 11456),
    (44, '0303.89.65', 0.0592, 400),
    (44, '5305.00.10', 0.0282, 2426),
    (44, '0709.70.00', 0.0259, 400),
    (44, '2931.49.40', 0.0007, 2280),
    (44, '5209.41.00', 0.0166, 12822),
    (44, '8215.99.90', 0.0173, 400),
    (44, '2937.22.2', 0.0112, 400),
    (44, '8479.50.00', 0.0015, 8534),
    (44, '5403.39.00', 0.0171, 7472),
    (44, '9209.92.00', 0.0671, 3200),
    (44, '6109.10.00', 0.0312, 7289),
    (44, '8533.40.91', 0.0628, 11780),
    (44, '3808.93.33', 0.0782, 5372),
    (44, '7015.10.91', 0.0009, 4283),
    (44, '5408.23.00', 0.0059, 2116),
    (44, '6004.10.12', 0.0673, 13101),
    (44, '0203.29.00', 0.0278, 400),
    (44, '2934.91.11', 0.1256, 564),
    (44, '5301.10.00', 0.0916, 2898),
    (44, '6815.99.1', 0.0711, 6081),
    (44, '8701.30.00', 0.0713, 400);

INSERT INTO relatorio_serv VALUES
    (44, '1.2001.34.10', '2025-01-30T18:09:55', 0.8734),
    (44, '1.0901.52.10', '2025-01-17T00:41:42', 0.002),
    (44, '1.23', '2025-01-26T00:19:35', 0.0337),
    (44, '1.1301.10.00', '2025-01-21T15:01:47', 0.0463);

INSERT INTO relatorio VALUES
    (45, '2024-12-27', '2025-04-04', '88.635.333', '0001-98', '11.679.309/0001-01', 'Análise de emissões em São Paulo na última década', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (45, '8483.40.90', 0.0559, 2475),
    (45, '1207.99.90', 0.0901, 2752),
    (45, '4016.91.00', 0.04, 400),
    (45, '0406.90.20', 0.3265, 2830),
    (45, '8443.32.39', 0.5815, 1424),
    (45, '5501.19.00', 0.0418, 8821),
    (45, '3402.31.00', 0.0025, 400),
    (45, '9108.11.10', 0.3349, 2900),
    (45, '8439.30.20', 0.0622, 400),
    (45, '9303.90.90', 0.0492, 1271),
    (45, '2933.91.72', 0.2252, 400),
    (45, '3702.54.1', 0.1232, 2954),
    (45, '8101.97.00', 0.0896, 400),
    (45, '3923.30.90', 0.0113, 4942),
    (45, '2933.91.61', 0.0748, 8194),
    (45, '8413.70.10', 0.1371, 8363),
    (45, '0402.29.30', 0.5523, 10444),
    (45, '8525.81.00', 1.0648, 400),
    (45, '8471.50.10', 0.1596, 5715);

INSERT INTO relatorio VALUES
    (46, '2024-10-15', '2026-02-07', '39.605.871', '0001-83', '87.888.161/0001-65', 'Impacto de atividades agropecuárias na Amazônia', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (46, '9018.19.80', 0.1662, 5143),
    (46, '9019.20.40', 0.0771, 1696),
    (46, '7901.11.11', 0.4059, 4951),
    (46, '7011.90.00', 0.0426, 400),
    (46, '2615.10.90', 0.1465, 3105),
    (46, '2937.29.60', 0.0572, 10081),
    (46, '9001.20.00', 0.0523, 9768),
    (46, '8607.21.00', 0.1909, 7158),
    (46, '2931.90.41', 0.2174, 400),
    (46, '3004.20.19', 0.0974, 3721),
    (46, '3923.21.90', 0.1383, 6800),
    (46, '4011.30.00', 0.0474, 1580),
    (46, '3004.90.25', 0.05, 11856),
    (46, '3908.10.11', 0.1866, 400),
    (46, '8423.90.21', 0.0707, 3251),
    (46, '2936.23.10', 0.4541, 400),
    (46, '8511.10.00', 0.0411, 9988),
    (46, '6804.22.11', 0.029, 1395),
    (46, '3920.10.9', 0.0213, 400),
    (46, '7406.10.10', 0.1557, 7507),
    (46, '2829.90.1', 0.0183, 5194);

INSERT INTO relatorio_serv VALUES
    (46, '1.1103.3', '2024-11-05T18:44:49', 0.1005),
    (46, '1.1103.32.00', '2024-11-11T11:02:07', 0.1794);

INSERT INTO relatorio VALUES
    (47, '2023-10-24', NULL, '64.087.915', '0001-27', '11.679.309/0001-01', 'Impacto de programas de incentivo fiscal na redução de emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (47, '6115.30.10', 0.0923, 4508),
    (47, '6805.30.20', 0.0005, 9635);

INSERT INTO relatorio_serv VALUES
    (47, '1.2403.32.00', '2023-11-28T05:12:02', 0.33),
    (47, '1.2301.96.00', '2023-11-06T15:57:35', 0.0003),
    (47, '1.1802', '2023-11-11T23:01:08', 0.0598),
    (47, '1.2605.00.00', '2023-11-19T19:48:54', 0.0031),
    (47, '1.0106.90.00', '2023-11-12T20:42:57', 0.0062),
    (47, '1.2602.90.00', '2023-11-22T14:17:08', 0.0003),
    (47, '1.0401.17.20', '2023-11-18T04:13:20', 0.0058),
    (47, '1.2503', '2023-11-15T15:15:19', 0.0024),
    (47, '1.1401.2', '2023-11-19T17:14:01', 0.0176),
    (47, '1.2302.23.00', '2023-11-11T11:28:41', 0.0001),
    (47, '1.0107.60.00', '2023-11-04T22:20:59', 0.0247),
    (47, '1.0501.39.00', '2023-11-07T12:58:33', 0.0008),
    (47, '1.0103.4', '2023-11-10T02:19:00', 0.0067),
    (47, '1.0901.51.22', '2023-11-16T01:46:25', 0.0064),
    (47, '1.0604.22.00', '2023-11-11T12:06:54', 0.0027),
    (47, '1.0502.34.51', '2023-11-05T18:23:31', 0.0055),
    (47, '1.0906.20.00', '2023-11-25T12:01:11', 0.0267),
    (47, '1.0502.12.30', '2023-11-27T20:47:34', 0.0),
    (47, '1.1805.39.00', '2023-11-03T01:09:34', 0.0218),
    (47, '1.2301.2', '2023-11-15T11:58:46', 0.0196),
    (47, '1.1403.21.20', '2023-11-07T00:28:38', 0.0089),
    (47, '1.2205.11.00', '2023-11-04T20:37:14', 0.004),
    (47, '1.0901.51.12', '2023-11-07T22:38:07', 0.0118);

INSERT INTO relatorio VALUES
    (48, '2023-10-13', '2025-01-01', '75.893.062', '0001-33', '37.669.280/0001-29', 'Emissões em microempresas', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (48, '2915.39.63', 0.2653, 400),
    (48, '4010.32.00', 0.1272, 2658),
    (48, '7901.12.90', 0.6671, 5736);

INSERT INTO relatorio_serv VALUES
    (48, '1.0504.13.00', '2023-11-25T14:24:36', 0.3583),
    (48, '1.1301.30.00', '2023-11-08T05:02:17', 0.0577),
    (48, '1.1107.50.00', '2023-11-05T00:49:10', 0.4122),
    (48, '1.2302.23.00', '2023-11-29T03:43:10', 0.4661),
    (48, '1.2601.20.00', '2023-11-07T08:11:36', 0.1643),
    (48, '1.0904.21.00', '2023-11-07T14:01:33', 1.232),
    (48, '1.0107.40.00', '2023-11-02T01:26:03', 0.218),
    (48, '1.0103.42.00', '2023-11-02T05:43:53', 0.7214),
    (48, '1.1105.30.00', '2023-11-15T16:03:17', 1.7163),
    (48, '1.0106.22.00', '2023-11-11T01:15:37', 0.1481),
    (48, '1.0503', '2023-11-28T23:06:42', 0.4714),
    (48, '1.0906.11.00', '2023-11-28T09:35:57', 0.6121),
    (48, '1.1404.41.00', '2023-11-29T15:32:25', 0.3733),
    (48, '1.2203.20.00', '2023-11-04T02:38:12', 0.1988);

INSERT INTO relatorio VALUES
    (49, '2024-03-01', '2025-12-27', '79.821.563', '0001-00', '11.679.309/0001-01', 'Análise de emissões em São Paulo na última década', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (49, '8531.10.10', 2.9489, 9688),
    (49, '2922.19.8', 0.0291, 3276),
    (49, '3917.22.90', 0.0085, 400),
    (49, '2849.90.90', 0.0082, 4149),
    (49, '2711.13.00', 0.1352, 400),
    (49, '3507.90.26', 0.0244, 4331),
    (49, '0908.21.00', 0.0152, 400),
    (49, '3002.12.33', 0.0049, 400),
    (49, '3501.10.00', 0.1172, 13990),
    (49, '8443.99.11', 0.2744, 6698),
    (49, '8516.33.00', 0.0088, 5764);

INSERT INTO relatorio_serv VALUES
    (49, '1.1105.59.00', '2024-04-13T11:29:54', 5.4953),
    (49, '1.0401.4', '2024-04-28T10:49:38', 0.0542),
    (49, '1.1405', '2024-04-18T07:36:57', 0.2476),
    (49, '1.1402.31.00', '2024-04-17T22:44:43', 0.043),
    (49, '1.1304.00.00', '2024-04-11T14:50:27', 0.2984),
    (49, '1.1107.40.00', '2024-04-08T14:07:12', 0.0512);

INSERT INTO relatorio VALUES
    (50, '2023-02-23', NULL, '01.274.895', '0001-40', '11.679.309/0001-01', 'Análise de emissões em São Paulo na última década', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (50, '8462.69.00', 0.3402, 8356),
    (50, '3811.29.90', 0.1516, 1731);

INSERT INTO relatorio_serv VALUES
    (50, '1.1303.20.00', '2023-03-16T21:18:03', 0.0643),
    (50, '1.1406.20.00', '2023-03-25T14:35:18', 0.0352),
    (50, '1.0106.90.00', '2023-03-22T02:45:56', 0.1524),
    (50, '1.0502.14.90', '2023-03-09T14:11:04', 0.037),
    (50, '1.1705.10.00', '2023-03-07T10:43:58', 0.0289),
    (50, '1.0504.2', '2023-03-01T07:08:17', 0.1743),
    (50, '1.0404', '2023-03-17T16:38:23', 0.0321),
    (50, '1.2501.32.00', '2023-03-05T11:01:03', 0.2482),
    (50, '1.1104.20.00', '2023-03-18T21:18:13', 0.2031),
    (50, '1.0502.14.51', '2023-03-13T14:33:54', 0.0051),
    (50, '1.1405.90.00', '2023-03-30T11:56:33', 0.0486),
    (50, '1.2001.34', '2023-03-14T22:34:43', 0.1473),
    (50, '1.0609.00.00', '2023-03-19T21:45:11', 0.105),
    (50, '1.0106', '2023-03-26T11:28:27', 0.2901),
    (50, '1.2601.20.00', '2023-03-12T05:22:51', 0.0186),
    (50, '1.0603.00.00', '2023-03-04T18:52:08', 0.1843),
    (50, '1.0910.90.00', '2023-03-23T15:54:03', 0.1912),
    (50, '1.0604.21.00', '2023-03-02T05:28:21', 0.0558),
    (50, '1.0906.30.00', '2023-03-05T02:00:53', 0.2799),
    (50, '1.0901', '2023-03-18T13:37:14', 0.1394),
    (50, '1.2502.10.00', '2023-03-09T11:05:46', 0.1898),
    (50, '1.2001.39.00', '2023-03-18T11:45:58', 0.1358),
    (50, '1.0801.10.00', '2023-03-15T08:52:51', 0.1295),
    (50, '1.1105.90.00', '2023-03-27T07:31:40', 0.0396),
    (50, '1.1805.12.00', '2023-03-28T13:36:28', 0.0301),
    (50, '1.1301.30.00', '2023-03-15T14:23:53', 0.0397);

INSERT INTO relatorio VALUES
    (51, '2021-07-23', NULL, '79.821.563', '0001-99', '11.679.309/0001-01', 'Análise de emissões em São Paulo na última década', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (51, '6103.32.00', 0.0795, 2088),
    (51, '8802.20.10', 0.0382, 13962),
    (51, '0303.32.00', 0.0674, 400),
    (51, '8417.20.00', 0.0352, 5000),
    (51, '5106.20.00', 0.0557, 400),
    (51, '2910.90.10', 0.009, 400),
    (51, '2936.21.12', 0.053, 1241),
    (51, '4407.19.00', 0.0669, 1497),
    (51, '3903.11.10', 0.0221, 9155),
    (51, '4811.59.29', 0.0257, 6701),
    (51, '7208.37.00', 0.0159, 5512),
    (51, '4202.22.20', 0.0125, 9677),
    (51, '2903.99.29', 0.4629, 15008),
    (51, '7614.10.10', 0.0966, 8554);

INSERT INTO relatorio_serv VALUES
    (51, '1.0908.00.00', '2021-08-28T14:07:08', 0.0433),
    (51, '1.0903.38.00', '2021-08-11T11:10:07', 0.361),
    (51, '1.1108.10.00', '2021-08-11T08:50:42', 0.2992),
    (51, '1.1403.23.00', '2021-08-08T11:59:30', 0.3302),
    (51, '1.0404', '2021-08-11T02:19:07', 0.1538),
    (51, '1.0502.1', '2021-08-04T21:34:28', 0.371),
    (51, '1.0502.11', '2021-08-27T15:29:34', 0.0797);

INSERT INTO relatorio VALUES
    (52, '2025-01-16', '2026-01-29', '48.912.037', '0001-38', '37.669.280/0001-29', 'Emissões em microempresas', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (52, '8542.32.2', 0.7535, 6820),
    (52, '4002.59.00', 0.081, 4358),
    (52, '8708.29.91', 0.0059, 3026),
    (52, '3907.10.31', 0.0635, 7218),
    (52, '2922.31.12', 0.0017, 10095),
    (52, '0801.22.00', 0.0591, 400),
    (52, '4801.00.30', 0.0035, 2493),
    (52, '3004.90.32', 0.0013, 9459),
    (52, '2921.45.00', 0.0548, 12567),
    (52, '2936.28.1', 0.0342, 14443),
    (52, '2933.33.69', 0.0002, 8980),
    (52, '3006.30.21', 0.0058, 5405),
    (52, '2934.20.32', 0.0712, 5195),
    (52, '3002.49.92', 0.0059, 9624),
    (52, '8425.31.90', 0.0276, 8894),
    (52, '4107.19.90', 0.0179, 2280),
    (52, '2925.29.30', 0.0044, 400),
    (52, '3002.12.12', 0.107, 2903),
    (52, '3102.50.11', 0.0049, 4579),
    (52, '8708.94.81', 0.0051, 8722),
    (52, '5107.10.1', 0.0041, 805),
    (52, '2924.29.20', 0.0188, 4468),
    (52, '8415.90.90', 0.0289, 3290),
    (52, '5801.10.00', 0.014, 400);

INSERT INTO relatorio_serv VALUES
    (52, '1.1403.23.00', '2025-02-18T10:38:22', 0.2847),
    (52, '1.1403.21', '2025-02-01T19:54:11', 0.0133);

INSERT INTO relatorio VALUES
    (53, '2024-10-23', NULL, '79.821.563', '0001-99', '87.888.161/0001-65', 'Impacto de atividades agropecuárias na Amazônia', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (53, '8711.20.20', 0.0255, 9662),
    (53, '8461.90.10', 0.0203, 400),
    (53, '3814.00.90', 0.029, 2861),
    (53, '3901.20.2', 0.0093, 6051),
    (53, '8433.59.19', 0.0504, 5235),
    (53, '6302.31.00', 0.0235, 400),
    (53, '2930.90.12', 0.0133, 400),
    (53, '7219.90.90', 0.0176, 10886),
    (53, '2905.19.9', 0.0679, 5802),
    (53, '1008.90.90', 0.0254, 400),
    (53, '4419.11.00', 0.0879, 11862),
    (53, '7804.11.00', 0.0158, 6598),
    (53, '0203.11.00', 0.0005, 8812);

INSERT INTO relatorio_serv VALUES
    (53, '1.1801.1', '2024-11-26T00:04:48', 0.0228),
    (53, '1.1405.1', '2024-11-09T07:36:09', 0.0803),
    (53, '1.1502.50.00', '2024-11-09T00:21:18', 0.0282),
    (53, '1.1001.30.00', '2024-11-17T14:57:19', 0.0609),
    (53, '1.0102.41.90', '2024-11-11T23:46:23', 0.2037),
    (53, '1.1801.21.00', '2024-11-18T16:40:27', 0.302),
    (53, '1.0902.90.00', '2024-11-25T11:52:04', 0.0636);

INSERT INTO relatorio VALUES
    (54, '2024-02-08', '2025-10-16', '79.821.563', '0001-99', '58.826.745/0001-34', 'Emissões a alto nível', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (54, '3006.93.00', 0.3502, 5176),
    (54, '2914.79.29', 0.3041, 7060),
    (54, '7313.00.00', 0.368, 400),
    (54, '3907.10.41', 0.0903, 6668),
    (54, '6203.43.00', 0.234, 2335),
    (54, '8448.11.10', 0.4355, 400),
    (54, '4002.19.1', 0.1974, 8442);

INSERT INTO relatorio_serv VALUES
    (54, '1.0102.41.10', '2024-03-25T06:25:41', 0.084),
    (54, '1.2602.20.00', '2024-03-17T01:47:38', 0.0972),
    (54, '1.1109.10.00', '2024-03-30T05:10:57', 0.1618),
    (54, '1.0105.40.00', '2024-03-05T19:56:37', 0.4064),
    (54, '1.0901.35.00', '2024-03-07T12:10:31', 0.1996),
    (54, '1.2301.19.00', '2024-03-26T08:35:44', 0.1703),
    (54, '1.0605.90.00', '2024-03-02T16:01:49', 0.1393),
    (54, '1.1701.33.00', '2024-03-19T10:15:14', 0.3035),
    (54, '1.2101.2', '2024-03-11T20:52:20', 0.3589);

INSERT INTO relatorio VALUES
    (55, '2025-03-30', '2026-03-02', '88.635.333', '0001-98', '09.850.333/0001-77', 'Emissões: e eu com isso?', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (55, '8418.61.00', 0.0159, 400),
    (55, '2915.90.41', 0.0768, 7502),
    (55, '8418.40.00', 0.1453, 2056),
    (55, '3004.39.82', 0.1509, 8593),
    (55, '3703.90.10', 0.0738, 400),
    (55, '7316.00.00', 0.0586, 11508),
    (55, '2615.90.00', 0.0522, 9705),
    (55, '9018.90.94', 0.0189, 2967),
    (55, '8308.20.00', 0.2248, 4852),
    (55, '8543.70.11', 0.0206, 11092),
    (55, '6406.20.00', 0.1487, 400),
    (55, '0304.43.00', 0.0939, 9090),
    (55, '8532.21.1', 0.0473, 13145),
    (55, '8477.90.00', 0.1162, 4596),
    (55, '6204.21.00', 0.0355, 4003),
    (55, '6104.61.00', 0.0312, 3831),
    (55, '2933.29.30', 0.0525, 4553),
    (55, '2933.91.29', 0.0464, 684),
    (55, '3808.93.52', 0.1438, 7484),
    (55, '9014.20.10', 0.0334, 902),
    (55, '2934.91.60', 0.0586, 2972),
    (55, '3811.21.50', 0.0052, 9655),
    (55, '7607.19.90', 0.0201, 10236),
    (55, '2933.69.16', 0.1664, 11053),
    (55, '3004.20.95', 0.094, 6069),
    (55, '8442.40.20', 0.0502, 2932),
    (55, '2524.10.00', 0.0165, 5372),
    (55, '6212.90.00', 0.1071, 1219);

INSERT INTO relatorio_serv VALUES
    (55, '1.0503', '2025-04-11T01:03:15', 0.1753),
    (55, '1.0501.25.00', '2025-04-15T12:42:57', 0.3167);

INSERT INTO relatorio VALUES
    (56, '2023-02-21', '2024-01-11', '65.172.380', '0001-61', '53.396.825/0001-34', 'Formas de reduzir o impacto de emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (56, '4820.40.00', 0.0718, 400),
    (56, '2907.19.20', 0.3732, 7727),
    (56, '3004.20.92', 0.121, 2520),
    (56, '6302.99.90', 0.0223, 2394),
    (56, '3803.00.10', 0.0046, 14210),
    (56, '7306.69.00', 0.1686, 9727),
    (56, '5603.93.40', 0.1853, 400),
    (56, '4802.20.90', 0.3378, 6517),
    (56, '8476.90.00', 0.634, 400),
    (56, '2921.19.91', 0.3469, 400),
    (56, '9022.13.1', 0.2312, 5192),
    (56, '2941.30.10', 0.0473, 400),
    (56, '6207.22.00', 0.2876, 400),
    (56, '3102.90.00', 0.1593, 4909),
    (56, '6905.90.00', 0.1128, 400),
    (56, '2934.20.10', 0.0824, 3708),
    (56, '8414.80.12', 0.035, 5362),
    (56, '2933.91.81', 0.0438, 3902);

INSERT INTO relatorio VALUES
    (57, '2025-10-19', NULL, '13.690.872', '0001-09', '54.777.163/0001-46', 'Andamento das metas da ONU', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (57, '2933.69.23', 7.5306, 400),
    (57, '2915.90.70', 6.6138, 9113),
    (57, '2915.90.4', 2.1019, 766),
    (57, '7410.21.90', 3.0118, 400),
    (57, '2934.99.51', 7.5834, 6684),
    (57, '2933.91.2', 2.4039, 11524),
    (57, '8443.99.11', 0.6079, 400),
    (57, '2517.20.00', 5.5735, 5399),
    (57, '2924.19.4', 4.6202, 4549),
    (57, '8532.23.90', 1.8322, 400),
    (57, '6304.19.90', 3.0822, 400),
    (57, '7019.11.00', 1.5908, 10854),
    (57, '2933.39.23', 9.1471, 12829),
    (57, '0207.14.33', 1.4346, 6252),
    (57, '8302.42.00', 2.6787, 9338),
    (57, '3003.90.65', 1.8361, 400);

INSERT INTO relatorio_serv VALUES
    (57, '1.0502.14.90', '2025-11-17T21:42:30', 5.0123),
    (57, '1.2405.11.00', '2025-11-12T05:51:59', 1.0545),
    (57, '1.1001.2', '2025-11-06T13:52:28', 0.0785),
    (57, '1.1406.33.00', '2025-11-05T17:00:38', 3.8242);

INSERT INTO relatorio VALUES
    (58, '2024-05-17', NULL, '53.921.807', '0001-18', '37.669.280/0001-29', 'Pesquisa de campo em emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (58, '9018.49.20', 0.0499, 512),
    (58, '5604.90.2', 0.0163, 7566),
    (58, '2306.49.00', 0.1745, 1282);

INSERT INTO relatorio_serv VALUES
    (58, '1.0504.49.00', '2024-06-09T14:53:46', 0.0071),
    (58, '1.0501.12.20', '2024-06-08T03:39:46', 0.0161),
    (58, '1.0401.14.00', '2024-06-27T01:38:20', 0.0487),
    (58, '1.2501.33.00', '2024-06-28T07:35:42', 0.0351),
    (58, '1.0502.11.10', '2024-06-03T16:24:46', 0.0049),
    (58, '1.2101.21.00', '2024-06-22T14:58:10', 0.0119),
    (58, '1.2301.1', '2024-06-28T08:24:36', 0.0988),
    (58, '1.0401.16.90', '2024-06-29T10:06:01', 0.1013),
    (58, '1.1404.19.00', '2024-06-23T00:16:21', 0.023),
    (58, '1.2504', '2024-06-28T13:43:37', 0.0887),
    (58, '1.1806.59.00', '2024-06-07T08:49:04', 0.1828),
    (58, '1.0101.1', '2024-06-16T19:48:09', 0.1005),
    (58, '1.0501.25.00', '2024-06-08T20:02:39', 0.1777),
    (58, '1.2101.22.00', '2024-06-14T23:50:16', 0.0465),
    (58, '1.1401.1', '2024-06-27T17:19:48', 0.0594),
    (58, '1.0904.37.00', '2024-06-04T16:34:04', 0.0878),
    (58, '1.0603.00.00', '2024-06-06T13:53:21', 0.004),
    (58, '1.1401.13.00', '2024-06-21T02:08:59', 0.0194),
    (58, '1.0504.11.00', '2024-06-26T07:41:19', 0.0719),
    (58, '1.0604.40.00', '2024-06-02T11:14:23', 0.0194),
    (58, '1.1001.12.10', '2024-06-01T14:35:09', 0.0405),
    (58, '1.0302.00.00', '2024-06-22T14:03:37', 0.0097),
    (58, '1.0102.80.00', '2024-06-08T16:02:29', 0.078),
    (58, '1.0906', '2024-06-16T21:19:04', 0.0239),
    (58, '1.0501.22.30', '2024-06-02T03:32:30', 0.1079),
    (58, '1.0601.10.00', '2024-06-04T00:13:09', 0.043),
    (58, '1.0504.31.00', '2024-06-19T17:17:04', 0.004),
    (58, '1.0903.32.00', '2024-06-17T22:14:34', 0.1121),
    (58, '1.0106.14.00', '2024-06-07T12:12:54', 0.0701),
    (58, '1.1806.6', '2024-06-07T23:35:20', 0.0692),
    (58, '1.0501.23', '2024-06-08T06:35:29', 0.0447),
    (58, '1.1103.36.10', '2024-06-10T07:59:46', 0.0837),
    (58, '1.2501.90.00', '2024-06-27T16:33:11', 0.1233),
    (58, '1.1802.30.00', '2024-06-28T11:32:59', 0.0453),
    (58, '1.2405.90.00', '2024-06-14T10:20:32', 0.0414),
    (58, '1.0901.51.24', '2024-06-21T03:03:45', 0.1051);

INSERT INTO relatorio VALUES
    (59, '2024-11-17', '2025-04-24', '75.893.062', '0001-33', '87.888.161/0001-65', 'Impacto de atividades agropecuárias na Amazônia', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (59, '3204.12.20', 0.0092, 10419),
    (59, '2939.80.90', 0.1863, 4180);

INSERT INTO relatorio_serv VALUES
    (59, '1.0503.27.00', '2024-12-04T21:47:45', 0.2005),
    (59, '1.2301.97.00', '2024-12-20T22:14:39', 0.3627),
    (59, '1.0602.3', '2024-12-03T21:48:39', 0.3791),
    (59, '1.0402.12.00', '2024-12-29T20:36:05', 0.055),
    (59, '1.0604', '2024-12-13T05:31:27', 0.1393),
    (59, '1.2302.21.00', '2024-12-23T22:11:42', 0.2418),
    (59, '1.2301.91.00', '2024-12-22T01:58:42', 0.3018),
    (59, '1.0502.24.40', '2024-12-15T22:47:03', 0.3436),
    (59, '1.0502.1', '2024-12-17T09:52:05', 0.3071),
    (59, '1.1406.12.00', '2024-12-27T07:28:02', 0.1515),
    (59, '1.1403.21.20', '2024-12-03T08:55:16', 0.1143),
    (59, '1.1805.21.00', '2024-12-11T08:06:44', 0.1811),
    (59, '1.1102.10.00', '2024-12-09T19:41:55', 0.2899);

INSERT INTO relatorio VALUES
    (60, '2023-10-28', '2025-06-22', '79.821.563', '0001-43', '09.850.333/0001-77', 'Emissões: e eu com isso?', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (60, '2009.19.00', 15.7027, 8378),
    (60, '5601.30.10', 0.0101, 400),
    (60, '2715.00.00', 0.4788, 4016),
    (60, '1605.51.00', 0.1864, 455),
    (60, '8479.60.00', 0.0692, 4072),
    (60, '3920.99.50', 0.3674, 1243),
    (60, '8467.99.00', 1.4344, 400),
    (60, '7508.10.00', 0.2197, 9663),
    (60, '8529.90.50', 0.9288, 11693),
    (60, '8534.00.1', 1.0215, 8080),
    (60, '2920.19.90', 0.2761, 400),
    (60, '3004.20.39', 0.0308, 8801),
    (60, '3906.90.62', 0.2228, 4759),
    (60, '0712.90.20', 0.3471, 400),
    (60, '6505.00.2', 0.01, 2956),
    (60, '0713.60.90', 0.2994, 400),
    (60, '4010.34.00', 0.4601, 1389),
    (60, '8523.52.90', 0.1806, 400),
    (60, '6101.20.00', 1.286, 738),
    (60, '3004.90.59', 2.3891, 10651),
    (60, '8708.93.00', 0.2521, 5491),
    (60, '0306.35.00', 0.0552, 400),
    (60, '0302.72.90', 0.5118, 8733),
    (60, '1805.00.00', 0.1001, 6205),
    (60, '7606.12.30', 1.3348, 2250),
    (60, '5515.29.00', 0.1856, 7162),
    (60, '5311.00.00', 0.2057, 1548),
    (60, '6006.34.10', 0.7878, 2257);

INSERT INTO relatorio_serv VALUES
    (60, '1.2302.21.00', '2023-11-06T15:18:11', 6.8297),
    (60, '1.1506.10.00', '2023-11-22T04:54:43', 0.4335),
    (60, '1.0503.29.00', '2023-11-02T21:12:49', 0.0772),
    (60, '1.2505.20.00', '2023-11-13T21:02:42', 0.1406);

INSERT INTO relatorio VALUES
    (61, '2025-10-08', NULL, '75.893.062', '0001-33', '00.001.333/0001-99', 'Tipos de emissão em empresas de refinaria', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (61, '8471.60.54', 0.0108, 13427);

INSERT INTO relatorio_serv VALUES
    (61, '1.1402', '2025-11-06T02:41:41', 0.1127),
    (61, '1.1404.49.00', '2025-11-07T12:45:56', 0.2806),
    (61, '1.0401.11', '2025-11-05T20:33:01', 0.0403),
    (61, '1.1201.33.00', '2025-11-11T06:30:22', 0.2307),
    (61, '1.0601.10.00', '2025-11-21T16:25:54', 0.3467),
    (61, '1.1404.44.00', '2025-11-27T16:22:54', 0.2475),
    (61, '1.2403.12.00', '2025-11-25T18:29:06', 0.0887),
    (61, '1.0901.40.00', '2025-11-19T10:11:14', 0.4721),
    (61, '1.1401.21.00', '2025-11-20T11:26:25', 0.0863),
    (61, '1.0304', '2025-11-05T03:30:20', 0.1581),
    (61, '1.0502.11', '2025-11-19T01:17:59', 0.016),
    (61, '1.1903.1', '2025-11-16T04:58:17', 0.0792),
    (61, '1.0104.00.00', '2025-11-02T18:02:53', 0.1753),
    (61, '1.0602.2', '2025-11-02T02:32:28', 0.1283);

INSERT INTO relatorio VALUES
    (62, '2024-08-03', NULL, '79.821.563', '0001-99', '58.826.745/0001-34', 'Emissões a alto nível', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (62, '8305.10.00', 0.2265, 7340),
    (62, '2910.10.00', 0.0839, 4380),
    (62, '1107.10.10', 0.2309, 5295),
    (62, '8506.50.90', 0.101, 5852),
    (62, '2933.91.29', 0.1756, 8526),
    (62, '6204.19.00', 0.0189, 16061),
    (62, '8539.90.90', 0.0785, 6104),
    (62, '2935.90.24', 0.0781, 5516),
    (62, '2835.10.11', 0.0582, 400),
    (62, '4811.59.22', 0.3108, 1603),
    (62, '8801.00.00', 0.1323, 2555),
    (62, '2933.29.1', 0.2085, 4128),
    (62, '8402.11.00', 0.1274, 6439),
    (62, '0102.29.11', 0.0955, 11353),
    (62, '2924.29.61', 0.2426, 6152);

INSERT INTO relatorio_serv VALUES
    (62, '1.1806.81.00', '2024-09-28T07:11:25', 1.1653),
    (62, '1.1410', '2024-09-25T19:44:34', 0.6223),
    (62, '1.1108.90.00', '2024-09-24T11:39:23', 0.3143),
    (62, '1.04', '2024-09-13T09:47:57', 2.1846),
    (62, '1.0503.21.00', '2024-09-19T01:34:44', 0.539);

INSERT INTO relatorio VALUES
    (63, '2021-08-12', NULL, '51.360.297', '0001-43', '37.669.280/0001-29', 'Emissões em microempresas', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (63, '8453.80.00', 0.0215, 400),
    (63, '2829.90.39', 0.0204, 3947),
    (63, '2804.21.00', 0.1552, 1076),
    (63, '2710.12.10', 0.0547, 3459),
    (63, '9021.21.90', 0.045, 5635),
    (63, '0102.39.19', 0.067, 400),
    (63, '8533.39.90', 0.0085, 400),
    (63, '3002.49.94', 0.0187, 400),
    (63, '1508.10.00', 0.0636, 400),
    (63, '2931.44.00', 0.1064, 400);

INSERT INTO relatorio_serv VALUES
    (63, '1.0502.11.30', '2021-09-16T02:14:51', 0.2523),
    (63, '1.0401.14.00', '2021-09-19T05:15:45', 0.0748),
    (63, '1.0401.16.10', '2021-09-13T16:13:20', 0.3408),
    (63, '1.0102.42.10', '2021-09-17T02:49:48', 0.1622),
    (63, '1.1401.1', '2021-09-28T03:44:55', 0.1487);

INSERT INTO relatorio VALUES
    (64, '2024-07-26', '2025-12-29', '13.690.872', '0001-09', '54.777.163/0001-46', 'O capitalismo como motor da exploração dos recursos naturais', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (64, '2603.00.90', 0.0214, 8515),
    (64, '5211.51.00', 0.1412, 11277),
    (64, '8409.99.2', 0.0307, 1136),
    (64, '8533.31.10', 0.0368, 400),
    (64, '0303.83.11', 0.0152, 400),
    (64, '2829.90.29', 0.127, 9262),
    (64, '7101.22.00', 0.1337, 400),
    (64, '0304.55.00', 0.0244, 400),
    (64, '2933.33.94', 0.1202, 6719),
    (64, '0802.91.00', 0.0853, 4303),
    (64, '3824.99.1', 0.1646, 3482),
    (64, '0210.92.00', 0.0484, 6686),
    (64, '3820.00.00', 0.069, 1934),
    (64, '7208.10.00', 0.0855, 7916),
    (64, '7205.10.00', 0.0191, 7530),
    (64, '8441.40.00', 0.0283, 627),
    (64, '7304.23.90', 0.0122, 12677),
    (64, '7210.61.00', 0.0571, 6329),
    (64, '3003.90.12', 0.009, 400),
    (64, '0305.49.10', 0.2398, 524),
    (64, '8903.32.00', 0.224, 9814),
    (64, '4418.89.00', 0.0068, 4669),
    (64, '3003.90.66', 0.0308, 3064),
    (64, '8540.60.10', 0.0526, 3178),
    (64, '3808.91.9', 0.0126, 400),
    (64, '8440.10.90', 0.0412, 10908),
    (64, '6901.00.00', 0.0791, 8532);

INSERT INTO relatorio_serv VALUES
    (64, '1.0403.19.00', '2024-08-08T22:13:32', 0.0986),
    (64, '1.0502.34.40', '2024-08-07T06:38:02', 0.108);

INSERT INTO relatorio VALUES
    (65, '2021-11-21', NULL, '79.821.563', '0001-00', '37.669.280/0001-29', 'Pesquisa de campo em emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (65, '3907.99.93', 1.5036, 400),
    (65, '8708.50.91', 0.0793, 3240),
    (65, '3808.91.99', 0.0381, 7427),
    (65, '3701.99.00', 0.0144, 4294),
    (65, '6903.10.40', 0.026, 7749),
    (65, '0705.19.00', 0.0539, 3795);

INSERT INTO relatorio_serv VALUES
    (65, '1.0502.31', '2021-12-01T01:40:40', 1.1035),
    (65, '1.2501.32.00', '2021-12-29T09:10:16', 0.1386),
    (65, '1.1503.00.00', '2021-12-10T19:03:34', 0.066),
    (65, '1.0901.40.00', '2021-12-17T13:55:31', 0.0042),
    (65, '1.1410.10.00', '2021-12-16T23:46:01', 0.2192),
    (65, '1.0102.11.00', '2021-12-27T19:05:22', 0.0041),
    (65, '1.1903.1', '2021-12-03T22:07:52', 0.0162),
    (65, '1.1902.10.00', '2021-12-17T15:56:26', 0.0065),
    (65, '1.2405.90.00', '2021-12-11T16:21:47', 0.0065);

INSERT INTO relatorio VALUES
    (66, '2022-01-14', NULL, '01.274.895', '0001-13', '54.777.163/0001-46', 'O capitalismo como motor da exploração dos recursos naturais', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (66, '7315.11.90', 0.0233, 15794),
    (66, '1212.93.00', 0.0144, 9604),
    (66, '7222.19.90', 0.0551, 6368),
    (66, '3808.59.26', 0.0278, 905),
    (66, '8528.69.10', 0.0359, 1846),
    (66, '2103.20.90', 0.0029, 3030),
    (66, '8535.30.27', 0.0498, 2838),
    (66, '2906.19.40', 0.0392, 2977),
    (66, '6103.10.10', 0.0298, 3806),
    (66, '8424.30.20', 0.0573, 9150),
    (66, '0303.89.53', 0.0017, 14041),
    (66, '6108.21.00', 0.1147, 6731),
    (66, '7304.29.39', 0.022, 400),
    (66, '2910.90.90', 0.0895, 9389),
    (66, '2845.30.00', 0.1299, 400),
    (66, '8414.70.00', 0.0194, 3386),
    (66, '6305.20.00', 0.0067, 5952),
    (66, '2921.19.4', 0.019, 400),
    (66, '8422.40.90', 0.0963, 524),
    (66, '3102.50.11', 0.0591, 7568);

INSERT INTO relatorio_serv VALUES
    (66, '1.0404.20.00', '2022-02-22T06:43:09', 0.0579),
    (66, '1.0402.22.00', '2022-02-01T13:57:02', 0.0246),
    (66, '1.0901.51.22', '2022-02-02T07:14:48', 0.0192);

INSERT INTO relatorio VALUES
    (67, '2025-04-23', '2025-07-15', '28.659.130', '0001-07', '37.669.280/0001-29', 'Emissões em microempresas', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (67, '4104.49.90', 0.3654, 9122),
    (67, '3920.62.91', 0.2296, 3188),
    (67, '8704.22.30', 0.0322, 3445);

INSERT INTO relatorio_serv VALUES
    (67, '1.0402.29.00', '2025-05-12T18:29:04', 0.1135),
    (67, '1.0504.13.00', '2025-05-06T10:49:48', 0.0923),
    (67, '1.0602.33.00', '2025-05-13T14:10:21', 0.0139),
    (67, '1.1403.22.2', '2025-05-13T20:33:18', 0.0403),
    (67, '1.0907.00.00', '2025-05-26T01:33:02', 0.0682),
    (67, '1.1101.90.00', '2025-05-21T02:53:29', 0.0495),
    (67, '1.2204.20.00', '2025-05-08T23:19:07', 0.0667),
    (67, '1.0605.20.00', '2025-05-16T15:17:09', 0.0648),
    (67, '1.1706.21.00', '2025-05-10T00:49:07', 0.055),
    (67, '1.1701.40.00', '2025-05-13T14:38:09', 0.0564),
    (67, '1.0502.34.10', '2025-05-03T02:12:48', 0.0347),
    (67, '1.0103.10.00', '2025-05-19T18:21:51', 0.0126),
    (67, '1.0501.14.10', '2025-05-14T03:23:50', 0.0159),
    (67, '1.0403.3', '2025-05-19T03:11:59', 0.187),
    (67, '1.0502.11.10', '2025-05-29T18:36:16', 0.1952),
    (67, '1.1302.1', '2025-05-15T23:40:05', 0.2411),
    (67, '1.1805.32.00', '2025-05-12T14:29:33', 0.2133),
    (67, '1.2501.90.00', '2025-05-21T04:12:36', 0.1021),
    (67, '1.0403.2', '2025-05-29T09:39:39', 0.051),
    (67, '1.1001.22.00', '2025-05-10T09:35:22', 0.0893),
    (67, '1.1805', '2025-05-05T03:15:27', 0.1084),
    (67, '1.0105.22.00', '2025-05-17T09:59:34', 0.1072),
    (67, '1.2003.25.20', '2025-05-27T21:02:36', 0.0968),
    (67, '1.15', '2025-05-11T02:40:22', 0.137),
    (67, '1.2302.2', '2025-05-13T18:23:51', 0.0982),
    (67, '1.1505.00.00', '2025-05-20T13:05:38', 0.1147),
    (67, '1.0402.13.20', '2025-05-28T03:11:20', 0.2186),
    (67, '1.2204', '2025-05-09T03:11:32', 0.0647),
    (67, '1.2403.3', '2025-05-09T17:12:53', 0.0611),
    (67, '1.0901.51.13', '2025-05-28T03:17:38', 0.0653),
    (67, '1.0802.10.00', '2025-05-01T17:16:00', 0.065);

INSERT INTO relatorio VALUES
    (68, '2025-10-15', '2026-03-02', '53.921.807', '0001-18', '11.679.309/0001-01', 'Análise de emissões em São Paulo na última década', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (68, '3003.10.12', 0.3083, 3165);

INSERT INTO relatorio_serv VALUES
    (68, '1.2604.00.00', '2025-11-16T04:13:59', 0.0435),
    (68, '1.1202', '2025-11-29T20:25:15', 0.1464),
    (68, '1.0502.14.59', '2025-11-27T05:56:23', 0.2737),
    (68, '1.2405.13.00', '2025-11-20T10:23:57', 0.0571),
    (68, '1.2205.19.00', '2025-11-17T14:00:32', 0.0715),
    (68, '1.0502.14.51', '2025-11-01T06:42:23', 0.0969),
    (68, '1.1506.90.00', '2025-11-26T19:47:53', 0.1162),
    (68, '1.1201.1', '2025-11-25T01:00:10', 0.0415),
    (68, '1.2504', '2025-11-01T02:06:00', 0.1896),
    (68, '1.1506.2', '2025-11-05T05:14:52', 0.0386),
    (68, '1.2001.3', '2025-11-25T12:10:29', 0.0515),
    (68, '1.1201.33.00', '2025-11-09T20:08:25', 0.1404),
    (68, '1.0906', '2025-11-05T14:18:21', 0.0197),
    (68, '1.0501.3', '2025-11-15T14:27:58', 0.0448),
    (68, '1.1103.36.20', '2025-11-18T07:19:46', 0.0765),
    (68, '1.1403', '2025-11-02T21:31:28', 0.293);

INSERT INTO relatorio VALUES
    (69, '2024-12-28', NULL, '79.821.563', '0001-00', '53.396.825/0001-34', 'Formas de reduzir o impacto de emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (69, '3815.90.10', 1.5646, 4469),
    (69, '0210.99.40', 0.0396, 1044),
    (69, '5111.11.10', 0.0081, 4412),
    (69, '2832.20.00', 0.0765, 3455),
    (69, '0306.39.90', 0.1264, 400),
    (69, '9401.59.00', 0.2503, 400);

INSERT INTO relatorio_serv VALUES
    (69, '1.0608', '2025-01-22T07:05:39', 2.4512),
    (69, '1.1403.21.10', '2025-01-09T23:46:01', 0.4656),
    (69, '1.0602.10.00', '2025-01-12T22:46:57', 0.0118),
    (69, '1.0903.1', '2025-01-04T18:46:19', 0.0231),
    (69, '1.01', '2025-01-02T08:42:19', 0.1042),
    (69, '1.1408.12.00', '2025-01-22T08:23:00', 0.4632),
    (69, '1.0903.13.00', '2025-01-09T21:42:44', 0.1411);

INSERT INTO relatorio VALUES
    (70, '2025-05-19', NULL, '65.172.380', '0001-61', '54.777.163/0001-46', 'Andamento das metas da ONU', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (70, '5206.15.00', 0.1085, 1976),
    (70, '0908.31.00', 0.0202, 4966),
    (70, '3003.90.59', 0.0486, 12532),
    (70, '3811.21.30', 0.0895, 750),
    (70, '5103.20.00', 0.0472, 4958),
    (70, '6005.43.00', 0.0097, 6845),
    (70, '2941.90.51', 0.0347, 2768),
    (70, '2701.20.00', 0.0489, 3386),
    (70, '3004.39.21', 0.0007, 7771),
    (70, '2837.20.21', 0.0084, 4076),
    (70, '7216.40.10', 0.0231, 18151),
    (70, '2936.26.90', 0.0032, 9116),
    (70, '2916.31.31', 0.0258, 6063),
    (70, '2912.49.10', 0.0452, 4219),
    (70, '5503.11.00', 0.0383, 2094),
    (70, '7901.20.10', 0.0096, 400),
    (70, '2939.69.1', 0.0229, 12426),
    (70, '2941.90.83', 0.0951, 5686),
    (70, '2937.23.21', 0.0749, 400),
    (70, '3002.14.00', 0.1068, 3507),
    (70, '5603.13.50', 0.002, 1186),
    (70, '8541.10.19', 0.0222, 5885),
    (70, '2918.23.00', 0.0332, 4401),
    (70, '1207.91.10', 0.041, 400),
    (70, '8428.60.00', 0.0252, 3896),
    (70, '2924.29.94', 0.0287, 4661),
    (70, '1008.50.10', 0.0392, 2301);

INSERT INTO relatorio_serv VALUES
    (70, '1.2501.39.00', '2025-06-15T07:27:35', 0.2853);

INSERT INTO relatorio VALUES
    (71, '2022-11-05', '2023-02-19', '48.603.715', '0001-78', '53.396.825/0001-34', 'Formas de reduzir o impacto de emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (71, '9027.20.12', 0.078, 1881),
    (71, '0510.00.90', 0.1239, 5265),
    (71, '1302.32.1', 0.1513, 2189),
    (71, '0713.10.90', 0.1961, 4454),
    (71, '4407.28.00', 0.4594, 11466),
    (71, '6208.22.00', 0.6212, 3313),
    (71, '0407.90.00', 0.0798, 9546),
    (71, '2103.90.19', 0.1023, 13083),
    (71, '8539.51.00', 0.0761, 4302),
    (71, '3206.50.1', 0.124, 6279);

INSERT INTO relatorio_serv VALUES
    (71, '1.0102.52.10', '2022-12-15T04:05:09', 0.4496),
    (71, '1.0502', '2022-12-04T07:20:01', 0.1165),
    (71, '1.0905.60.00', '2022-12-13T20:15:44', 0.8726),
    (71, '1.0503.90.00', '2022-12-29T00:55:21', 0.8087),
    (71, '1.2003.21.90', '2022-12-09T00:00:35', 0.3909),
    (71, '1.0106.2', '2022-12-06T05:55:43', 0.2352),
    (71, '1.0107.60.00', '2022-12-01T01:00:13', 0.1969);

INSERT INTO relatorio VALUES
    (72, '2025-10-04', '2026-02-08', '88.635.333', '0001-98', '11.679.309/0001-01', 'Análise de emissões em São Paulo na última década', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (72, '7210.41.10', 0.13, 2161),
    (72, '2941.90.31', 0.0233, 3204),
    (72, '5209.11.00', 0.0904, 1091),
    (72, '2926.90.23', 0.2267, 4710),
    (72, '2853.90.30', 0.258, 2632),
    (72, '0703.10.21', 0.0919, 6327),
    (72, '7306.90.20', 0.0439, 4920),
    (72, '3702.42.10', 0.132, 400),
    (72, '8539.31.20', 0.0583, 12747),
    (72, '3917.32.29', 0.2266, 6328),
    (72, '2523.29.90', 0.0135, 400),
    (72, '0808.30.00', 0.0266, 1662),
    (72, '7308.20.00', 0.0859, 13393),
    (72, '9104.00.00', 0.0255, 1282),
    (72, '0303.83.21', 0.0756, 1135),
    (72, '2922.43.00', 0.03, 400),
    (72, '6204.31.00', 0.0221, 7858),
    (72, '2903.77.90', 0.0466, 1865),
    (72, '2922.50.9', 0.0133, 4147),
    (72, '3002.12.15', 0.0678, 400),
    (72, '1105.10.00', 0.0802, 6849);

INSERT INTO relatorio_serv VALUES
    (72, '1.0501.25.00', '2025-11-02T21:56:11', 0.2708),
    (72, '1.0602.2', '2025-11-29T09:55:12', 0.449);

INSERT INTO relatorio VALUES
    (73, '2022-01-15', NULL, '48.912.037', '0001-38', '37.669.280/0001-29', 'Emissões em microempresas', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (73, '3919.90.20', 0.3424, 9047),
    (73, '2917.39.19', 0.0082, 9963),
    (73, '6204.31.00', 0.0047, 5198),
    (73, '8539.41.10', 0.0211, 400),
    (73, '3903.30.10', 0.0162, 466),
    (73, '2615.10.90', 0.0716, 400),
    (73, '7211.90.90', 0.0083, 3133),
    (73, '7307.21.00', 0.0, 400),
    (73, '9306.90.90', 0.0079, 400),
    (73, '9701.21.00', 0.0213, 13327),
    (73, '3306.90.00', 0.0015, 1720),
    (73, '7508.90.10', 0.059, 400),
    (73, '8421.99.91', 0.034, 5209),
    (73, '6104.59.00', 0.0143, 11559),
    (73, '2831.10.19', 0.0011, 2176),
    (73, '8422.30.23', 0.0091, 5658),
    (73, '0304.95.00', 0.009, 12668),
    (73, '8525.89.21', 0.0097, 4652),
    (73, '4811.51.10', 0.0408, 4716),
    (73, '8422.90.10', 0.0036, 2168),
    (73, '8455.22.90', 0.0004, 400),
    (73, '8443.99.80', 0.0015, 400),
    (73, '6306.30.90', 0.0181, 13217),
    (73, '2926.30.11', 0.0141, 2215);

INSERT INTO relatorio_serv VALUES
    (73, '1.0403.90.00', '2022-02-08T13:33:00', 0.1458),
    (73, '1.2203.10.00', '2022-02-16T00:26:56', 0.0046),
    (73, '1.1509.00.00', '2022-02-23T21:02:01', 0.0027);

INSERT INTO relatorio VALUES
    (74, '2021-06-27', '2022-12-11', '39.605.871', '0001-83', '37.669.280/0001-29', 'Emissões em microempresas', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (74, '5210.39.00', 0.028, 2915),
    (74, '2918.19.43', 0.0074, 843),
    (74, '0105.13.00', 0.0745, 1021),
    (74, '8711.10.00', 0.0008, 400),
    (74, '0712.90.20', 0.0116, 4228),
    (74, '0307.82.00', 0.1232, 400),
    (74, '2827.39.91', 0.0215, 400),
    (74, '2807.00.20', 0.0099, 3598),
    (74, '8529.10.90', 0.0399, 7183),
    (74, '8419.89.19', 0.0092, 400),
    (74, '7209.16.00', 0.0091, 8281),
    (74, '2832.10.10', 0.0182, 10784),
    (74, '2530.90.90', 0.0932, 447),
    (74, '6909.12.30', 0.0185, 4331),
    (74, '9027.89.11', 0.0391, 400),
    (74, '6104.51.00', 0.0071, 6523),
    (74, '8903.12.00', 0.009, 400),
    (74, '2921.11.32', 0.0473, 17913),
    (74, '0304.75.00', 0.0438, 815),
    (74, '8607.29.00', 0.0379, 15171),
    (74, '8517.62.14', 0.2035, 2015),
    (74, '5510.30.1', 0.0108, 400),
    (74, '2939.11.10', 0.0331, 400),
    (74, '0401.10.10', 0.1175, 3011),
    (74, '8440.90.00', 0.039, 6931),
    (74, '8414.80.21', 0.0104, 400),
    (74, '8716.80.00', 0.0236, 400);

INSERT INTO relatorio_serv VALUES
    (74, '1.0301.2', '2021-07-06T16:40:16', 0.0386),
    (74, '1.0504.23.00', '2021-07-21T23:43:28', 0.1329),
    (74, '1.0701.00.00', '2021-07-18T05:17:31', 0.2751);

INSERT INTO relatorio VALUES
    (75, '2024-12-25', '2026-03-07', '56.738.014', '0001-69', '58.826.745/0001-34', 'Emissões a alto nível', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (75, '5207.10.00', 0.0408, 5874),
    (75, '9028.90.10', 0.0239, 7557),
    (75, '3915.20.00', 0.1058, 400);

INSERT INTO relatorio_serv VALUES
    (75, '1.0910.90.00', '2025-01-06T00:51:29', 0.095),
    (75, '1.1405.22.00', '2025-01-07T00:56:15', 0.3768),
    (75, '1.1409.23.00', '2025-01-27T16:28:21', 0.4602),
    (75, '1.2502.30.00', '2025-01-09T21:41:42', 0.1017),
    (75, '1.0903.31.00', '2025-01-08T09:06:38', 0.093),
    (75, '1.1302.22.00', '2025-01-14T07:18:18', 0.1001),
    (75, '1.1410.90.00', '2025-01-04T10:03:11', 0.1623),
    (75, '1.0103.42.00', '2025-01-13T17:41:46', 0.1376),
    (75, '1.1805.22.00', '2025-01-22T20:36:30', 0.02),
    (75, '1.0502.14.40', '2025-01-17T15:31:22', 0.3236),
    (75, '1.1106.20.00', '2025-01-03T12:27:01', 0.5234),
    (75, '1.0505', '2025-01-22T11:45:50', 0.3632),
    (75, '1.2003', '2025-01-27T16:05:21', 0.1839);

INSERT INTO relatorio VALUES
    (76, '2025-10-12', NULL, '18.024.935', '0001-76', '37.669.280/0001-29', 'Emissões em microempresas', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (76, '5211.20.90', 1.9139, 5988),
    (76, '3907.99.92', 0.0663, 8335),
    (76, '8536.90.90', 0.0039, 3241),
    (76, '0301.99.9', 0.066, 9084),
    (76, '5407.93.00', 0.0555, 965),
    (76, '6005.37.00', 0.0104, 11861),
    (76, '2922.19.3', 0.0167, 8609),
    (76, '2921.51.39', 0.0873, 11108),
    (76, '2916.31.21', 0.0957, 1172),
    (76, '0307.71.00', 0.1677, 6336),
    (76, '2937.23.21', 0.0877, 1735),
    (76, '8204.20.00', 0.1207, 400),
    (76, '0102.29.1', 0.0958, 400),
    (76, '2934.99.29', 0.0082, 6578),
    (76, '8210.00.10', 0.0912, 400),
    (76, '5402.51.10', 0.0066, 656),
    (76, '2826.12.00', 0.0638, 5861),
    (76, '1702.20.00', 0.0607, 7397),
    (76, '2913.00.10', 0.0884, 5886),
    (76, '9508.23.00', 0.0554, 8140),
    (76, '6903.90.91', 0.0107, 400),
    (76, '6115.10.92', 0.0104, 9703);

INSERT INTO relatorio_serv VALUES
    (76, '1.2201', '2025-11-27T01:52:15', 0.5602),
    (76, '1.1706.2', '2025-11-29T16:06:20', 0.0002),
    (76, '1.1102.90.00', '2025-11-20T14:17:42', 0.0038);

INSERT INTO relatorio VALUES
    (77, '2026-03-27', NULL, '48.603.715', '0001-45', '54.777.163/0001-46', 'Andamento das metas da ONU', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (77, '7405.00.00', 0.0315, 8447),
    (77, '0102.31.90', 0.0572, 4855),
    (77, '8403.10.90', 0.2512, 3514),
    (77, '6505.00.32', 0.1526, 5964),
    (77, '8702.20.00', 0.2079, 2576),
    (77, '2930.20.23', 0.0777, 6170),
    (77, '2922.19.2', 0.1459, 3201),
    (77, '4408.10.91', 0.0932, 6627),
    (77, '2933.39.36', 0.0213, 1454),
    (77, '2843.29.10', 0.1328, 6143),
    (77, '7010.10.00', 0.104, 4640),
    (77, '8517.62.65', 0.1262, 3571),
    (77, '8708.50.9', 0.0246, 5939),
    (77, '8704.32.90', 0.0649, 4154);

INSERT INTO relatorio_serv VALUES
    (77, '1.2302.21.00', '2026-04-14T20:00:26', 0.0434),
    (77, '1.0605.10.00', '2026-04-18T22:37:44', 0.3249),
    (77, '1.0502.11.10', '2026-04-14T08:53:06', 0.8772),
    (77, '1.1403.21.20', '2026-04-18T12:28:08', 0.0636),
    (77, '1.2301.13.00', '2026-04-21T16:08:33', 0.1729),
    (77, '1.1001.11.00', '2026-04-24T13:16:53', 0.1367);

INSERT INTO relatorio VALUES
    (78, '2022-02-06', NULL, '56.738.014', '0001-69', '58.826.745/0001-34', 'Impacto das técnicas de produção em emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (78, '0304.63.00', 0.0166, 5969),
    (78, '7407.10.10', 0.0114, 8957),
    (78, '8413.91.90', 0.0135, 400);

INSERT INTO relatorio_serv VALUES
    (78, '1.0105.50.00', '2022-03-22T05:10:40', 0.1551),
    (78, '1.2404.11.00', '2022-03-16T01:41:18', 0.1301),
    (78, '1.1701.29.00', '2022-03-16T23:46:59', 0.0781),
    (78, '1.1201', '2022-03-01T14:31:04', 0.0849),
    (78, '1.1409.12.00', '2022-03-04T18:14:07', 0.1906),
    (78, '1.1504.00.00', '2022-03-11T07:14:30', 0.0527),
    (78, '1.2302', '2022-03-15T05:21:15', 0.1545),
    (78, '1.1405.21.00', '2022-03-19T08:16:43', 0.0984),
    (78, '1.1805.2', '2022-03-11T21:00:58', 0.0716),
    (78, '1.1404.22.00', '2022-03-01T08:58:08', 0.1312),
    (78, '1.0504.90.00', '2022-03-28T02:09:00', 0.2695),
    (78, '1.0504.45.90', '2022-03-04T17:15:11', 0.2522),
    (78, '1.0502.33.10', '2022-03-06T16:52:37', 0.0328),
    (78, '1.0102.35', '2022-03-22T13:44:34', 0.0836),
    (78, '1.1106.36', '2022-03-23T09:38:40', 0.132),
    (78, '1.0301.10.00', '2022-03-11T02:27:34', 0.137),
    (78, '1.0501.14.52', '2022-03-12T10:43:01', 0.1846),
    (78, '1.1409', '2022-03-20T09:11:10', 0.072),
    (78, '1.19', '2022-03-12T04:12:36', 0.0493),
    (78, '1.1509.00.00', '2022-03-20T12:01:26', 0.139),
    (78, '1.1806.8', '2022-03-30T19:04:15', 0.3257),
    (78, '1.0905.1', '2022-03-23T16:01:09', 0.0431),
    (78, '1.1105.10.00', '2022-03-08T05:27:45', 0.1392),
    (78, '1.0608.30.00', '2022-03-23T02:49:43', 0.0266),
    (78, '1.0604.30.00', '2022-03-23T11:09:38', 0.179),
    (78, '1.1409.11.00', '2022-03-12T00:35:26', 0.149),
    (78, '1.0502.21.10', '2022-03-25T22:49:16', 0.0293);

INSERT INTO relatorio VALUES
    (79, '2021-10-22', NULL, '64.087.915', '0001-27', '37.669.280/0001-29', 'Pesquisa de campo em emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (79, '8446.30.20', 0.1687, 1837);

INSERT INTO relatorio_serv VALUES
    (79, '1.2303.00.00', '2021-11-05T01:51:23', 0.6432),
    (79, '1.1806.40.00', '2021-11-19T20:17:38', 0.0035),
    (79, '1.0906.1', '2021-11-24T10:43:57', 0.0146),
    (79, '1.0404', '2021-11-23T19:05:51', 0.0099),
    (79, '1.0502.34.59', '2021-11-11T03:29:38', 0.004),
    (79, '1.1201.31.00', '2021-11-22T00:28:49', 0.0008),
    (79, '1.0905.50.00', '2021-11-27T21:04:57', 0.0162),
    (79, '1.0903.37.00', '2021-11-11T16:43:51', 0.024),
    (79, '1.0506.00.00', '2021-11-06T10:13:49', 0.1246),
    (79, '1.0502.34.30', '2021-11-19T10:19:18', 0.0838),
    (79, '1.1102.50.00', '2021-11-17T16:08:29', 0.0262),
    (79, '1.1402.90.00', '2021-11-04T12:45:54', 0.0863),
    (79, '1.1806.63.00', '2021-11-10T11:01:13', 0.0588),
    (79, '1.1301', '2021-11-02T02:20:17', 0.0546),
    (79, '1.0901.21.00', '2021-11-04T10:33:12', 0.0053),
    (79, '1.0501.22', '2021-11-20T20:03:44', 0.05),
    (79, '1.0910.90.00', '2021-11-27T15:06:12', 0.0274),
    (79, '1.1106.41.00', '2021-11-03T18:43:52', 0.009),
    (79, '1.1202.20.00', '2021-11-28T12:51:42', 0.0248),
    (79, '1.0904.2', '2021-11-13T13:34:02', 0.001),
    (79, '1.0102.6', '2021-11-26T07:33:36', 0.002),
    (79, '1.0901.51.21', '2021-11-11T09:29:40', 0.0091),
    (79, '1.1703.10.00', '2021-11-12T10:14:00', 0.0163),
    (79, '1.0401.11.19', '2021-11-21T02:47:35', 0.0415),
    (79, '1.1412.00.00', '2021-11-10T05:49:15', 0.0037),
    (79, '1.2404.19.00', '2021-11-06T07:47:26', 0.0141),
    (79, '1.1406.12.00', '2021-11-22T12:57:20', 0.0999),
    (79, '1.1801.12.00', '2021-11-03T03:48:14', 0.0214),
    (79, '1.1501', '2021-11-18T13:47:47', 0.0522),
    (79, '1.2002.40.00', '2021-11-04T22:41:47', 0.0036),
    (79, '1.0502.23.10', '2021-11-22T10:31:40', 0.1366),
    (79, '1.1803.21.00', '2021-11-21T09:48:44', 0.0009);

INSERT INTO relatorio VALUES
    (80, '2025-04-11', '2025-06-19', '48.603.715', '0001-45', '54.777.163/0001-46', 'O capitalismo como motor da exploração dos recursos naturais', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (80, '8419.90.31', 0.1166, 400),
    (80, '2105.00.10', 0.0315, 11396),
    (80, '4806.20.00', 0.092, 400),
    (80, '2302.10.00', 0.0091, 400),
    (80, '3212.90.90', 0.2628, 10868),
    (80, '8703.70.00', 0.0408, 6555),
    (80, '7419.80.10', 0.0129, 12703),
    (80, '6003.30.00', 0.0223, 400),
    (80, '2921.19.1', 0.0929, 1199),
    (80, '2924.29.11', 0.0361, 2497),
    (80, '8438.50.00', 0.0352, 4318),
    (80, '3811.90.10', 0.1072, 7139),
    (80, '4704.11.00', 0.0416, 400);

INSERT INTO relatorio_serv VALUES
    (80, '1.0404', '2025-05-15T07:59:20', 0.0093),
    (80, '1.1001.30.00', '2025-05-08T20:48:03', 0.0257),
    (80, '1.0101.12.00', '2025-05-28T21:37:53', 0.0404),
    (80, '1.1706.12.00', '2025-05-20T07:25:16', 0.0148),
    (80, '1.1405.2', '2025-05-09T03:29:41', 0.0231),
    (80, '1.1001.11.00', '2025-05-05T15:02:55', 0.098),
    (80, '1.1106.43.00', '2025-05-09T03:55:48', 0.0909),
    (80, '1.0901.39.00', '2025-05-17T06:32:42', 0.0193),
    (80, '1.0303.90.00', '2025-05-08T00:08:44', 0.0306),
    (80, '1.1409.24.00', '2025-05-15T09:07:55', 0.0545),
    (80, '1.2205', '2025-05-24T05:02:40', 0.041),
    (80, '1.0905.12.00', '2025-05-26T19:29:56', 0.0238);

INSERT INTO relatorio VALUES
    (81, '2026-01-08', '2026-06-02', '12.905.674', '0001-18', '54.777.163/0001-46', 'Andamento das metas da ONU', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (81, '6104.19.10', 0.0177, 8125),
    (81, '7208.10.00', 0.0583, 400),
    (81, '3808.92.94', 0.1075, 400),
    (81, '7011.10.90', 0.044, 400),
    (81, '3813.00.10', 0.1129, 400),
    (81, '7901.12.10', 0.0283, 11346),
    (81, '7605.29.90', 0.0581, 11140),
    (81, '9018.39.21', 0.1533, 7407),
    (81, '2926.20.00', 0.0251, 3527),
    (81, '3004.49.50', 0.0702, 4626),
    (81, '2827.39.97', 0.04, 1363),
    (81, '8473.40.10', 0.0082, 11529),
    (81, '0709.56.00', 0.0634, 10557),
    (81, '2941.10.39', 0.0256, 11420),
    (81, '3506.91.10', 0.036, 5803),
    (81, '8513.90.00', 0.0217, 4442),
    (81, '7409.40.90', 0.0582, 3010),
    (81, '2934.99.15', 0.1511, 4899),
    (81, '8501.10.19', 0.219, 1264),
    (81, '2926.30.20', 0.0326, 400),
    (81, '2922.39.21', 0.0123, 1053),
    (81, '6005.21.00', 0.0449, 2154),
    (81, '0301.99.11', 0.1293, 5592),
    (81, '0710.29.00', 0.0578, 2495),
    (81, '3906.90.22', 0.0461, 5222);

INSERT INTO relatorio_serv VALUES
    (81, '1.0106.13.00', '2026-02-24T22:43:31', 0.0711),
    (81, '1.2201.1', '2026-02-09T03:47:27', 0.0203),
    (81, '1.0102.42.20', '2026-02-25T02:16:01', 0.2191);

INSERT INTO relatorio VALUES
    (82, '2025-12-08', '2026-03-10', '88.635.333', '0001-98', '87.888.161/0001-65', 'Impacto de atividades agropecuárias na Amazônia', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (82, '8481.80.2', 0.1379, 11011),
    (82, '6004.10.14', 0.0806, 10621),
    (82, '2917.19.2', 0.4317, 6747),
    (82, '8460.40.11', 0.3976, 2257),
    (82, '2930.90.19', 0.0935, 6888),
    (82, '9027.89.13', 0.2646, 8560),
    (82, '4802.57.91', 0.1209, 400),
    (82, '8806.22.00', 0.0166, 510),
    (82, '3827.69.00', 0.0071, 400),
    (82, '2715.00.00', 0.2182, 2673),
    (82, '5509.11.00', 0.1024, 11714),
    (82, '2915.39.55', 0.06, 400),
    (82, '2530.90.90', 0.1197, 5673),
    (82, '2939.69.19', 0.2843, 5763),
    (82, '8304.00.00', 0.0485, 10560),
    (82, '2930.90.4', 0.1724, 7437),
    (82, '3917.32.51', 0.042, 6963),
    (82, '2914.79.1', 0.2442, 400),
    (82, '2606.00.1', 0.252, 400),
    (82, '9506.51.00', 0.1158, 4494),
    (82, '6401.99.10', 0.4065, 6176),
    (82, '8456.11.90', 0.2124, 400),
    (82, '8708.70.90', 0.1886, 3587),
    (82, '1602.32.20', 0.1554, 2162),
    (82, '8504.40.10', 0.124, 7980),
    (82, '8433.60.90', 0.0781, 2761),
    (82, '8544.42.00', 0.0777, 3679);

INSERT INTO relatorio_serv VALUES
    (82, '1.0901.90.00', '2026-01-07T16:41:01', 0.1531);

INSERT INTO relatorio VALUES
    (83, '2025-02-18', '2025-09-09', '51.360.297', '0001-43', '11.679.309/0001-01', 'Análise de emissões em São Paulo na última década', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (83, '5402.32.19', 0.1976, 400),
    (83, '2935.90.95', 0.1803, 400),
    (83, '3003.10.13', 0.1236, 400),
    (83, '2933.39.2', 0.136, 400),
    (83, '5206.23.00', 0.1334, 438),
    (83, '0305.69.90', 0.0571, 5195),
    (83, '0103.10.00', 0.418, 5638);

INSERT INTO relatorio_serv VALUES
    (83, '1.1304.00.00', '2025-03-12T08:08:57', 0.3609),
    (83, '1.0502.1', '2025-03-20T14:13:54', 0.2686),
    (83, '1.2201.19.00', '2025-03-01T00:15:14', 0.2634),
    (83, '1.0602', '2025-03-30T04:23:24', 0.046),
    (83, '1.2003.10.00', '2025-03-29T09:22:26', 0.0365),
    (83, '1.0901.51.16', '2025-03-10T21:06:39', 0.2252),
    (83, '1.0903.21.00', '2025-03-06T11:42:06', 0.0386),
    (83, '1.1108.90.00', '2025-03-17T23:49:13', 0.212);

INSERT INTO relatorio VALUES
    (84, '2023-06-22', '2026-04-07', '48.603.715', '0001-45', '53.396.825/0001-34', 'Formas de reduzir o impacto de emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (84, '6813.20.00', 0.2147, 400),
    (84, '8434.10.00', 0.0676, 2185),
    (84, '2517.10.00', 0.2531, 5473),
    (84, '2836.30.00', 0.0756, 1012),
    (84, '4810.32.90', 0.0305, 4190),
    (84, '8207.60.00', 0.0161, 7205),
    (84, '9508.10.00', 0.2224, 400),
    (84, '8712.00.90', 0.2632, 5052),
    (84, '8423.10.00', 0.1936, 3591),
    (84, '9001.10.20', 0.0505, 7140),
    (84, '8504.40.40', 0.1083, 400),
    (84, '9201.20.00', 0.1105, 400),
    (84, '3006.30.18', 0.2721, 400),
    (84, '0305.32.30', 0.0394, 9516);

INSERT INTO relatorio_serv VALUES
    (84, '1.2405', '2023-07-15T05:30:44', 0.0317),
    (84, '1.0501.39.00', '2023-07-14T03:25:13', 0.6177),
    (84, '1.2404.32.00', '2023-07-23T17:46:37', 0.5757),
    (84, '1.1405.30.00', '2023-07-07T10:19:02', 0.3185),
    (84, '1.0904.2', '2023-07-16T05:53:56', 0.5672);

INSERT INTO relatorio VALUES
    (85, '2022-04-27', '2023-10-05', '88.635.333', '0001-98', '09.850.333/0001-77', 'Emissões: e eu com isso?', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (85, '3911.90.24', 0.3104, 6687),
    (85, '8421.99.9', 0.3743, 400),
    (85, '0303.24.10', 0.4725, 6360),
    (85, '0304.92.12', 0.1712, 8381),
    (85, '8112.69.00', 0.5613, 400),
    (85, '9031.20.90', 0.8394, 11349),
    (85, '9608.91.00', 0.471, 4776),
    (85, '1214.90.00', 0.8061, 400);

INSERT INTO relatorio VALUES
    (86, '2024-03-13', '2026-01-27', '48.912.037', '0001-48', '37.669.280/0001-29', 'Pesquisa de campo em emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (86, '8801.00.00', 1.2342, 400),
    (86, '5514.30.19', 0.0021, 1480),
    (86, '3808.91.9', 0.0056, 400),
    (86, '3803.00.90', 0.2247, 2315),
    (86, '2403.19.00', 0.0064, 3253),
    (86, '1602.50.00', 0.0945, 400),
    (86, '2306.50.00', 0.0979, 1627),
    (86, '3002.42.70', 0.0047, 4132),
    (86, '9113.10.00', 0.052, 7309),
    (86, '2903.77.34', 0.0857, 10730),
    (86, '8502.11.90', 0.0394, 2752),
    (86, '8504.50.90', 0.0601, 8010),
    (86, '8521.90.00', 0.0177, 11652),
    (86, '5401.10.12', 0.0817, 6452),
    (86, '6204.39.00', 0.0269, 400),
    (86, '3003.90.64', 0.1731, 400),
    (86, '8428.39.20', 0.0702, 6854),
    (86, '3307.90.00', 0.0241, 10468),
    (86, '3910.00.29', 0.0065, 2243),
    (86, '3003.90.4', 0.0015, 2019),
    (86, '2934.91.3', 0.0086, 400),
    (86, '8443.99.29', 0.0285, 983);

INSERT INTO relatorio VALUES
    (87, '2022-10-06', '2023-04-05', '27.401.593', '0001-66', '58.826.745/0001-34', 'Impacto das técnicas de produção em emissões', NULL, NULL, NULL);

INSERT INTO relatorio_serv VALUES
    (87, '1.1404.43.00', '2022-11-04T21:32:14', 2.9455),
    (87, '1.0502.33.10', '2022-11-21T00:38:19', 0.2624),
    (87, '1.1401.12.00', '2022-11-02T08:18:43', 0.5851),
    (87, '1.1506.22.00', '2022-11-20T16:50:43', 0.0021),
    (87, '1.0401.11', '2022-11-19T09:02:43', 0.2198),
    (87, '1.1406.11.00', '2022-11-06T05:03:26', 0.1854),
    (87, '1.0107.40.00', '2022-11-28T16:15:38', 0.0181),
    (87, '1.1401.18.00', '2022-11-18T08:32:59', 0.2081),
    (87, '1.1805.12.00', '2022-11-06T02:50:18', 0.1075),
    (87, '1.0102.52.20', '2022-11-29T22:06:51', 0.0395),
    (87, '1.1402.21.00', '2022-11-16T18:02:52', 0.1743),
    (87, '1.1107.3', '2022-11-06T00:43:55', 0.0297),
    (87, '1.2205.13.00', '2022-11-15T20:38:52', 0.0791),
    (87, '1.0401.16.20', '2022-11-15T10:43:43', 0.059);

INSERT INTO relatorio VALUES
    (88, '2024-08-04', NULL, '48.603.715', '0001-45', '53.396.825/0001-34', 'Formas de reduzir o impacto de emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (88, '2901.22.00', 0.0846, 400),
    (88, '8414.80.33', 0.0333, 9845),
    (88, '8802.30.29', 0.0512, 1584),
    (88, '6506.99.00', 0.2328, 1682),
    (88, '0303.32.00', 0.0301, 4726),
    (88, '8479.89.40', 0.0611, 5926),
    (88, '3004.49.10', 0.087, 400),
    (88, '0302.99.00', 0.0406, 2927),
    (88, '2924.29.41', 0.0574, 1058),
    (88, '3003.10.11', 0.0583, 2093),
    (88, '8473.50.10', 0.0861, 1748),
    (88, '9027.89.12', 0.0086, 9706),
    (88, '3402.90.29', 0.1216, 10646),
    (88, '5510.90.1', 0.0814, 8144);

INSERT INTO relatorio_serv VALUES
    (88, '1.0606.20.00', '2024-09-08T20:36:33', 0.0381),
    (88, '1.2203.20.00', '2024-09-27T14:47:03', 0.0238),
    (88, '1.2001.81.00', '2024-09-04T07:59:44', 0.2089),
    (88, '1.1402.31.00', '2024-09-21T12:50:40', 0.0836),
    (88, '1.1103.4', '2024-09-26T14:39:11', 0.1548),
    (88, '1.0602.90.00', '2024-09-02T05:32:21', 0.304);

INSERT INTO relatorio VALUES
    (89, '2022-05-27', '2023-12-22', '28.659.130', '0001-07', '37.669.280/0001-29', 'Pesquisa de campo em emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (89, '1604.17.00', 0.0629, 400),
    (89, '5501.30.00', 0.1178, 400),
    (89, '2824.90.10', 0.2577, 400);

INSERT INTO relatorio_serv VALUES
    (89, '1.0401.19.00', '2022-06-23T13:01:22', 0.1816),
    (89, '1.0609.00.00', '2022-06-14T04:33:24', 0.0339),
    (89, '1.0903.35.00', '2022-06-07T17:23:04', 0.178),
    (89, '1.0401.49.00', '2022-06-14T08:29:56', 0.2793),
    (89, '1.1805.23.00', '2022-06-17T22:01:44', 0.0542),
    (89, '1.1201.19.00', '2022-06-25T07:18:01', 0.2128),
    (89, '1.1404.19.00', '2022-06-06T06:08:38', 0.1263),
    (89, '1.0501.12', '2022-06-16T20:36:43', 0.1733),
    (89, '1.1702.2', '2022-06-01T15:57:50', 0.0827),
    (89, '1.1403.22.12', '2022-06-06T06:09:13', 0.2171),
    (89, '1.0903.37.00', '2022-06-28T06:00:58', 0.0645),
    (89, '1.0901.29.00', '2022-06-24T15:02:29', 0.1764),
    (89, '1.2404.13.00', '2022-06-05T12:47:13', 0.053),
    (89, '1.0901.35.00', '2022-06-25T14:23:56', 0.1082),
    (89, '1.1001.2', '2022-06-29T19:38:58', 0.0785),
    (89, '1.0102', '2022-06-03T20:36:08', 0.2697);

INSERT INTO relatorio VALUES
    (90, '2023-08-21', NULL, '53.921.807', '0001-18', '37.669.280/0001-29', 'Pesquisa de campo em emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (90, '2933.91.6', 0.8868, 4273);

INSERT INTO relatorio_serv VALUES
    (90, '1.1103.39.00', '2023-09-12T15:58:03', 0.0205),
    (90, '1.1402.32.00', '2023-09-19T07:11:00', 0.1729),
    (90, '1.0502.2', '2023-09-13T20:07:37', 0.3489),
    (90, '1.0801', '2023-09-20T11:13:58', 0.2622),
    (90, '1.2002.20.00', '2023-09-23T01:09:51', 0.6806),
    (90, '1.1409.2', '2023-09-19T23:13:24', 0.8543),
    (90, '1.1409.12.00', '2023-09-28T12:10:36', 0.1596),
    (90, '1.1901', '2023-09-04T19:50:06', 0.0581),
    (90, '1.1103.31.00', '2023-09-05T09:41:06', 0.1853),
    (90, '1.1105.30.00', '2023-09-21T08:29:13', 0.0517),
    (90, '1.1101.20.00', '2023-09-02T04:11:53', 0.0857),
    (90, '1.1403.22.22', '2023-09-13T22:27:29', 0.2145),
    (90, '1.0304', '2023-09-18T07:27:38', 0.2432),
    (90, '1.0403.22.00', '2023-09-19T22:29:28', 0.1386),
    (90, '1.2501.11.00', '2023-09-07T01:59:49', 0.2103),
    (90, '1.0301.39.00', '2023-09-28T04:47:59', 0.1495);

INSERT INTO relatorio VALUES
    (91, '2023-07-15', '2024-11-24', '01.274.895', '0001-40', '11.679.309/0001-01', 'Análise de emissões em São Paulo na última década', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (91, '0302.53.00', 0.0081, 12130);

INSERT INTO relatorio_serv VALUES
    (91, '1.1806.6', '2023-08-17T11:21:55', 0.0648),
    (91, '1.0501.22.30', '2023-08-14T11:51:54', 0.0259),
    (91, '1.0501.14.20', '2023-08-09T06:23:48', 0.0422),
    (91, '1.1706', '2023-08-03T21:14:03', 0.1283),
    (91, '1.2002.10.00', '2023-08-11T20:56:21', 0.126),
    (91, '1.0801', '2023-08-24T19:42:20', 0.0376),
    (91, '1.0402.12.00', '2023-08-06T21:00:55', 0.0311),
    (91, '1.2001.31.10', '2023-08-05T06:12:01', 0.0798),
    (91, '1.1302', '2023-08-23T21:09:59', 0.1119),
    (91, '1.1401.39.00', '2023-08-19T03:17:49', 0.1212),
    (91, '1.1803.2', '2023-08-28T07:49:51', 0.0492),
    (91, '1.1701.3', '2023-08-05T20:57:48', 0.0714),
    (91, '1.0403.21.20', '2023-08-22T14:08:01', 0.0711),
    (91, '1.0503.2', '2023-08-28T08:16:11', 0.0052),
    (91, '1.0904.39.00', '2023-08-11T12:06:40', 0.0837),
    (91, '1.2003', '2023-08-06T08:26:08', 0.0997),
    (91, '1.1403.10.00', '2023-08-22T03:57:45', 0.0929),
    (91, '1.0102.61.00', '2023-08-15T04:13:00', 0.0518),
    (91, '1.1402.14.00', '2023-08-06T18:34:16', 0.0366),
    (91, '1.0501.32.00', '2023-08-06T05:47:36', 0.1166),
    (91, '1.1403.22.13', '2023-08-27T16:52:34', 0.0697),
    (91, '1.1703.10.00', '2023-08-22T00:54:30', 0.0287),
    (91, '1.0502.32.30', '2023-08-25T16:06:59', 0.0826),
    (91, '1.0401.11.1', '2023-08-26T16:16:16', 0.2808),
    (91, '1.1103.36.10', '2023-08-19T13:05:41', 0.0032),
    (91, '1.0905.80.00', '2023-08-08T07:07:55', 0.1104),
    (91, '1.1409.12.00', '2023-08-11T09:10:47', 0.0633),
    (91, '1.0502.22.30', '2023-08-20T06:50:26', 0.0402),
    (91, '1.1104.10.00', '2023-08-28T03:58:17', 0.1079),
    (91, '1.0504.45', '2023-08-11T10:32:30', 0.0352),
    (91, '1.0402', '2023-08-03T01:52:56', 0.0023),
    (91, '1.0403.11.90', '2023-08-04T13:47:49', 0.0842),
    (91, '1.1801.22.00', '2023-08-08T01:57:12', 0.0436),
    (91, '1.0502.34.30', '2023-08-13T12:30:26', 0.1632),
    (91, '1.2405.11.00', '2023-08-14T03:22:12', 0.1034),
    (91, '1.2205.1', '2023-08-24T14:34:43', 0.0541),
    (91, '1.1406.12.00', '2023-08-09T03:26:46', 0.0334),
    (91, '1.1403', '2023-08-09T00:52:04', 0.0239),
    (91, '1.0102.6', '2023-08-08T16:23:53', 0.1038);

INSERT INTO relatorio VALUES
    (92, '2022-03-15', '2022-09-23', '13.690.872', '0001-09', '53.396.825/0001-34', 'Formas de reduzir o impacto de emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (92, '1103.19.00', 0.492, 8842),
    (92, '5501.90.00', 0.0206, 5926),
    (92, '7406.10.20', 0.1864, 5213),
    (92, '1207.30.10', 1.3549, 3671),
    (92, '2934.91.33', 0.4931, 11633),
    (92, '3002.49.92', 0.3739, 8441),
    (92, '2939.11.61', 0.2909, 400),
    (92, '1212.94.00', 0.3461, 10875),
    (92, '2918.29.29', 0.3147, 4333),
    (92, '7116.20.90', 1.5511, 7826),
    (92, '8501.52.20', 0.2779, 9412),
    (92, '2808.00.20', 0.1982, 1719),
    (92, '3920.10.99', 0.8416, 400),
    (92, '7612.90.12', 0.5584, 1649),
    (92, '2204.29.20', 0.1384, 3962),
    (92, '5516.13.00', 1.169, 3439);

INSERT INTO relatorio_serv VALUES
    (92, '1.0901.52.90', '2022-04-20T05:45:11', 0.22),
    (92, '1.0901.51.1', '2022-04-06T22:20:52', 0.1674);

INSERT INTO relatorio VALUES
    (93, '2023-09-18', '2026-03-12', '51.360.297', '0001-43', '11.679.309/0001-01', 'Impacto de programas de incentivo fiscal na redução de emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (93, '7801.10.19', 0.487, 11122),
    (93, '2924.29.96', 1.2503, 10041),
    (93, '5208.51.00', 0.5865, 8352),
    (93, '7017.10.00', 0.6121, 11715),
    (93, '1201.90.00', 0.4717, 9122),
    (93, '5407.52.10', 0.0117, 1983),
    (93, '0101.30.00', 0.654, 4928),
    (93, '6004.10.91', 0.5607, 12328),
    (93, '7216.61.10', 0.2669, 2783),
    (93, '4818.90.90', 0.0636, 400),
    (93, '0306.16.90', 0.0308, 1179),
    (93, '0303.45.00', 0.0939, 4749),
    (93, '2933.33.51', 0.1233, 11103),
    (93, '8517.62.99', 0.0508, 7845);

INSERT INTO relatorio_serv VALUES
    (93, '1.1503.00.00', '2023-10-22T20:32:35', 0.4858),
    (93, '1.0504.90.00', '2023-10-15T02:50:55', 0.5723),
    (93, '1.2301.22.00', '2023-10-08T19:04:45', 0.3132),
    (93, '1.0401.16.20', '2023-10-23T21:05:05', 0.1393),
    (93, '1.2002.30.00', '2023-10-15T23:46:39', 0.2125),
    (93, '1.1101.90.00', '2023-10-20T18:57:46', 0.8012),
    (93, '1.0402.21.20', '2023-10-29T19:14:40', 0.5544);

INSERT INTO relatorio VALUES
    (94, '2024-07-26', '2024-10-05', '13.690.872', '0001-54', '53.396.825/0001-34', 'Formas de reduzir o impacto de emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (94, '3901.90.30', 0.0883, 11602),
    (94, '4811.59.22', 0.0213, 400),
    (94, '3003.20.93', 0.1455, 400),
    (94, '2852.10.25', 0.0204, 15933),
    (94, '6005.41.00', 0.0086, 13583),
    (94, '7212.50.10', 0.0701, 6743),
    (94, '8704.23.20', 0.0218, 9592),
    (94, '8711.40.00', 0.018, 14476),
    (94, '8456.90.00', 0.0123, 918),
    (94, '2909.49.32', 0.0552, 5158),
    (94, '1213.00.00', 0.0613, 5601),
    (94, '5308.20.00', 0.014, 400),
    (94, '8440.10.11', 0.0696, 400),
    (94, '8301.30.00', 0.0337, 15137),
    (94, '8514.40.00', 0.0273, 5079);

INSERT INTO relatorio_serv VALUES
    (94, '1.1401.1', '2024-08-16T02:45:59', 0.0521),
    (94, '1.2301.98.00', '2024-08-04T19:50:43', 0.0865),
    (94, '1.0604.30.00', '2024-08-09T05:00:14', 0.0088),
    (94, '1.1402.31.00', '2024-08-30T06:49:02', 0.0968),
    (94, '1.1806.63.00', '2024-08-01T06:03:29', 0.0175),
    (94, '1.0501.13.10', '2024-08-09T05:40:00', 0.2778),
    (94, '1.0401.23.00', '2024-08-23T19:17:20', 0.0751),
    (94, '1.0901.35.00', '2024-08-13T22:07:49', 0.0541),
    (94, '1.2301.12.00', '2024-08-15T21:50:58', 0.234),
    (94, '1.0902.20.00', '2024-08-19T04:59:34', 0.0769),
    (94, '1.0403.21', '2024-08-19T18:43:03', 0.0252),
    (94, '1.1806.8', '2024-08-05T10:57:42', 0.0375),
    (94, '1.2506.00.00', '2024-08-23T03:06:31', 0.0307);

INSERT INTO relatorio VALUES
    (95, '2022-03-12', '2025-11-21', '48.603.715', '0001-78', '53.396.825/0001-34', 'Formas de reduzir o impacto de emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (95, '8540.20.90', 0.0498, 6205),
    (95, '2934.20.33', 0.4239, 400),
    (95, '4104.11.23', 0.2872, 6311),
    (95, '9021.90.1', 0.2866, 8188),
    (95, '3813.00.90', 0.4619, 5506),
    (95, '1514.99.10', 1.1259, 400),
    (95, '3301.29.21', 0.2615, 5230),
    (95, '9706.90.00', 0.1809, 7459),
    (95, '2924.19.29', 1.5629, 15978),
    (95, '2932.19.10', 0.548, 1649),
    (95, '9021.39.11', 0.2439, 400),
    (95, '7204.50.00', 0.1399, 400),
    (95, '5911.32.00', 0.0808, 7227);

INSERT INTO relatorio_serv VALUES
    (95, '1.2003.24.00', '2022-04-09T04:10:38', 0.4883),
    (95, '1.0502.13', '2022-04-07T16:46:26', 0.1643),
    (95, '1.1404.44.00', '2022-04-15T00:45:10', 1.3357),
    (95, '1.0502.32.10', '2022-04-18T22:53:44', 0.4814),
    (95, '1.0502.22.30', '2022-04-18T11:50:31', 0.1878),
    (95, '1.0501.14.5', '2022-04-24T03:05:23', 0.0428),
    (95, '1.2501.40.00', '2022-04-22T16:56:19', 0.445),
    (95, '1.2508.00.00', '2022-04-03T05:07:39', 0.2646),
    (95, '1.1303', '2022-04-07T17:29:35', 0.4906),
    (95, '1.1706.21.00', '2022-04-01T07:51:18', 0.1142),
    (95, '1.0105.12.00', '2022-04-24T06:41:36', 0.1868),
    (95, '1.1403.21', '2022-04-29T16:07:51', 0.2836);

INSERT INTO relatorio VALUES
    (96, '2021-10-31', NULL, '75.893.062', '0001-33', '58.826.745/0001-34', 'Emissões e as metas da ONU', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (96, '8302.49.00', 0.1104, 400),
    (96, '8206.00.00', 0.0073, 2264),
    (96, '7304.29.31', 0.0529, 9418);

INSERT INTO relatorio_serv VALUES
    (96, '1.0107.60.00', '2021-11-05T05:23:05', 0.1725),
    (96, '1.2405.1', '2021-11-19T12:16:55', 0.1578),
    (96, '1.1402.14.00', '2021-11-21T01:24:44', 0.0098),
    (96, '1.21', '2021-11-02T09:01:02', 0.0326),
    (96, '1.1805.13.00', '2021-11-11T19:47:14', 0.0918),
    (96, '1.0502.34.20', '2021-11-14T13:31:52', 0.2455),
    (96, '1.1903.30.00', '2021-11-15T12:24:04', 0.0995),
    (96, '1.0905.13.00', '2021-11-09T12:00:42', 0.0543),
    (96, '1.0401.41.00', '2021-11-05T06:44:36', 0.0036),
    (96, '1.0103.20.00', '2021-11-15T12:13:15', 0.055),
    (96, '1.2403', '2021-11-18T10:09:03', 0.0524);

INSERT INTO relatorio VALUES
    (97, '2023-09-07', '2026-02-25', '33.738.001', '0001-77', '00.001.333/0001-99', 'Tipos de emissão em empresas de refinaria', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (97, '3824.99.85', 0.4575, 7283),
    (97, '2841.90.1', 3.6037, 7078),
    (97, '8487.10.00', 0.3137, 400),
    (97, '3003.90.1', 0.1778, 3741),
    (97, '6104.51.00', 0.2097, 2078),
    (97, '1701.91.00', 0.8864, 400),
    (97, '3817.00.10', 0.1752, 5913),
    (97, '2933.39.41', 0.8844, 9495);

INSERT INTO relatorio VALUES
    (98, '2023-05-04', NULL, '71.498.635', '0001-06', '11.679.309/0001-01', 'Impacto de programas de incentivo fiscal na redução de emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (98, '8711.10.00', 0.0044, 6380),
    (98, '4811.59.10', 0.0728, 877),
    (98, '7019.15.00', 0.0599, 8975),
    (98, '3003.90.11', 0.0644, 666),
    (98, '4012.90.90', 0.0937, 6885),
    (98, '2931.51.00', 0.0412, 400),
    (98, '2905.16.00', 0.0893, 7614),
    (98, '8480.20.00', 0.0037, 14309),
    (98, '0106.39.00', 0.0021, 2155),
    (98, '2909.41.00', 0.0162, 400),
    (98, '3921.19.00', 0.1781, 1005),
    (98, '2845.10.00', 0.0746, 7264),
    (98, '8467.19.00', 0.0858, 443),
    (98, '1901.10.20', 0.0535, 1403),
    (98, '7110.29.00', 0.0843, 3503),
    (98, '1205.90.10', 0.1345, 7801),
    (98, '7307.19.90', 0.0105, 4369),
    (98, '3909.10.00', 0.1255, 7974),
    (98, '8708.40.80', 0.2295, 7383),
    (98, '5603.12.40', 0.103, 13411),
    (98, '8443.32.99', 0.1044, 400),
    (98, '6115.29.90', 0.0574, 7607),
    (98, '2930.80.10', 0.1253, 6081),
    (98, '2933.53.72', 0.0849, 1585),
    (98, '2903.78.00', 0.0727, 400),
    (98, '7004.90.00', 0.0142, 5187);

INSERT INTO relatorio_serv VALUES
    (98, '1.0908.00.00', '2023-06-02T03:30:13', 0.3372),
    (98, '1.0502.11.30', '2023-06-19T14:03:49', 0.0826),
    (98, '1.1409.11.00', '2023-06-28T22:42:27', 0.0399),
    (98, '1.1501.20.00', '2023-06-27T07:06:59', 0.1065);

INSERT INTO relatorio VALUES
    (99, '2022-07-11', NULL, '01.274.895', '0001-13', '54.777.163/0001-46', 'Andamento das metas da ONU', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (99, '8461.40.10', 0.661, 4276),
    (99, '3806.30.00', 0.2026, 6846),
    (99, '6806.20.00', 0.3385, 2788),
    (99, '6001.10.90', 0.1309, 11819),
    (99, '6403.12.00', 0.4255, 8383),
    (99, '2921.43.23', 0.3655, 4214),
    (99, '9007.92.00', 0.0233, 8668),
    (99, '2930.30.2', 0.2677, 3558),
    (99, '8468.90.20', 0.0524, 2854),
    (99, '1903.00.00', 0.2625, 400),
    (99, '2931.59.95', 0.1963, 400),
    (99, '8455.90.00', 0.1153, 6576),
    (99, '4702.00.00', 0.5509, 400),
    (99, '7415.39.00', 0.0305, 2077),
    (99, '3004.50.90', 0.1414, 400),
    (99, '3204.13.00', 0.3082, 5796),
    (99, '3003.20.4', 1.0296, 400);

INSERT INTO relatorio_serv VALUES
    (99, '1.0501.12', '2022-08-07T20:53:30', 1.7275),
    (99, '1.1406.39.00', '2022-08-28T21:04:35', 0.2201);

INSERT INTO relatorio VALUES
    (100, '2025-01-26', '2025-04-03', '53.921.807', '0001-18', '54.777.163/0001-46', 'Andamento das metas da ONU', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (100, '3824.81.10', 0.0547, 6058),
    (100, '8501.40.11', 0.0229, 5641),
    (100, '8546.90.00', 0.0164, 11848);

INSERT INTO relatorio_serv VALUES
    (100, '1.0102.52', '2025-02-12T11:54:28', 0.0938),
    (100, '1.0402.12.00', '2025-02-23T18:53:15', 0.0131),
    (100, '1.0402.13.10', '2025-02-08T16:41:48', 0.0932),
    (100, '1.0102.42', '2025-02-22T00:44:40', 0.0047),
    (100, '1.2403.2', '2025-02-06T14:53:32', 0.0433),
    (100, '1.1506.21.00', '2025-02-03T01:01:16', 0.086),
    (100, '1.0403.3', '2025-02-02T14:45:32', 0.0976),
    (100, '1.1302.21.00', '2025-02-22T05:32:36', 0.1235),
    (100, '1.0401.16', '2025-02-09T19:53:33', 0.0366),
    (100, '1.1901.30.00', '2025-02-24T12:14:18', 0.0781),
    (100, '1.0501.11', '2025-02-18T20:42:35', 0.0218),
    (100, '1.1402.1', '2025-02-16T12:25:32', 0.007),
    (100, '1.1301.30.00', '2025-02-06T17:19:40', 0.0317),
    (100, '1.0105.70.00', '2025-02-27T06:32:38', 0.0736),
    (100, '1.1402.3', '2025-02-11T19:00:23', 0.0572),
    (100, '1.1103.42.00', '2025-02-16T17:56:43', 0.1014),
    (100, '1.1101.17.00', '2025-02-18T14:23:46', 0.0101),
    (100, '1.0502.13', '2025-02-18T13:41:43', 0.0144),
    (100, '1.0609.00.00', '2025-02-21T23:03:14', 0.0348),
    (100, '1.2504.21.00', '2025-02-11T22:43:16', 0.0093),
    (100, '1.1406.34.00', '2025-02-23T00:31:26', 0.0465),
    (100, '1.1410', '2025-02-07T03:04:32', 0.0363),
    (100, '1.0404.10.00', '2025-02-14T14:37:23', 0.1271),
    (100, '1.1805.39.00', '2025-02-25T12:54:38', 0.0486),
    (100, '1.1502', '2025-02-20T11:19:21', 0.0081),
    (100, '1.0203.00.00', '2025-02-23T21:24:02', 0.0183),
    (100, '1.1104', '2025-02-15T07:00:21', 0.0296),
    (100, '1.0401.23.00', '2025-02-27T01:11:03', 0.0165),
    (100, '1.1404.13.00', '2025-02-09T16:09:25', 0.0141),
    (100, '1.1401.2', '2025-02-25T19:43:40', 0.0259),
    (100, '1.1101.20.00', '2025-02-08T15:20:41', 0.0141),
    (100, '1.2501.33.00', '2025-02-03T16:16:39', 0.0647),
    (100, '1.1401.15.00', '2025-02-26T11:33:39', 0.0529),
    (100, '1.0504.42.00', '2025-02-20T05:41:43', 0.0147),
    (100, '1.1507.90.00', '2025-02-21T23:16:54', 0.0192);

INSERT INTO relatorio VALUES
    (101, '2025-03-27', NULL, '65.172.380', '0001-61', '53.396.825/0001-34', 'Formas de reduzir o impacto de emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (101, '8208.20.00', 0.85, 400),
    (101, '1207.40.90', 1.1184, 5853),
    (101, '2921.43.21', 0.7893, 400),
    (101, '1002.90.00', 1.34, 400),
    (101, '8419.40.90', 0.717, 15225),
    (101, '8442.50.00', 1.5574, 3669),
    (101, '0302.42.10', 2.1794, 8758),
    (101, '4008.21.00', 0.5828, 5710);

INSERT INTO relatorio_serv VALUES
    (101, '1.1201.1', '2025-04-11T14:01:47', 0.2997);

INSERT INTO relatorio VALUES
    (102, '2024-06-20', NULL, '33.738.001', '0001-77', '00.001.333/0001-99', 'Tipos de emissão em empresas de refinaria', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (102, '8482.91.19', 0.1299, 400),
    (102, '5210.32.00', 0.0079, 10346),
    (102, '8459.21.99', 0.0253, 5758),
    (102, '8419.90.40', 0.0072, 6244),
    (102, '7217.10.19', 0.0967, 12028),
    (102, '3004.39.39', 0.0632, 6126),
    (102, '2941.40.11', 0.0164, 602),
    (102, '8439.99.90', 0.0033, 400),
    (102, '5506.40.00', 0.007, 1566),
    (102, '5211.43.00', 0.034, 10761),
    (102, '2921.43.22', 0.0647, 7522),
    (102, '7205.29.90', 0.0405, 8692),
    (102, '9028.30.3', 0.0321, 400),
    (102, '2939.72.10', 0.0467, 5659),
    (102, '2922.19.99', 0.1163, 10670),
    (102, '7302.40.00', 0.017, 400),
    (102, '3203.00.11', 0.1193, 9305),
    (102, '8705.30.00', 0.0476, 4319),
    (102, '7218.99.00', 0.0182, 3191),
    (102, '7008.00.00', 0.0025, 15522),
    (102, '5407.71.00', 0.0366, 5185),
    (102, '0805.29.00', 0.0773, 5621),
    (102, '2903.79.19', 0.0419, 5789);

INSERT INTO relatorio_serv VALUES
    (102, '1.1107.20.00', '2024-07-17T22:02:00', 0.3998);

INSERT INTO relatorio VALUES
    (103, '2024-01-12', '2025-04-08', '79.821.563', '0001-99', '37.669.280/0001-29', 'Pesquisa de campo em emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (103, '5602.90.00', 0.3137, 400),
    (103, '4707.10.00', 0.0074, 12103),
    (103, '8479.89.2', 0.4128, 400),
    (103, '4202.92.00', 0.2086, 400),
    (103, '0304.31.00', 0.279, 1030),
    (103, '4811.90.1', 0.3054, 6518),
    (103, '2933.39.8', 0.1315, 8945),
    (103, '7409.29.00', 0.0287, 5832),
    (103, '0303.89.65', 0.1799, 10851),
    (103, '7302.40.00', 0.0462, 7076),
    (103, '8440.10.1', 0.1043, 438),
    (103, '9306.30.00', 0.1031, 3517),
    (103, '7210.61.00', 0.1241, 4597),
    (103, '0804.50.20', 0.0444, 6329),
    (103, '0703.10.29', 0.5433, 8602);

INSERT INTO relatorio_serv VALUES
    (103, '1.0602.23.00', '2024-02-07T13:07:07', 0.1293),
    (103, '1.1106', '2024-02-25T10:18:38', 0.1296),
    (103, '1.0602.33.00', '2024-02-09T00:24:38', 0.0991),
    (103, '1.0901.51.16', '2024-02-12T23:10:18', 0.2243),
    (103, '1.1402.12.00', '2024-02-10T14:04:14', 0.1908),
    (103, '1.0501.12.10', '2024-02-01T23:09:55', 0.3877),
    (103, '1.1001.90.00', '2024-02-17T16:42:03', 0.3449),
    (103, '1.1302', '2024-02-03T14:12:44', 0.1643),
    (103, '1.0501.24.22', '2024-02-22T17:01:54', 0.549),
    (103, '1.0904.40.00', '2024-02-08T23:07:45', 0.17),
    (103, '1.2301.13.00', '2024-02-21T21:58:39', 0.2468),
    (103, '1.0904.33.00', '2024-02-12T00:44:06', 0.0276);

INSERT INTO relatorio VALUES
    (104, '2024-10-22', '2025-04-23', '01.274.895', '0001-40', '11.679.309/0001-01', 'Impacto de programas de incentivo fiscal na redução de emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (104, '7304.29.10', 0.0255, 400),
    (104, '7304.23.90', 0.02, 6244),
    (104, '1401.10.00', 0.0311, 1928);

INSERT INTO relatorio_serv VALUES
    (104, '1.0504.23.00', '2024-11-06T16:33:35', 0.0113),
    (104, '1.0906', '2024-11-24T04:59:28', 0.0144),
    (104, '1.0903.34.00', '2024-11-08T00:14:16', 0.0016),
    (104, '1.0903.21.00', '2024-11-28T09:58:25', 0.0104),
    (104, '1.0602.32.00', '2024-11-10T14:24:25', 0.0042),
    (104, '1.0101.2', '2024-11-18T10:03:36', 0.0719),
    (104, '1.2405', '2024-11-18T01:46:39', 0.0602),
    (104, '1.0401.4', '2024-11-28T04:38:06', 0.0455),
    (104, '1.0402.13', '2024-11-21T15:23:21', 0.0238),
    (104, '1.1201.19.00', '2024-11-07T23:26:19', 0.0089),
    (104, '1.0501.29.00', '2024-11-24T11:22:04', 0.0653),
    (104, '1.2001.10.00', '2024-11-07T23:39:10', 0.0097),
    (104, '1.1404.30.00', '2024-11-01T18:42:02', 0.0649),
    (104, '1.0608.40.00', '2024-11-19T07:14:14', 0.0297),
    (104, '1.2403.11.00', '2024-11-18T13:41:15', 0.0038),
    (104, '1.0102.42.10', '2024-11-06T10:42:44', 0.0152),
    (104, '1.1408.11.00', '2024-11-18T19:49:52', 0.0181),
    (104, '1.1703.21.00', '2024-11-25T19:32:59', 0.0041),
    (104, '1.2001.34', '2024-11-05T04:31:14', 0.0696),
    (104, '1.0906.11.00', '2024-11-18T01:05:02', 0.0164),
    (104, '1.0403.13.90', '2024-11-02T13:23:46', 0.0006),
    (104, '1.1409.25.00', '2024-11-19T21:14:21', 0.0448),
    (104, '1.1101.17.00', '2024-11-11T19:46:45', 0.0228),
    (104, '1.1102.10.00', '2024-11-15T17:51:12', 0.0113),
    (104, '1.1105.41.00', '2024-11-09T11:14:52', 0.0172),
    (104, '1.0301.32.00', '2024-11-04T19:08:20', 0.0237),
    (104, '1.2003.22.00', '2024-11-15T07:50:33', 0.0035),
    (104, '1.0102.33.00', '2024-11-04T08:29:55', 0.0299),
    (104, '1.1805.24.00', '2024-11-15T03:49:56', 0.0188),
    (104, '1.0906.30.00', '2024-11-15T09:25:13', 0.026),
    (104, '1.0102.41.90', '2024-11-02T08:45:27', 0.0051),
    (104, '1.0501.15.00', '2024-11-29T07:41:14', 0.0007),
    (104, '1.0502.14.10', '2024-11-16T14:15:49', 0.0474),
    (104, '1.2504.2', '2024-11-12T08:13:29', 0.0095),
    (104, '1.0605.20.00', '2024-11-27T01:16:49', 0.0408);

INSERT INTO relatorio VALUES
    (105, '2022-09-17', NULL, '53.921.807', '0001-18', '58.826.745/0001-34', 'Impacto das técnicas de produção em emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (105, '8102.94.00', 0.8331, 10180);

INSERT INTO relatorio_serv VALUES
    (105, '1.0403.31.00', '2022-10-19T01:59:32', 0.242),
    (105, '1.2001.34.20', '2022-10-07T06:05:23', 0.3233),
    (105, '1.26', '2022-10-10T16:38:45', 0.1786),
    (105, '1.1106.10.00', '2022-10-16T20:08:57', 0.2512),
    (105, '1.0502.13.20', '2022-10-21T18:45:49', 0.5115),
    (105, '1.1106.36.10', '2022-10-06T20:24:37', 0.0716),
    (105, '1.0802.30.00', '2022-10-11T05:14:20', 0.0209),
    (105, '1.0101.2', '2022-10-26T14:49:06', 0.0457),
    (105, '1.0402.33.00', '2022-10-11T13:41:34', 0.3548),
    (105, '1.1103.29.00', '2022-10-02T08:44:02', 0.196),
    (105, '1.2501.2', '2022-10-04T23:02:18', 0.0068),
    (105, '1.0504.44.00', '2022-10-03T08:45:11', 0.046),
    (105, '1.0403.21.10', '2022-10-18T12:30:21', 0.1747),
    (105, '1.2302.23.00', '2022-10-19T03:28:35', 0.1321),
    (105, '1.0301.10.00', '2022-10-20T04:19:46', 0.2994),
    (105, '1.1403.22.14', '2022-10-07T05:48:07', 0.5458),
    (105, '1.2403.11.00', '2022-10-13T04:51:40', 0.011),
    (105, '1.0502.34.30', '2022-10-06T11:38:38', 0.1285),
    (105, '1.2505.90.00', '2022-10-15T00:55:21', 0.1677);

INSERT INTO relatorio VALUES
    (106, '2024-09-03', NULL, '88.635.333', '0001-98', '58.826.745/0001-34', 'Impacto das técnicas de produção em emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (106, '2710.19.1', 0.1392, 3952),
    (106, '1605.61.00', 0.2155, 9180),
    (106, '8409.91.1', 0.1062, 6334),
    (106, '9114.30.00', 0.1437, 13449),
    (106, '2926.20.00', 0.1559, 6197),
    (106, '8467.29.91', 0.1931, 5251),
    (106, '3912.20.2', 0.0869, 5505),
    (106, '5404.11.00', 0.0962, 3473),
    (106, '9406.90.10', 0.1193, 400),
    (106, '8420.10.10', 0.1585, 9254),
    (106, '2710.19.9', 0.0745, 400),
    (106, '7209.16.00', 0.0954, 7882),
    (106, '2934.92.00', 0.0759, 3888),
    (106, '0208.10.00', 0.1803, 4698),
    (106, '2827.49.19', 0.1683, 400),
    (106, '8544.30.00', 0.2125, 4806),
    (106, '7011.10.10', 0.1736, 1389),
    (106, '8902.00.90', 0.1455, 13687),
    (106, '3802.90.10', 0.6241, 5785),
    (106, '2827.39.93', 0.1942, 3097),
    (106, '3911.10.2', 0.1989, 400);

INSERT INTO relatorio_serv VALUES
    (106, '1.1806.8', '2024-10-16T11:25:13', 0.124),
    (106, '1.1404.12.00', '2024-10-10T23:34:55', 0.0672);

INSERT INTO relatorio VALUES
    (107, '2022-07-14', NULL, '48.912.037', '0001-48', '37.669.280/0001-29', 'Emissões em microempresas', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (107, '2807.00.20', 2.3347, 5072),
    (107, '2804.69.00', 0.1132, 1242),
    (107, '2925.11.00', 0.2133, 7616),
    (107, '7207.12.00', 0.0824, 1367),
    (107, '8471.30.12', 0.1331, 400),
    (107, '3204.18.90', 0.0329, 7032),
    (107, '3804.00.11', 0.0441, 10252),
    (107, '8448.39.1', 0.104, 3097),
    (107, '0909.21.00', 0.0593, 13125),
    (107, '5407.52.20', 0.0115, 582),
    (107, '8714.95.00', 0.0099, 9723),
    (107, '2939.44.00', 0.0541, 7367),
    (107, '3002.12.16', 0.0419, 13598),
    (107, '2927.00.29', 0.0014, 400),
    (107, '9101.11.00', 0.2166, 11333),
    (107, '8443.91.99', 0.1533, 16855),
    (107, '6104.22.00', 0.0638, 11707),
    (107, '2933.91.51', 0.0542, 4503),
    (107, '7312.90.00', 0.0107, 400),
    (107, '0210.12.00', 0.0746, 400),
    (107, '2918.29.90', 0.0032, 2293),
    (107, '6902.20.92', 0.0525, 4369),
    (107, '0710.80.00', 0.0751, 5066),
    (107, '9006.61.00', 0.0247, 8127),
    (107, '8517.62.91', 0.001, 6617),
    (107, '2903.79.39', 0.0157, 400),
    (107, '9018.50.90', 0.0173, 1296);

INSERT INTO relatorio_serv VALUES
    (107, '1.0503.2', '2022-08-16T22:41:20', 0.4191);

INSERT INTO relatorio VALUES
    (108, '2026-04-08', NULL, '79.821.563', '0001-43', '09.850.333/0001-77', 'Emissões: e eu com isso?', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (108, '6601.91.90', 2.7474, 6076),
    (108, '2905.19.11', 0.0363, 7532),
    (108, '0105.11.10', 0.0106, 1558),
    (108, '8448.32.11', 0.1018, 4521),
    (108, '8607.11.20', 0.1373, 11979),
    (108, '6910.10.00', 0.0752, 4720),
    (108, '8432.39.10', 0.0582, 2440),
    (108, '2924.29.92', 0.0149, 400),
    (108, '8703.32.10', 0.371, 400),
    (108, '2939.79.39', 0.0473, 12476),
    (108, '3507.90.1', 0.1802, 400),
    (108, '2933.99.4', 0.1263, 1200),
    (108, '8207.13.00', 0.0024, 4341),
    (108, '7210.70.10', 0.1375, 8141),
    (108, '8456.50.00', 0.0372, 2599),
    (108, '3209.90.19', 0.1336, 642),
    (108, '2932.95.00', 0.0908, 4833),
    (108, '8438.90.00', 0.0003, 400),
    (108, '8504.31.1', 0.0089, 400),
    (108, '2839.19.00', 0.0025, 2477);

INSERT INTO relatorio_serv VALUES
    (108, '1.1402.15.00', '2026-05-13T06:07:35', 1.3887),
    (108, '1.1002.10.00', '2026-05-08T06:26:26', 0.0133),
    (108, '1.1302.11.00', '2026-05-05T16:37:18', 0.0165);

INSERT INTO relatorio VALUES
    (109, '2026-01-05', '2026-06-14', '79.821.563', '0001-65', '37.669.280/0001-29', 'Pesquisa de campo em emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (109, '4601.99.00', 0.06, 6975),
    (109, '7214.30.00', 0.049, 6929),
    (109, '6112.11.00', 0.0291, 8460),
    (109, '8609.00.00', 0.0102, 400),
    (109, '2912.12.00', 0.0583, 400),
    (109, '8443.32.51', 0.1542, 7502),
    (109, '2921.42.29', 0.0053, 11341),
    (109, '8413.30.90', 0.1114, 950),
    (109, '7308.20.00', 0.0869, 5330),
    (109, '6006.31.20', 0.0356, 2607),
    (109, '6303.12.00', 0.0667, 2828),
    (109, '2917.39.50', 0.1026, 400),
    (109, '8709.90.00', 0.0934, 2142),
    (109, '7310.21.10', 0.0417, 400),
    (109, '4811.51.30', 0.0398, 7315),
    (109, '2852.10.19', 0.0217, 1768),
    (109, '8486.10.00', 0.1305, 3980),
    (109, '2916.14.90', 0.0291, 3634),
    (109, '3004.39.39', 0.0317, 3111),
    (109, '8482.50.10', 0.007, 2364),
    (109, '8517.71.20', 0.0741, 8104),
    (109, '0306.93.00', 0.086, 400),
    (109, '3808.94.22', 0.004, 11759),
    (109, '8448.39.11', 0.1865, 5385);

INSERT INTO relatorio_serv VALUES
    (109, '1.2003.25.20', '2026-02-23T05:12:24', 0.5905);

INSERT INTO relatorio VALUES
    (110, '2023-03-11', NULL, '64.087.915', '0001-27', '11.679.309/0001-01', 'Análise de emissões em São Paulo na última década', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (110, '8504.90.40', 0.2875, 400),
    (110, '2828.90.20', 0.0165, 1182);

INSERT INTO relatorio_serv VALUES
    (110, '1.02', '2023-04-22T17:12:37', 8.5519),
    (110, '1.2201.12.00', '2023-04-08T09:40:09', 0.1357),
    (110, '1.0502.22.10', '2023-04-08T12:40:58', 1.1098),
    (110, '1.1408.14.00', '2023-04-18T08:36:37', 0.5706),
    (110, '1.0901.52', '2023-04-03T14:42:40', 0.1552),
    (110, '1.2501.37.00', '2023-04-25T15:58:37', 0.7528),
    (110, '1.1705.20.00', '2023-04-07T10:06:56', 0.8554),
    (110, '1.0904.32.00', '2023-04-14T06:14:19', 0.9052),
    (110, '1.0601.90.00', '2023-04-15T11:19:21', 0.5121),
    (110, '1.2101.21.00', '2023-04-17T03:22:23', 0.1166),
    (110, '1.0104.00.00', '2023-04-12T13:23:20', 0.1095),
    (110, '1.0402.11.10', '2023-04-03T15:19:31', 0.1335),
    (110, '1.2001.39.00', '2023-04-23T09:20:18', 0.4222),
    (110, '1.0502.33', '2023-04-06T05:43:56', 0.189),
    (110, '1.0102.69.00', '2023-04-08T14:09:58', 0.1089),
    (110, '1.1106', '2023-04-18T03:11:33', 0.1974),
    (110, '1.0901.39.00', '2023-04-06T23:56:37', 0.6708),
    (110, '1.0504.45.20', '2023-04-28T22:07:39', 0.7131);

INSERT INTO relatorio VALUES
    (111, '2025-07-24', NULL, '48.912.037', '0001-38', '58.826.745/0001-34', 'Emissões e as metas da ONU', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (111, '2833.40.10', 0.8152, 8673),
    (111, '5802.20.00', 0.0081, 5267),
    (111, '3002.12.21', 0.006, 5577),
    (111, '0305.51.00', 0.0161, 3209),
    (111, '1209.24.00', 0.0063, 4195),
    (111, '8422.30.2', 0.0129, 2562),
    (111, '8101.99.90', 0.0394, 12240),
    (111, '4107.92.10', 0.0101, 2896),
    (111, '2836.92.00', 0.0043, 400);

INSERT INTO relatorio_serv VALUES
    (111, '1.0501.11.30', '2025-08-21T02:23:18', 0.3215),
    (111, '1.0502.19.00', '2025-08-28T16:18:38', 0.0),
    (111, '1.1401.16.00', '2025-08-07T12:03:42', 0.003);

INSERT INTO relatorio VALUES
    (112, '2025-10-31', NULL, '09.723.145', '0001-56', '53.396.825/0001-34', 'Formas de reduzir o impacto de emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (112, '9018.39.29', 1.1513, 400),
    (112, '0603.90.00', 0.0231, 3944),
    (112, '2933.39.41', 0.0823, 3751),
    (112, '2306.41.00', 0.0281, 8340),
    (112, '2933.55.40', 0.0172, 6282),
    (112, '8473.30.31', 0.0255, 1760),
    (112, '2833.24.00', 0.0045, 400),
    (112, '4202.39.00', 0.0569, 400),
    (112, '8430.41.20', 0.0596, 20243),
    (112, '5509.22.00', 0.0139, 400),
    (112, '2933.59.34', 0.1899, 400),
    (112, '8476.21.00', 0.0054, 6499),
    (112, '8429.51.2', 0.043, 3928),
    (112, '8424.82.21', 0.0018, 4268),
    (112, '8473.50.10', 0.0722, 6842),
    (112, '8472.90.99', 0.0024, 1941),
    (112, '5102.20.00', 0.2293, 2713),
    (112, '6909.12.10', 0.1036, 400),
    (112, '0901.12.00', 0.0103, 3083),
    (112, '8517.62.39', 0.0099, 400),
    (112, '0304.92.12', 0.0307, 400),
    (112, '3907.10.3', 0.1407, 4455),
    (112, '2924.19.2', 0.0796, 9500),
    (112, '2933.99.63', 0.0772, 1258),
    (112, '8536.90.20', 0.0236, 400),
    (112, '2922.49.6', 0.1447, 9115),
    (112, '7117.11.00', 0.0154, 11209);

INSERT INTO relatorio_serv VALUES
    (112, '1.0502.23.20', '2025-11-13T09:58:25', 0.4776),
    (112, '1.1706.11.00', '2025-11-24T08:49:31', 0.0048),
    (112, '1.2001.33.00', '2025-11-02T19:09:47', 0.0107),
    (112, '1.2003.26.90', '2025-11-10T13:33:29', 0.0068);

INSERT INTO relatorio VALUES
    (113, '2024-05-17', NULL, '33.738.001', '0001-77', '00.001.333/0001-99', 'Tipos de emissão em empresas de refinaria', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (113, '8501.53.20', 0.139, 18794),
    (113, '8406.90.2', 0.2339, 400),
    (113, '1702.40.20', 0.722, 3351),
    (113, '2931.59.11', 0.4082, 876),
    (113, '2904.10.11', 0.1694, 10907),
    (113, '9404.29.00', 0.4989, 3758),
    (113, '0306.94.00', 0.0861, 7886),
    (113, '4010.11.00', 0.1954, 5432),
    (113, '0104.20.90', 0.2601, 400),
    (113, '3003.90.64', 0.4844, 3512),
    (113, '7310.29.20', 0.1717, 400),
    (113, '8429.40.00', 0.1722, 400),
    (113, '3507.90.49', 0.1334, 9605),
    (113, '2907.21.00', 0.1168, 400),
    (113, '8536.50.10', 0.1606, 10090),
    (113, '8448.39.9', 0.0833, 400),
    (113, '5205.26.00', 0.3805, 400),
    (113, '8528.49.90', 0.1954, 400),
    (113, '8443.91.10', 0.232, 8175),
    (113, '2903.13.00', 0.0417, 400),
    (113, '8205.70.00', 0.0856, 400);

INSERT INTO relatorio_serv VALUES
    (113, '1.1903.1', '2024-06-01T06:35:37', 1.3541);

INSERT INTO relatorio VALUES
    (114, '2025-10-11', '2026-03-25', '79.821.563', '0001-65', '11.679.309/0001-01', 'Impacto de programas de incentivo fiscal na redução de emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (114, '8545.11.00', 0.3797, 5283),
    (114, '6003.10.00', 1.3481, 8873),
    (114, '0303.89.64', 0.2762, 5957),
    (114, '2920.23.00', 0.2646, 400),
    (114, '8549.31.00', 0.7345, 400),
    (114, '7222.19.10', 1.0202, 7305),
    (114, '8521.10.81', 0.1631, 10615),
    (114, '2922.29.90', 0.8713, 4839),
    (114, '2833.29.30', 0.1885, 3001),
    (114, '3926.90.40', 0.0731, 400),
    (114, '2912.19.12', 0.1078, 5624),
    (114, '2614.00.90', 0.4487, 4617),
    (114, '1404.20.10', 0.4479, 657),
    (114, '2935.90.2', 0.4038, 16089),
    (114, '3915.90.00', 1.2295, 3695),
    (114, '3808.93.27', 0.4341, 9648),
    (114, '5703.21.00', 0.0459, 400),
    (114, '2913.00.10', 1.0475, 400),
    (114, '9603.29.00', 0.1332, 400),
    (114, '8433.51.00', 0.3357, 8279),
    (114, '8472.90.59', 0.2845, 4190),
    (114, '2834.10.10', 0.1528, 2508),
    (114, '3606.10.00', 0.4648, 8501),
    (114, '2933.99.53', 0.5585, 400),
    (114, '5301.21.10', 0.3381, 1084),
    (114, '1301.90.10', 0.8089, 2368),
    (114, '6303.92.00', 1.2809, 400);

INSERT INTO relatorio_serv VALUES
    (114, '1.25', '2025-11-14T00:18:58', 1.1348);

INSERT INTO relatorio VALUES
    (115, '2025-03-29', NULL, '01.274.895', '0001-40', '11.679.309/0001-01', 'Impacto de programas de incentivo fiscal na redução de emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (115, '9608.99.8', 0.507, 7482);

INSERT INTO relatorio_serv VALUES
    (115, '1.0201.00.00', '2025-04-10T23:05:48', 0.0175),
    (115, '1.1706.11.00', '2025-04-01T22:29:07', 0.1307),
    (115, '1.0402.14.00', '2025-04-05T22:33:12', 0.303),
    (115, '1.1704.20.00', '2025-04-03T19:35:05', 0.1382),
    (115, '1.2205.1', '2025-04-03T00:39:28', 0.5104),
    (115, '1.0102.1', '2025-04-26T09:37:37', 0.2621),
    (115, '1.1701.29.00', '2025-04-12T00:59:14', 0.1503),
    (115, '1.2404.32.00', '2025-04-22T07:44:49', 0.3439),
    (115, '1.1303', '2025-04-15T01:18:41', 0.2109),
    (115, '1.1109.30.00', '2025-04-20T13:05:04', 0.3095),
    (115, '1.2003.21', '2025-04-26T07:34:40', 0.0344),
    (115, '1.0301.31.00', '2025-04-08T20:09:00', 0.1111),
    (115, '1.2301.91.00', '2025-04-13T20:00:39', 0.5647),
    (115, '1.1501.10.00', '2025-04-15T14:33:30', 0.2046);

INSERT INTO relatorio VALUES
    (116, '2024-03-15', NULL, '09.723.145', '0001-93', '54.777.163/0001-46', 'O capitalismo como motor da exploração dos recursos naturais', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (116, '7604.29.19', 0.0125, 10758),
    (116, '2905.17.20', 0.0744, 3945),
    (116, '2933.33.69', 0.1567, 8706),
    (116, '8479.82.90', 0.1551, 4292),
    (116, '3926.10.00', 0.0971, 400),
    (116, '8517.62.56', 0.1062, 10694),
    (116, '3707.90.29', 0.343, 400),
    (116, '8532.30.90', 0.0733, 2344),
    (116, '7229.20.00', 0.1382, 400),
    (116, '3705.00.10', 0.0706, 3581),
    (116, '2520.20.90', 0.0226, 400);

INSERT INTO relatorio_serv VALUES
    (116, '1.1903', '2024-04-11T21:30:11', 0.0615),
    (116, '1.2606.00.00', '2024-04-10T04:23:01', 0.0449),
    (116, '1.1404.22.00', '2024-04-08T08:06:50', 0.0235),
    (116, '1.0504.43.00', '2024-04-29T11:50:47', 0.0392),
    (116, '1.1106.3', '2024-04-06T21:00:01', 0.0222),
    (116, '1.2301.1', '2024-04-26T04:48:56', 0.022),
    (116, '1.13', '2024-04-23T18:28:56', 0.0076),
    (116, '1.2101.30.00', '2024-04-18T05:23:55', 0.1014),
    (116, '1.0106.60.00', '2024-04-05T02:35:45', 0.098),
    (116, '1.0501.14.40', '2024-04-05T16:58:46', 0.0739),
    (116, '1.1103.4', '2024-04-21T01:26:42', 0.0799),
    (116, '1.1408.19.00', '2024-04-16T23:13:21', 0.0784),
    (116, '1.1703.9', '2024-04-07T23:57:00', 0.0616);

INSERT INTO relatorio VALUES
    (117, '2023-04-23', '2026-04-18', '28.659.130', '0001-07', '53.396.825/0001-34', 'Formas de reduzir o impacto de emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (117, '3915.20.00', 0.3332, 7528);

INSERT INTO relatorio_serv VALUES
    (117, '1.26', '2023-05-16T07:27:51', 0.2219),
    (117, '1.0604.90.00', '2023-05-25T19:43:41', 0.0537),
    (117, '1.0301.29.00', '2023-05-24T04:06:59', 0.1803),
    (117, '1.1702.90.00', '2023-05-19T03:01:19', 0.0822),
    (117, '1.1103.2', '2023-05-14T01:37:32', 0.3767),
    (117, '1.0403.11.90', '2023-05-11T18:10:27', 0.0365),
    (117, '1.2003.21.10', '2023-05-14T03:53:17', 0.071),
    (117, '1.1509.00.00', '2023-05-21T17:33:46', 0.1805),
    (117, '1.1507.90.00', '2023-05-05T11:26:10', 0.3413),
    (117, '1.2506.00.00', '2023-05-01T07:21:06', 0.0369),
    (117, '1.2403', '2023-05-26T11:40:11', 0.1371),
    (117, '1.2002.40.00', '2023-05-05T17:16:20', 0.1468),
    (117, '1.1301.40.00', '2023-05-24T19:16:27', 0.0371),
    (117, '1.1108.30.00', '2023-05-10T06:44:32', 0.048),
    (117, '1.2402', '2023-05-14T05:41:32', 0.0091),
    (117, '1.0901.51.2', '2023-05-10T18:48:38', 0.0769),
    (117, '1.0901.31.00', '2023-05-13T02:58:02', 0.0202);

INSERT INTO relatorio VALUES
    (118, '2023-01-16', NULL, '09.723.145', '0001-93', '11.679.309/0001-01', 'Análise de emissões em São Paulo na última década', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (118, '2840.11.00', 0.4196, 1444),
    (118, '7304.90.1', 0.2173, 8897),
    (118, '8456.90.00', 0.3085, 7315),
    (118, '8502.13.19', 0.5579, 7424),
    (118, '8465.95.12', 0.1871, 5755),
    (118, '7225.30.00', 0.559, 6619),
    (118, '8508.60.00', 0.4177, 14246),
    (118, '8510.30.00', 0.0585, 3220),
    (118, '0305.41.00', 0.1818, 9417),
    (118, '6108.99.00', 0.0634, 400),
    (118, '4802.58.92', 0.189, 6213);

INSERT INTO relatorio_serv VALUES
    (118, '1.1102.90.00', '2023-02-21T10:30:23', 0.6246),
    (118, '1.1403.22.11', '2023-02-22T12:31:44', 0.0584),
    (118, '1.0501.24.21', '2023-02-07T07:46:14', 0.0911),
    (118, '1.0101.2', '2023-02-25T15:30:18', 0.2641),
    (118, '1.0502.34.10', '2023-02-22T05:05:17', 0.4963);

INSERT INTO relatorio VALUES
    (119, '2024-11-23', NULL, '53.921.807', '0001-18', '37.669.280/0001-29', 'Pesquisa de campo em emissões', NULL, NULL, NULL);

INSERT INTO relatorio_serv VALUES
    (119, '1.1103.36', '2024-12-02T19:02:15', 0.1104),
    (119, '1.1802.20.00', '2024-12-22T12:45:15', 0.2962),
    (119, '1.0903.35.00', '2024-12-26T19:42:02', 0.1595),
    (119, '1.1108.90.00', '2024-12-29T00:59:34', 0.1205),
    (119, '1.1106', '2024-12-18T07:44:36', 0.1717),
    (119, '1.2508.00.00', '2024-12-15T12:51:33', 0.0022),
    (119, '1.0501.13.10', '2024-12-01T02:10:12', 0.1364),
    (119, '1.1804.00.00', '2024-12-20T07:31:13', 0.2098),
    (119, '1.2501.2', '2024-12-27T22:40:54', 0.0623),
    (119, '1.2504.1', '2024-12-07T16:55:26', 0.5603),
    (119, '1.1401.18.00', '2024-12-14T17:19:34', 0.2435),
    (119, '1.0501.3', '2024-12-20T09:01:47', 0.4787),
    (119, '1.0905', '2024-12-01T12:28:23', 0.1518),
    (119, '1.1106.36.90', '2024-12-26T15:05:37', 0.1054),
    (119, '1.2302.2', '2024-12-11T18:56:26', 0.3357),
    (119, '1.1302.19.00', '2024-12-19T00:35:56', 0.0709),
    (119, '1.1106.34.00', '2024-12-02T05:33:33', 0.2915),
    (119, '1.0202.00.00', '2024-12-23T20:51:49', 0.1039),
    (119, '1.0502.14.40', '2024-12-01T09:16:32', 0.5584),
    (119, '1.1703.22.00', '2024-12-16T02:13:45', 0.3026),
    (119, '1.2404.32.00', '2024-12-04T12:52:08', 0.0151),
    (119, '1.2402.20.00', '2024-12-23T11:09:28', 0.5733),
    (119, '1.0505.10.00', '2024-12-08T15:44:35', 0.1968),
    (119, '1.1901.10.00', '2024-12-07T02:45:24', 0.2081),
    (119, '1.0501.24.21', '2024-12-02T14:07:15', 0.0541),
    (119, '1.1403.21.20', '2024-12-09T04:21:47', 0.0061),
    (119, '1.1402.1', '2024-12-14T07:08:34', 0.3587),
    (119, '1.2002.30.00', '2024-12-03T09:55:23', 0.1638),
    (119, '1.1401.14.00', '2024-12-04T08:00:56', 0.1753),
    (119, '1.0901.52.10', '2024-12-18T13:15:02', 0.4129),
    (119, '1.0502.39.00', '2024-12-02T00:49:16', 0.1659),
    (119, '1.1201.50.00', '2024-12-14T00:15:42', 0.3869),
    (119, '1.2404.12.00', '2024-12-21T06:09:55', 0.4761),
    (119, '1.0905.90.00', '2024-12-12T20:24:49', 0.5222),
    (119, '1.0903.39.00', '2024-12-02T17:31:27', 0.354),
    (119, '1.0501.29.00', '2024-12-21T02:26:43', 0.3494),
    (119, '1.1403.22.90', '2024-12-01T02:09:25', 0.1314),
    (119, '1.1406.1', '2024-12-18T13:44:44', 0.1297),
    (119, '1.1302.11.00', '2024-12-23T22:29:09', 0.1529),
    (119, '1.2501.37.00', '2024-12-13T18:37:00', 0.6945);

INSERT INTO relatorio VALUES
    (120, '2025-11-04', '2026-02-01', '13.690.872', '0001-54', '54.777.163/0001-46', 'Andamento das metas da ONU', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (120, '2910.90.90', 0.7422, 400),
    (120, '2933.53.7', 0.5064, 5620),
    (120, '0303.89.3', 0.9923, 400),
    (120, '6212.20.00', 1.6494, 400),
    (120, '8708.94.82', 0.5504, 400),
    (120, '8433.59.1', 0.3225, 400),
    (120, '2933.53.2', 0.1774, 687),
    (120, '7110.21.00', 1.4362, 400),
    (120, '2930.20.21', 0.3276, 5435),
    (120, '8506.10.20', 1.3873, 8489),
    (120, '8714.20.00', 0.439, 4995),
    (120, '8456.11.19', 0.5074, 2198);

INSERT INTO relatorio_serv VALUES
    (120, '1.2304.1', '2025-12-24T07:04:49', 0.1838),
    (120, '1.0102.35.30', '2025-12-20T17:45:14', 0.0623),
    (120, '1.0901.52.90', '2025-12-28T13:19:53', 0.6282),
    (120, '1.1107.3', '2025-12-13T08:06:01', 0.2538),
    (120, '1.2205.13.00', '2025-12-15T01:52:10', 0.4185),
    (120, '1.0401.11.11', '2025-12-11T12:52:03', 0.1844),
    (120, '1.2003.10.00', '2025-12-25T00:04:41', 0.1684),
    (120, '1.0401.11.20', '2025-12-17T01:10:19', 0.3493),
    (120, '1.2001.89.00', '2025-12-24T15:43:17', 0.4759),
    (120, '1.0501.22.10', '2025-12-23T12:29:13', 0.2675),
    (120, '1.1506.29.00', '2025-12-25T08:19:04', 0.3422),
    (120, '1.0905.40.00', '2025-12-27T12:27:59', 0.1336),
    (120, '1.1106', '2025-12-28T08:25:35', 0.3231),
    (120, '1.1106.42.00', '2025-12-15T01:09:50', 0.2497),
    (120, '1.0107.90.00', '2025-12-01T08:36:14', 0.0544);

INSERT INTO relatorio VALUES
    (121, '2024-07-05', '2025-09-07', '39.605.871', '0001-83', '09.850.333/0001-77', 'Emissões: e eu com isso?', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (121, '0302.55.00', 0.8411, 400),
    (121, '4810.19.82', 2.3295, 2900),
    (121, '2931.49.1', 0.0927, 8224),
    (121, '8474.80.90', 0.3418, 3957),
    (121, '2935.90.24', 0.8874, 3671),
    (121, '2904.10.12', 0.814, 1667),
    (121, '8464.20.2', 1.0465, 400),
    (121, '3906.90.52', 0.2517, 5698),
    (121, '3301.90.10', 1.4175, 2347),
    (121, '9021.39.30', 0.1095, 400),
    (121, '8716.31.00', 2.3428, 3160),
    (121, '8471.70.90', 1.9027, 8377);

INSERT INTO relatorio_serv VALUES
    (121, '1.0502.32.20', '2024-08-13T09:10:56', 0.9728),
    (121, '1.0105.11.00', '2024-08-14T09:56:08', 0.0118),
    (121, '1.2001.20.00', '2024-08-22T01:59:50', 0.3905);

INSERT INTO relatorio VALUES
    (122, '2024-10-08', NULL, '65.172.380', '0001-61', '54.777.163/0001-46', 'Andamento das metas da ONU', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (122, '8508.70.00', 0.0396, 7741),
    (122, '2208.40.00', 0.0568, 400),
    (122, '4802.57.93', 0.0263, 4342),
    (122, '9506.59.00', 0.1804, 6330),
    (122, '8466.93.50', 0.0321, 1697),
    (122, '5205.21.00', 0.1571, 400),
    (122, '2903.92.20', 0.0979, 7238),
    (122, '5407.73.00', 0.1227, 7971),
    (122, '8419.12.00', 0.0461, 13273),
    (122, '3811.90.90', 0.0523, 6971),
    (122, '4401.32.00', 0.2548, 400),
    (122, '8527.13.00', 0.0898, 400),
    (122, '2933.69.2', 0.0361, 6101),
    (122, '2908.19.90', 0.084, 1603),
    (122, '7304.90.1', 0.0526, 400),
    (122, '2933.39.12', 0.1466, 400),
    (122, '3705.00.90', 0.0567, 6019),
    (122, '0303.89.41', 0.0443, 400),
    (122, '6909.90.00', 0.1228, 400),
    (122, '2846.10.10', 0.0272, 4584),
    (122, '3812.39.11', 0.0339, 5254),
    (122, '2008.30.00', 0.0754, 1520),
    (122, '6215.10.00', 0.1205, 2280),
    (122, '8434.10.00', 0.2379, 400),
    (122, '6112.31.00', 0.1281, 3694),
    (122, '5104.00.00', 0.0234, 9505),
    (122, '7802.00.00', 0.2097, 400),
    (122, '9603.50.00', 0.0383, 8931);

INSERT INTO relatorio_serv VALUES
    (122, '1.1706.21.00', '2024-11-12T07:49:57', 0.2579),
    (122, '1.2601', '2024-11-07T17:07:10', 0.0313),
    (122, '1.1506', '2024-11-18T14:46:27', 0.1275);

INSERT INTO relatorio VALUES
    (123, '2025-10-26', '2026-02-26', '56.738.014', '0001-69', '11.679.309/0001-01', 'Impacto de programas de incentivo fiscal na redução de emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (123, '6802.29.00', 0.3054, 400);

INSERT INTO relatorio_serv VALUES
    (123, '1.2301.1', '2025-11-15T23:48:58', 0.1397),
    (123, '1.0901.51.17', '2025-11-12T01:46:52', 0.1357),
    (123, '1.0502.14.40', '2025-11-03T11:54:37', 0.0472),
    (123, '1.1403.25.00', '2025-11-26T05:51:23', 0.4667),
    (123, '1.0901.29.00', '2025-11-04T23:55:21', 0.0267),
    (123, '1.0301.3', '2025-11-26T09:32:06', 0.0233),
    (123, '1.1401.39.00', '2025-11-16T08:42:09', 0.1279),
    (123, '1.2003.22.00', '2025-11-26T12:24:30', 0.153),
    (123, '1.1506.21.00', '2025-11-07T08:04:19', 0.2335),
    (123, '1.0901.31.00', '2025-11-26T01:57:08', 0.0061),
    (123, '1.0501.11.30', '2025-11-02T03:40:47', 0.025),
    (123, '1.0102.35.10', '2025-11-15T19:00:37', 0.2038),
    (123, '1.0102.35', '2025-11-01T15:35:53', 0.139),
    (123, '1.0502.33', '2025-11-19T05:23:25', 0.2507),
    (123, '1.0605', '2025-11-13T07:27:01', 0.0797),
    (123, '1.0106.2', '2025-11-27T15:18:35', 0.1332),
    (123, '1.0502.13', '2025-11-01T21:29:45', 0.3552),
    (123, '1.0301.21.00', '2025-11-24T21:23:14', 0.2611),
    (123, '1.2205.11.00', '2025-11-12T05:47:26', 0.2735),
    (123, '1.0505.20.00', '2025-11-16T11:46:01', 0.0221),
    (123, '1.0502.34.20', '2025-11-22T20:09:13', 0.1451),
    (123, '1.1403.22.23', '2025-11-09T05:01:22', 0.4633),
    (123, '1.2003.25.20', '2025-11-04T06:29:07', 0.0811),
    (123, '1.17', '2025-11-27T20:25:24', 0.0482),
    (123, '1.2606.00.00', '2025-11-09T08:43:14', 0.0497),
    (123, '1.1402', '2025-11-06T23:55:53', 0.0397),
    (123, '1.1409.21.00', '2025-11-10T14:00:01', 0.0394),
    (123, '1.1411.00.00', '2025-11-10T04:26:28', 0.0363),
    (123, '1.1406.1', '2025-11-22T11:14:18', 0.1632),
    (123, '1.1403.22.90', '2025-11-08T10:13:21', 0.1305),
    (123, '1.0904.39.00', '2025-11-01T06:21:51', 0.0748),
    (123, '1.0102.53.20', '2025-11-06T07:40:12', 0.0543),
    (123, '1.1302.1', '2025-11-07T00:18:05', 0.0069),
    (123, '1.1106.35.00', '2025-11-28T17:52:55', 0.1175),
    (123, '1.1404.13.00', '2025-11-01T14:49:58', 0.1156);

INSERT INTO relatorio VALUES
    (124, '2022-08-26', '2026-04-01', '79.821.563', '0001-65', '37.669.280/0001-29', 'Emissões em microempresas', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (124, '2933.39.8', 0.0458, 400),
    (124, '8708.40.80', 0.2158, 400),
    (124, '2918.12.00', 0.2329, 6577),
    (124, '2933.69.19', 0.0512, 400),
    (124, '0502.90.10', 0.1719, 12786),
    (124, '2941.50.10', 0.1122, 400),
    (124, '6302.39.00', 0.2654, 1002),
    (124, '0304.32.10', 0.0809, 10101),
    (124, '5407.71.00', 0.0396, 3187),
    (124, '6117.10.00', 0.1405, 5626),
    (124, '7616.10.00', 0.479, 1264),
    (124, '3003.90.7', 0.0248, 400),
    (124, '2504.10.00', 0.1449, 7286),
    (124, '9030.33.2', 0.1886, 400),
    (124, '2811.22.20', 0.2002, 3754),
    (124, '5303.90.90', 0.2748, 8553),
    (124, '2914.79.90', 0.3061, 4028),
    (124, '3403.19.00', 0.05, 400),
    (124, '7210.90.00', 0.3871, 400);

INSERT INTO relatorio_serv VALUES
    (124, '1.2204.30.00', '2022-09-13T01:35:28', 0.0592),
    (124, '1.0504.2', '2022-09-08T21:22:51', 0.0687),
    (124, '1.0107.30.00', '2022-09-17T09:53:14', 0.1741);

INSERT INTO relatorio VALUES
    (125, '2021-11-30', '2023-05-07', '88.635.333', '0001-98', '58.826.745/0001-34', 'Emissões a alto nível', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (125, '3212.90.10', 0.2337, 9844),
    (125, '7307.92.00', 0.0442, 4559),
    (125, '4820.90.00', 0.2206, 1852),
    (125, '6006.22.00', 0.0012, 9842),
    (125, '2936.27.10', 0.108, 2096),
    (125, '9018.90.3', 0.1947, 400),
    (125, '6304.92.00', 0.223, 12212),
    (125, '9705.21.00', 0.231, 12728),
    (125, '8459.69.00', 0.077, 10840),
    (125, '4302.30.00', 0.0191, 2520);

INSERT INTO relatorio VALUES
    (126, '2025-01-20', NULL, '13.690.872', '0001-54', '54.777.163/0001-46', 'Andamento das metas da ONU', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (126, '0207.25.00', 1.3746, 3388),
    (126, '2909.60.1', 0.4596, 400),
    (126, '2939.59.10', 0.7825, 3813),
    (126, '2941.40.19', 0.6664, 3234),
    (126, '2934.99.51', 0.7548, 400),
    (126, '7217.10.19', 1.1092, 6188),
    (126, '3307.30.00', 0.4135, 6186),
    (126, '2933.33.3', 0.3078, 8525),
    (126, '3808.99.95', 0.517, 400),
    (126, '2933.69.9', 0.8333, 7893),
    (126, '1212.99.10', 0.2534, 2229),
    (126, '4203.10.00', 1.8385, 7494),
    (126, '8601.20.00', 0.5531, 18359),
    (126, '8428.33.00', 0.8688, 400);

INSERT INTO relatorio_serv VALUES
    (126, '1.0901.51.14', '2025-02-10T19:41:40', 3.7143),
    (126, '1.0205.00.00', '2025-02-23T22:22:49', 1.1588),
    (126, '1.2504.2', '2025-02-27T04:58:45', 0.6282),
    (126, '1.2301.23.00', '2025-02-11T01:13:05', 0.8009),
    (126, '1.2204.20.00', '2025-02-16T13:12:09', 0.5095);

INSERT INTO relatorio VALUES
    (127, '2026-02-27', NULL, '75.893.062', '0001-33', '54.777.163/0001-46', 'Andamento das metas da ONU', NULL, NULL, NULL);

INSERT INTO relatorio_serv VALUES
    (127, '1.0501.21', '2026-03-19T21:26:51', 1.2868),
    (127, '1.0910', '2026-03-17T14:21:00', 1.8734),
    (127, '1.2301.96.00', '2026-03-03T04:52:18', 0.1011),
    (127, '1.1805.3', '2026-03-14T00:55:40', 0.5333),
    (127, '1.1806.51.00', '2026-03-26T13:38:07', 0.1192),
    (127, '1.1806.63.00', '2026-03-20T13:56:01', 1.6671),
    (127, '1.0901.52.30', '2026-03-19T02:28:02', 1.409),
    (127, '1.2304', '2026-03-07T22:34:48', 0.3309),
    (127, '1.1001.2', '2026-03-28T21:54:39', 0.9621),
    (127, '1.1405.2', '2026-03-29T20:01:01', 1.7096),
    (127, '1.0608.20.00', '2026-03-24T12:58:13', 0.0771),
    (127, '1.1402.12.00', '2026-03-23T12:16:31', 0.6445),
    (127, '1.1001.12.90', '2026-03-27T11:01:29', 0.7916),
    (127, '1.0402.14.00', '2026-03-22T08:35:58', 0.065),
    (127, '1.1404.49.00', '2026-03-17T02:45:26', 0.2258);

INSERT INTO relatorio VALUES
    (128, '2023-03-18', '2023-11-15', '45.690.123', '0001-36', '87.888.161/0001-65', 'Impacto de atividades agropecuárias na Amazônia', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (128, '8448.33.10', 2.3642, 7563),
    (128, '2903.79.12', 0.0039, 7078),
    (128, '2920.29.50', 0.0143, 2875),
    (128, '3004.39.94', 0.0142, 400),
    (128, '3903.20.00', 0.0468, 400);

INSERT INTO relatorio_serv VALUES
    (128, '1.0504.11.00', '2023-04-08T16:16:33', 2.0925),
    (128, '1.1507.90.00', '2023-04-13T06:14:54', 0.0083),
    (128, '1.1901.20.00', '2023-04-06T13:36:04', 0.0021),
    (128, '1.2001.34', '2023-04-14T04:18:00', 0.0081),
    (128, '1.2002', '2023-04-16T22:44:57', 0.0335);

INSERT INTO relatorio VALUES
    (129, '2023-01-08', '2025-05-13', '79.821.563', '0001-00', '58.826.745/0001-34', 'Emissões e as metas da ONU', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (129, '3302.90.1', 2.013, 4377),
    (129, '3907.10.49', 0.0757, 6378),
    (129, '9027.20.29', 0.0496, 1167),
    (129, '3901.10.20', 0.0015, 11059),
    (129, '3003.90.79', 0.0289, 1885),
    (129, '8448.20.90', 0.0259, 400);

INSERT INTO relatorio_serv VALUES
    (129, '1.1701.19.00', '2023-02-15T06:37:35', 1.8304),
    (129, '1.0901.51.23', '2023-02-11T04:17:26', 0.0047),
    (129, '1.0502.12.10', '2023-02-19T23:41:17', 0.0914),
    (129, '1.1705', '2023-02-14T09:05:23', 0.019),
    (129, '1.0102.3', '2023-02-05T10:19:33', 0.009),
    (129, '1.0903.32.00', '2023-02-05T23:40:16', 0.025),
    (129, '1.1403.90.00', '2023-02-23T10:36:14', 0.0247),
    (129, '1.0901.51.13', '2023-02-25T17:39:26', 0.1874),
    (129, '1.1903.40.00', '2023-02-22T14:37:18', 0.0342);

INSERT INTO relatorio VALUES
    (130, '2025-09-04', NULL, '79.821.563', '0001-43', '09.850.333/0001-77', 'Emissões: e eu com isso?', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (130, '8421.91.10', 3.1595, 400),
    (130, '4408.39.91', 0.0107, 400),
    (130, '4805.50.00', 0.0201, 1980),
    (130, '4008.19.00', 0.0265, 5114),
    (130, '3003.90.7', 0.0082, 2618),
    (130, '3003.39.19', 0.0595, 1769),
    (130, '5404.90.00', 0.1171, 1363),
    (130, '0702.00.00', 0.049, 6464),
    (130, '8479.89.40', 0.026, 8632),
    (130, '6115.10.93', 0.0844, 4983);

INSERT INTO relatorio_serv VALUES
    (130, '1.2201.19.00', '2025-10-16T02:59:28', 0.8467),
    (130, '1.2401.00.00', '2025-10-24T08:51:32', 0.0782),
    (130, '1.1703.91.00', '2025-10-19T18:30:28', 0.0085),
    (130, '1.0504.12.00', '2025-10-25T00:07:54', 0.0178);

INSERT INTO relatorio VALUES
    (131, '2023-04-25', NULL, '79.821.563', '0001-43', '09.850.333/0001-77', 'Emissões: e eu com isso?', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (131, '4410.11.90', 1.638, 1501),
    (131, '8413.30.10', 0.0215, 7117),
    (131, '0704.90.00', 0.0001, 470),
    (131, '3815.90.91', 0.1492, 400),
    (131, '2835.10.11', 0.0355, 3299),
    (131, '4410.19.11', 0.027, 3719),
    (131, '2916.15.1', 0.0169, 6387),
    (131, '8450.20.20', 0.0737, 400),
    (131, '4105.10.90', 0.2991, 7432),
    (131, '0709.30.00', 0.005, 400);

INSERT INTO relatorio_serv VALUES
    (131, '1.0301.39.00', '2023-05-11T13:50:18', 0.9441);

INSERT INTO relatorio VALUES
    (132, '2022-12-02', NULL, '28.659.130', '0001-07', '54.777.163/0001-46', 'Andamento das metas da ONU', NULL, NULL, NULL);

INSERT INTO relatorio_serv VALUES
    (132, '1.0502.11.30', '2023-01-06T20:01:59', 0.1186),
    (132, '1.0401.12.10', '2023-01-08T09:48:22', 0.0288),
    (132, '1.0608', '2023-01-15T08:01:19', 0.0423),
    (132, '1.1401.32.00', '2023-01-09T13:53:33', 0.0627),
    (132, '1.2302.10.00', '2023-01-03T14:39:16', 0.2062),
    (132, '1.2403.2', '2023-01-26T11:19:35', 0.0026),
    (132, '1.1105.10.00', '2023-01-11T18:44:11', 0.0736),
    (132, '1.0904.2', '2023-01-11T10:14:03', 0.284),
    (132, '1.1107.31.00', '2023-01-27T13:32:39', 0.1267),
    (132, '1.2101', '2023-01-20T01:50:03', 0.0439),
    (132, '1.16', '2023-01-28T23:09:57', 0.0516),
    (132, '1.0504.12.00', '2023-01-05T10:46:30', 0.019),
    (132, '1.0502.24', '2023-01-22T08:00:30', 0.0529),
    (132, '1.1201.33.00', '2023-01-14T12:20:44', 0.0863),
    (132, '1.2304.90.00', '2023-01-05T10:19:17', 0.0482),
    (132, '1.0403.21.20', '2023-01-05T22:25:21', 0.05),
    (132, '1.0903.34.00', '2023-01-08T09:29:41', 0.0223),
    (132, '1.0502.32.10', '2023-01-18T17:50:23', 0.089),
    (132, '1.1107.20.00', '2023-01-16T23:06:52', 0.0258),
    (132, '1.2205.19.00', '2023-01-15T10:15:05', 0.0787),
    (132, '1.0901.51.17', '2023-01-20T06:28:01', 0.0447),
    (132, '1.1409.12.00', '2023-01-11T20:48:00', 0.1952),
    (132, '1.1202', '2023-01-30T12:18:09', 0.1117),
    (132, '1.1102.40.00', '2023-01-25T21:08:25', 0.0063),
    (132, '1.0502.3', '2023-01-18T01:56:47', 0.1842),
    (132, '1.2405.11.00', '2023-01-28T22:23:36', 0.0657),
    (132, '1.1404.42.00', '2023-01-21T10:07:24', 0.1209),
    (132, '1.1402.14.00', '2023-01-05T12:44:45', 0.0093),
    (132, '1.0504.45.10', '2023-01-13T07:04:27', 0.1568),
    (132, '1.2304.11.00', '2023-01-11T02:08:20', 0.0662),
    (132, '1.2404.32.00', '2023-01-08T08:56:26', 0.1797),
    (132, '1.0401.2', '2023-01-03T11:44:03', 0.0464),
    (132, '1.1102.50.00', '2023-01-03T01:22:24', 0.0085),
    (132, '1.1903.11.00', '2023-01-05T08:55:06', 0.0573),
    (132, '1.1806.53.00', '2023-01-15T23:52:48', 0.0814),
    (132, '1.1101.90.00', '2023-01-16T11:21:02', 0.0726),
    (132, '1.1401.19.00', '2023-01-05T09:00:09', 0.0538),
    (132, '1.2404.22.00', '2023-01-07T15:28:43', 0.0387),
    (132, '1.0502.21.10', '2023-01-20T19:02:07', 0.0493),
    (132, '1.0801', '2023-01-07T13:37:20', 0.1553);

INSERT INTO relatorio VALUES
    (133, '2023-07-24', '2025-02-25', '79.821.563', '0001-65', '58.826.745/0001-34', 'Impacto das técnicas de produção em emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (133, '7505.12.29', 0.0338, 17605),
    (133, '0105.13.00', 0.1498, 6891),
    (133, '3909.50.1', 0.0818, 400),
    (133, '8443.31.13', 0.2113, 964),
    (133, '2916.12.20', 0.1147, 400),
    (133, '8450.11.00', 0.022, 6583),
    (133, '9503.00.9', 0.0812, 6562),
    (133, '2916.19.2', 0.0323, 400),
    (133, '8443.32.35', 0.0638, 400),
    (133, '6205.90.10', 0.1376, 400),
    (133, '2827.39.94', 0.1171, 8897),
    (133, '9111.80.00', 0.0562, 839),
    (133, '0209.10.21', 0.1357, 6478),
    (133, '1404.90.10', 0.0531, 2389);

INSERT INTO relatorio_serv VALUES
    (133, '1.0102.42.10', '2023-08-23T05:00:57', 0.1952);

INSERT INTO relatorio VALUES
    (134, '2025-11-03', NULL, '79.821.563', '0001-65', '11.679.309/0001-01', 'Impacto de programas de incentivo fiscal na redução de emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (134, '8502.13.90', 0.8748, 8958),
    (134, '0904.11.00', 12.0381, 2982),
    (134, '8481.80.39', 4.6015, 400),
    (134, '5903.20.00', 1.7251, 400),
    (134, '3926.90.22', 2.8522, 9514),
    (134, '0406.20.00', 1.6689, 2939),
    (134, '6207.22.00', 3.5587, 6188),
    (134, '3004.90.24', 1.619, 7735),
    (134, '3003.20.9', 2.8873, 400),
    (134, '2926.90.21', 4.633, 14080),
    (134, '3809.10.10', 2.2914, 400),
    (134, '2936.21.12', 0.784, 1805);

INSERT INTO relatorio_serv VALUES
    (134, '1.1108.10.00', '2025-12-22T18:28:56', 1.3017),
    (134, '1.0101.29.00', '2025-12-23T15:51:00', 0.8478),
    (134, '1.2203.10.00', '2025-12-20T07:04:17', 1.5912),
    (134, '1.1107.31.00', '2025-12-02T05:11:01', 1.8194);

INSERT INTO relatorio VALUES
    (135, '2023-03-25', '2024-03-22', '48.603.715', '0001-78', '54.777.163/0001-46', 'O capitalismo como motor da exploração dos recursos naturais', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (135, '3003.39.26', 0.2345, 1987),
    (135, '8481.80.39', 0.0013, 400),
    (135, '2302.30.10', 0.0766, 6237),
    (135, '8517.62.39', 0.1341, 9165),
    (135, '2939.79.40', 0.1568, 4888),
    (135, '2711.13.00', 0.1216, 6311),
    (135, '8429.51.2', 0.0173, 4221),
    (135, '2006.00.00', 0.0624, 4759);

INSERT INTO relatorio_serv VALUES
    (135, '1.0501.11.10', '2023-04-26T18:43:28', 0.2294),
    (135, '1.0102.5', '2023-04-05T03:35:47', 0.1161),
    (135, '1.1509.00.00', '2023-04-21T03:34:04', 0.0152),
    (135, '1.2301.98.00', '2023-04-03T11:26:59', 0.3133),
    (135, '1.2201', '2023-04-10T02:19:17', 0.1783),
    (135, '1.0908.00.00', '2023-04-18T00:36:19', 0.3037),
    (135, '1.1404.44.00', '2023-04-17T13:30:47', 0.0075),
    (135, '1.1506.90.00', '2023-04-10T16:05:52', 0.0159),
    (135, '1.1108.30.00', '2023-04-07T02:40:41', 0.1184),
    (135, '1.2501.1', '2023-04-06T11:02:23', 0.238);

INSERT INTO relatorio VALUES
    (136, '2023-11-12', '2024-06-07', '09.723.145', '0001-93', '54.777.163/0001-46', 'Andamento das metas da ONU', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (136, '5514.19.90', 0.1459, 400),
    (136, '5405.00.00', 0.2811, 4655),
    (136, '2920.90.90', 0.011, 2986),
    (136, '8428.60.00', 0.1804, 14172),
    (136, '2922.49.52', 0.4082, 7330),
    (136, '7505.12.2', 0.2441, 2729),
    (136, '2915.39.5', 0.4762, 558);

INSERT INTO relatorio_serv VALUES
    (136, '1.0402.13', '2023-12-16T21:06:57', 0.4107),
    (136, '1.0402.29.00', '2023-12-08T23:06:22', 0.1584),
    (136, '1.0901.5', '2023-12-13T18:35:20', 0.1257),
    (136, '1.1902.90.00', '2023-12-30T15:13:22', 0.2677),
    (136, '1.1103.10.00', '2023-12-14T05:17:02', 0.1796),
    (136, '1.0905.1', '2023-12-14T10:33:12', 0.1157),
    (136, '1.0401.16', '2023-12-15T04:21:45', 0.1132),
    (136, '1.2404.1', '2023-12-21T03:24:39', 0.379),
    (136, '1.0102.11.00', '2023-12-12T13:38:10', 0.0441),
    (136, '1.0605.40.00', '2023-12-22T19:37:47', 0.0116),
    (136, '1.1401.11.00', '2023-12-18T07:40:10', 0.1511);

INSERT INTO relatorio VALUES
    (137, '2023-07-01', '2025-12-01', '48.603.715', '0001-45', '54.777.163/0001-46', 'Andamento das metas da ONU', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (137, '8466.93.30', 0.549, 4182),
    (137, '2933.36.00', 0.0875, 2713),
    (137, '9006.30.00', 0.662, 4880),
    (137, '4407.25.00', 0.0677, 6725),
    (137, '1522.00.00', 0.2143, 6480),
    (137, '2711.12.10', 0.4222, 11730),
    (137, '2832.30.20', 0.5396, 14453),
    (137, '8445.19.27', 0.59, 13094);

INSERT INTO relatorio_serv VALUES
    (137, '1.0906.40.00', '2023-08-15T21:41:54', 0.1388),
    (137, '1.1106.36', '2023-08-23T00:16:07', 0.0125),
    (137, '1.0402.19.00', '2023-08-03T08:32:43', 0.1519),
    (137, '1.0502.24.52', '2023-08-17T21:07:21', 0.4845),
    (137, '1.2501.22.00', '2023-08-06T07:48:46', 0.2135),
    (137, '1.0302.00.00', '2023-08-23T14:09:07', 0.0584),
    (137, '1.2406', '2023-08-02T15:46:27', 0.1134),
    (137, '1.1903', '2023-08-01T21:04:51', 0.2629),
    (137, '1.0906.90.00', '2023-08-16T21:09:29', 0.1674),
    (137, '1.1105.70.00', '2023-08-02T21:13:16', 0.006),
    (137, '1.1404.43.00', '2023-08-13T10:56:14', 0.1292),
    (137, '1.10', '2023-08-04T16:42:59', 0.0725),
    (137, '1.1701.2', '2023-08-09T20:59:43', 0.3837),
    (137, '1.0102.6', '2023-08-04T14:28:18', 0.0298);

INSERT INTO relatorio VALUES
    (138, '2025-12-07', NULL, '88.635.333', '0001-98', '37.669.280/0001-29', 'Emissões em microempresas', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (138, '0304.49.20', 0.087, 6369),
    (138, '8420.10.10', 0.0214, 1618),
    (138, '0305.51.00', 0.0476, 400),
    (138, '7413.00.00', 0.0056, 3388),
    (138, '0802.32.00', 0.0087, 5493),
    (138, '8801.00.00', 0.0712, 3528),
    (138, '2940.00.12', 0.0136, 6858),
    (138, '4002.19.20', 0.0393, 5221),
    (138, '6403.91.10', 0.0078, 10465),
    (138, '8543.40.00', 0.0868, 400),
    (138, '2530.90.90', 0.0858, 3562),
    (138, '2826.90.90', 0.0773, 2736),
    (138, '2917.39.3', 0.039, 8936),
    (138, '0602.30.00', 0.0338, 2853),
    (138, '8501.51.10', 0.0083, 3718),
    (138, '8501.40.11', 0.0258, 400),
    (138, '8465.99.00', 0.0675, 506),
    (138, '3105.90.19', 0.0899, 2789),
    (138, '3003.39.9', 0.0175, 7034),
    (138, '9021.39.20', 0.0615, 400),
    (138, '0304.92.29', 0.027, 400),
    (138, '3824.99.83', 0.0075, 6160),
    (138, '2918.29.10', 0.0372, 6196),
    (138, '0602.10.00', 0.0177, 11138),
    (138, '3507.90.19', 0.0218, 400),
    (138, '8542.39.11', 0.0425, 7855),
    (138, '2009.12.00', 0.0504, 12896),
    (138, '2710.12.4', 0.0356, 3782);

INSERT INTO relatorio_serv VALUES
    (138, '1.2001.33.00', '2026-01-02T22:34:45', 0.0133),
    (138, '1.0501.3', '2026-01-14T01:03:40', 0.0782),
    (138, '1.0501.14.40', '2026-01-13T23:56:54', 0.0142);

INSERT INTO relatorio VALUES
    (139, '2025-09-09', NULL, '79.821.563', '0001-65', '37.669.280/0001-29', 'Emissões em microempresas', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (139, '2924.21.20', 0.0258, 7280),
    (139, '3808.69.10', 0.0764, 12135),
    (139, '8466.93.19', 0.1837, 400),
    (139, '5105.29.91', 0.1817, 8633),
    (139, '2504.10.00', 0.5622, 1918),
    (139, '8533.90.00', 0.1467, 2251),
    (139, '8806.99.00', 0.0395, 2396),
    (139, '8536.50.30', 0.0679, 12920),
    (139, '0302.53.00', 0.2903, 8527),
    (139, '8443.99.42', 0.0436, 8765),
    (139, '2849.20.00', 0.1621, 6832),
    (139, '9021.39.40', 0.1824, 10657),
    (139, '3003.90.58', 0.0411, 400),
    (139, '6306.22.00', 0.0222, 6141),
    (139, '5210.32.00', 0.435, 12595),
    (139, '2939.19.00', 0.0936, 3651),
    (139, '8532.30.90', 0.4842, 4387),
    (139, '7015.10.10', 0.0862, 6256),
    (139, '9017.20.00', 0.0383, 6494),
    (139, '2939.69.59', 0.1717, 400),
    (139, '3004.10.19', 0.1637, 4946);

INSERT INTO relatorio_serv VALUES
    (139, '1.1405', '2025-10-02T04:29:58', 0.0376),
    (139, '1.1805.62.00', '2025-10-29T09:49:55', 0.4853),
    (139, '1.0101.1', '2025-10-22T20:28:20', 0.158);

INSERT INTO relatorio VALUES
    (140, '2023-05-14', '2023-12-13', '88.635.333', '0001-98', '87.888.161/0001-65', 'Impacto de atividades agropecuárias na Amazônia', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (140, '9202.10.00', 0.0454, 7435),
    (140, '5801.27.00', 0.4922, 400),
    (140, '8477.59.1', 0.2746, 4886),
    (140, '8529.90.1', 0.1154, 400),
    (140, '8506.10.1', 0.2818, 5399),
    (140, '8602.90.00', 0.2006, 7398),
    (140, '2934.10.10', 0.4981, 1656),
    (140, '0301.94.10', 0.3547, 16470),
    (140, '4301.90.00', 0.1684, 7674),
    (140, '3809.91.41', 0.169, 890);

INSERT INTO relatorio_serv VALUES
    (140, '1.1106.36.10', '2023-06-28T02:40:33', 0.1433),
    (140, '1.1109.30.00', '2023-06-28T10:24:10', 0.4618),
    (140, '1.0205.00.00', '2023-06-20T00:47:08', 0.1028),
    (140, '1.0103.20.00', '2023-06-21T12:01:58', 0.126);

INSERT INTO relatorio VALUES
    (141, '2025-01-14', NULL, '65.172.380', '0001-53', '54.777.163/0001-46', 'Andamento das metas da ONU', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (141, '8714.96.11', 0.4721, 6042),
    (141, '8422.20.00', 0.0048, 3630),
    (141, '2914.79.1', 0.0029, 3259),
    (141, '0304.95.00', 0.003, 7736),
    (141, '0301.94.10', 0.0025, 1435),
    (141, '0803.10.00', 0.0036, 14281),
    (141, '5205.13.90', 0.0013, 5843),
    (141, '8542.31.90', 0.0116, 7975);

INSERT INTO relatorio VALUES
    (142, '2023-03-10', '2024-08-10', '13.690.872', '0001-09', '53.396.825/0001-34', 'Formas de reduzir o impacto de emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (142, '8482.10.90', 0.1205, 1710),
    (142, '7010.90.2', 0.2155, 400),
    (142, '8418.21.00', 0.0957, 12308),
    (142, '5211.12.00', 0.3426, 7993),
    (142, '8419.50.2', 0.0847, 2234),
    (142, '8419.50.10', 0.7162, 1851),
    (142, '6802.99.10', 0.3686, 1246),
    (142, '2208.30.10', 0.0856, 10384),
    (142, '8108.90.00', 0.069, 1004),
    (142, '8433.40.00', 0.1224, 21920),
    (142, '7315.90.00', 0.043, 2972),
    (142, '2523.30.00', 0.1931, 5272),
    (142, '7415.21.00', 0.0981, 400),
    (142, '6217.90.00', 0.3254, 1586),
    (142, '8421.39.10', 0.0086, 4128);

INSERT INTO relatorio_serv VALUES
    (142, '1.1805.40.00', '2023-04-01T03:12:26', 0.0864),
    (142, '1.1701.5', '2023-04-03T13:25:06', 0.0414),
    (142, '1.0101.21.00', '2023-04-04T19:51:52', 0.0325);

INSERT INTO relatorio VALUES
    (143, '2026-04-04', NULL, '48.912.037', '0001-38', '37.669.280/0001-29', 'Emissões em microempresas', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (143, '3804.00.12', 0.964, 4641),
    (143, '2905.19.11', 0.0369, 1926),
    (143, '3701.30.21', 0.0057, 400),
    (143, '4706.10.00', 0.0365, 12275),
    (143, '2933.59.33', 0.1181, 5223),
    (143, '6903.20.20', 0.0412, 811),
    (143, '0304.33.00', 0.0113, 4519),
    (143, '2936.27.10', 0.0018, 400),
    (143, '8473.30.41', 0.0051, 400),
    (143, '8536.50.90', 0.0614, 1883),
    (143, '7004.20.00', 0.0987, 400),
    (143, '2933.35.00', 0.0001, 2678),
    (143, '8443.91.99', 0.0286, 4107),
    (143, '9024.80.90', 0.0213, 400),
    (143, '8443.39.28', 0.0303, 12283),
    (143, '2403.99.90', 0.0668, 7502),
    (143, '3003.39.16', 0.0028, 8396),
    (143, '5911.20.90', 0.0258, 400),
    (143, '9030.89.20', 0.0878, 4930),
    (143, '8703.32.90', 0.0273, 517),
    (143, '2903.79.90', 0.0396, 400),
    (143, '2924.29.94', 0.002, 3312),
    (143, '2939.45.20', 0.1136, 1450),
    (143, '2839.90.20', 0.0065, 8278),
    (143, '6203.29.10', 0.005, 400),
    (143, '7226.91.00', 0.0032, 18293);

INSERT INTO relatorio_serv VALUES
    (143, '1.1405.11.00', '2026-05-05T01:39:09', 0.1049);

INSERT INTO relatorio VALUES
    (144, '2024-09-17', NULL, '09.723.145', '0001-93', '11.679.309/0001-01', 'Impacto de programas de incentivo fiscal na redução de emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (144, '9108.11.10', 0.0484, 10206),
    (144, '7404.00.00', 0.1287, 4717),
    (144, '8424.89.90', 0.2819, 3077),
    (144, '7219.34.00', 0.1877, 13716),
    (144, '4820.90.00', 0.0278, 1775),
    (144, '3005.90.90', 0.3217, 7001),
    (144, '7226.20.90', 0.0435, 3508),
    (144, '8536.90.10', 0.0808, 400),
    (144, '1604.19.00', 0.3583, 2345),
    (144, '3912.11.10', 0.1916, 15613),
    (144, '2922.19.52', 0.3864, 400),
    (144, '2939.63.00', 0.044, 2970),
    (144, '5902.10.90', 0.1718, 4336),
    (144, '8101.99.10', 0.0807, 400),
    (144, '9705.21.00', 0.1307, 4856);

INSERT INTO relatorio_serv VALUES
    (144, '1.0606', '2024-10-07T23:54:27', 0.0647),
    (144, '1.0103.42.00', '2024-10-18T20:46:09', 0.0366),
    (144, '1.1803.21.00', '2024-10-02T09:45:03', 0.2574),
    (144, '1.1403.90.00', '2024-10-23T04:02:19', 0.2883),
    (144, '1.1401.39.00', '2024-10-25T05:45:49', 0.1119),
    (144, '1.1405.90.00', '2024-10-21T23:03:36', 0.0807),
    (144, '1.0502.32.30', '2024-10-04T18:19:48', 0.11),
    (144, '1.1406', '2024-10-16T08:10:46', 0.0528),
    (144, '1.2501.3', '2024-10-13T14:31:48', 0.1403);

INSERT INTO relatorio VALUES
    (145, '2022-10-20', '2026-02-03', '79.821.563', '0001-65', '58.826.745/0001-34', 'Emissões e as metas da ONU', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (145, '4703.29.00', 1.0854, 4242),
    (145, '3215.90.00', 3.5198, 400),
    (145, '9027.20.12', 1.446, 542),
    (145, '3003.90.4', 0.6822, 4160),
    (145, '2309.90.50', 0.2798, 2504),
    (145, '6804.10.00', 3.0877, 2966),
    (145, '3004.20.41', 0.4912, 400),
    (145, '2933.91.62', 0.9571, 2020);

INSERT INTO relatorio_serv VALUES
    (145, '1.1102.50.00', '2022-11-29T01:06:27', 0.1159),
    (145, '1.0903.35.00', '2022-11-21T03:49:59', 0.7301),
    (145, '1.0502.34', '2022-11-15T00:56:21', 0.428);

INSERT INTO relatorio VALUES
    (146, '2025-12-24', '2026-02-28', '13.690.872', '0001-09', '54.777.163/0001-46', 'Andamento das metas da ONU', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (146, '3004.43.00', 0.2792, 5303),
    (146, '4810.14.90', 0.484, 400),
    (146, '8414.10.00', 0.0097, 5788),
    (146, '9021.90.12', 0.0596, 6820),
    (146, '4114.20.10', 0.1896, 6889),
    (146, '2852.10.14', 0.0643, 8892),
    (146, '2923.90.30', 0.0381, 10153),
    (146, '3004.20.41', 0.0199, 400),
    (146, '2007.99.26', 0.1663, 400),
    (146, '3606.90.00', 0.0496, 3542),
    (146, '3905.19.90', 0.3321, 6759),
    (146, '2103.10.90', 0.169, 404),
    (146, '0204.42.00', 0.0097, 1565),
    (146, '8460.90.1', 0.1926, 10902),
    (146, '5201.00.90', 0.0671, 850),
    (146, '0106.20.00', 0.2159, 8328),
    (146, '1204.00.90', 0.0208, 400),
    (146, '8412.39.00', 0.0964, 7986),
    (146, '8204.12.00', 0.6005, 400),
    (146, '7407.29.2', 0.5181, 3955),
    (146, '8542.39.11', 0.1334, 6105),
    (146, '8481.20.90', 0.0728, 6283),
    (146, '6006.32.10', 0.2693, 7109);

INSERT INTO relatorio_serv VALUES
    (146, '1.2205.1', '2026-01-03T05:40:25', 0.0833),
    (146, '1.1103.42.00', '2026-01-25T18:12:11', 0.1914),
    (146, '1.1303.20.00', '2026-01-26T03:23:51', 0.0515);

INSERT INTO relatorio VALUES
    (147, '2025-04-27', NULL, '09.723.145', '0001-78', '09.850.333/0001-77', 'Emissões: e eu com isso?', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (147, '2610.00.10', 72.0573, 7513),
    (147, '3004.90.19', 4.0893, 11728),
    (147, '5111.11.20', 0.1695, 18056),
    (147, '8426.49.10', 0.5556, 3775),
    (147, '6812.99.90', 0.4652, 5304),
    (147, '2915.90.4', 1.3178, 400),
    (147, '9017.20.00', 3.8037, 400),
    (147, '2915.39.91', 1.0277, 5157),
    (147, '2933.99.99', 1.262, 2384),
    (147, '6306.19.10', 0.502, 1741),
    (147, '4806.10.00', 0.6553, 2506),
    (147, '8532.29.10', 0.306, 7539),
    (147, '4001.30.00', 1.4411, 400),
    (147, '3808.59.2', 0.4155, 400),
    (147, '7901.12.10', 2.7956, 1046);

INSERT INTO relatorio VALUES
    (148, '2025-08-17', NULL, '09.723.145', '0001-56', '54.777.163/0001-46', 'Andamento das metas da ONU', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (148, '2934.99.32', 9.1618, 7577),
    (148, '6306.40.90', 0.2493, 14822),
    (148, '2903.99.21', 0.0318, 13168),
    (148, '6203.42.00', 0.7871, 1738),
    (148, '3003.90.65', 1.4289, 2935),
    (148, '6004.10.91', 0.3414, 2867),
    (148, '2903.76.00', 0.0193, 7574),
    (148, '1302.14.00', 0.229, 9470),
    (148, '8412.21.90', 0.008, 4024),
    (148, '4805.12.00', 0.4312, 400),
    (148, '8471.50.10', 0.1017, 400),
    (148, '4410.90.00', 0.0391, 400),
    (148, '8539.39.11', 0.8465, 8975),
    (148, '6909.19.10', 0.5032, 5396),
    (148, '5207.10.00', 0.1663, 2461),
    (148, '4106.91.00', 0.8312, 2380),
    (148, '2922.19.91', 0.7589, 7710),
    (148, '8542.31.20', 0.1364, 13746),
    (148, '8433.40.00', 0.2639, 5780),
    (148, '3002.49.99', 0.1464, 8218),
    (148, '1513.21.20', 0.4715, 5048),
    (148, '5509.12.90', 0.4912, 2705),
    (148, '2103.30.21', 0.0781, 7692),
    (148, '2918.99.29', 0.5516, 11616),
    (148, '1302.19.20', 0.0327, 7215),
    (148, '2904.32.00', 0.0124, 8969),
    (148, '0801.32.00', 0.1588, 400),
    (148, '2923.20.00', 2.4259, 9619),
    (148, '5212.14.00', 1.6389, 2343),
    (148, '3002.12.35', 0.0016, 3798);

INSERT INTO relatorio_serv VALUES
    (148, '1.1105.90.00', '2025-09-28T09:43:39', 8.0509),
    (148, '1.06', '2025-09-27T16:07:48', 0.1679),
    (148, '1.2003.25.10', '2025-09-03T20:24:10', 0.249),
    (148, '1.0102.52.20', '2025-09-03T18:46:13', 0.0414);

INSERT INTO relatorio VALUES
    (149, '2024-07-12', '2024-11-05', '79.821.563', '0001-65', '11.679.309/0001-01', 'Análise de emissões em São Paulo na última década', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (149, '2008.70.90', 16.6662, 4631),
    (149, '9032.89.8', 5.0416, 6905),
    (149, '3006.60.00', 4.8621, 6697),
    (149, '2103.10.90', 2.7942, 6197),
    (149, '6112.11.00', 8.1474, 1914),
    (149, '2903.99.16', 2.7307, 4020),
    (149, '5407.94.00', 0.3015, 400),
    (149, '8504.23.00', 1.3928, 8994),
    (149, '6216.00.00', 7.2525, 400);

INSERT INTO relatorio_serv VALUES
    (149, '1.1802.50.00', '2024-08-17T00:02:27', 9.7659),
    (149, '1.0401.16.20', '2024-08-09T21:05:24', 5.8521);

INSERT INTO relatorio VALUES
    (150, '2024-01-10', '2025-07-23', '20.978.635', '0001-10', '53.396.825/0001-34', 'Formas de reduzir o impacto de emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (150, '5509.91.00', 1.2742, 400),
    (150, '3904.10.10', 0.0478, 10975),
    (150, '2916.39.40', 0.018, 400),
    (150, '7211.14.00', 0.3652, 7634),
    (150, '8510.90.11', 0.0146, 4375),
    (150, '2852.10.11', 0.157, 5275),
    (150, '9010.10.10', 0.0441, 3697),
    (150, '9024.10.90', 0.0013, 400),
    (150, '8415.10.19', 0.043, 11655),
    (150, '2937.90.30', 0.1167, 7270),
    (150, '0908.22.00', 0.0063, 400),
    (150, '3301.12.90', 0.2458, 8416),
    (150, '8421.39.90', 0.113, 4004),
    (150, '4818.90.10', 0.0688, 400),
    (150, '2707.50.90', 0.1707, 400),
    (150, '9030.33.21', 0.0722, 2392),
    (150, '9021.10.20', 0.0307, 5624),
    (150, '8501.32.10', 0.0557, 400),
    (150, '3827.63.00', 0.1405, 3750),
    (150, '6207.99.90', 0.0267, 8297),
    (150, '8459.51.00', 0.0869, 5953),
    (150, '2903.19.90', 0.3954, 400),
    (150, '8421.21.00', 0.355, 2316),
    (150, '6104.23.00', 0.0184, 1679),
    (150, '4407.11.00', 0.1072, 401),
    (150, '7314.41.00', 0.1369, 3992),
    (150, '2933.59.13', 0.2779, 3365);

INSERT INTO relatorio_serv VALUES
    (150, '1.2601.30.00', '2024-02-20T03:16:38', 0.909);

INSERT INTO relatorio VALUES
    (151, '2023-10-08', NULL, '18.024.935', '0001-76', '11.679.309/0001-01', 'Impacto de programas de incentivo fiscal na redução de emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (151, '8207.70.20', 3.5946, 4638),
    (151, '4011.10.00', 0.1667, 1213),
    (151, '2835.29.10', 0.0153, 7279),
    (151, '3507.90.49', 0.0125, 7743),
    (151, '2917.19.90', 0.0116, 10826),
    (151, '3909.40.9', 0.2653, 4965),
    (151, '3505.20.00', 0.171, 15543),
    (151, '4102.21.00', 0.0401, 1057),
    (151, '2921.12.00', 0.0128, 7059),
    (151, '9306.21.30', 0.0046, 5390),
    (151, '9606.10.00', 0.0215, 5900),
    (151, '3605.00.00', 0.0231, 3959);

INSERT INTO relatorio_serv VALUES
    (151, '1.1001.21.00', '2023-11-10T05:11:53', 0.8604),
    (151, '1.1401.12.00', '2023-11-25T00:49:05', 0.0309),
    (151, '1.0404', '2023-11-22T03:01:12', 0.0324);

INSERT INTO relatorio VALUES
    (152, '2022-03-03', '2022-04-22', '27.401.593', '0001-66', '11.679.309/0001-01', 'Impacto de programas de incentivo fiscal na redução de emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (152, '0303.89.90', 0.1248, 10666);

INSERT INTO relatorio_serv VALUES
    (152, '1.0502.2', '2022-04-02T19:08:57', 0.3772),
    (152, '1.0504.45.90', '2022-04-06T20:43:48', 0.0305),
    (152, '1.1408.13.00', '2022-04-19T05:41:42', 0.0118),
    (152, '1.0901.51.25', '2022-04-09T23:41:09', 0.0164),
    (152, '1.2001.82.00', '2022-04-27T21:34:58', 0.0011),
    (152, '1.0203.00.00', '2022-04-23T05:06:35', 0.0065),
    (152, '1.2403.19.00', '2022-04-06T14:09:30', 0.0398),
    (152, '1.0504.44.00', '2022-04-23T00:47:36', 0.0133),
    (152, '1.1102', '2022-04-11T16:11:31', 0.0031),
    (152, '1.1706.22.00', '2022-04-28T21:51:50', 0.0127),
    (152, '1.0501.24.21', '2022-04-25T10:40:57', 0.0016),
    (152, '1.1702.21.00', '2022-04-22T17:03:13', 0.007),
    (152, '1.1106.32.00', '2022-04-27T00:41:44', 0.0078),
    (152, '1.2003.21', '2022-04-06T15:39:04', 0.006),
    (152, '1.0905.60.00', '2022-04-01T07:26:05', 0.0065),
    (152, '1.0502.14.90', '2022-04-01T17:08:02', 0.0114),
    (152, '1.0901.51.29', '2022-04-23T17:56:44', 0.0144),
    (152, '1.2301.96.00', '2022-04-24T05:32:21', 0.019),
    (152, '1.1106.20.00', '2022-04-09T17:44:12', 0.0011),
    (152, '1.0102.69.00', '2022-04-04T13:50:34', 0.0072),
    (152, '1.2403.3', '2022-04-14T06:39:46', 0.0003),
    (152, '1.0102.52.20', '2022-04-03T16:54:57', 0.0062),
    (152, '1.0502.12.20', '2022-04-19T17:34:56', 0.0045);

INSERT INTO relatorio VALUES
    (153, '2024-06-02', NULL, '18.024.935', '0001-76', '58.826.745/0001-34', 'Emissões e as metas da ONU', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (153, '8307.10.10', 3.9047, 8001),
    (153, '5404.19.90', 0.1332, 2423),
    (153, '3004.10.1', 0.5891, 8667),
    (153, '8517.14.90', 0.2385, 400),
    (153, '7318.19.00', 0.0317, 10121),
    (153, '9405.19.90', 0.0354, 5099),
    (153, '8409.91.11', 0.0008, 3247),
    (153, '5402.31.1', 0.0155, 4688),
    (153, '0105.94.00', 0.0369, 5941),
    (153, '0210.93.00', 0.2307, 530),
    (153, '3004.90.69', 0.0498, 5695),
    (153, '2918.19.43', 0.0397, 400),
    (153, '6209.20.00', 0.0001, 400),
    (153, '5806.10.00', 0.0056, 400),
    (153, '6211.11.00', 0.1014, 3939),
    (153, '0209.10.11', 0.299, 6799),
    (153, '6304.11.00', 0.0193, 443),
    (153, '5601.30.10', 0.0445, 400),
    (153, '2928.00.90', 0.2709, 588),
    (153, '8448.32.30', 0.3031, 400),
    (153, '2841.90.8', 0.0095, 400),
    (153, '0207.14.31', 0.0128, 13714),
    (153, '4805.12.00', 0.0511, 8075);

INSERT INTO relatorio_serv VALUES
    (153, '1.0502.14.90', '2024-07-26T16:03:25', 1.1301);

INSERT INTO relatorio VALUES
    (154, '2022-03-14', '2022-07-21', '13.690.872', '0001-09', '54.777.163/0001-46', 'O capitalismo como motor da exploração dos recursos naturais', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (154, '2922.49.61', 0.1721, 5311),
    (154, '2834.29.30', 0.22, 4988),
    (154, '6305.32.00', 0.4273, 400),
    (154, '8504.31.19', 0.1125, 8201),
    (154, '8714.95.00', 0.2447, 9891),
    (154, '2909.44.11', 0.6431, 8733),
    (154, '3003.39.34', 0.6452, 400),
    (154, '2941.90.3', 0.0199, 836),
    (154, '7901.11.11', 0.4474, 400),
    (154, '7307.21.00', 0.064, 4314),
    (154, '2903.81.30', 0.1131, 400),
    (154, '2818.30.00', 0.2009, 400),
    (154, '9002.11.11', 0.1812, 3720),
    (154, '2933.33.6', 0.1734, 8577),
    (154, '2909.50.19', 0.129, 5184),
    (154, '0106.39.00', 0.1099, 4575),
    (154, '4802.54.99', 0.1026, 4042),
    (154, '8442.40.90', 0.0383, 400);

INSERT INTO relatorio VALUES
    (155, '2021-10-10', NULL, '56.738.014', '0001-69', '58.826.745/0001-34', 'Impacto das técnicas de produção em emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (155, '3907.10.10', 0.0442, 7049),
    (155, '4816.90.10', 0.0088, 10184),
    (155, '2921.42.90', 0.0139, 400);

INSERT INTO relatorio_serv VALUES
    (155, '1.1106', '2021-11-13T20:56:45', 0.0558),
    (155, '1.0502.33', '2021-11-15T17:05:21', 0.0286),
    (155, '1.1408.13.00', '2021-11-12T19:19:33', 0.0185),
    (155, '1.1404.49.00', '2021-11-14T16:38:52', 0.0464),
    (155, '1.0502.14.5', '2021-11-28T14:40:53', 0.0271),
    (155, '1.1101.13.00', '2021-11-03T23:57:40', 0.0576),
    (155, '1.23', '2021-11-12T07:00:04', 0.0416),
    (155, '1.1706.23.00', '2021-11-15T20:00:48', 0.0068),
    (155, '1.0502.13.20', '2021-11-01T12:09:08', 0.0112),
    (155, '1.0910.90.00', '2021-11-05T20:20:10', 0.0932),
    (155, '1.1805.13.00', '2021-11-09T21:44:36', 0.0238),
    (155, '1.1508.00.00', '2021-11-01T01:42:11', 0.0413),
    (155, '1.0901.31.00', '2021-11-08T15:23:09', 0.0264),
    (155, '1.0903.13.00', '2021-11-18T10:36:37', 0.0755),
    (155, '1.0503.90.00', '2021-11-01T17:32:00', 0.0628),
    (155, '1.1103.36.20', '2021-11-21T06:15:34', 0.0538),
    (155, '1.0504.45', '2021-11-17T02:04:11', 0.1424),
    (155, '1.1403.21.10', '2021-11-02T13:28:46', 0.0821);

INSERT INTO relatorio VALUES
    (156, '2021-08-05', NULL, '65.172.380', '0001-61', '54.777.163/0001-46', 'Andamento das metas da ONU', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (156, '5603.14.30', 0.1721, 7815),
    (156, '2930.90.3', 0.0216, 2050),
    (156, '8501.63.00', 0.0236, 400),
    (156, '1210.20.10', 0.1023, 2126),
    (156, '5004.00.00', 0.0271, 400),
    (156, '9032.89.24', 0.0068, 8536),
    (156, '5208.59.90', 0.0135, 4965),
    (156, '3201.20.00', 0.06, 4030),
    (156, '8443.13.90', 0.0633, 1548),
    (156, '0206.30.00', 0.0147, 5064),
    (156, '8443.32.40', 0.1212, 400),
    (156, '2921.59.19', 0.1073, 6958),
    (156, '2938.90.20', 0.0313, 2470),
    (156, '4816.90.10', 0.0148, 7891),
    (156, '3901.20.19', 0.0097, 9964),
    (156, '2932.99.13', 0.0307, 6650),
    (156, '5403.31.90', 0.148, 4431),
    (156, '3004.90.13', 0.023, 6432),
    (156, '2920.90.32', 0.0745, 5684),
    (156, '7011.10.90', 0.0515, 7354),
    (156, '3404.90.21', 0.0605, 1628),
    (156, '5510.12.19', 0.0393, 6363),
    (156, '2103.90.29', 0.0105, 3855);

INSERT INTO relatorio VALUES
    (157, '2024-02-19', NULL, '88.635.333', '0001-98', '11.679.309/0001-01', 'Impacto de programas de incentivo fiscal na redução de emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (157, '6004.10.92', 0.1064, 11577),
    (157, '8536.90.40', 0.0148, 400),
    (157, '8525.89.13', 0.046, 2329),
    (157, '4401.21.00', 0.0174, 5556),
    (157, '2937.29.60', 0.0031, 400),
    (157, '2704.00.12', 0.0242, 400),
    (157, '8532.23.10', 0.0122, 2853),
    (157, '2836.20.10', 0.0426, 9313),
    (157, '5509.91.00', 0.0042, 698),
    (157, '2908.19.2', 0.0733, 3190),
    (157, '2920.19.90', 0.0028, 4998),
    (157, '2903.29.10', 0.0235, 13080),
    (157, '2934.99.34', 0.0455, 12678),
    (157, '9018.90.94', 0.0086, 8769),
    (157, '1212.99.90', 0.0057, 4053),
    (157, '8477.20.10', 0.0401, 6140),
    (157, '2934.99.43', 0.0523, 400),
    (157, '5401.10.11', 0.015, 400),
    (157, '3812.31.00', 0.0247, 2274),
    (157, '6804.22.1', 0.0346, 400),
    (157, '8481.80.99', 0.0174, 400),
    (157, '8212.20.20', 0.0859, 2786),
    (157, '6209.20.00', 0.006, 400),
    (157, '7225.50.90', 0.0067, 2035),
    (157, '3207.20.9', 0.0103, 4850),
    (157, '4102.29.00', 0.0217, 7639),
    (157, '0713.33.21', 0.0015, 1573),
    (157, '8461.20.10', 0.015, 400);

INSERT INTO relatorio VALUES
    (158, '2023-11-13', NULL, '75.893.062', '0001-33', '58.826.745/0001-34', 'Emissões e as metas da ONU', NULL, NULL, NULL);

INSERT INTO relatorio_serv VALUES
    (158, '1.0904.32.00', '2023-12-30T17:23:43', 0.0932),
    (158, '1.1409.1', '2023-12-09T17:08:26', 0.1141),
    (158, '1.0102.53.20', '2023-12-11T06:26:31', 0.1352),
    (158, '1.2204.10.00', '2023-12-27T05:59:50', 0.1314),
    (158, '1.0401.2', '2023-12-28T03:50:13', 0.1529),
    (158, '1.0601', '2023-12-03T17:10:35', 0.1411),
    (158, '1.1103.50.00', '2023-12-09T10:52:04', 0.2954),
    (158, '1.0404.10.00', '2023-12-28T22:48:15', 0.0974),
    (158, '1.1108', '2023-12-30T14:42:47', 0.1445),
    (158, '1.18', '2023-12-02T02:53:44', 0.5428),
    (158, '1.1805.24.00', '2023-12-13T17:12:58', 0.1728),
    (158, '1.0910.10.00', '2023-12-09T21:52:22', 0.1726),
    (158, '1.1001.12.90', '2023-12-25T09:18:37', 0.0577),
    (158, '1.1706.24.00', '2023-12-25T10:40:49', 0.0152),
    (158, '1.0502.31.10', '2023-12-17T12:04:55', 0.0156),
    (158, '1.1701.2', '2023-12-27T22:40:17', 0.703);

INSERT INTO relatorio VALUES
    (159, '2023-06-14', NULL, '65.172.380', '0001-53', '54.777.163/0001-46', 'O capitalismo como motor da exploração dos recursos naturais', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (159, '8455.22.90', 0.716, 6340),
    (159, '6815.99.14', 0.0546, 400),
    (159, '3003.90.73', 0.0074, 2202),
    (159, '2920.11.20', 0.0686, 9907),
    (159, '3002.12.22', 0.0026, 779),
    (159, '5513.39.19', 0.0208, 2972),
    (159, '2504.10.00', 0.0081, 5600),
    (159, '0207.14.21', 0.098, 1857),
    (159, '2511.20.00', 0.1473, 400),
    (159, '6104.41.00', 0.0227, 11049),
    (159, '5603.94.90', 0.0032, 8797),
    (159, '8462.59.00', 0.0349, 10485),
    (159, '8536.69.90', 0.0128, 2548),
    (159, '1604.19.00', 0.0007, 16182),
    (159, '2941.50.20', 0.0563, 2698),
    (159, '8464.20.29', 0.0312, 400),
    (159, '8450.11.00', 0.1311, 1220),
    (159, '3921.90.12', 0.04, 400),
    (159, '4011.40.00', 0.0192, 1745),
    (159, '9030.40.20', 0.0141, 7122),
    (159, '8424.10.00', 0.0026, 9105),
    (159, '5609.00.90', 0.0237, 4990),
    (159, '2920.90.5', 0.0, 400),
    (159, '4811.10.90', 0.0041, 400),
    (159, '3004.20.9', 0.0871, 11243),
    (159, '5603.94.20', 0.0677, 400);

INSERT INTO relatorio_serv VALUES
    (159, '1.1201.31.00', '2023-07-07T15:21:22', 0.4031),
    (159, '1.0401.15', '2023-07-13T21:20:00', 0.0129),
    (159, '1.0105.40.00', '2023-07-18T16:54:06', 0.079),
    (159, '1.0202.00.00', '2023-07-01T15:28:32', 0.0152);

INSERT INTO relatorio VALUES
    (160, '2023-12-12', '2025-06-06', '53.921.807', '0001-18', '37.669.280/0001-29', 'Emissões em microempresas', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (160, '6815.12.00', 0.3829, 6903),
    (160, '8543.90.10', 0.1248, 400);

INSERT INTO relatorio_serv VALUES
    (160, '1.1001.1', '2024-01-13T14:18:55', 0.106),
    (160, '1.1705', '2024-01-28T10:02:29', 0.1231),
    (160, '1.0902.20.00', '2024-01-28T16:06:02', 0.4673),
    (160, '1.0904.3', '2024-01-05T09:32:11', 0.5394),
    (160, '1.0501.24.22', '2024-01-20T18:26:10', 0.3177),
    (160, '1.1403.22.90', '2024-01-06T03:12:35', 0.2478),
    (160, '1.0604.22.00', '2024-01-12T02:07:27', 0.5569),
    (160, '1.0401.17.20', '2024-01-11T15:45:59', 0.0697),
    (160, '1.1701.3', '2024-01-09T04:07:01', 0.0342),
    (160, '1.1106.31.00', '2024-01-17T14:36:26', 0.1801),
    (160, '1.1105.60.00', '2024-01-19T10:24:11', 0.7091),
    (160, '1.1405.22.00', '2024-01-06T22:19:22', 0.1462),
    (160, '1.0503.26.00', '2024-01-08T14:26:52', 0.3098),
    (160, '1.0904.32.00', '2024-01-23T13:12:45', 0.1559),
    (160, '1.1805.19.00', '2024-01-06T05:27:25', 0.5374),
    (160, '1.2001.20.00', '2024-01-07T12:54:12', 0.5542),
    (160, '1.2003.23.00', '2024-01-01T05:14:57', 0.5202),
    (160, '1.2003.26.10', '2024-01-08T13:34:42', 0.2056),
    (160, '1.2003.2', '2024-01-13T17:25:56', 0.3778),
    (160, '1.2101.23.00', '2024-01-26T23:57:29', 0.9081);

INSERT INTO relatorio VALUES
    (161, '2024-03-28', NULL, '13.690.872', '0001-09', '53.396.825/0001-34', 'Formas de reduzir o impacto de emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (161, '9031.80.11', 0.1111, 5539),
    (161, '2909.49.2', 0.0426, 7304),
    (161, '0801.32.00', 0.0616, 400),
    (161, '8424.89.20', 0.0436, 400),
    (161, '2826.19.20', 0.1279, 6317),
    (161, '2924.29.45', 0.0214, 2448),
    (161, '4011.70.90', 0.0871, 2305),
    (161, '3703.10.10', 0.0018, 4619),
    (161, '8443.32.35', 0.0115, 6669),
    (161, '7010.90.2', 0.0571, 721),
    (161, '2930.90.42', 0.0092, 400),
    (161, '8512.20.21', 0.104, 3806),
    (161, '2620.29.00', 0.0354, 13810),
    (161, '8702.40.90', 0.1307, 400),
    (161, '5602.29.00', 0.047, 3704),
    (161, '8443.14.00', 0.115, 9925),
    (161, '8512.20.29', 0.0101, 4554),
    (161, '2306.90.10', 0.0515, 7186),
    (161, '3004.20.62', 0.0405, 3514),
    (161, '4803.00.90', 0.0263, 11397),
    (161, '0301.99.11', 0.1512, 5231),
    (161, '9032.89.22', 0.076, 400),
    (161, '8516.40.00', 0.1028, 4506),
    (161, '2208.70.00', 0.0099, 3205),
    (161, '4802.57.92', 0.0311, 1933),
    (161, '2833.11.90', 0.0141, 4707),
    (161, '4810.19.99', 0.0067, 12848),
    (161, '8517.79.00', 0.2733, 400),
    (161, '8402.90.00', 0.0119, 1140);

INSERT INTO relatorio_serv VALUES
    (161, '1.2501.12.00', '2024-04-07T14:29:41', 0.052);

INSERT INTO relatorio VALUES
    (162, '2025-08-23', '2026-05-12', '09.723.145', '0001-78', '09.850.333/0001-77', 'Emissões: e eu com isso?', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (162, '2916.19.11', 0.9291, 1373),
    (162, '8479.10.90', 0.006, 7942),
    (162, '0713.35.90', 0.0644, 4856),
    (162, '5202.10.00', 0.0795, 3379),
    (162, '3403.91.90', 0.0016, 400),
    (162, '5601.22.91', 0.0223, 12023),
    (162, '8539.32.20', 0.0118, 2127),
    (162, '8532.24.20', 0.0027, 5770),
    (162, '8467.89.00', 0.0025, 3816),
    (162, '4705.00.00', 0.0037, 5738),
    (162, '3202.90.12', 0.0861, 400),
    (162, '3907.29.4', 0.0244, 833),
    (162, '2301.20.90', 0.0448, 1629),
    (162, '2937.23.21', 0.037, 7024),
    (162, '7110.29.00', 0.007, 4520),
    (162, '0305.42.00', 0.0122, 400);

INSERT INTO relatorio VALUES
    (163, '2025-01-04', '2026-05-12', '65.172.380', '0001-61', '54.777.163/0001-46', 'O capitalismo como motor da exploração dos recursos naturais', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (163, '8414.90.20', 0.4003, 7755),
    (163, '1513.29.11', 0.6847, 400),
    (163, '9401.41.00', 0.361, 400),
    (163, '7315.89.00', 0.0349, 400),
    (163, '4802.20.10', 0.0676, 680),
    (163, '8212.20.20', 0.3183, 400),
    (163, '8109.21.00', 0.2269, 2596),
    (163, '7804.19.00', 0.0416, 5899),
    (163, '7217.90.00', 0.2499, 14669),
    (163, '8466.20.10', 0.4492, 4661),
    (163, '0713.10.10', 0.1493, 11204),
    (163, '3904.10.20', 0.5202, 4604),
    (163, '2841.90.2', 0.0907, 5141);

INSERT INTO relatorio VALUES
    (164, '2022-11-18', NULL, '01.274.895', '0001-40', '37.669.280/0001-29', 'Emissões em microempresas', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (164, '8512.20.19', 0.0339, 4736),
    (164, '7304.59.90', 0.0353, 400),
    (164, '0305.63.00', 0.0775, 1209);

INSERT INTO relatorio_serv VALUES
    (164, '1.1903.40.00', '2022-12-04T11:27:39', 0.0377),
    (164, '1.1507.10.00', '2022-12-19T19:10:11', 0.0188),
    (164, '1.1202.90.00', '2022-12-28T08:07:25', 0.03),
    (164, '1.0502.24.5', '2022-12-01T20:12:59', 0.0272),
    (164, '1.1805.2', '2022-12-16T17:20:30', 0.0105),
    (164, '1.1701.51.00', '2022-12-15T11:59:08', 0.0516),
    (164, '1.1103.3', '2022-12-15T00:10:54', 0.0139),
    (164, '1.1301', '2022-12-02T06:18:47', 0.0099),
    (164, '1.0801', '2022-12-07T19:53:30', 0.0213),
    (164, '1.0504.1', '2022-12-16T23:13:07', 0.0265),
    (164, '1.1102.40.00', '2022-12-11T09:03:20', 0.0177),
    (164, '1.1705', '2022-12-07T05:53:03', 0.0805),
    (164, '1.0901.51.14', '2022-12-11T10:31:36', 0.0673),
    (164, '1.2505.10.00', '2022-12-28T22:16:52', 0.0772),
    (164, '1.1703.9', '2022-12-03T20:18:04', 0.0068),
    (164, '1.1705.10.00', '2022-12-07T11:09:04', 0.0056),
    (164, '1.0403', '2022-12-06T01:12:06', 0.0132),
    (164, '1.1403.26.00', '2022-12-11T08:59:32', 0.0401),
    (164, '1.0502.12.10', '2022-12-16T11:08:27', 0.025),
    (164, '1.0401.13.00', '2022-12-26T05:32:18', 0.1032),
    (164, '1.1701.34.00', '2022-12-19T02:31:39', 0.07),
    (164, '1.1409.2', '2022-12-16T05:27:25', 0.0539),
    (164, '1.1507.20.00', '2022-12-03T06:33:00', 0.0068),
    (164, '1.1805.11.00', '2022-12-01T01:48:16', 0.0594),
    (164, '1.2601.10.00', '2022-12-10T20:21:45', 0.0584),
    (164, '1.1401.39.00', '2022-12-29T09:41:10', 0.1337),
    (164, '1.1403.22', '2022-12-05T18:57:53', 0.0254),
    (164, '1.2403.31.00', '2022-12-28T23:52:40', 0.1059);

INSERT INTO relatorio VALUES
    (165, '2025-03-30', NULL, '56.738.014', '0001-69', '37.669.280/0001-29', 'Emissões em microempresas', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (165, '2933.53.60', 0.0599, 5439),
    (165, '6211.12.00', 0.1451, 1328);

INSERT INTO relatorio_serv VALUES
    (165, '1.0502.13.10', '2025-04-06T06:53:28', 0.034),
    (165, '1.2002.40.00', '2025-04-14T14:54:12', 0.0749),
    (165, '1.1001.21.00', '2025-04-20T05:37:17', 0.0508),
    (165, '1.0506.00.00', '2025-04-28T23:17:18', 0.0287),
    (165, '1.1002.10.00', '2025-04-20T19:33:01', 0.0264),
    (165, '1.0604.22.00', '2025-04-05T09:57:38', 0.0085),
    (165, '1.2405.12.00', '2025-04-05T22:54:11', 0.0667),
    (165, '1.2003.21', '2025-04-18T15:33:53', 0.0448),
    (165, '1.1103.22.00', '2025-04-02T22:32:00', 0.05),
    (165, '1.0502.21', '2025-04-25T01:32:32', 0.0325),
    (165, '1.1109.90.00', '2025-04-01T21:54:02', 0.0405),
    (165, '1.0205.00.00', '2025-04-27T23:19:00', 0.024),
    (165, '1.0502.21.10', '2025-04-03T09:41:11', 0.0459),
    (165, '1.1701.40.00', '2025-04-17T19:57:06', 0.0393),
    (165, '1.0105.11.00', '2025-04-26T15:26:48', 0.0126),
    (165, '1.1403.23.00', '2025-04-21T15:52:48', 0.044),
    (165, '1.1701.32.00', '2025-04-29T12:04:23', 0.118),
    (165, '1.1805.11.00', '2025-04-02T18:23:21', 0.0311),
    (165, '1.1101.11.00', '2025-04-22T00:13:32', 0.0579),
    (165, '1.1805.62.00', '2025-04-19T16:08:00', 0.0089),
    (165, '1.1302.2', '2025-04-27T23:24:41', 0.0677),
    (165, '1.2002.10.00', '2025-04-07T13:50:03', 0.0112),
    (165, '1.2003.25.10', '2025-04-19T00:42:02', 0.0661),
    (165, '1.1903.1', '2025-04-15T13:21:53', 0.0012),
    (165, '1.0401.16.10', '2025-04-25T21:12:44', 0.0214),
    (165, '1.1803.2', '2025-04-22T03:37:49', 0.0375);

INSERT INTO relatorio VALUES
    (166, '2025-06-18', NULL, '48.912.037', '0001-48', '58.826.745/0001-34', 'Impacto das técnicas de produção em emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (166, '2805.19.90', 6.4181, 1625),
    (166, '8423.81.90', 0.156, 3468),
    (166, '8504.32.11', 0.2225, 400),
    (166, '5516.23.00', 0.0002, 4351),
    (166, '6902.20.10', 0.8196, 400),
    (166, '0206.21.00', 0.2066, 4176),
    (166, '4810.14.90', 0.4428, 4943),
    (166, '2828.10.00', 0.0001, 1996),
    (166, '9021.90.92', 0.0752, 2956);

INSERT INTO relatorio VALUES
    (167, '2023-01-09', NULL, '18.024.935', '0001-76', '58.826.745/0001-34', 'Impacto das técnicas de produção em emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (167, '2812.19.20', 0.6928, 617),
    (167, '3801.30.10', 0.0305, 2044),
    (167, '9004.90.90', 0.0024, 5347),
    (167, '2827.39.60', 0.0015, 6813),
    (167, '5402.51.10', 0.0061, 7060),
    (167, '8105.20.29', 0.0108, 1760),
    (167, '5104.00.00', 0.0384, 7115),
    (167, '9010.50.20', 0.0034, 400),
    (167, '8421.11.90', 0.0194, 1327),
    (167, '5211.20.20', 0.0148, 7120),
    (167, '8419.40.20', 0.0127, 400),
    (167, '0303.23.00', 0.0337, 400),
    (167, '6005.44.00', 0.0113, 8042),
    (167, '8414.90.34', 0.0014, 400),
    (167, '9032.89.89', 0.0031, 2413),
    (167, '2941.30.10', 0.0317, 16614),
    (167, '8212.10.20', 0.0526, 2711),
    (167, '9021.90.19', 0.0004, 9074),
    (167, '3402.90.90', 0.0004, 12412),
    (167, '2809.20.20', 0.0014, 585),
    (167, '0505.10.00', 0.0102, 1989),
    (167, '8466.92.00', 0.0125, 400),
    (167, '5516.91.00', 0.0119, 2211);

INSERT INTO relatorio VALUES
    (168, '2023-02-27', '2024-08-23', '71.498.635', '0001-06', '37.669.280/0001-29', 'Emissões em microempresas', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (168, '3907.50.10', 0.1568, 400),
    (168, '7013.91.10', 1.048, 2090),
    (168, '9018.49.11', 0.0375, 400),
    (168, '4907.00.90', 0.8192, 8195),
    (168, '4911.91.00', 0.5947, 3389),
    (168, '0303.24.90', 0.4387, 5303),
    (168, '8406.90.21', 1.4472, 10399),
    (168, '8523.21.20', 0.5363, 15549),
    (168, '2921.51.3', 0.1058, 400),
    (168, '3003.39.14', 0.4666, 7971);

INSERT INTO relatorio_serv VALUES
    (168, '1.1101.14.00', '2023-03-16T05:18:18', 0.0043),
    (168, '1.1507.90.00', '2023-03-24T01:40:07', 0.6194);

INSERT INTO relatorio VALUES
    (169, '2024-01-15', NULL, '39.605.871', '0001-83', '54.777.163/0001-46', 'O capitalismo como motor da exploração dos recursos naturais', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (169, '7901.20.90', 0.2374, 8301),
    (169, '8450.20.10', 0.1193, 3121),
    (169, '2504.90.00', 0.0106, 5088),
    (169, '2934.99.43', 0.0555, 3112),
    (169, '9403.40.00', 0.071, 9272),
    (169, '6203.19.00', 0.0468, 17383),
    (169, '5210.32.00', 0.0256, 3255),
    (169, '8416.90.00', 0.087, 6875),
    (169, '6307.10.00', 0.0302, 820),
    (169, '0504.00.1', 0.0702, 10391),
    (169, '6116.99.00', 0.0546, 3791),
    (169, '9106.10.00', 0.0222, 7534),
    (169, '5206.21.00', 0.1447, 11053),
    (169, '0307.51.00', 0.1432, 7386),
    (169, '2827.39.91', 0.0233, 400),
    (169, '8441.40.00', 0.027, 5829),
    (169, '2933.29.13', 0.2439, 6039),
    (169, '2920.90.59', 0.048, 400),
    (169, '7202.11.00', 0.0757, 3187),
    (169, '7216.10.00', 0.0415, 9199),
    (169, '8538.90.90', 0.2471, 400),
    (169, '8480.71.00', 0.0351, 400),
    (169, '0304.73.00', 0.0671, 400),
    (169, '0206.21.00', 0.1908, 3572),
    (169, '2930.90.69', 0.0037, 6995);

INSERT INTO relatorio VALUES
    (170, '2022-11-18', NULL, '48.603.715', '0001-78', '54.777.163/0001-46', 'Andamento das metas da ONU', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (170, '3806.90.1', 0.1117, 2404),
    (170, '9018.41.00', 0.0787, 10591),
    (170, '3301.90.30', 0.0696, 400),
    (170, '3808.59.29', 0.3404, 2494),
    (170, '5702.50.10', 0.2718, 3980),
    (170, '2939.11.52', 0.0548, 7573),
    (170, '2930.20.23', 0.5442, 3101),
    (170, '2530.10.90', 0.4248, 3382);

INSERT INTO relatorio_serv VALUES
    (170, '1.2405.14.00', '2022-12-28T10:24:12', 0.6918),
    (170, '1.2301.91.00', '2022-12-23T07:41:17', 0.1556),
    (170, '1.1202', '2022-12-03T08:57:44', 0.2525),
    (170, '1.2003.29.00', '2022-12-04T09:47:41', 0.2568),
    (170, '1.0502.24.20', '2022-12-08T14:05:04', 0.0566),
    (170, '1.2001.31', '2022-12-03T12:45:51', 0.1093),
    (170, '1.1903', '2022-12-08T09:28:18', 0.0131),
    (170, '1.0402.3', '2022-12-27T03:31:16', 0.0405),
    (170, '1.2001.32.00', '2022-12-12T06:21:18', 0.0934),
    (170, '1.0501.11.10', '2022-12-03T16:22:42', 0.6087);

INSERT INTO relatorio VALUES
    (171, '2025-10-07', '2026-06-12', '79.821.563', '0001-99', '54.777.163/0001-46', 'Andamento das metas da ONU', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (171, '3825.90.00', 0.3213, 400),
    (171, '7408.29.1', 0.3277, 400),
    (171, '6107.12.00', 0.095, 400),
    (171, '2917.39.40', 0.0797, 400),
    (171, '8471.70.40', 0.0903, 7171),
    (171, '2906.19.90', 0.0536, 485),
    (171, '9027.90.99', 0.0512, 6285);

INSERT INTO relatorio_serv VALUES
    (171, '1.1403.26.00', '2025-11-14T22:14:08', 0.0262),
    (171, '1.1502.90.00', '2025-11-23T08:24:05', 0.0582),
    (171, '1.1102.60.00', '2025-11-10T18:36:26', 0.0617),
    (171, '1.2204.30.00', '2025-11-09T05:05:01', 0.2373),
    (171, '1.0102.42.10', '2025-11-03T20:29:54', 0.6933),
    (171, '1.1105.5', '2025-11-10T17:42:07', 0.0494);

INSERT INTO relatorio VALUES
    (172, '2025-03-03', '2025-10-29', '65.172.380', '0001-53', '53.396.825/0001-34', 'Formas de reduzir o impacto de emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (172, '8419.90.40', 0.543, 11208),
    (172, '6204.12.00', 0.0041, 7990),
    (172, '3824.99.5', 0.0276, 2850),
    (172, '2933.33.51', 0.0403, 2579),
    (172, '1704.90.10', 0.0177, 400),
    (172, '8708.29.99', 0.005, 1255),
    (172, '8539.32.30', 0.0144, 3727),
    (172, '6902.20.10', 0.0042, 1741),
    (172, '2931.41.00', 0.0134, 400);

INSERT INTO relatorio_serv VALUES
    (172, '1.1806.52.00', '2025-04-07T00:45:30', 0.0461),
    (172, '1.0503.12.00', '2025-04-02T04:48:27', 0.0002),
    (172, '1.0102.53.20', '2025-04-23T15:50:45', 0.0083);

INSERT INTO relatorio VALUES
    (173, '2025-06-20', '2026-04-11', '20.978.635', '0001-10', '54.777.163/0001-46', 'Andamento das metas da ONU', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (173, '8211.93.10', 2.4571, 4773),
    (173, '5209.31.00', 0.208, 9842),
    (173, '3502.90.10', 0.1101, 9759),
    (173, '8419.90.39', 0.3936, 2195),
    (173, '2909.49.23', 0.4104, 400),
    (173, '7602.00.00', 0.0684, 9236),
    (173, '6405.10.90', 0.1831, 1812),
    (173, '6108.22.00', 0.0294, 400),
    (173, '8448.11.20', 0.0894, 5272),
    (173, '2931.41.00', 0.0054, 400),
    (173, '2939.69.41', 0.0113, 400),
    (173, '2907.11.00', 0.0916, 400),
    (173, '2827.60.1', 0.0004, 400),
    (173, '3208.10.10', 0.0061, 4699),
    (173, '9022.90.10', 0.0213, 7646),
    (173, '3206.50.2', 0.0083, 3624),
    (173, '2941.90.13', 0.0766, 5890),
    (173, '3908.10.19', 0.0326, 16026),
    (173, '3204.14.00', 0.0119, 7743),
    (173, '2932.95.00', 0.0072, 10500),
    (173, '3507.90.32', 0.0034, 10549),
    (173, '4011.20.10', 0.0079, 400),
    (173, '2804.21.00', 0.0432, 8226);

INSERT INTO relatorio_serv VALUES
    (173, '1.1806.8', '2025-07-05T00:13:51', 1.3548),
    (173, '1.0403.11.90', '2025-07-13T22:59:09', 0.0382);

INSERT INTO relatorio VALUES
    (174, '2021-10-13', NULL, '39.605.871', '0001-83', '87.888.161/0001-65', 'Impacto de atividades agropecuárias na Amazônia', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (174, '0303.89.53', 0.1558, 11143),
    (174, '9032.90.91', 0.532, 8394),
    (174, '2837.20.29', 0.2164, 400),
    (174, '6815.99.90', 1.0582, 4382),
    (174, '2922.50.32', 0.3229, 6443),
    (174, '3004.20.6', 1.5228, 6250),
    (174, '3827.20.00', 0.479, 6754),
    (174, '3701.91.00', 0.6945, 5361),
    (174, '6204.39.00', 0.2265, 400),
    (174, '5504.90.10', 0.5758, 400),
    (174, '2106.90.2', 0.4141, 442),
    (174, '2930.90.29', 0.6184, 400),
    (174, '2818.20.90', 0.2486, 1236),
    (174, '7208.27.10', 0.2369, 3491),
    (174, '8448.39.11', 0.1049, 6854),
    (174, '9021.40.00', 0.0921, 400),
    (174, '4804.29.00', 0.1563, 4472),
    (174, '8448.32.90', 0.4694, 8756);

INSERT INTO relatorio_serv VALUES
    (174, '1.2301.92.00', '2021-11-20T00:07:09', 0.0445),
    (174, '1.0901.35.00', '2021-11-06T09:23:52', 0.7343),
    (174, '1.0905.11.00', '2021-11-28T11:32:19', 0.1487);

INSERT INTO relatorio VALUES
    (175, '2025-10-22', '2026-02-21', '56.738.014', '0001-69', '58.826.745/0001-34', 'Impacto das técnicas de produção em emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (175, '7210.90.00', 0.5221, 6514);

INSERT INTO relatorio_serv VALUES
    (175, '1.1201.50.00', '2025-11-27T19:49:45', 0.1598),
    (175, '1.0504.45.10', '2025-11-15T13:42:03', 0.4717),
    (175, '1.2403.22.00', '2025-11-26T18:43:01', 0.3316),
    (175, '1.0402.22.00', '2025-11-18T13:03:10', 0.0981),
    (175, '1.0102.31.00', '2025-11-14T00:05:55', 0.2452),
    (175, '1.1706.90.00', '2025-11-19T09:31:09', 0.2296),
    (175, '1.1805.19.00', '2025-11-24T23:46:25', 0.1952),
    (175, '1.0403.32.00', '2025-11-15T20:09:12', 0.1802),
    (175, '1.26', '2025-11-16T09:13:01', 0.108),
    (175, '1.0301.22.00', '2025-11-06T18:15:53', 0.0701),
    (175, '1.1506.23.00', '2025-11-04T22:59:54', 0.2817),
    (175, '1.0502.23.20', '2025-11-14T20:05:17', 0.2954),
    (175, '1.2002.20.00', '2025-11-06T19:22:08', 0.1555),
    (175, '1.2403.12.00', '2025-11-02T19:28:27', 0.1531),
    (175, '1.1701.5', '2025-11-15T22:33:55', 0.0078),
    (175, '1.0502.22.30', '2025-11-08T10:18:45', 0.4663),
    (175, '1.1409.29.00', '2025-11-11T15:35:15', 0.208),
    (175, '1.0106.12.00', '2025-11-13T22:26:31', 0.1692),
    (175, '1.1702', '2025-11-11T00:09:49', 0.3057),
    (175, '1.2507', '2025-11-17T18:15:52', 0.3786),
    (175, '1.1105.51.00', '2025-11-11T02:31:28', 0.2746),
    (175, '1.0102.53', '2025-11-08T12:04:59', 0.1009),
    (175, '1.2001.3', '2025-11-27T05:41:09', 0.303),
    (175, '1.1201.1', '2025-11-29T00:19:18', 0.2342),
    (175, '1.1403.22.90', '2025-11-17T09:30:42', 0.7506),
    (175, '1.2508.00.00', '2025-11-27T10:36:11', 0.0212),
    (175, '1.2001.34.30', '2025-11-27T02:18:44', 0.1198),
    (175, '1.0301.39.00', '2025-11-22T03:43:22', 0.3044);

INSERT INTO relatorio VALUES
    (176, '2023-06-04', '2025-03-01', '51.360.297', '0001-43', '37.669.280/0001-29', 'Emissões em microempresas', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (176, '5205.24.00', 0.5642, 6389),
    (176, '2921.46.80', 0.327, 4633),
    (176, '2825.30.90', 0.3921, 9868),
    (176, '8112.39.00', 0.1974, 5457),
    (176, '2849.90.10', 0.0657, 2076),
    (176, '8541.41.12', 0.2067, 2670);

INSERT INTO relatorio_serv VALUES
    (176, '1.2504.11.00', '2023-07-26T22:16:22', 0.0136),
    (176, '1.0905.12.00', '2023-07-07T12:29:16', 0.0881),
    (176, '1.0102.42.20', '2023-07-26T11:40:14', 0.3804),
    (176, '1.0103.10.00', '2023-07-28T13:18:52', 0.1222),
    (176, '1.0402.21', '2023-07-25T10:17:05', 0.0565),
    (176, '1.1103.22.00', '2023-07-08T20:57:20', 0.1956),
    (176, '1.1106.4', '2023-07-27T14:26:21', 0.1815),
    (176, '1.0901.51.1', '2023-07-25T10:56:13', 0.0441),
    (176, '1.1703.9', '2023-07-13T00:31:11', 0.0649),
    (176, '1.0505.10.00', '2023-07-06T12:02:48', 0.0392),
    (176, '1.2204.30.00', '2023-07-15T20:56:53', 0.1611),
    (176, '1.0501.14.59', '2023-07-01T13:36:00', 0.0708);

INSERT INTO relatorio VALUES
    (177, '2023-09-18', NULL, '53.921.807', '0001-18', '11.679.309/0001-01', 'Análise de emissões em São Paulo na última década', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (177, '5607.50.90', 0.0394, 8492),
    (177, '2933.11.12', 0.0272, 579),
    (177, '2931.90.29', 0.0046, 976);

INSERT INTO relatorio_serv VALUES
    (177, '1.0502.33', '2023-10-28T16:19:31', 0.1763),
    (177, '1.0609.00.00', '2023-10-30T15:28:29', 0.025),
    (177, '1.0303', '2023-10-20T17:26:37', 0.1776),
    (177, '1.0502.24.40', '2023-10-03T01:19:24', 0.0468),
    (177, '1.0910.90.00', '2023-10-29T05:31:10', 0.3573),
    (177, '1.1001.21.00', '2023-10-12T16:02:56', 0.1073),
    (177, '1.0910.20.00', '2023-10-07T04:33:35', 0.4155),
    (177, '1.1201.20.00', '2023-10-27T19:04:55', 0.049),
    (177, '1.0606.19.00', '2023-10-18T01:37:40', 0.4687),
    (177, '1.1107.31.00', '2023-10-23T05:55:38', 0.3083),
    (177, '1.1408.15.00', '2023-10-20T17:36:13', 0.2996),
    (177, '1.1405.12.00', '2023-10-17T12:04:07', 0.055),
    (177, '1.0703.00.00', '2023-10-26T04:03:39', 0.2672),
    (177, '1.1101.60.00', '2023-10-24T09:54:10', 0.2073),
    (177, '1.0904.33.00', '2023-10-20T05:51:23', 0.2251),
    (177, '1.0605.20.00', '2023-10-23T11:28:29', 0.0113);

INSERT INTO relatorio VALUES
    (178, '2021-09-15', NULL, '53.921.807', '0001-18', '37.669.280/0001-29', 'Emissões em microempresas', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (178, '7019.15.00', 0.3905, 4646),
    (178, '6216.00.00', 0.3926, 1202),
    (178, '8529.90.1', 0.1368, 1362);

INSERT INTO relatorio_serv VALUES
    (178, '1.0504.23.00', '2021-10-04T05:17:52', 0.1412),
    (178, '1.2001.39.00', '2021-10-03T12:21:41', 0.2149),
    (178, '1.0502.24.5', '2021-10-12T17:09:00', 0.0167),
    (178, '1.2003.25.10', '2021-10-13T17:15:25', 0.1182),
    (178, '1.0909.20.00', '2021-10-09T15:23:15', 0.362),
    (178, '1.0402.2', '2021-10-09T00:02:28', 0.2647),
    (178, '1.2601.40.00', '2021-10-20T13:50:15', 0.258),
    (178, '1.08', '2021-10-11T05:21:56', 0.119),
    (178, '1.0901.51.1', '2021-10-17T00:49:02', 0.075),
    (178, '1.0401.21.20', '2021-10-27T10:10:09', 0.063),
    (178, '1.0403.90.00', '2021-10-07T12:31:09', 0.2667),
    (178, '1.11', '2021-10-14T09:11:23', 0.1446),
    (178, '1.0103.20.00', '2021-10-30T23:08:51', 0.1854),
    (178, '1.1303.20.00', '2021-10-13T13:24:31', 0.1266),
    (178, '1.1302.22.00', '2021-10-01T21:36:07', 0.1631),
    (178, '1.0502.14.40', '2021-10-01T06:41:28', 0.127),
    (178, '1.2403.1', '2021-10-12T22:04:54', 0.0145),
    (178, '1.2101.22.00', '2021-10-23T23:27:57', 0.4914),
    (178, '1.22', '2021-10-16T05:36:15', 0.5084),
    (178, '1.1402.22.00', '2021-10-28T14:41:52', 0.0116),
    (178, '1.0606.1', '2021-10-10T01:30:05', 0.2845),
    (178, '1.0404', '2021-10-30T04:10:20', 0.0669),
    (178, '1.0103.4', '2021-10-28T07:17:04', 0.1458),
    (178, '1.0903.31.00', '2021-10-02T10:29:38', 0.0422),
    (178, '1.0402.19.00', '2021-10-02T21:34:36', 0.1904),
    (178, '1.0403.22.00', '2021-10-12T00:50:20', 0.1846),
    (178, '1.0107.60.00', '2021-10-15T08:26:13', 0.3022),
    (178, '1.13', '2021-10-25T18:06:12', 0.2474),
    (178, '1.0504.4', '2021-10-14T10:41:56', 0.1144),
    (178, '1.0501.24', '2021-10-25T00:19:58', 0.0523),
    (178, '1.2002.40.00', '2021-10-18T10:13:54', 0.2306),
    (178, '1.0604.90.00', '2021-10-02T18:47:29', 0.1167),
    (178, '1.0301.29.00', '2021-10-18T02:28:42', 0.0271),
    (178, '1.18', '2021-10-14T01:31:49', 0.0368),
    (178, '1.1103.42.00', '2021-10-02T08:16:08', 0.0576),
    (178, '1.2501.36.00', '2021-10-16T07:34:20', 0.2349),
    (178, '1.1105.59.00', '2021-10-04T22:00:46', 0.2094),
    (178, '1.0901.51.24', '2021-10-10T23:33:34', 0.2068),
    (178, '1.0502.22.20', '2021-10-28T20:45:05', 0.0291);

INSERT INTO relatorio VALUES
    (179, '2024-04-04', '2024-10-08', '20.978.635', '0001-10', '53.396.825/0001-34', 'Formas de reduzir o impacto de emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (179, '8505.90.80', 2.4774, 1797),
    (179, '7410.11.12', 0.0109, 4975),
    (179, '3809.91.4', 0.0264, 4383),
    (179, '8407.21.10', 0.0911, 9542),
    (179, '0301.95.90', 0.0003, 1318),
    (179, '8201.90.00', 0.0218, 400),
    (179, '2916.19.90', 0.0038, 1551),
    (179, '8412.21.90', 0.1044, 3700),
    (179, '1602.31.00', 0.1005, 400),
    (179, '7314.39.00', 0.276, 11039),
    (179, '2930.90.41', 0.003, 9225),
    (179, '3003.90.85', 0.0372, 4627),
    (179, '8406.90.2', 0.076, 7839),
    (179, '3824.99.85', 0.0216, 8119),
    (179, '2849.20.00', 0.3745, 5116),
    (179, '8708.94.90', 0.0868, 400),
    (179, '0304.46.00', 0.0126, 2946),
    (179, '9010.50.90', 0.0954, 7289),
    (179, '8471.60.53', 0.0016, 11175),
    (179, '4002.11.20', 0.2593, 400),
    (179, '2827.60.1', 0.0456, 400),
    (179, '2712.20.00', 0.0017, 400);

INSERT INTO relatorio_serv VALUES
    (179, '1.1405.90.00', '2024-05-16T02:35:40', 0.4038),
    (179, '1.1410', '2024-05-28T13:44:54', 0.0216);

INSERT INTO relatorio VALUES
    (180, '2022-07-18', '2025-07-04', '48.603.715', '0001-45', '54.777.163/0001-46', 'Andamento das metas da ONU', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (180, '2903.79.11', 0.226, 3341),
    (180, '5504.90.10', 0.213, 3511),
    (180, '5309.19.00', 0.4251, 400),
    (180, '8456.30.90', 0.114, 400),
    (180, '1902.20.00', 0.2553, 5713),
    (180, '2924.29.63', 0.0204, 3483);

INSERT INTO relatorio_serv VALUES
    (180, '1.0905.90.00', '2022-08-03T05:08:41', 0.3966),
    (180, '1.0502.23.10', '2022-08-10T12:16:44', 0.2466),
    (180, '1.2101.22.00', '2022-08-21T21:39:58', 0.8789),
    (180, '1.0602.29.00', '2022-08-29T16:48:51', 0.1201),
    (180, '1.0504.43.00', '2022-08-20T15:39:02', 0.1524),
    (180, '1.0504', '2022-08-10T22:41:09', 0.1235);

INSERT INTO relatorio VALUES
    (181, '2022-08-03', '2024-11-26', '13.690.872', '0001-54', '54.777.163/0001-46', 'O capitalismo como motor da exploração dos recursos naturais', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (181, '4304.00.00', 0.2803, 5024),
    (181, '2207.10.90', 0.4957, 7623),
    (181, '6303.99.00', 0.1552, 1957),
    (181, '8413.50.10', 0.0544, 6740),
    (181, '5808.90.00', 0.3501, 6051),
    (181, '8506.10.3', 0.32, 400),
    (181, '6909.12.10', 0.9736, 3997),
    (181, '2937.29.10', 0.2145, 416),
    (181, '2924.29.4', 0.0497, 10881),
    (181, '5607.90.10', 0.1472, 3471);

INSERT INTO relatorio_serv VALUES
    (181, '1.1106.31.00', '2022-09-27T15:06:41', 1.4196),
    (181, '1.1103.29.00', '2022-09-23T03:24:23', 0.6643),
    (181, '1.2003.24.00', '2022-09-02T07:02:33', 0.5145),
    (181, '1.0901.51.21', '2022-09-03T14:32:05', 0.4077),
    (181, '1.2301.2', '2022-09-15T00:33:32', 0.6103),
    (181, '1.0502.29.00', '2022-09-04T12:54:30', 0.1695),
    (181, '1.1101.40.00', '2022-09-01T14:54:07', 0.2446),
    (181, '1.1403.22.90', '2022-09-04T00:32:37', 0.252),
    (181, '1.0503.90.00', '2022-09-10T14:40:17', 0.393);

INSERT INTO relatorio VALUES
    (182, '2023-12-09', '2025-05-16', '48.603.715', '0001-45', '53.396.825/0001-34', 'Formas de reduzir o impacto de emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (182, '5601.22.1', 1.0529, 8397),
    (182, '8542.32.2', 0.464, 4236),
    (182, '2106.90.21', 0.0197, 11347),
    (182, '8414.90.3', 0.938, 2803),
    (182, '6309.00.90', 0.1332, 400),
    (182, '2834.29.30', 0.3953, 5991),
    (182, '7006.00.00', 1.0891, 5839),
    (182, '6208.21.00', 0.7401, 400),
    (182, '7415.39.00', 0.2129, 400),
    (182, '0804.10.10', 0.0559, 11329),
    (182, '8704.23.90', 0.0958, 400),
    (182, '2933.29.13', 0.3727, 6753);

INSERT INTO relatorio_serv VALUES
    (182, '1.2301.95.00', '2024-01-09T06:40:42', 0.1927),
    (182, '1.2501.33.00', '2024-01-21T23:07:01', 0.2667),
    (182, '1.1803.22.00', '2024-01-19T00:28:49', 0.0449),
    (182, '1.1410.90.00', '2024-01-03T05:57:36', 0.2103),
    (182, '1.0907.00.00', '2024-01-14T05:47:06', 0.5569),
    (182, '1.0401.1', '2024-01-01T22:19:05', 0.1304),
    (182, '1.0904.32.00', '2024-01-22T14:31:04', 0.2858),
    (182, '1.0102.31.00', '2024-01-18T03:51:14', 0.2265),
    (182, '1.0403.33.00', '2024-01-29T21:59:40', 0.2931),
    (182, '1.1105.4', '2024-01-21T22:58:08', 0.1718),
    (182, '1.0802.30.00', '2024-01-06T22:12:34', 0.2257),
    (182, '1.0905.2', '2024-01-26T22:10:07', 0.2512);

INSERT INTO relatorio VALUES
    (183, '2023-01-02', NULL, '75.893.062', '0001-33', '00.001.333/0001-99', 'Tipos de emissão em empresas de refinaria', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (183, '0713.33.91', 0.0933, 400);

INSERT INTO relatorio_serv VALUES
    (183, '1.1001.40.00', '2023-02-02T19:28:05', 0.1748),
    (183, '1.0604.40.00', '2023-02-27T01:46:57', 0.1335),
    (183, '1.2304.19.00', '2023-02-17T06:28:22', 0.0093),
    (183, '1.2508.00.00', '2023-02-19T08:29:40', 0.0634),
    (183, '1.13', '2023-02-23T22:26:40', 0.0381),
    (183, '1.0101.21.00', '2023-02-15T04:08:49', 0.0564),
    (183, '1.1301.30.00', '2023-02-02T02:41:38', 0.0769),
    (183, '1.1706.21.00', '2023-02-18T04:57:27', 0.1209),
    (183, '1.2501', '2023-02-21T03:55:07', 0.0338),
    (183, '1.0107.50.00', '2023-02-13T18:40:33', 0.0975),
    (183, '1.1703.21.00', '2023-02-22T05:00:36', 0.0817),
    (183, '1.1001.12', '2023-02-18T13:43:18', 0.0718),
    (183, '1.0501.1', '2023-02-06T19:44:42', 0.094),
    (183, '1.11', '2023-02-17T16:33:36', 0.1117),
    (183, '1.1803.10.00', '2023-02-23T01:56:38', 0.0909),
    (183, '1.1804.00.00', '2023-02-27T23:18:55', 0.062),
    (183, '1.0901.51.23', '2023-02-22T11:07:40', 0.0269),
    (183, '1.1104.20.00', '2023-02-22T18:56:27', 0.0056),
    (183, '1.2601.90.00', '2023-02-05T16:06:52', 0.0643),
    (183, '1.0502.19.00', '2023-02-18T17:48:32', 0.2325),
    (183, '1.0901.51.13', '2023-02-13T06:29:07', 0.1211),
    (183, '1.1103', '2023-02-12T13:36:47', 0.0241),
    (183, '1.1408.20.00', '2023-02-14T16:28:19', 0.0488),
    (183, '1.0503.26.00', '2023-02-11T17:39:15', 0.0945),
    (183, '1.0901.51', '2023-02-02T19:47:58', 0.1173),
    (183, '1.2301.95.00', '2023-02-11T03:16:06', 0.0388),
    (183, '1.1103.22.00', '2023-02-12T11:21:38', 0.0641),
    (183, '1.1402.22.00', '2023-02-13T02:51:59', 0.0432),
    (183, '1.1404.41.00', '2023-02-19T17:26:44', 0.0624),
    (183, '1.0802.20.00', '2023-02-22T05:44:08', 0.0513),
    (183, '1.1802.20.00', '2023-02-05T15:24:55', 0.0392),
    (183, '1.2404.32.00', '2023-02-25T01:17:32', 0.1107),
    (183, '1.0504.45.20', '2023-02-27T19:49:53', 0.0153),
    (183, '1.1806.3', '2023-02-02T17:00:04', 0.0666),
    (183, '1.1401.21.00', '2023-02-26T22:10:11', 0.1753),
    (183, '1.0102.33.00', '2023-02-19T17:50:47', 0.0541),
    (183, '1.0904.37.00', '2023-02-03T19:41:23', 0.1201),
    (183, '1.1304.00.00', '2023-02-27T00:35:20', 0.1097),
    (183, '1.1102.30.00', '2023-02-11T04:30:24', 0.0429),
    (183, '1.2003.26.10', '2023-02-09T14:44:25', 0.0125);

INSERT INTO relatorio VALUES
    (184, '2023-06-07', NULL, '33.738.001', '0001-77', '00.001.333/0001-99', 'Tipos de emissão em empresas de refinaria', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (184, '6909.12.90', 0.0124, 11966),
    (184, '1605.40.00', 0.0008, 10963),
    (184, '2826.19.10', 0.0426, 1282),
    (184, '9305.99.00', 0.245, 14795),
    (184, '2401.30.00', 0.1126, 1397),
    (184, '7019.14.00', 0.0317, 6553),
    (184, '3004.90.13', 0.1059, 6888),
    (184, '6904.10.00', 0.0561, 11693),
    (184, '9307.00.00', 0.0983, 6616),
    (184, '2933.69.22', 0.0685, 6137),
    (184, '8540.60.10', 0.0115, 8879),
    (184, '7605.11.10', 0.0182, 4270),
    (184, '3003.90.76', 0.0425, 12339),
    (184, '9507.30.00', 0.1347, 400),
    (184, '6004.90.10', 0.0382, 3786),
    (184, '2922.19.11', 0.0806, 6327),
    (184, '8419.40.10', 0.0251, 6727),
    (184, '9030.33.90', 0.049, 2257),
    (184, '7305.12.00', 0.0155, 5198),
    (184, '6307.10.00', 0.0086, 400),
    (184, '6103.41.00', 0.0562, 4412),
    (184, '8458.99.00', 0.0414, 1806),
    (184, '7320.10.00', 0.0543, 3780),
    (184, '6214.90.10', 0.0702, 1371);

INSERT INTO relatorio VALUES
    (185, '2025-07-24', '2025-09-25', '75.893.062', '0001-33', '58.826.745/0001-34', 'Impacto das técnicas de produção em emissões', NULL, NULL, NULL);

INSERT INTO relatorio_serv VALUES
    (185, '1.0501.22.20', '2025-08-17T11:46:10', 0.6471),
    (185, '1.2406', '2025-08-16T20:25:06', 0.1759),
    (185, '1.2501.33.00', '2025-08-28T18:23:53', 0.1039),
    (185, '1.2003.29.00', '2025-08-27T22:50:34', 0.3873),
    (185, '1.0504.45.90', '2025-08-26T04:49:13', 0.6746),
    (185, '1.1201.90.00', '2025-08-21T15:46:29', 0.758),
    (185, '1.2502.10.00', '2025-08-20T07:46:03', 0.0634),
    (185, '1.0106.3', '2025-08-25T05:57:25', 1.0446),
    (185, '1.0501.14.52', '2025-08-25T10:14:27', 0.4903),
    (185, '1.2404.1', '2025-08-25T13:44:20', 0.8882),
    (185, '1.2001', '2025-08-29T20:39:24', 0.1904),
    (185, '1.0501.1', '2025-08-20T05:52:24', 0.2082),
    (185, '1.1406.34.00', '2025-08-14T14:24:15', 0.4922),
    (185, '1.0102.13.00', '2025-08-29T04:30:04', 0.3916),
    (185, '1.1001.90.00', '2025-08-19T22:18:43', 0.3991),
    (185, '1.0401.21.10', '2025-08-23T06:48:01', 0.5174),
    (185, '1.0502.24', '2025-08-19T19:15:15', 1.3501),
    (185, '1.1507', '2025-08-18T05:11:49', 0.5135);

INSERT INTO relatorio VALUES
    (186, '2025-11-27', '2026-06-08', '75.893.062', '0001-33', '58.826.745/0001-34', 'Emissões a alto nível', NULL, NULL, NULL);

INSERT INTO relatorio_serv VALUES
    (186, '1.0502.23.10', '2025-12-25T00:29:01', 0.0094),
    (186, '1.1405.22.00', '2025-12-11T20:53:08', 0.062),
    (186, '1.1703.2', '2025-12-09T23:33:34', 0.5037),
    (186, '1.0903.33.00', '2025-12-20T21:48:23', 0.1894),
    (186, '1.0901.51', '2025-12-15T12:56:14', 0.0584),
    (186, '1.0502.22', '2025-12-23T11:23:17', 0.464),
    (186, '1.1403.90.00', '2025-12-25T06:49:08', 0.1631),
    (186, '1.1903.40.00', '2025-12-26T06:57:38', 0.1033),
    (186, '1.0401.1', '2025-12-14T15:49:01', 0.0505),
    (186, '1.1404.13.00', '2025-12-02T19:06:16', 0.0845),
    (186, '1.0502.34.52', '2025-12-26T09:14:03', 0.1218),
    (186, '1.2205.11.00', '2025-12-21T17:12:51', 0.034);

INSERT INTO relatorio VALUES
    (187, '2026-03-25', NULL, '51.360.297', '0001-43', '37.669.280/0001-29', 'Emissões em microempresas', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (187, '5212.25.00', 0.0066, 3445),
    (187, '3301.13.00', 0.0727, 4043),
    (187, '2924.29.6', 0.0655, 9835),
    (187, '3907.10.41', 0.0246, 400),
    (187, '5510.30.12', 0.2479, 4664),
    (187, '3824.99.88', 0.0414, 6978),
    (187, '0802.99.00', 0.0395, 1817),
    (187, '1505.00.10', 0.0957, 3661),
    (187, '8413.81.00', 0.1091, 3342),
    (187, '8473.21.00', 0.0566, 400),
    (187, '4107.19.10', 0.1064, 4765),
    (187, '2811.19.90', 0.036, 2641),
    (187, '9111.90.90', 0.0169, 400),
    (187, '9007.20.90', 0.0231, 7639),
    (187, '8607.11.10', 0.071, 400);

INSERT INTO relatorio_serv VALUES
    (187, '1.0901.10.00', '2026-04-25T16:25:17', 0.2474),
    (187, '1.0802.10.00', '2026-04-06T10:44:50', 0.1368),
    (187, '1.0502.1', '2026-04-13T10:36:56', 0.0606),
    (187, '1.1403.22.11', '2026-04-19T07:06:49', 0.2483),
    (187, '1.0502.31.20', '2026-04-29T08:31:24', 0.3367),
    (187, '1.0301.90.00', '2026-04-17T23:27:44', 0.0455),
    (187, '1.1401.14.00', '2026-04-16T06:22:58', 0.0221),
    (187, '1.0403.23.00', '2026-04-22T07:55:43', 0.1425),
    (187, '1.1706.21.00', '2026-04-17T17:06:48', 0.083),
    (187, '1.1805.3', '2026-04-19T11:13:55', 0.2517),
    (187, '1.1806.53.00', '2026-04-25T02:42:21', 0.0404),
    (187, '1.2403.22.00', '2026-04-13T12:36:35', 0.0977);

INSERT INTO relatorio VALUES
    (188, '2021-12-21', NULL, '09.723.145', '0001-56', '54.777.163/0001-46', 'O capitalismo como motor da exploração dos recursos naturais', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (188, '2921.19.99', 1.942, 400),
    (188, '0302.89.21', 0.0285, 720),
    (188, '7604.21.00', 0.0125, 1173),
    (188, '8211.92.10', 0.0053, 3097),
    (188, '3824.99.8', 0.3009, 8652),
    (188, '3808.92.91', 0.0702, 6505),
    (188, '0801.12.00', 0.003, 4434),
    (188, '8471.50.10', 0.2384, 9342);

INSERT INTO relatorio_serv VALUES
    (188, '1.1105.41.00', '2022-01-11T15:08:35', 0.5202),
    (188, '1.23', '2022-01-28T01:17:40', 0.0505),
    (188, '1.1401.31.00', '2022-01-09T00:05:42', 0.1021),
    (188, '1.1107.20.00', '2022-01-11T05:59:22', 0.0221);

INSERT INTO relatorio VALUES
    (189, '2021-07-31', NULL, '09.723.145', '0001-78', '09.850.333/0001-77', 'Emissões: e eu com isso?', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (189, '9031.80.9', 8.8954, 400),
    (189, '8476.89.10', 0.0256, 4427),
    (189, '1602.20.00', 0.3873, 400),
    (189, '4814.90.00', 0.0511, 10249),
    (189, '8309.90.00', 0.0372, 5874),
    (189, '2915.90.33', 0.7203, 7125),
    (189, '8413.30.20', 0.7097, 1150),
    (189, '2939.80.10', 0.0601, 1745),
    (189, '2817.00.20', 0.435, 7332),
    (189, '3812.39.19', 0.166, 400),
    (189, '7220.12.90', 0.3903, 3398);

INSERT INTO relatorio VALUES
    (190, '2023-11-19', '2026-05-27', '48.912.037', '0001-48', '11.679.309/0001-01', 'Análise de emissões em São Paulo na última década', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (190, '5510.90.12', 0.8344, 4274),
    (190, '6806.90.10', 0.0143, 400),
    (190, '8514.90.00', 0.0111, 14107),
    (190, '8413.70.10', 0.0513, 7099),
    (190, '4805.19.00', 0.0079, 400),
    (190, '5211.49.00', 0.026, 3554),
    (190, '5402.45.20', 0.0148, 4537),
    (190, '2825.50.10', 0.0131, 400),
    (190, '8445.40.12', 0.0193, 4835),
    (190, '3101.00.00', 0.0078, 5724),
    (190, '9208.10.00', 0.0686, 7006),
    (190, '2933.91.4', 0.0062, 1108),
    (190, '6004.10.42', 0.0022, 400),
    (190, '2933.59.14', 0.0021, 2036),
    (190, '3926.10.00', 0.0608, 400),
    (190, '2103.90.1', 0.0072, 2119);

INSERT INTO relatorio_serv VALUES
    (190, '1.0604.2', '2023-12-09T18:22:42', 0.3959),
    (190, '1.0102.53.20', '2023-12-26T05:35:49', 0.0151),
    (190, '1.0501.3', '2023-12-01T12:05:13', 0.0202),
    (190, '1.0301.31.00', '2023-12-30T05:35:07', 0.0099);

INSERT INTO relatorio VALUES
    (191, '2021-10-11', '2025-03-02', '09.723.145', '0001-78', '09.850.333/0001-77', 'Emissões: e eu com isso?', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (191, '4811.90.19', 3.7516, 1451),
    (191, '3824.88.20', 0.0724, 1885),
    (191, '2931.59.98', 0.1459, 400),
    (191, '8504.31.11', 0.0392, 1540),
    (191, '9402.90.90', 0.3607, 12451),
    (191, '8517.61.30', 0.1327, 2369),
    (191, '3808.92.91', 0.4335, 10755),
    (191, '0703.90.90', 0.2594, 5219),
    (191, '4410.19.99', 0.0022, 1702),
    (191, '7301.20.00', 0.0451, 9588),
    (191, '3702.41.00', 0.0888, 1627),
    (191, '8465.91.20', 0.0234, 400),
    (191, '3701.30.10', 0.0077, 7966),
    (191, '3002.12.33', 0.6161, 8852),
    (191, '4002.19.12', 0.0227, 400),
    (191, '8425.11.00', 0.1033, 2512),
    (191, '2523.10.00', 0.2739, 7617),
    (191, '6202.40.00', 0.2927, 400),
    (191, '8507.30.1', 0.044, 400),
    (191, '8540.40.00', 0.0361, 5891),
    (191, '4802.61.92', 0.0668, 2317),
    (191, '2852.10.29', 0.2432, 400),
    (191, '1105.10.00', 0.0398, 4768),
    (191, '3919.90.20', 0.7311, 2198),
    (191, '8433.11.00', 0.7505, 400),
    (191, '4705.00.00', 0.0096, 4829),
    (191, '6107.19.00', 0.0018, 5466),
    (191, '3703.10.2', 0.023, 7865);

INSERT INTO relatorio_serv VALUES
    (191, '1.0401.15.10', '2021-11-13T18:32:48', 1.1923);

INSERT INTO relatorio VALUES
    (192, '2022-09-03', '2025-04-16', '09.723.145', '0001-78', '09.850.333/0001-77', 'Emissões: e eu com isso?', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (192, '2853.90.30', 3.1846, 400),
    (192, '2940.00.22', 0.0443, 1738),
    (192, '3906.90.2', 0.1859, 3120),
    (192, '3004.39.26', 0.1448, 13374),
    (192, '2523.90.00', 0.0367, 400),
    (192, '2915.70.39', 0.003, 4979),
    (192, '9022.90.9', 0.0901, 400),
    (192, '5211.52.00', 0.2426, 10656),
    (192, '6813.89.90', 0.0335, 4908),
    (192, '6005.24.00', 0.0023, 6535),
    (192, '6107.91.00', 0.0295, 6493),
    (192, '2841.30.00', 0.3075, 400),
    (192, '8421.99.10', 0.1547, 9678),
    (192, '9105.19.00', 0.0699, 10239),
    (192, '8605.00.10', 0.2344, 2694),
    (192, '8434.20.10', 0.176, 1271),
    (192, '3004.90.76', 0.0315, 8209);

INSERT INTO relatorio_serv VALUES
    (192, '1.0403.32.00', '2022-10-07T01:16:04', 1.1578),
    (192, '1.0602.29.00', '2022-10-19T23:27:44', 0.0042),
    (192, '1.1202.30.00', '2022-10-04T16:03:03', 0.0674);

INSERT INTO relatorio VALUES
    (193, '2026-03-12', NULL, '09.723.145', '0001-56', '54.777.163/0001-46', 'Andamento das metas da ONU', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (193, '8539.31.19', 4.3227, 400),
    (193, '2915.90.32', 0.1708, 400),
    (193, '3603.30.00', 0.0045, 4598),
    (193, '2702.20.00', 0.1578, 7463),
    (193, '1505.00.90', 0.1058, 11803),
    (193, '8511.10.00', 0.2473, 400),
    (193, '0303.64.00', 0.0012, 12887),
    (193, '3002.41.22', 0.0457, 8677),
    (193, '2934.99.93', 0.1723, 400),
    (193, '5305.00.90', 0.2738, 8277),
    (193, '2807.00.20', 0.0909, 400),
    (193, '8474.20.90', 0.2093, 4051),
    (193, '6811.81.00', 0.0357, 400),
    (193, '2918.16.10', 0.2492, 400),
    (193, '8426.49.10', 0.0929, 1267);

INSERT INTO relatorio VALUES
    (194, '2024-05-08', '2026-05-14', '28.659.130', '0001-07', '00.001.333/0001-99', 'Tipos de emissão em empresas de refinaria', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (194, '2933.91.8', 0.0948, 6933),
    (194, '2933.99.6', 0.0971, 400);

INSERT INTO relatorio_serv VALUES
    (194, '1.0604.21.00', '2024-06-14T19:00:29', 0.0158),
    (194, '1.1706.12.00', '2024-06-09T18:35:25', 0.3144),
    (194, '1.2604.00.00', '2024-06-12T00:37:04', 0.2409),
    (194, '1.0402.11', '2024-06-07T17:49:44', 0.1148),
    (194, '1.1301.20.00', '2024-06-02T11:42:23', 0.0592),
    (194, '1.0906.30.00', '2024-06-06T13:02:08', 0.7481),
    (194, '1.2203.10.00', '2024-06-08T10:07:38', 0.054),
    (194, '1.0402', '2024-06-28T04:25:36', 0.69),
    (194, '1.2501.12.00', '2024-06-17T12:44:50', 0.3291),
    (194, '1.1805.11.00', '2024-06-11T01:54:32', 0.5936),
    (194, '1.2503.10.00', '2024-06-02T06:32:15', 0.108),
    (194, '1.1802.10.00', '2024-06-08T13:56:26', 0.0856),
    (194, '1.1404.1', '2024-06-24T19:59:37', 0.4798),
    (194, '1.2605.00.00', '2024-06-01T21:17:45', 0.0279),
    (194, '1.1409.12.00', '2024-06-08T02:19:33', 0.3417),
    (194, '1.1803.2', '2024-06-07T17:53:00', 0.2785),
    (194, '1.1507.20.00', '2024-06-15T21:18:20', 0.6652),
    (194, '1.1507.10.00', '2024-06-12T09:38:50', 0.1773),
    (194, '1.2402', '2024-06-21T02:12:05', 0.0398),
    (194, '1.0501.21.20', '2024-06-08T23:55:32', 0.3943),
    (194, '1.1806.6', '2024-06-17T15:02:06', 0.0761),
    (194, '1.1102.20.00', '2024-06-14T20:17:30', 0.1137),
    (194, '1.2001.32.00', '2024-06-16T16:18:18', 0.39),
    (194, '1.1401', '2024-06-07T16:23:31', 0.1027),
    (194, '1.0401.43.00', '2024-06-18T03:53:29', 0.1128),
    (194, '1.1403.10.00', '2024-06-01T14:52:44', 0.1348),
    (194, '1.1001.12.10', '2024-06-28T20:11:55', 0.1382),
    (194, '1.1109', '2024-06-28T02:02:09', 0.1077),
    (194, '1.0903.38.00', '2024-06-28T07:03:20', 0.9646),
    (194, '1.1801.2', '2024-06-02T17:03:57', 0.235),
    (194, '1.0903.1', '2024-06-15T21:45:52', 0.6089),
    (194, '1.1106.34.00', '2024-06-05T16:56:54', 0.6333),
    (194, '1.0901.34.00', '2024-06-16T02:02:14', 0.087),
    (194, '1.1404', '2024-06-08T06:20:26', 0.3139);

INSERT INTO relatorio VALUES
    (195, '2025-01-14', '2025-11-02', '12.905.674', '0001-18', '54.777.163/0001-46', 'O capitalismo como motor da exploração dos recursos naturais', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (195, '3808.93.49', 0.0609, 7629),
    (195, '8536.30.90', 0.0381, 4121),
    (195, '7415.33.00', 0.1313, 2194),
    (195, '8479.71.00', 0.1773, 2923),
    (195, '8708.21.00', 0.0096, 9210),
    (195, '2710.12.60', 0.0706, 400),
    (195, '6202.90.00', 0.3442, 11573),
    (195, '6111.90.90', 0.1772, 9111),
    (195, '3911.90.29', 0.0574, 4595),
    (195, '8413.60.11', 0.0781, 5825),
    (195, '8481.80.29', 0.0543, 400),
    (195, '0104.10.11', 0.3679, 5519),
    (195, '3825.90.00', 0.1087, 3577),
    (195, '0101.90.00', 0.1106, 400),
    (195, '1207.99.10', 0.0692, 4579);

INSERT INTO relatorio_serv VALUES
    (195, '1.1404.22.00', '2025-02-02T21:31:29', 0.0555),
    (195, '1.0905.13.00', '2025-02-25T04:24:55', 0.2097),
    (195, '1.1103.33.00', '2025-02-04T14:42:56', 0.1547),
    (195, '1.1105.10.00', '2025-02-21T21:45:10', 0.2676);

INSERT INTO relatorio VALUES
    (196, '2024-06-08', '2024-09-15', '48.912.037', '0001-48', '58.826.745/0001-34', 'Emissões e as metas da ONU', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (196, '1302.13.00', 2.1802, 400),
    (196, '8504.31.99', 0.0823, 6956),
    (196, '3914.00.1', 0.1341, 10536),
    (196, '2921.19.3', 0.1572, 7538),
    (196, '2834.10.10', 0.0173, 676),
    (196, '4407.19.00', 0.0367, 8687),
    (196, '8415.90.20', 0.0023, 435),
    (196, '2621.90.10', 0.0081, 13725),
    (196, '3507.10.00', 0.0459, 400),
    (196, '7605.11.10', 0.0249, 10415),
    (196, '2930.90.94', 0.0464, 400),
    (196, '8525.89.29', 0.2901, 2275),
    (196, '5607.50.1', 0.0623, 7651),
    (196, '2308.00.00', 0.0278, 400),
    (196, '5402.47.90', 0.1373, 12166),
    (196, '9021.90.91', 0.0044, 400),
    (196, '5501.11.00', 0.0001, 3733),
    (196, '3206.50.29', 0.0115, 11419);

INSERT INTO relatorio VALUES
    (197, '2021-08-04', NULL, '65.172.380', '0001-61', '53.396.825/0001-34', 'Formas de reduzir o impacto de emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (197, '5208.11.00', 0.0075, 8315),
    (197, '7114.20.00', 0.1297, 7353),
    (197, '5401.10.12', 0.1129, 2154),
    (197, '3206.50.1', 0.0562, 6387),
    (197, '8541.10.9', 0.0217, 8387),
    (197, '4419.20.00', 0.0646, 7278),
    (197, '8425.31.10', 0.2164, 2483),
    (197, '6117.90.00', 0.1999, 14959),
    (197, '3909.10.00', 0.1103, 1225),
    (197, '2933.55.10', 0.0545, 12665),
    (197, '0401.20.90', 0.1523, 2668),
    (197, '5512.29.00', 0.0129, 400),
    (197, '8201.10.00', 0.0334, 9701),
    (197, '5911.90.00', 0.0455, 3838),
    (197, '8513.10.90', 0.0011, 400),
    (197, '2921.51.34', 0.1029, 400),
    (197, '2933.39.3', 0.1096, 400),
    (197, '8209.00.19', 0.035, 5262),
    (197, '4408.90.10', 0.126, 3183),
    (197, '8542.90.00', 0.1424, 14312),
    (197, '7211.90.90', 0.2948, 5265);

INSERT INTO relatorio_serv VALUES
    (197, '1.1409.90.00', '2021-09-04T07:58:11', 0.0629),
    (197, '1.1801.1', '2021-09-19T03:33:46', 0.0147);

INSERT INTO relatorio VALUES
    (198, '2025-02-07', NULL, '48.912.037', '0001-48', '58.826.745/0001-34', 'Emissões a alto nível', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (198, '3603.50.00', 2.0339, 11236),
    (198, '5509.31.00', 0.2439, 7449),
    (198, '2922.49.6', 0.0444, 4089),
    (198, '2924.29.47', 0.1337, 4946),
    (198, '0102.29.19', 0.2814, 4088),
    (198, '5402.39.00', 0.0196, 4396),
    (198, '8465.95.92', 0.0491, 7427),
    (198, '3002.41.21', 0.0685, 650),
    (198, '8539.32.30', 0.0168, 6193),
    (198, '3808.61.00', 0.241, 12014),
    (198, '1605.62.00', 0.0028, 4540),
    (198, '2916.20.13', 0.0497, 400),
    (198, '2710.19.91', 0.1077, 8496),
    (198, '2933.53.21', 0.026, 4654),
    (198, '7315.12.90', 0.3104, 722),
    (198, '9106.90.00', 0.1183, 12186),
    (198, '7203.10.00', 0.0258, 11845),
    (198, '1605.10.00', 0.0204, 1295);

INSERT INTO relatorio_serv VALUES
    (198, '1.0103.10.00', '2025-03-10T06:08:30', 0.9442);

INSERT INTO relatorio VALUES
    (199, '2022-01-16', '2023-10-27', '48.912.037', '0001-48', '37.669.280/0001-29', 'Pesquisa de campo em emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (199, '0713.20.10', 0.8478, 6772),
    (199, '6812.99.90', 0.0188, 15040),
    (199, '8410.12.00', 0.0124, 11732),
    (199, '2917.13.29', 0.0323, 400),
    (199, '8424.30.20', 0.0307, 654),
    (199, '2009.12.00', 0.001, 400),
    (199, '8448.20.10', 0.0054, 4578),
    (199, '2924.29.92', 0.0028, 10866),
    (199, '2939.79.1', 0.0286, 3241),
    (199, '0105.15.00', 0.0063, 10330),
    (199, '2931.90.90', 0.0003, 7717),
    (199, '3002.12.21', 0.0077, 5755),
    (199, '2811.12.00', 0.0203, 400),
    (199, '2931.90.52', 0.0028, 400),
    (199, '8105.90.10', 0.0934, 3743),
    (199, '2916.16.00', 0.0013, 3172),
    (199, '9405.50.00', 0.0024, 2771),
    (199, '3825.50.00', 0.1232, 11089),
    (199, '8525.83.00', 0.0062, 1099),
    (199, '5211.49.00', 0.0033, 3274),
    (199, '5402.32.11', 0.0094, 2157),
    (199, '4202.91.00', 0.021, 6668),
    (199, '2933.59.91', 0.0051, 400),
    (199, '2520.10.20', 0.0176, 4942),
    (199, '2914.19.21', 0.0938, 9193),
    (199, '3809.92.19', 0.0197, 11135),
    (199, '2530.90.10', 0.0023, 8392);

INSERT INTO relatorio_serv VALUES
    (199, '1.1405.21.00', '2022-02-17T20:08:39', 0.385),
    (199, '1.1406.34.00', '2022-02-01T16:15:38', 0.0286),
    (199, '1.0401.14.00', '2022-02-15T18:56:10', 0.0404),
    (199, '1.1401.39.00', '2022-02-15T11:17:36', 0.0003);

INSERT INTO relatorio VALUES
    (200, '2021-09-03', '2025-12-19', '48.912.037', '0001-48', '58.826.745/0001-34', 'Emissões a alto nível', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (200, '8422.40.30', 4.6942, 6158),
    (200, '4012.13.00', 0.0389, 5367),
    (200, '0303.99.90', 0.0665, 3370),
    (200, '4410.11.29', 0.0056, 4004),
    (200, '3003.20.63', 0.0084, 400),
    (200, '0304.89.10', 0.1081, 400),
    (200, '7304.41.90', 0.6049, 400),
    (200, '9504.90.10', 0.0027, 400),
    (200, '8423.30.19', 0.0415, 7455),
    (200, '5501.20.00', 0.0694, 439),
    (200, '2843.90.90', 0.2989, 20449),
    (200, '0811.20.00', 0.117, 400),
    (200, '3808.94.1', 0.002, 10037),
    (200, '2933.99.35', 0.0164, 5813),
    (200, '8704.21.10', 0.5142, 4675),
    (200, '4823.20.91', 0.4455, 1364),
    (200, '3003.90.87', 0.0825, 12188),
    (200, '7208.39.90', 0.0066, 7823),
    (200, '3923.21.90', 0.0275, 400),
    (200, '5305.00.10', 0.1328, 11995);

INSERT INTO relatorio VALUES
    (201, '2021-11-29', NULL, '01.274.895', '0001-40', '11.679.309/0001-01', 'Impacto de programas de incentivo fiscal na redução de emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (201, '5509.32.00', 0.0716, 9868),
    (201, '6104.13.00', 0.1869, 634);

INSERT INTO relatorio_serv VALUES
    (201, '1.0501.2', '2021-12-22T08:38:53', 0.0019),
    (201, '1.0502.33.20', '2021-12-12T18:25:00', 0.0051),
    (201, '1.2603.00.00', '2021-12-12T17:58:52', 0.0131),
    (201, '1.1406.32.00', '2021-12-07T20:44:48', 0.0375),
    (201, '1.1903.50.00', '2021-12-17T18:20:28', 0.0851),
    (201, '1.0107.60.00', '2021-12-06T23:06:19', 0.0367),
    (201, '1.1107.33.00', '2021-12-03T09:15:55', 0.0557),
    (201, '1.2203.10.00', '2021-12-07T18:00:32', 0.0982),
    (201, '1.0102.42.20', '2021-12-02T13:31:41', 0.3693),
    (201, '1.0203.00.00', '2021-12-10T11:14:16', 0.1388),
    (201, '1.2501.35.00', '2021-12-03T16:06:23', 0.0402),
    (201, '1.0501.21.30', '2021-12-26T21:53:41', 0.0823),
    (201, '1.1706.21.00', '2021-12-07T04:22:05', 0.0049),
    (201, '1.1801.12.00', '2021-12-10T03:00:46', 0.0702),
    (201, '1.2502', '2021-12-01T04:26:00', 0.0347),
    (201, '1.1806.39.00', '2021-12-05T03:04:35', 0.0396),
    (201, '1.0502.33.10', '2021-12-27T21:46:49', 0.0813),
    (201, '1.0303.13.00', '2021-12-05T06:36:50', 0.0438),
    (201, '1.0501.14.52', '2021-12-20T01:04:43', 0.0677),
    (201, '1.2301.99.00', '2021-12-25T12:35:12', 0.0312),
    (201, '1.0909', '2021-12-07T05:21:12', 0.0438),
    (201, '1.1806.3', '2021-12-14T22:15:45', 0.0181),
    (201, '1.0904.37.00', '2021-12-18T03:07:29', 0.04),
    (201, '1.0502.14.20', '2021-12-25T19:22:11', 0.0046),
    (201, '1.1805.32.00', '2021-12-25T02:08:32', 0.1372),
    (201, '1.0101', '2021-12-06T01:30:11', 0.0156),
    (201, '1.0403.31.00', '2021-12-15T10:47:04', 0.1051),
    (201, '1.0504.3', '2021-12-12T12:37:53', 0.0708),
    (201, '1.0501.11.20', '2021-12-04T01:44:56', 0.081),
    (201, '1.0402.21', '2021-12-22T06:16:53', 0.0572),
    (201, '1.0102', '2021-12-20T13:17:04', 0.0681),
    (201, '1.2101', '2021-12-07T05:34:41', 0.051);

INSERT INTO relatorio VALUES
    (202, '2025-08-23', '2026-06-08', '65.172.380', '0001-61', '54.777.163/0001-46', 'Andamento das metas da ONU', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (202, '6110.20.00', 0.3912, 1707),
    (202, '6204.61.00', 0.4119, 9124),
    (202, '2842.90.00', 0.32, 400),
    (202, '8806.94.00', 0.0625, 9127),
    (202, '3906.90.21', 0.1273, 400),
    (202, '3707.90.29', 0.4872, 3257),
    (202, '2306.20.00', 0.1615, 5585),
    (202, '8516.10.00', 0.1902, 1544),
    (202, '5402.62.00', 0.2171, 16253),
    (202, '5109.10.00', 0.3558, 2960),
    (202, '2928.00.30', 0.3568, 2517),
    (202, '4010.12.00', 0.381, 9443),
    (202, '2937.22.39', 0.1049, 400);

INSERT INTO relatorio_serv VALUES
    (202, '1.0907.00.00', '2025-09-03T08:42:25', 0.7104);

INSERT INTO relatorio VALUES
    (203, '2024-07-13', '2025-10-12', '65.172.380', '0001-61', '54.777.163/0001-46', 'O capitalismo como motor da exploração dos recursos naturais', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (203, '2926.90.30', 0.0843, 9320),
    (203, '4802.40.10', 0.008, 9167),
    (203, '8426.19.00', 0.0193, 4411),
    (203, '8543.70.15', 0.1353, 400),
    (203, '3002.12.14', 0.031, 12963),
    (203, '3920.59.00', 0.0428, 4329),
    (203, '2921.42.4', 0.0435, 5273),
    (203, '2924.19.32', 0.0568, 1501),
    (203, '9027.30.1', 0.0032, 7492),
    (203, '0105.13.00', 0.1308, 400),
    (203, '8446.30.90', 0.0265, 3903),
    (203, '3825.61.00', 0.0498, 12357),
    (203, '8448.39.92', 0.0897, 9112),
    (203, '0602.90.10', 0.0718, 3766),
    (203, '6815.99.13', 0.044, 400),
    (203, '8534.00.1', 0.0305, 400),
    (203, '2941.90.49', 0.0681, 2708),
    (203, '8517.62.64', 0.0297, 14933),
    (203, '6115.29.20', 0.0866, 6199),
    (203, '2903.46.00', 0.0806, 4243),
    (203, '1302.19.40', 0.1383, 400),
    (203, '3701.30.31', 0.0263, 5461),
    (203, '8540.91.20', 0.0613, 3759),
    (203, '2930.90.79', 0.0076, 3508);

INSERT INTO relatorio_serv VALUES
    (203, '1.1806.59.00', '2024-08-05T14:39:01', 0.0058),
    (203, '1.0901.51.25', '2024-08-27T15:55:57', 0.0092),
    (203, '1.1109.90.00', '2024-08-22T04:17:43', 0.1291);

INSERT INTO relatorio VALUES
    (204, '2023-03-29', '2025-11-24', '48.603.715', '0001-45', '53.396.825/0001-34', 'Formas de reduzir o impacto de emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (204, '8401.20.00', 0.0691, 10780),
    (204, '5210.19.10', 0.001, 2618),
    (204, '2804.70.10', 0.0761, 400),
    (204, '8406.90.21', 0.0652, 5465),
    (204, '8409.91.15', 0.0878, 400),
    (204, '2621.90.90', 0.0224, 6829),
    (204, '2903.77.33', 0.1151, 7625),
    (204, '9305.91.00', 0.056, 400),
    (204, '8479.89.40', 0.1951, 1452),
    (204, '2922.49.20', 0.0265, 7382),
    (204, '0303.89.6', 0.0521, 1910),
    (204, '8421.91.10', 0.0161, 8827),
    (204, '3301.29.18', 0.205, 400),
    (204, '8539.31.3', 0.0731, 1385);

INSERT INTO relatorio_serv VALUES
    (204, '1.2304.1', '2023-04-21T23:29:55', 0.0241),
    (204, '1.2204.40.00', '2023-04-09T19:40:02', 0.0263),
    (204, '1.1001.50.00', '2023-04-21T09:52:01', 0.0125),
    (204, '1.0502.24.20', '2023-04-21T22:26:29', 0.0284),
    (204, '1.0402.21.20', '2023-04-10T09:51:17', 0.0251),
    (204, '1.2502.20.00', '2023-04-09T19:03:14', 0.1801),
    (204, '1.0502.34.10', '2023-04-14T17:35:45', 0.0272),
    (204, '1.1702.2', '2023-04-12T17:11:40', 0.0338),
    (204, '1.1406.3', '2023-04-11T19:44:14', 0.0101),
    (204, '1.0404.30.00', '2023-04-03T17:09:17', 0.032),
    (204, '1.0401.29.00', '2023-04-22T03:00:58', 0.0255),
    (204, '1.1401.2', '2023-04-17T13:35:46', 0.012),
    (204, '1.2606.00.00', '2023-04-17T14:04:56', 0.1576),
    (204, '1.1802.40.00', '2023-04-24T04:58:54', 0.0116);

INSERT INTO relatorio VALUES
    (205, '2023-10-12', NULL, '48.912.037', '0001-38', '37.669.280/0001-29', 'Pesquisa de campo em emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (205, '2829.19.20', 1.6358, 8415),
    (205, '1302.14.00', 0.017, 1651),
    (205, '2917.39.1', 0.0635, 400),
    (205, '9608.91.00', 0.1941, 6753),
    (205, '8105.90.10', 0.0158, 10410),
    (205, '0907.10.00', 0.0069, 793),
    (205, '0302.73.00', 0.0517, 5197),
    (205, '8456.12.1', 0.0219, 1595),
    (205, '2904.99.40', 0.1081, 4230),
    (205, '2852.10.11', 0.1038, 7117),
    (205, '7214.10.90', 0.3426, 400),
    (205, '0304.96.00', 0.0035, 529),
    (205, '3003.20.95', 0.0001, 400),
    (205, '4805.93.00', 0.005, 490),
    (205, '2933.59.19', 0.3133, 11884),
    (205, '6403.59.10', 0.0001, 11223),
    (205, '8511.80.30', 0.1417, 400),
    (205, '5806.32.00', 0.0942, 400),
    (205, '8903.22.00', 0.0165, 7404),
    (205, '2933.99.33', 0.0143, 3251),
    (205, '5806.40.00', 0.0013, 1623),
    (205, '9001.90.10', 0.0631, 5838),
    (205, '6203.12.00', 0.148, 400),
    (205, '8409.91.1', 0.061, 4753),
    (205, '9110.11.90', 0.3819, 1953),
    (205, '8419.89.1', 0.0032, 9458),
    (205, '6201.90.00', 0.0579, 400),
    (205, '2309.90.30', 0.0039, 400),
    (205, '3002.12.14', 0.2893, 3759);

INSERT INTO relatorio VALUES
    (206, '2024-07-16', NULL, '53.921.807', '0001-18', '54.777.163/0001-46', 'O capitalismo como motor da exploração dos recursos naturais', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (206, '3004.20.91', 0.0595, 13645),
    (206, '5208.23.00', 0.2465, 5181);

INSERT INTO relatorio_serv VALUES
    (206, '1.1806.90.00', '2024-08-21T01:36:07', 0.6196),
    (206, '1.2101.21.00', '2024-08-12T13:57:52', 0.3163),
    (206, '1.0702.00.00', '2024-08-07T09:43:01', 0.762),
    (206, '1.2002.20.00', '2024-08-03T18:18:37', 0.072),
    (206, '1.0102.11.00', '2024-08-19T18:38:10', 1.5309),
    (206, '1.2504.21.00', '2024-08-13T20:56:31', 0.3235),
    (206, '1.0501.13.10', '2024-08-30T10:31:04', 0.1996),
    (206, '1.0502.19.00', '2024-08-10T05:39:00', 0.2711),
    (206, '1.2003.21.10', '2024-08-13T09:21:57', 0.4043),
    (206, '1.1701.33.00', '2024-08-06T01:18:28', 0.1815),
    (206, '1.0105.22.00', '2024-08-09T18:58:22', 0.9168),
    (206, '1.0906.1', '2024-08-17T18:50:23', 0.3584),
    (206, '1.1704.10.00', '2024-08-10T03:48:48', 2.0267),
    (206, '1.1406.1', '2024-08-25T15:28:37', 0.2116),
    (206, '1.0403.13.10', '2024-08-06T13:46:43', 1.0848),
    (206, '1.1403.25.00', '2024-08-21T05:19:03', 1.9954),
    (206, '1.2606.00.00', '2024-08-21T15:03:14', 1.538),
    (206, '1.2201.20.00', '2024-08-07T22:39:40', 0.6224),
    (206, '1.0501.12.20', '2024-08-30T07:41:08', 0.4769),
    (206, '1.0602.3', '2024-08-04T01:52:41', 0.1036),
    (206, '1.1302.23.00', '2024-08-27T10:30:31', 0.2319),
    (206, '1.2003.25.10', '2024-08-25T23:19:45', 0.042);

INSERT INTO relatorio VALUES
    (207, '2025-06-05', NULL, '79.821.563', '0001-00', '87.888.161/0001-65', 'Impacto de atividades agropecuárias na Amazônia', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (207, '8201.90.00', 1.577, 14476),
    (207, '2921.49.10', 0.0493, 1984),
    (207, '8527.21.00', 0.0085, 2356),
    (207, '6004.10.14', 0.0785, 4531),
    (207, '0106.33.90', 0.0136, 400),
    (207, '8479.89.32', 0.1518, 4203),
    (207, '8433.60.21', 0.0237, 400),
    (207, '8424.30.90', 0.0212, 400),
    (207, '2932.19.20', 0.0037, 972),
    (207, '0804.50.20', 0.0338, 400);

INSERT INTO relatorio_serv VALUES
    (207, '1.0102', '2025-07-25T18:42:43', 0.7062),
    (207, '1.1410', '2025-07-07T16:22:11', 0.1254),
    (207, '1.1001.12.90', '2025-07-08T04:37:45', 0.0038),
    (207, '1.1402.12.00', '2025-07-18T03:53:56', 0.0174),
    (207, '1.1805.39.00', '2025-07-11T10:58:08', 0.0014),
    (207, '1.2505.20.00', '2025-07-26T00:13:04', 0.0012);

INSERT INTO relatorio VALUES
    (208, '2024-06-22', '2024-08-22', '48.912.037', '0001-48', '11.679.309/0001-01', 'Análise de emissões em São Paulo na última década', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (208, '6506.10.90', 0.6836, 6800),
    (208, '3808.94.1', 0.0354, 3033),
    (208, '2915.60.1', 0.0481, 400),
    (208, '2833.29.70', 0.0138, 400),
    (208, '3302.90.9', 0.0001, 400),
    (208, '7225.50.10', 0.0143, 400),
    (208, '0802.11.00', 0.0328, 3750),
    (208, '3827.59.00', 0.0265, 12247),
    (208, '7217.20.10', 0.0557, 712),
    (208, '2933.99.61', 0.0256, 6994),
    (208, '3004.39.31', 0.054, 400);

INSERT INTO relatorio_serv VALUES
    (208, '1.0101', '2024-07-12T06:04:16', 0.3328),
    (208, '1.0502.11.30', '2024-07-02T12:54:53', 0.0088),
    (208, '1.1001.40.00', '2024-07-29T10:03:34', 0.0038);

INSERT INTO relatorio VALUES
    (209, '2022-11-19', NULL, '39.605.871', '0001-83', '87.888.161/0001-65', 'Impacto de atividades agropecuárias na Amazônia', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (209, '8523.52.90', 0.303, 3517),
    (209, '2810.00.10', 0.6232, 400),
    (209, '1605.56.00', 1.7745, 5460),
    (209, '6005.90.90', 2.2943, 2382),
    (209, '2925.29.21', 0.6691, 5179),
    (209, '9030.20.2', 0.2827, 3908),
    (209, '5902.10.10', 0.815, 400),
    (209, '7319.40.00', 1.7721, 3420),
    (209, '2937.29.50', 0.4601, 7931),
    (209, '6304.91.00', 1.2241, 2229),
    (209, '2009.50.00', 1.9114, 400),
    (209, '8423.89.00', 1.0664, 4320),
    (209, '3919.90.90', 1.5859, 11202),
    (209, '3815.90.92', 0.3786, 11829),
    (209, '5810.92.00', 0.8452, 4437),
    (209, '7222.19.90', 1.025, 400),
    (209, '6214.20.00', 0.8112, 3416),
    (209, '2903.61.00', 4.5127, 400);

INSERT INTO relatorio_serv VALUES
    (209, '1.0102.1', '2022-12-12T11:58:09', 0.6166),
    (209, '1.1506.22.00', '2022-12-22T05:19:26', 1.0564),
    (209, '1.0504.32.00', '2022-12-08T18:36:18', 0.524),
    (209, '1.2201.20.00', '2022-12-19T18:33:56', 0.3634);

INSERT INTO relatorio VALUES
    (210, '2023-07-15', NULL, '79.821.563', '0001-43', '09.850.333/0001-77', 'Emissões: e eu com isso?', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (210, '5514.29.00', 0.9862, 400),
    (210, '3816.00.11', 0.0478, 400),
    (210, '2941.90.35', 0.0222, 1419),
    (210, '8408.20.30', 0.0154, 3954),
    (210, '6204.52.00', 0.11, 400),
    (210, '2009.50.00', 0.0032, 1099),
    (210, '5402.48.00', 0.0104, 9161),
    (210, '2843.90.19', 0.0284, 12973),
    (210, '7010.90.21', 0.0, 8294),
    (210, '4811.41.10', 0.1818, 400),
    (210, '6204.53.00', 0.0118, 6581),
    (210, '3811.90.90', 0.0519, 5242),
    (210, '9402.10.00', 0.0643, 7933),
    (210, '9026.10.2', 0.0404, 7922),
    (210, '5105.29.99', 0.0148, 6863),
    (210, '8409.99.15', 0.008, 2930),
    (210, '3808.92.96', 0.0061, 2377),
    (210, '3003.90.76', 0.0366, 9006),
    (210, '0209.10.11', 0.1124, 1454),
    (210, '8541.21.10', 0.0415, 6566),
    (210, '3813.00.10', 0.0701, 998),
    (210, '3901.90.40', 0.0133, 13716),
    (210, '2933.33.59', 0.1306, 2944),
    (210, '6902.90.10', 0.0143, 6423),
    (210, '3901.90.10', 0.23, 8860),
    (210, '2933.69.14', 0.0058, 555),
    (210, '6802.91.00', 0.0006, 10932),
    (210, '7227.20.00', 0.0165, 400);

INSERT INTO relatorio VALUES
    (211, '2025-08-05', '2025-12-28', '18.024.935', '0001-76', '58.826.745/0001-34', 'Emissões a alto nível', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (211, '8515.19.00', 3.075, 5641),
    (211, '7801.10.1', 0.5077, 1659),
    (211, '5510.20.19', 0.0157, 7105),
    (211, '6505.00.12', 0.0083, 6186),
    (211, '0305.79.00', 0.1235, 3413),
    (211, '9028.30.21', 0.0018, 1212),
    (211, '5510.12.12', 0.1421, 2750),
    (211, '8007.00.10', 0.0804, 400),
    (211, '8411.82.00', 0.2423, 9920),
    (211, '7205.10.00', 0.0263, 400),
    (211, '5607.41.00', 0.0263, 7426),
    (211, '8708.94.1', 0.0772, 2027),
    (211, '5204.11.11', 0.0385, 10785);

INSERT INTO relatorio_serv VALUES
    (211, '1.0502.13.20', '2025-09-17T02:03:07', 1.8214);

INSERT INTO relatorio VALUES
    (212, '2022-10-27', '2023-07-29', '71.498.635', '0001-06', '37.669.280/0001-29', 'Pesquisa de campo em emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (212, '9030.82.90', 0.2431, 7775),
    (212, '7208.54.00', 0.2082, 400),
    (212, '2914.23.20', 0.1999, 400),
    (212, '2827.35.00', 0.078, 4054),
    (212, '3105.30.00', 0.0349, 4479),
    (212, '0302.89.37', 0.0632, 9654),
    (212, '2811.19.40', 0.055, 2998),
    (212, '9028.30.1', 0.1023, 400),
    (212, '2915.90.39', 0.0716, 16537),
    (212, '3912.20.10', 0.1858, 1873),
    (212, '4410.11.2', 0.3126, 9459),
    (212, '3808.91.92', 0.0333, 2583),
    (212, '5804.29.10', 0.0631, 12462),
    (212, '3004.20.69', 0.2047, 400),
    (212, '2103.10.90', 0.2802, 13486),
    (212, '2922.50.91', 0.6376, 400);

INSERT INTO relatorio_serv VALUES
    (212, '1.1706.23.00', '2022-11-02T12:59:35', 0.3674),
    (212, '1.2304.11.00', '2022-11-02T12:40:20', 0.0732),
    (212, '1.2504.11.00', '2022-11-29T09:57:02', 0.1363),
    (212, '1.0502.11.10', '2022-11-12T14:58:35', 0.2597);

INSERT INTO relatorio VALUES
    (213, '2025-08-29', '2026-02-26', '13.690.872', '0001-54', '53.396.825/0001-34', 'Formas de reduzir o impacto de emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (213, '1521.90.11', 0.0722, 400),
    (213, '3906.90.11', 1.0485, 400),
    (213, '3824.99.35', 0.2563, 2925),
    (213, '3002.41.15', 0.472, 400),
    (213, '8471.60.90', 1.4956, 400),
    (213, '4802.58.92', 0.3965, 4135);

INSERT INTO relatorio_serv VALUES
    (213, '1.2302.10.00', '2025-09-09T12:08:30', 0.3217),
    (213, '1.1703.3', '2025-09-20T21:32:00', 0.1921),
    (213, '1.20', '2025-09-24T09:38:07', 0.3847),
    (213, '1.2405.20.00', '2025-09-08T13:13:38', 0.4993),
    (213, '1.1001', '2025-09-06T05:55:16', 0.547),
    (213, '1.1001.30.00', '2025-09-16T07:35:42', 1.3099),
    (213, '1.1706.11.00', '2025-09-19T14:13:58', 0.381),
    (213, '1.1805', '2025-09-07T04:18:06', 0.0785),
    (213, '1.1805.50.00', '2025-09-22T16:19:14', 0.2431),
    (213, '1.0301.29.00', '2025-09-19T16:20:40', 0.2095);

INSERT INTO relatorio VALUES
    (214, '2024-03-02', '2024-07-08', '13.690.872', '0001-09', '54.777.163/0001-46', 'Andamento das metas da ONU', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (214, '8203.10.10', 0.6704, 3754),
    (214, '9026.10.29', 0.1713, 2707),
    (214, '1509.30.00', 0.2453, 11137),
    (214, '1502.10.1', 0.3342, 400),
    (214, '2933.35.00', 0.1791, 3365),
    (214, '3801.20.10', 0.2512, 2643),
    (214, '7202.92.00', 0.3093, 400),
    (214, '8443.99.70', 0.0827, 6125),
    (214, '8460.40.99', 0.0763, 13005),
    (214, '0303.83.21', 0.1668, 529),
    (214, '8462.42.00', 0.0295, 400),
    (214, '2930.90.91', 0.6729, 600),
    (214, '8311.90.00', 0.7199, 9479),
    (214, '1604.20.30', 0.2994, 8810),
    (214, '3002.49.94', 0.1812, 5030),
    (214, '3815.19.00', 0.0736, 400),
    (214, '2933.53.21', 0.2232, 8662),
    (214, '8443.13.90', 0.2971, 4368),
    (214, '3908.10.21', 0.2314, 3849);

INSERT INTO relatorio_serv VALUES
    (214, '1.1803.22.00', '2024-04-21T06:44:22', 0.3195),
    (214, '1.0502.3', '2024-04-04T00:02:36', 0.2614);

INSERT INTO relatorio VALUES
    (215, '2022-05-06', '2023-08-30', '01.274.895', '0001-23', '58.826.745/0001-34', 'Emissões a alto nível', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (215, '2904.99.16', 0.146, 9734),
    (215, '2933.59.92', 0.3461, 6665),
    (215, '8301.20.00', 1.0235, 10116),
    (215, '0102.21.10', 0.2494, 10441),
    (215, '2921.19.29', 0.1504, 400),
    (215, '2829.90.12', 0.0604, 2373),
    (215, '8445.40.11', 0.0767, 8366),
    (215, '0304.47.00', 0.7909, 4146),
    (215, '8207.19.10', 0.5883, 400),
    (215, '3003.20.52', 0.3146, 11450),
    (215, '2009.29.00', 0.3681, 9180),
    (215, '8543.70.20', 0.503, 8970),
    (215, '9027.20.2', 0.0763, 9848),
    (215, '3307.10.00', 0.3048, 7679),
    (215, '0603.12.00', 0.4555, 7411),
    (215, '2903.13.00', 0.0343, 4655),
    (215, '3901.10.20', 0.0723, 9559),
    (215, '9031.90.10', 0.1187, 775),
    (215, '4202.12.20', 0.8435, 2231);

INSERT INTO relatorio_serv VALUES
    (215, '1.2303.00.00', '2022-06-04T15:00:47', 0.7262),
    (215, '1.0901.51.21', '2022-06-14T00:19:50', 0.1327),
    (215, '1.0504', '2022-06-26T01:08:53', 0.065),
    (215, '1.0502.12.30', '2022-06-19T02:13:47', 0.0289);

INSERT INTO relatorio VALUES
    (216, '2024-03-20', '2024-12-15', '09.723.145', '0001-93', '58.826.745/0001-34', 'Emissões e as metas da ONU', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (216, '9014.10.00', 0.1229, 4384),
    (216, '0302.14.00', 0.1116, 400),
    (216, '5702.31.00', 0.0928, 5266),
    (216, '2922.29.90', 0.0657, 3042),
    (216, '3004.39.81', 0.1322, 400),
    (216, '2903.75.00', 0.0983, 4572);

INSERT INTO relatorio_serv VALUES
    (216, '1.0102.1', '2024-04-17T20:32:26', 0.1336),
    (216, '1.0607.00.00', '2024-04-14T08:34:05', 0.0399),
    (216, '1.0401.43.00', '2024-04-14T21:12:39', 0.0184),
    (216, '1.2101.23.00', '2024-04-21T16:59:09', 0.0051),
    (216, '1.0502.12.10', '2024-04-24T09:11:38', 0.0057),
    (216, '1.05', '2024-04-24T16:37:43', 0.0242),
    (216, '1.0402.90.00', '2024-04-01T08:35:04', 0.0367),
    (216, '1.0502.24', '2024-04-14T08:30:21', 0.0103),
    (216, '1.1106.32.00', '2024-04-07T21:47:14', 0.0458);

INSERT INTO relatorio VALUES
    (217, '2021-08-04', NULL, '33.738.001', '0001-77', '00.001.333/0001-99', 'Tipos de emissão em empresas de refinaria', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (217, '5603.91.30', 0.8029, 4422),
    (217, '4810.13.8', 0.7362, 400),
    (217, '0303.43.00', 0.6533, 2235),
    (217, '2933.99.62', 1.4699, 4896),
    (217, '5402.61.10', 1.8235, 1212),
    (217, '2933.39.43', 0.5975, 1702),
    (217, '8708.29.11', 1.4414, 5637),
    (217, '8455.22.90', 1.2326, 400),
    (217, '2712.20.00', 0.6699, 723),
    (217, '4703.29.00', 0.922, 4337),
    (217, '1509.30.00', 1.4471, 4280),
    (217, '1501.10.00', 1.2804, 5678),
    (217, '8439.30.20', 0.8996, 400),
    (217, '8482.99.10', 1.2888, 23789),
    (217, '6203.43.00', 0.5633, 6717),
    (217, '3905.91.90', 0.4686, 6701),
    (217, '0807.20.00', 1.5818, 7637),
    (217, '5402.47.90', 1.4528, 400),
    (217, '0303.44.00', 0.1113, 18688),
    (217, '7611.00.00', 3.5822, 8514),
    (217, '0304.81.00', 0.2372, 400),
    (217, '0210.92.00', 0.3876, 5553),
    (217, '2922.14.00', 0.3244, 7345),
    (217, '8448.20.20', 1.2254, 13258),
    (217, '3702.56.00', 0.0905, 400),
    (217, '0302.11.00', 1.5754, 2210),
    (217, '3502.20.00', 1.6573, 3928),
    (217, '0810.90.16', 0.3653, 11311),
    (217, '8414.70.00', 0.8487, 7745),
    (217, '9405.31.00', 2.3344, 1237);

INSERT INTO relatorio_serv VALUES
    (217, '1.0402.39.00', '2021-09-11T03:19:59', 4.274),
    (217, '1.0501.32.00', '2021-09-19T17:01:31', 0.2219);

INSERT INTO relatorio VALUES
    (218, '2022-08-30', '2023-11-28', '65.172.380', '0001-61', '53.396.825/0001-34', 'Formas de reduzir o impacto de emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (218, '2921.51.35', 0.1459, 5113),
    (218, '8504.90.10', 0.2625, 3510),
    (218, '2941.20.90', 0.1229, 10585),
    (218, '8544.19.19', 0.2437, 5647),
    (218, '8428.90.90', 0.0521, 7516),
    (218, '5208.31.00', 0.1818, 400),
    (218, '2510.20.90', 0.1095, 12753),
    (218, '7010.90.2', 0.2129, 8639),
    (218, '5404.19.1', 0.5225, 5701),
    (218, '5407.73.00', 0.0207, 400),
    (218, '2930.90.29', 0.0923, 15430),
    (218, '3003.90.59', 0.0018, 2520),
    (218, '0206.22.00', 0.4125, 3947),
    (218, '8441.90.00', 0.0733, 400),
    (218, '3005.90.11', 0.2205, 5732),
    (218, '8545.19.20', 0.0459, 4278),
    (218, '3004.10.19', 0.1679, 4947),
    (218, '9022.12.00', 0.0863, 400),
    (218, '2613.90.90', 0.0837, 9034),
    (218, '8527.99.90', 0.1664, 4618),
    (218, '7302.40.00', 0.0295, 400),
    (218, '2931.51.00', 0.134, 4156),
    (218, '2009.89.11', 0.415, 4733),
    (218, '8517.62.49', 0.0187, 2246),
    (218, '4403.41.00', 0.0713, 4631),
    (218, '3003.39.2', 0.1681, 10620),
    (218, '7326.11.00', 0.5229, 558),
    (218, '0901.22.00', 0.0674, 9364),
    (218, '7202.41.00', 0.073, 7828),
    (218, '0302.89.2', 0.0409, 400);

INSERT INTO relatorio_serv VALUES
    (218, '1.0501.11.30', '2022-09-25T06:19:01', 0.3002),
    (218, '1.2101.21.00', '2022-09-28T14:10:35', 0.4035),
    (218, '1.2203.10.00', '2022-09-29T05:36:39', 0.5835);

INSERT INTO relatorio VALUES
    (219, '2022-07-12', '2023-06-14', '39.605.871', '0001-83', '09.850.333/0001-77', 'Emissões: e eu com isso?', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (219, '8441.40.00', 0.0477, 10119),
    (219, '2921.42.3', 0.023, 5048),
    (219, '2924.19.29', 0.613, 10174),
    (219, '8502.20.90', 0.0444, 5154),
    (219, '9018.90.69', 0.0817, 4384),
    (219, '7114.19.00', 0.2059, 3041),
    (219, '3005.10.40', 0.2499, 1827),
    (219, '9010.50.20', 0.6011, 3284),
    (219, '2922.19.95', 0.1167, 400),
    (219, '0302.72.10', 0.6615, 400);

INSERT INTO relatorio_serv VALUES
    (219, '1.2405.14.00', '2022-08-04T13:15:02', 0.201),
    (219, '1.0901.5', '2022-08-10T22:44:38', 0.1353);

INSERT INTO relatorio VALUES
    (220, '2024-12-04', '2026-05-16', '64.087.915', '0001-27', '58.826.745/0001-34', 'Emissões a alto nível', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (220, '2710.19.99', 0.4509, 4158),
    (220, '8461.20.10', 0.0078, 10858),
    (220, '3003.90.67', 0.0044, 400);

INSERT INTO relatorio_serv VALUES
    (220, '1.0602.23.00', '2025-01-10T10:18:06', 4.4113),
    (220, '1.1202.20.00', '2025-01-03T04:16:56', 0.1334),
    (220, '1.0402.2', '2025-01-12T01:03:10', 0.0577),
    (220, '1.1803.29.00', '2025-01-22T19:52:46', 0.5504),
    (220, '1.0503.11.00', '2025-01-19T19:38:19', 0.1673),
    (220, '1.1702.22.00', '2025-01-27T09:20:22', 0.0332),
    (220, '1.1001.12.10', '2025-01-09T09:52:17', 0.0836),
    (220, '1.0502.24.5', '2025-01-14T01:50:10', 0.0535),
    (220, '1.1406.39.00', '2025-01-04T20:49:03', 0.0331),
    (220, '1.1806.53.00', '2025-01-27T07:42:38', 0.14),
    (220, '1.2001', '2025-01-27T13:12:15', 0.0172),
    (220, '1.1902', '2025-01-18T17:33:03', 0.0217),
    (220, '1.1703.99.00', '2025-01-07T11:40:41', 0.0075),
    (220, '1.0910', '2025-01-24T18:04:34', 0.0423),
    (220, '1.1501', '2025-01-08T08:16:53', 0.0367),
    (220, '1.0501.24.29', '2025-01-20T17:52:29', 0.0141),
    (220, '1.0502.14.59', '2025-01-29T17:55:49', 0.1409);

INSERT INTO relatorio VALUES
    (221, '2022-04-22', '2025-08-28', '09.723.145', '0001-78', '09.850.333/0001-77', 'Emissões: e eu com isso?', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (221, '4004.00.00', 1.0388, 5655),
    (221, '2807.00.10', 0.0326, 11657),
    (221, '8706.00.20', 0.1261, 400),
    (221, '2909.44.19', 0.0092, 2890),
    (221, '8473.50.50', 0.2069, 2590),
    (221, '5902.10.10', 0.0372, 400),
    (221, '2937.23.31', 0.1963, 15666),
    (221, '1702.60.10', 0.0045, 3619),
    (221, '2008.30.00', 0.1795, 3492),
    (221, '8539.22.00', 0.0844, 7362),
    (221, '9306.21.30', 0.0673, 2670),
    (221, '2921.41.00', 0.0526, 10429),
    (221, '7201.10.00', 0.1074, 5595),
    (221, '8423.20.00', 0.0179, 1033),
    (221, '7407.29.10', 0.0014, 400),
    (221, '8510.90.1', 0.0712, 9304),
    (221, '6104.19.20', 0.0284, 5316),
    (221, '3002.42.60', 0.0306, 4285),
    (221, '9618.00.00', 0.0986, 3826),
    (221, '2915.39.94', 0.0062, 1885),
    (221, '9603.30.00', 0.0087, 400),
    (221, '7301.20.00', 0.0623, 15282);

INSERT INTO relatorio_serv VALUES
    (221, '1.1106.4', '2022-05-22T02:03:53', 0.9294);

INSERT INTO relatorio VALUES
    (222, '2025-06-27', NULL, '75.893.062', '0001-33', '00.001.333/0001-99', 'Tipos de emissão em empresas de refinaria', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (222, '7216.22.00', 0.0293, 400),
    (222, '8482.99.10', 0.0975, 3741);

INSERT INTO relatorio_serv VALUES
    (222, '1.1105.90.00', '2025-07-25T23:23:48', 0.0681),
    (222, '1.0503.12.00', '2025-07-23T11:28:54', 0.1841),
    (222, '1.2402.20.00', '2025-07-01T02:59:19', 0.055),
    (222, '1.0905.80.00', '2025-07-23T06:38:36', 0.0346),
    (222, '1.0504.4', '2025-07-03T14:34:49', 0.1867),
    (222, '1.1106.43.00', '2025-07-19T03:37:27', 0.1138),
    (222, '1.2205.14.00', '2025-07-18T20:36:10', 0.0263),
    (222, '1.0102', '2025-07-04T02:06:15', 0.0363),
    (222, '1.0403.19.00', '2025-07-24T01:55:18', 0.1103),
    (222, '1.1414.00.00', '2025-07-20T11:06:24', 0.0086),
    (222, '1.1103.90.00', '2025-07-21T23:16:27', 0.0157),
    (222, '1.0502.12', '2025-07-06T14:00:27', 0.084),
    (222, '1.0609.00.00', '2025-07-21T21:02:31', 0.1449),
    (222, '1.1106.36', '2025-07-19T23:09:43', 0.2068),
    (222, '1.0608', '2025-07-10T08:34:44', 0.0224),
    (222, '1.26', '2025-07-17T22:48:44', 0.1736);

INSERT INTO relatorio VALUES
    (223, '2025-08-16', NULL, '53.921.807', '0001-18', '53.396.825/0001-34', 'Formas de reduzir o impacto de emissões', NULL, NULL, NULL);

INSERT INTO relatorio_serv VALUES
    (223, '1.0501.3', '2025-09-27T15:46:14', 0.0257),
    (223, '1.0501.13.10', '2025-09-20T13:01:58', 0.302),
    (223, '1.0502.33', '2025-09-24T13:36:03', 0.1124),
    (223, '1.0905.70.00', '2025-09-17T01:36:58', 0.0458),
    (223, '1.2504.22.00', '2025-09-11T10:27:17', 0.0607),
    (223, '1.1101.17.00', '2025-09-01T12:12:37', 0.1255),
    (223, '1.1502.40.00', '2025-09-04T01:51:43', 0.1331),
    (223, '1.0106.60.00', '2025-09-14T12:01:21', 0.1007),
    (223, '1.0701.00.00', '2025-09-11T15:42:34', 0.2078),
    (223, '1.2604.00.00', '2025-09-01T05:06:06', 0.061),
    (223, '1.1404.13.00', '2025-09-18T02:09:11', 0.0925),
    (223, '1.1103', '2025-09-11T16:30:17', 0.0582),
    (223, '1.2502.10.00', '2025-09-29T21:27:41', 0.0142),
    (223, '1.0501.22', '2025-09-14T03:43:07', 0.0926),
    (223, '1.1106.4', '2025-09-20T11:56:00', 0.2845),
    (223, '1.0401.1', '2025-09-13T23:59:25', 0.0222),
    (223, '1.0401.21.20', '2025-09-18T22:10:20', 0.2309),
    (223, '1.0102.35.10', '2025-09-20T01:20:59', 0.061),
    (223, '1.13', '2025-09-09T17:33:06', 0.0822),
    (223, '1.0504.41.00', '2025-09-15T20:45:08', 0.0779),
    (223, '1.1301.20.00', '2025-09-11T03:35:36', 0.1836),
    (223, '1.1106.36.20', '2025-09-05T07:04:28', 0.0345),
    (223, '1.0402.90.00', '2025-09-06T01:13:35', 0.0199),
    (223, '1.1109.10.00', '2025-09-02T07:03:00', 0.1765),
    (223, '1.1101.13.00', '2025-09-28T20:18:27', 0.1735),
    (223, '1.0401.30.00', '2025-09-27T16:59:31', 0.0275),
    (223, '1.0504.11.00', '2025-09-16T10:18:54', 0.0988),
    (223, '1.1702.2', '2025-09-24T21:34:39', 0.2894),
    (223, '1.1409', '2025-09-15T19:55:17', 0.3062),
    (223, '1.1404.42.00', '2025-09-08T18:25:46', 0.1536),
    (223, '1.0802.20.00', '2025-09-25T08:58:57', 0.0646),
    (223, '1.1401.17.00', '2025-09-14T19:40:09', 0.1812),
    (223, '1.0401.4', '2025-09-19T22:40:44', 0.0377),
    (223, '1.0906.30.00', '2025-09-07T13:01:12', 0.0986);

INSERT INTO relatorio VALUES
    (224, '2023-03-03', NULL, '01.274.895', '0001-40', '37.669.280/0001-29', 'Pesquisa de campo em emissões', NULL, NULL, NULL);

INSERT INTO relatorio_serv VALUES
    (224, '1.0102.80.00', '2023-04-05T08:26:29', 0.2438),
    (224, '1.0904.2', '2023-04-06T11:09:11', 0.1197),
    (224, '1.1803.21.00', '2023-04-15T06:19:08', 0.0916),
    (224, '1.0503.27.00', '2023-04-26T17:31:42', 0.0594),
    (224, '1.2304.11.00', '2023-04-14T06:10:40', 0.2581),
    (224, '1.1409.25.00', '2023-04-24T23:30:41', 0.0185),
    (224, '1.1409.21.00', '2023-04-24T00:01:12', 0.1428),
    (224, '1.1701', '2023-04-09T18:51:26', 0.026),
    (224, '1.1105.60.00', '2023-04-06T01:34:32', 0.0221),
    (224, '1.0401.11.19', '2023-04-04T00:27:29', 0.1965),
    (224, '1.0901.3', '2023-04-03T07:11:52', 0.0046),
    (224, '1.1903.1', '2023-04-08T14:22:55', 0.212),
    (224, '1.1806.81.00', '2023-04-11T19:03:08', 0.2262),
    (224, '1.0901.40.00', '2023-04-09T10:08:02', 0.1226),
    (224, '1.1406.33.00', '2023-04-26T05:05:07', 0.059),
    (224, '1.1703.2', '2023-04-11T20:05:10', 0.1275),
    (224, '1.0401.4', '2023-04-10T00:52:37', 0.3749);

INSERT INTO relatorio VALUES
    (225, '2022-04-29', '2025-01-29', '79.821.563', '0001-99', '53.396.825/0001-34', 'Formas de reduzir o impacto de emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (225, '4811.90.90', 0.0085, 880),
    (225, '3004.20.19', 0.0104, 6753),
    (225, '0902.40.00', 0.0047, 3772),
    (225, '7306.90.10', 0.0225, 8655),
    (225, '8443.99.31', 0.0389, 400),
    (225, '4009.42.90', 0.0062, 7099),
    (225, '2930.90.52', 0.001, 400),
    (225, '5303.10.90', 0.0081, 5929),
    (225, '0306.93.00', 0.029, 7438),
    (225, '7804.19.00', 0.0033, 10894),
    (225, '9014.20.90', 0.0613, 2517),
    (225, '2931.49.1', 0.0484, 3444),
    (225, '4002.31.00', 0.0744, 400),
    (225, '4810.29.10', 0.0503, 11688);

INSERT INTO relatorio_serv VALUES
    (225, '1.0105.50.00', '2022-05-27T00:39:14', 0.0091),
    (225, '1.1106.10.00', '2022-05-19T16:00:14', 0.0456),
    (225, '1.0105.12.00', '2022-05-24T00:03:27', 0.0374),
    (225, '1.0801.20.00', '2022-05-01T07:40:40', 0.0017),
    (225, '1.1405.21.00', '2022-05-13T05:19:42', 0.2126),
    (225, '1.1101.13.00', '2022-05-19T05:07:55', 0.0572),
    (225, '1.0103.30.00', '2022-05-26T03:06:33', 0.184),
    (225, '1.1502.30.00', '2022-05-27T01:19:23', 0.042),
    (225, '1.0501.22.20', '2022-05-16T14:29:17', 0.1011);

INSERT INTO relatorio VALUES
    (226, '2022-12-18', NULL, '65.172.380', '0001-61', '54.777.163/0001-46', 'O capitalismo como motor da exploração dos recursos naturais', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (226, '2928.00.30', 8.0513, 400),
    (226, '0804.20.10', 3.6791, 11302),
    (226, '8542.39.99', 2.8634, 400),
    (226, '9031.80.50', 2.5043, 18805),
    (226, '4015.90.00', 6.9303, 1810),
    (226, '9015.90.10', 8.6571, 5337),
    (226, '8462.26.00', 8.2541, 400),
    (226, '3811.11.00', 7.5546, 400),
    (226, '5210.51.00', 0.4195, 2875),
    (226, '8440.10.20', 11.2417, 400),
    (226, '9018.50.90', 2.9799, 400),
    (226, '6505.00.1', 6.7286, 6225),
    (226, '8482.10.10', 13.9575, 3340),
    (226, '4412.10.00', 2.5875, 12606),
    (226, '7410.21.20', 0.5616, 2921),
    (226, '8903.22.00', 15.6232, 400),
    (226, '2916.20.13', 0.2105, 11061);

INSERT INTO relatorio_serv VALUES
    (226, '1.1203.00.00', '2023-01-04T18:59:30', 18.3492),
    (226, '1.1702.2', '2023-01-16T16:11:51', 4.3174),
    (226, '1.1401.12.00', '2023-01-18T04:38:40', 2.5431),
    (226, '1.1106.43.00', '2023-01-03T17:44:44', 10.2034);

INSERT INTO relatorio VALUES
    (227, '2023-07-25', NULL, '09.723.145', '0001-56', '54.777.163/0001-46', 'O capitalismo como motor da exploração dos recursos naturais', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (227, '6403.51.90', 15.5138, 3406),
    (227, '8503.00.90', 0.0434, 400),
    (227, '8451.90.10', 0.0083, 3784),
    (227, '8543.90.90', 0.1227, 3814),
    (227, '7508.90.90', 0.1836, 3334),
    (227, '0302.36.00', 0.2613, 10652),
    (227, '8517.62.1', 1.1472, 5011),
    (227, '8433.20.90', 0.0736, 9067),
    (227, '2909.49.3', 0.3776, 400),
    (227, '8514.39.00', 0.1226, 400),
    (227, '2933.39.91', 1.1405, 2395),
    (227, '8529.90.1', 1.789, 9757),
    (227, '3802.10.00', 0.7106, 400),
    (227, '4804.59.10', 0.8906, 712),
    (227, '7212.10.00', 1.5913, 400),
    (227, '8438.80.10', 0.1333, 2493),
    (227, '3923.29.10', 0.1939, 400),
    (227, '9018.39.30', 0.1983, 8282),
    (227, '9019.20.90', 0.6058, 10110),
    (227, '6207.99.10', 0.4063, 4127),
    (227, '0104.10.90', 1.2068, 478),
    (227, '4805.12.00', 0.2087, 1388);

INSERT INTO relatorio_serv VALUES
    (227, '1.0402.14.00', '2023-08-08T16:49:29', 11.0673);

INSERT INTO relatorio VALUES
    (228, '2022-10-16', '2024-04-10', '12.905.674', '0001-18', '54.777.163/0001-46', 'Andamento das metas da ONU', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (228, '2852.10.21', 0.8971, 7157),
    (228, '3824.99.3', 0.3884, 400),
    (228, '1507.90.19', 0.0432, 1576),
    (228, '6902.10.18', 0.5283, 2155),
    (228, '3002.41.2', 0.8485, 3751),
    (228, '5407.83.00', 1.4442, 12459),
    (228, '2941.90.49', 0.3457, 5982),
    (228, '9005.90.90', 0.1588, 6773);

INSERT INTO relatorio_serv VALUES
    (228, '1.0901.52', '2022-11-14T23:09:31', 0.7389);

INSERT INTO relatorio VALUES
    (229, '2021-11-17', NULL, '09.723.145', '0001-93', '53.396.825/0001-34', 'Formas de reduzir o impacto de emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (229, '2933.91.19', 0.1656, 400),
    (229, '8202.99.90', 0.0342, 400),
    (229, '3404.90.12', 0.1437, 4080),
    (229, '8453.20.00', 0.0358, 14240),
    (229, '8530.10.10', 0.4966, 400),
    (229, '1604.20.20', 0.0417, 1894),
    (229, '3301.90.30', 0.1932, 2937),
    (229, '3002.41.22', 0.1513, 765),
    (229, '2909.19.90', 0.0033, 10434),
    (229, '9608.91.00', 0.1386, 7097),
    (229, '0302.14.00', 0.0044, 6632),
    (229, '8201.60.00', 0.2432, 3391),
    (229, '0602.30.00', 0.3009, 7224),
    (229, '6909.19.90', 0.0985, 2933),
    (229, '2935.90.92', 0.2112, 400);

INSERT INTO relatorio_serv VALUES
    (229, '1.1805.13.00', '2021-12-28T20:15:44', 0.0119),
    (229, '1.0401.42.00', '2021-12-22T21:56:18', 0.0459),
    (229, '1.1903.30.00', '2021-12-25T03:34:57', 0.1119),
    (229, '1.1201.50.00', '2021-12-11T08:31:00', 0.1689),
    (229, '1.1409.25.00', '2021-12-26T03:34:46', 0.0937),
    (229, '1.1401.2', '2021-12-25T10:43:24', 0.0244),
    (229, '1.1506.21.00', '2021-12-18T17:47:17', 0.0168),
    (229, '1.1802.40.00', '2021-12-30T00:34:47', 0.1122),
    (229, '1.0604.30.00', '2021-12-28T14:05:35', 0.1632),
    (229, '1.0501.31.00', '2021-12-20T15:47:59', 0.2831),
    (229, '1.2002.30.00', '2021-12-25T20:19:35', 0.0243),
    (229, '1.1401.18.00', '2021-12-09T18:05:08', 0.0758),
    (229, '1.0502.12.10', '2021-12-22T01:08:04', 0.0596);

INSERT INTO relatorio VALUES
    (230, '2021-11-03', '2025-09-25', '48.603.715', '0001-45', '53.396.825/0001-34', 'Formas de reduzir o impacto de emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (230, '2933.33.3', 0.0713, 400),
    (230, '3003.90.42', 0.0574, 1557),
    (230, '3004.31.00', 0.0183, 16635),
    (230, '7321.12.00', 0.0059, 6304),
    (230, '9503.00.50', 0.2506, 6288),
    (230, '6112.41.00', 0.0465, 5370),
    (230, '5210.31.00', 0.0632, 6728),
    (230, '2809.10.00', 0.2519, 5173),
    (230, '0904.11.00', 0.1625, 3845),
    (230, '2934.91.32', 0.0162, 14913),
    (230, '9026.10.29', 0.0328, 7747),
    (230, '6102.30.00', 0.4483, 12427),
    (230, '4806.30.00', 0.0423, 4450),
    (230, '6302.29.00', 0.0641, 9029),
    (230, '3301.29.19', 0.2962, 400);

INSERT INTO relatorio_serv VALUES
    (230, '1.1103.36.10', '2021-12-07T06:23:20', 0.279),
    (230, '1.1506.2', '2021-12-28T08:38:04', 0.1811),
    (230, '1.1403.22', '2021-12-03T04:20:59', 0.2491),
    (230, '1.1402.3', '2021-12-07T09:57:00', 0.1835),
    (230, '1.0403.29.00', '2021-12-28T04:48:49', 0.1008),
    (230, '1.2301.15.00', '2021-12-10T16:11:54', 0.3716),
    (230, '1.2405', '2021-12-25T13:50:59', 0.1936),
    (230, '1.1805.50.00', '2021-12-24T06:58:51', 0.1447),
    (230, '1.0106.2', '2021-12-12T04:23:20', 0.2257),
    (230, '1.0401.16.10', '2021-12-08T15:59:35', 0.3435),
    (230, '1.0501.29.00', '2021-12-03T10:50:15', 0.1933);

INSERT INTO relatorio VALUES
    (231, '2025-11-09', '2025-12-24', '65.172.380', '0001-61', '54.777.163/0001-46', 'O capitalismo como motor da exploração dos recursos naturais', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (231, '8406.10.00', 0.006, 2446),
    (231, '0714.10.00', 0.0846, 4291),
    (231, '2933.33.19', 0.125, 2020),
    (231, '2941.20.90', 0.0241, 400),
    (231, '0805.22.00', 0.0499, 400),
    (231, '3907.10.91', 0.0623, 1029),
    (231, '9025.11.91', 0.0575, 400),
    (231, '2506.20.00', 0.0084, 22083),
    (231, '2924.29.41', 0.0416, 9784),
    (231, '4811.90.20', 0.2038, 6248);

INSERT INTO relatorio_serv VALUES
    (231, '1.1102.60.00', '2025-12-10T02:35:58', 0.0652),
    (231, '1.2001.50.00', '2025-12-05T12:16:33', 0.0619);

INSERT INTO relatorio VALUES
    (232, '2023-12-26', NULL, '09.723.145', '0001-93', '54.777.163/0001-46', 'Andamento das metas da ONU', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (232, '2306.60.00', 0.1892, 400),
    (232, '8104.90.00', 1.456, 1921),
    (232, '2841.90.49', 2.6786, 8671),
    (232, '0903.00.10', 0.1927, 400),
    (232, '2905.19.12', 0.6344, 400),
    (232, '8481.20.90', 0.2095, 400),
    (232, '2811.19.20', 0.1994, 8863);

INSERT INTO relatorio_serv VALUES
    (232, '1.1903', '2024-01-20T09:28:34', 0.0511),
    (232, '1.0404', '2024-01-25T13:04:31', 0.91),
    (232, '1.1406.31.00', '2024-01-14T05:56:29', 0.1334),
    (232, '1.1103.32.00', '2024-01-14T14:50:33', 0.0864),
    (232, '1.0502.14.10', '2024-01-19T18:28:53', 0.0887),
    (232, '1.2601.30.00', '2024-01-06T13:17:54', 0.2549),
    (232, '1.2502.30.00', '2024-01-18T15:17:49', 0.2222),
    (232, '1.2503.20.00', '2024-01-23T06:09:57', 0.0345),
    (232, '1.1106.35.00', '2024-01-02T15:17:16', 0.5991),
    (232, '1.0402.22.00', '2024-01-23T15:40:06', 0.2861),
    (232, '1.0106.40.00', '2024-01-21T04:56:43', 0.0768),
    (232, '1.1805.39.00', '2024-01-01T00:58:49', 0.4648),
    (232, '1.08', '2024-01-25T06:33:48', 0.2188);

INSERT INTO relatorio VALUES
    (233, '2021-10-02', '2025-09-12', '09.723.145', '0001-78', '09.850.333/0001-77', 'Emissões: e eu com isso?', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (233, '6004.10.12', 228.7657, 2446),
    (233, '5404.11.00', 0.183, 400),
    (233, '3808.92.9', 0.8021, 14241),
    (233, '7201.20.00', 0.0924, 400),
    (233, '2915.39.6', 0.4116, 3475),
    (233, '2905.12.20', 5.6175, 10616),
    (233, '2921.19.3', 2.7179, 12830),
    (233, '5210.32.00', 2.6092, 8986),
    (233, '1212.91.00', 8.707, 4934),
    (233, '2937.23.59', 2.1892, 400),
    (233, '2915.39.63', 10.8562, 9096),
    (233, '2842.90.00', 0.4284, 10435),
    (233, '2833.29.60', 1.7246, 7009),
    (233, '2905.59.90', 17.2389, 3113),
    (233, '4105.10.2', 2.1113, 1367),
    (233, '3003.20.19', 8.074, 1301),
    (233, '8714.99.90', 37.4423, 400),
    (233, '3305.20.00', 6.8868, 2747),
    (233, '3003.90.38', 14.6155, 400),
    (233, '9023.00.00', 5.308, 400);

INSERT INTO relatorio_serv VALUES
    (233, '1.0503', '2021-11-28T22:43:37', 11.8182),
    (233, '1.1105.30.00', '2021-11-06T11:19:22', 0.2714);

INSERT INTO relatorio VALUES
    (234, '2023-11-08', NULL, '53.921.807', '0001-18', '11.679.309/0001-01', 'Impacto de programas de incentivo fiscal na redução de emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (234, '6903.10.40', 0.0178, 13469),
    (234, '7015.90.90', 0.0583, 3542);

INSERT INTO relatorio_serv VALUES
    (234, '1.2602.10.00', '2023-12-18T09:10:12', 0.0402),
    (234, '1.1102.30.00', '2023-12-18T06:21:23', 0.0682),
    (234, '1.1701.51.00', '2023-12-11T19:38:11', 0.1035),
    (234, '1.20', '2023-12-27T05:40:09', 0.0004),
    (234, '1.1806.51.00', '2023-12-26T12:36:25', 0.0101),
    (234, '1.1101.13.00', '2023-12-01T08:16:54', 0.0202),
    (234, '1.1701.32.00', '2023-12-12T17:46:18', 0.0756),
    (234, '1.1403.25.00', '2023-12-22T19:53:45', 0.0127),
    (234, '1.0502.11.20', '2023-12-16T12:40:44', 0.0101),
    (234, '1.0501.24.22', '2023-12-12T15:37:29', 0.0154);

INSERT INTO relatorio VALUES
    (235, '2023-09-24', '2023-12-30', '27.401.593', '0001-66', '11.679.309/0001-01', 'Impacto de programas de incentivo fiscal na redução de emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (235, '8425.19.10', 0.4363, 9367),
    (235, '3922.90.00', 0.0158, 4160);

INSERT INTO relatorio_serv VALUES
    (235, '1.1102.60.00', '2023-10-25T15:41:06', 2.5612),
    (235, '1.1103.31.00', '2023-10-14T18:55:27', 0.0583),
    (235, '1.2601.40.00', '2023-10-28T04:04:41', 0.0121),
    (235, '1.1805.50.00', '2023-10-05T02:01:08', 0.1412),
    (235, '1.0901.51.25', '2023-10-26T19:07:40', 0.0065),
    (235, '1.23', '2023-10-20T05:01:35', 0.1105),
    (235, '1.0107.40.00', '2023-10-13T05:40:42', 0.0107),
    (235, '1.1805.61.00', '2023-10-19T16:36:48', 0.1172),
    (235, '1.0401.49.00', '2023-10-21T20:32:46', 0.0157),
    (235, '1.1409.30.00', '2023-10-03T19:58:52', 0.0414),
    (235, '1.2205.19.00', '2023-10-03T19:07:23', 0.0006),
    (235, '1.2501.11.00', '2023-10-17T18:47:09', 0.0614),
    (235, '1.1403.22.21', '2023-10-02T03:40:29', 0.0466),
    (235, '1.0901.33.00', '2023-10-27T17:22:28', 0.2876),
    (235, '1.0906', '2023-10-01T05:18:35', 0.1273),
    (235, '1.0403.21', '2023-10-25T16:22:44', 0.0085),
    (235, '1.1903.20.00', '2023-10-14T20:16:02', 0.0),
    (235, '1.0502.14.5', '2023-10-07T23:36:00', 0.1671),
    (235, '1.0903.2', '2023-10-27T23:33:32', 0.2751),
    (235, '1.1406', '2023-10-21T08:10:20', 0.0056),
    (235, '1.0502.24.52', '2023-10-17T16:05:52', 0.0323),
    (235, '1.2501.35.00', '2023-10-09T09:07:30', 0.1218),
    (235, '1.0401.11.11', '2023-10-30T16:35:49', 0.0576);

INSERT INTO relatorio VALUES
    (236, '2023-03-28', '2024-06-13', '39.605.871', '0001-83', '87.888.161/0001-65', 'Impacto de atividades agropecuárias na Amazônia', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (236, '8445.40.3', 1.6467, 5972),
    (236, '1515.90.10', 2.0025, 8485),
    (236, '2812.90.00', 0.734, 9084),
    (236, '2905.19.95', 0.5511, 18871),
    (236, '2712.10.00', 0.8458, 400),
    (236, '6207.22.00', 0.5807, 5415),
    (236, '2909.60.11', 1.6607, 6972),
    (236, '1502.10.12', 0.9042, 5432),
    (236, '6114.20.00', 0.2918, 4999),
    (236, '1514.19.10', 0.9791, 5128),
    (236, '6403.99.90', 0.2183, 3445),
    (236, '4804.31.10', 0.4989, 6077),
    (236, '3002.42.50', 1.5228, 5467),
    (236, '3002.42.90', 0.7645, 7924),
    (236, '8905.10.00', 0.665, 400),
    (236, '0305.31.00', 1.3316, 7785),
    (236, '2920.90.2', 0.8499, 400),
    (236, '6001.99.00', 1.8237, 15537),
    (236, '8504.40.50', 1.4446, 2467),
    (236, '3920.61.00', 5.9958, 5349),
    (236, '4704.19.00', 0.6363, 400),
    (236, '0707.00.00', 1.0805, 3385),
    (236, '3003.90.24', 1.7132, 400),
    (236, '6203.33.00', 0.5744, 10884),
    (236, '1514.11.00', 0.9821, 11870),
    (236, '5407.73.00', 0.2178, 7662),
    (236, '9029.90.10', 1.3746, 400);

INSERT INTO relatorio_serv VALUES
    (236, '1.2504.2', '2023-04-22T16:04:49', 3.3679),
    (236, '1.2602', '2023-04-19T21:01:59', 2.0072);

INSERT INTO relatorio VALUES
    (237, '2021-08-02', '2026-04-06', '65.172.380', '0001-53', '54.777.163/0001-46', 'Andamento das metas da ONU', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (237, '1513.29.20', 0.6541, 691),
    (237, '1901.20.10', 0.0099, 6175),
    (237, '0808.10.00', 0.0049, 9798),
    (237, '8701.21.00', 0.0199, 424),
    (237, '2918.19.30', 0.0018, 400),
    (237, '3006.10.90', 0.0335, 3554),
    (237, '3503.00.11', 0.0048, 4317),
    (237, '9010.10.20', 0.0089, 400),
    (237, '8202.31.00', 0.0006, 400),
    (237, '8456.11.90', 0.0006, 2236),
    (237, '8517.62.94', 0.0165, 9824),
    (237, '4407.25.00', 0.0023, 4764),
    (237, '3002.42.20', 0.006, 577),
    (237, '3002.41.26', 0.0192, 4129),
    (237, '2005.51.00', 0.0945, 7868),
    (237, '3907.99.99', 0.0005, 3519),
    (237, '2901.23.00', 0.0003, 6092),
    (237, '1602.32.10', 0.0087, 2523),
    (237, '3904.40.10', 0.0351, 7198),
    (237, '1514.11.00', 0.0632, 8489);

INSERT INTO relatorio_serv VALUES
    (237, '1.2501.1', '2021-09-18T05:47:53', 0.0175),
    (237, '1.2403.2', '2021-09-21T22:29:48', 0.0007),
    (237, '1.1504.00.00', '2021-09-08T14:45:23', 0.002),
    (237, '1.1403.22.14', '2021-09-23T20:14:26', 0.0011);

INSERT INTO relatorio VALUES
    (238, '2021-07-02', '2023-02-18', '28.659.130', '0001-07', '00.001.333/0001-99', 'Tipos de emissão em empresas de refinaria', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (238, '5603.14.30', 0.0204, 9427),
    (238, '8463.10.10', 0.0204, 16738),
    (238, '2833.40.20', 0.0201, 6663);

INSERT INTO relatorio_serv VALUES
    (238, '1.0103.20.00', '2021-08-09T08:23:55', 0.052),
    (238, '1.2001.83.00', '2021-08-01T05:36:16', 0.0474),
    (238, '1.1302.23.00', '2021-08-23T14:21:14', 0.0051),
    (238, '1.0502.34', '2021-08-20T20:13:16', 0.0486),
    (238, '1.2402.20.00', '2021-08-19T09:17:06', 0.0701),
    (238, '1.0405.00.00', '2021-08-02T09:21:17', 0.0309),
    (238, '1.1103.3', '2021-08-13T07:59:26', 0.0429),
    (238, '1.0401.21.90', '2021-08-18T04:39:27', 0.0096),
    (238, '1.1703.3', '2021-08-26T02:30:39', 0.0189),
    (238, '1.0602', '2021-08-13T13:56:22', 0.0638),
    (238, '1.2403.22.00', '2021-08-17T00:04:45', 0.0906),
    (238, '1.1303.20.00', '2021-08-01T07:03:14', 0.0537),
    (238, '1.0501.12.20', '2021-08-20T21:18:44', 0.0445),
    (238, '1.0502.31.10', '2021-08-07T04:43:08', 0.0953),
    (238, '1.0102.6', '2021-08-17T17:05:27', 0.0149),
    (238, '1.0102.1', '2021-08-21T23:35:13', 0.0719),
    (238, '1.0910.10.00', '2021-08-20T05:44:36', 0.1478),
    (238, '1.2404.32.00', '2021-08-12T08:37:42', 0.3897),
    (238, '1.1104.10.00', '2021-08-15T14:40:18', 0.1193),
    (238, '1.1903.30.00', '2021-08-15T20:03:58', 0.0596),
    (238, '1.2404.31.00', '2021-08-01T07:47:02', 0.0753),
    (238, '1.1103.42.00', '2021-08-05T11:41:49', 0.1315),
    (238, '1.2301.23.00', '2021-08-02T19:45:41', 0.1067),
    (238, '1.1103.41.00', '2021-08-07T17:37:18', 0.0535);

INSERT INTO relatorio VALUES
    (239, '2022-10-28', NULL, '56.738.014', '0001-69', '58.826.745/0001-34', 'Emissões e as metas da ONU', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (239, '2920.90.2', 0.5681, 7691),
    (239, '7408.11.00', 0.3697, 516);

INSERT INTO relatorio_serv VALUES
    (239, '1.1703.31.00', '2022-11-28T16:12:15', 0.4559),
    (239, '1.0504.11.00', '2022-11-12T19:34:47', 0.0633),
    (239, '1.0107.50.00', '2022-11-06T08:16:15', 0.0391),
    (239, '1.1806.90.00', '2022-11-13T00:45:22', 0.2981),
    (239, '1.0403.3', '2022-11-26T09:13:51', 0.0429),
    (239, '1.1413.00.00', '2022-11-25T17:30:07', 0.2472),
    (239, '1.1802.40.00', '2022-11-29T09:29:09', 0.1433),
    (239, '1.1107.10.00', '2022-11-28T04:54:26', 0.3496),
    (239, '1.0403.1', '2022-11-20T05:06:25', 0.2574),
    (239, '1.2504', '2022-11-28T10:02:29', 0.1526),
    (239, '1.0501.31.00', '2022-11-14T11:21:13', 0.1174),
    (239, '1.0906.90.00', '2022-11-06T10:28:50', 0.2157),
    (239, '1.2001.89.00', '2022-11-28T12:11:48', 0.1466),
    (239, '1.0904.31.00', '2022-11-15T18:19:25', 0.0722),
    (239, '1.0103.30.00', '2022-11-24T03:32:39', 0.3733),
    (239, '1.1402.1', '2022-11-24T14:04:47', 0.0959),
    (239, '1.1202.20.00', '2022-11-26T14:29:13', 0.2196),
    (239, '1.0606.11.00', '2022-11-27T00:33:57', 0.5165);

INSERT INTO relatorio VALUES
    (240, '2023-02-19', NULL, '13.690.872', '0001-09', '54.777.163/0001-46', 'O capitalismo como motor da exploração dos recursos naturais', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (240, '8452.29.25', 0.0159, 400),
    (240, '3002.12.13', 0.0803, 1886),
    (240, '5402.61.10', 0.1585, 7062),
    (240, '8539.39.1', 0.0246, 400),
    (240, '2827.39.20', 0.0289, 8312),
    (240, '2507.00.10', 0.0031, 3022),
    (240, '3909.50.2', 0.0578, 6796),
    (240, '8430.41.90', 0.048, 7969),
    (240, '2605.00.00', 0.1461, 4864),
    (240, '8424.30.30', 0.0323, 5790),
    (240, '2931.52.00', 0.0391, 3489),
    (240, '8540.91.40', 0.1995, 400),
    (240, '8110.10.20', 0.1608, 5740),
    (240, '9503.00.21', 0.2548, 6374),
    (240, '0511.99.10', 0.2251, 4118),
    (240, '8480.79.90', 0.0401, 400),
    (240, '2903.99.3', 0.0166, 2393),
    (240, '2009.89.12', 0.0081, 5777),
    (240, '8479.60.00', 0.0845, 8140),
    (240, '2937.22.90', 0.0307, 4032),
    (240, '8483.60.11', 0.2784, 2425),
    (240, '3702.98.00', 0.1315, 5568),
    (240, '6202.30.00', 0.0377, 8014),
    (240, '8419.40.20', 0.0104, 400),
    (240, '2903.49.00', 0.2822, 3042),
    (240, '3002.41.14', 0.2581, 5978);

INSERT INTO relatorio_serv VALUES
    (240, '1.2504.1', '2023-03-19T11:18:01', 0.2948),
    (240, '1.0106.60.00', '2023-03-20T23:47:53', 0.6978);

INSERT INTO relatorio VALUES
    (241, '2025-06-21', NULL, '01.274.895', '0001-40', '37.669.280/0001-29', 'Pesquisa de campo em emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (241, '2008.99.00', 0.2081, 400);

INSERT INTO relatorio_serv VALUES
    (241, '1.0502.12.20', '2025-07-29T14:36:38', 0.0951),
    (241, '1.0501.21.30', '2025-07-02T12:55:45', 0.123),
    (241, '1.1901.20.00', '2025-07-14T08:48:04', 0.0171),
    (241, '1.0901.22.00', '2025-07-05T15:33:20', 0.0483),
    (241, '1.1001.12', '2025-07-21T23:26:05', 0.0099),
    (241, '1.2002.20.00', '2025-07-06T00:54:36', 0.0434),
    (241, '1.1106.34.00', '2025-07-13T12:28:30', 0.0818),
    (241, '1.0502.21.30', '2025-07-21T13:54:35', 0.012),
    (241, '1.0501.22.20', '2025-07-02T12:35:28', 0.0416),
    (241, '1.0103.20.00', '2025-07-07T17:45:18', 0.0629),
    (241, '1.0107', '2025-07-28T00:56:38', 0.0727),
    (241, '1.1105.20.00', '2025-07-10T04:08:34', 0.0155),
    (241, '1.2501.22.00', '2025-07-24T13:50:10', 0.0158),
    (241, '1.1801.11.00', '2025-07-25T20:25:57', 0.0443),
    (241, '1.19', '2025-07-16T10:59:48', 0.2405),
    (241, '1.1801.29.00', '2025-07-21T00:24:14', 0.1439),
    (241, '1.0501.13', '2025-07-03T11:14:46', 0.0154),
    (241, '1.0401.17.10', '2025-07-11T11:27:15', 0.0451),
    (241, '1.2404.11.00', '2025-07-09T02:49:38', 0.0462),
    (241, '1.0608.30.00', '2025-07-10T05:08:39', 0.0635),
    (241, '1.1806.5', '2025-07-04T07:55:48', 0.0342);

INSERT INTO relatorio VALUES
    (242, '2022-11-26', NULL, '79.821.563', '0001-65', '11.679.309/0001-01', 'Impacto de programas de incentivo fiscal na redução de emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (242, '8517.62.2', 0.0642, 13915),
    (242, '5211.11.00', 0.1427, 6469),
    (242, '2204.22.19', 0.0809, 667),
    (242, '9018.19.20', 0.0705, 2393),
    (242, '3201.90.11', 0.169, 11436),
    (242, '3801.10.00', 0.0878, 3571),
    (242, '2921.46.10', 0.0501, 4568),
    (242, '2914.19.29', 0.0566, 400),
    (242, '2934.99.53', 0.2418, 3845),
    (242, '6505.00.90', 0.0664, 12722),
    (242, '3917.22.10', 0.1184, 7353),
    (242, '3506.10.10', 0.2538, 1747),
    (242, '7505.12.2', 0.1162, 400),
    (242, '2909.49.10', 0.1178, 677),
    (242, '0901.11.90', 0.0429, 14722),
    (242, '8452.10.00', 0.0461, 400),
    (242, '8211.92.10', 0.0608, 7938),
    (242, '7310.10.10', 0.032, 2698);

INSERT INTO relatorio_serv VALUES
    (242, '1.1806.8', '2022-12-17T02:35:41', 0.0821);

INSERT INTO relatorio VALUES
    (243, '2024-05-17', '2025-06-03', '51.360.297', '0001-43', '58.826.745/0001-34', 'Emissões a alto nível', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (243, '8477.10.2', 0.2996, 4422),
    (243, '8518.90.90', 0.804, 1219),
    (243, '2805.19.10', 0.1144, 7320),
    (243, '2933.33.82', 0.3566, 400),
    (243, '9701.21.00', 0.014, 6811),
    (243, '8471.30.11', 0.2618, 4401),
    (243, '8410.11.00', 0.1015, 7652),
    (243, '0305.71.00', 0.8924, 6434);

INSERT INTO relatorio_serv VALUES
    (243, '1.0901.52.20', '2024-06-09T14:52:56', 1.122),
    (243, '1.1405.50.00', '2024-06-20T08:50:01', 0.1244),
    (243, '1.0504.45.10', '2024-06-04T02:34:43', 0.4151),
    (243, '1.1805.12.00', '2024-06-16T09:13:54', 0.1861),
    (243, '1.1101.1', '2024-06-29T01:32:37', 0.5741),
    (243, '1.0401.29.00', '2024-06-08T04:09:47', 1.8411),
    (243, '1.0602.90.00', '2024-06-20T22:08:57', 0.1296),
    (243, '1.0906.20.00', '2024-06-25T09:53:48', 0.3742),
    (243, '1.0403.90.00', '2024-06-07T18:48:46', 0.1875);

INSERT INTO relatorio VALUES
    (244, '2022-01-23', NULL, '01.274.895', '0001-23', '87.888.161/0001-65', 'Impacto de atividades agropecuárias na Amazônia', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (244, '5802.10.00', 0.3101, 400),
    (244, '1301.90.10', 0.1434, 400),
    (244, '2915.70.3', 0.1064, 7652),
    (244, '8448.51.10', 0.3427, 1352),
    (244, '8517.62.51', 0.0531, 400),
    (244, '2927.00.30', 0.3366, 7705),
    (244, '8413.50.10', 0.0227, 2611),
    (244, '3003.90.6', 0.5208, 400),
    (244, '2924.29.99', 0.155, 400),
    (244, '3808.99.19', 0.2573, 1839),
    (244, '6403.19.00', 0.2948, 2269),
    (244, '6812.99.10', 0.9965, 841),
    (244, '8549.13.00', 0.0753, 400),
    (244, '2914.23.10', 0.2592, 400),
    (244, '7407.10.2', 0.033, 4103),
    (244, '3827.90.00', 0.0346, 400),
    (244, '5702.50.10', 0.1851, 400),
    (244, '5402.19.10', 0.1488, 4286),
    (244, '8211.10.00', 0.2714, 7535),
    (244, '0307.43.10', 0.0721, 7259),
    (244, '2827.51.00', 0.1301, 2462);

INSERT INTO relatorio_serv VALUES
    (244, '1.0402.33.00', '2022-02-13T09:33:44', 0.2565);

INSERT INTO relatorio VALUES
    (245, '2021-08-04', '2022-03-16', '79.821.563', '0001-65', '37.669.280/0001-29', 'Pesquisa de campo em emissões', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (245, '9032.89.25', 0.3252, 400),
    (245, '4811.51.28', 1.2031, 5113),
    (245, '5701.10.12', 1.3019, 5158),
    (245, '2922.49.51', 0.1091, 5124),
    (245, '0103.92.00', 0.4357, 12515),
    (245, '8416.10.00', 0.3183, 7880),
    (245, '8518.10.10', 0.306, 7391),
    (245, '9110.90.00', 0.3559, 12408);

INSERT INTO relatorio_serv VALUES
    (245, '1.1001.50.00', '2021-09-20T11:26:20', 0.1908),
    (245, '1.0502.19.00', '2021-09-21T05:49:53', 0.0672),
    (245, '1.1405.22.00', '2021-09-25T12:40:54', 0.1187);

INSERT INTO relatorio VALUES
    (246, '2023-06-10', NULL, '75.893.062', '0001-31', '58.826.745/0001-34', 'Emissões e as metas da ONU', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (246, '8483.20.00', 0.2745, 7801),
    (246, '2841.80.20', 0.1237, 1138),
    (246, '3905.19.90', 0.2115, 8262);

INSERT INTO relatorio_serv VALUES
    (246, '1.1501.20.00', '2023-07-09T05:18:40', 0.5941),
    (246, '1.1805.3', '2023-07-11T12:24:56', 0.0899),
    (246, '1.1105.59.00', '2023-07-15T17:20:40', 0.0301),
    (246, '1.1507.10.00', '2023-07-09T18:47:32', 0.2139),
    (246, '1.0102.70.00', '2023-07-13T21:03:46', 0.0384),
    (246, '1.0903.3', '2023-07-10T06:42:33', 0.1344),
    (246, '1.0401', '2023-07-24T02:17:58', 0.2963),
    (246, '1.2203', '2023-07-04T13:17:25', 0.3739),
    (246, '1.2003', '2023-07-25T07:57:37', 0.3507),
    (246, '1.1409.23.00', '2023-07-15T22:19:45', 0.1987),
    (246, '1.2101.10.00', '2023-07-10T21:13:41', 0.0573),
    (246, '1.2304.12.00', '2023-07-27T15:31:08', 0.4743),
    (246, '1.0906.11.00', '2023-07-18T16:28:32', 0.0982);

INSERT INTO relatorio VALUES
    (247, '2024-08-05', NULL, '13.690.872', '0001-09', '54.777.163/0001-46', 'Andamento das metas da ONU', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (247, '2906.19.30', 0.4867, 400),
    (247, '5211.32.00', 0.068, 5027),
    (247, '3003.90.87', 0.2905, 10635),
    (247, '3301.29.12', 1.5639, 400),
    (247, '7217.10.90', 0.2504, 2771),
    (247, '2612.10.00', 1.188, 3382),
    (247, '2804.50.00', 0.6275, 400),
    (247, '3920.10.99', 0.8709, 5738),
    (247, '6903.10.1', 0.4706, 4631),
    (247, '9018.14.10', 0.4441, 5608),
    (247, '8702.40.10', 0.2984, 1880),
    (247, '8428.39.90', 0.3993, 400);

INSERT INTO relatorio_serv VALUES
    (247, '1.0401.22.00', '2024-09-28T21:14:15', 0.108),
    (247, '1.04', '2024-09-23T18:14:42', 0.057),
    (247, '1.0502.14.5', '2024-09-13T00:55:12', 0.0562);

INSERT INTO relatorio VALUES
    (248, '2025-05-27', '2025-12-22', '45.690.123', '0001-36', '87.888.161/0001-65', 'Impacto de atividades agropecuárias na Amazônia', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (248, '2939.69.4', 1.4492, 3966),
    (248, '9108.19.00', 0.0105, 400),
    (248, '2933.39.29', 0.0922, 6202),
    (248, '7220.20.10', 0.1621, 6669),
    (248, '2908.99.13', 0.0417, 400),
    (248, '2207.20.1', 0.0366, 5256),
    (248, '7505.11.2', 0.0448, 683);

INSERT INTO relatorio_serv VALUES
    (248, '1.0404.10.00', '2025-06-27T14:16:27', 2.3428),
    (248, '1.0301.29.00', '2025-06-03T07:06:24', 0.1179),
    (248, '1.1402.13.00', '2025-06-11T17:32:37', 0.0062),
    (248, '1.1102.90.00', '2025-06-18T18:06:28', 0.0063),
    (248, '1.0501.24.10', '2025-06-03T12:50:16', 0.0313),
    (248, '1.0502.24.5', '2025-06-20T09:23:30', 0.0879),
    (248, '1.1404.43.00', '2025-06-24T12:01:59', 0.2361),
    (248, '1.1409', '2025-06-24T17:16:27', 0.0115),
    (248, '1.1101.11.00', '2025-06-09T01:58:09', 0.051),
    (248, '1.0502.23', '2025-06-23T05:20:15', 0.0908);

INSERT INTO relatorio VALUES
    (249, '2022-12-03', NULL, '01.274.895', '0001-23', '54.777.163/0001-46', 'O capitalismo como motor da exploração dos recursos naturais', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (249, '2917.11.20', 0.0305, 400),
    (249, '0706.90.00', 0.0611, 3435),
    (249, '5208.42.00', 0.0449, 5373),
    (249, '2620.60.00', 0.1116, 400),
    (249, '9028.90.10', 0.0065, 7956),
    (249, '0511.91.10', 0.0386, 10933),
    (249, '0713.90.90', 0.0053, 1418),
    (249, '3915.90.00', 0.0114, 400),
    (249, '0401.40.2', 0.0545, 2257),
    (249, '2401.20.30', 0.0168, 4974),
    (249, '9002.11.11', 0.041, 10730),
    (249, '0303.89.65', 0.0241, 400),
    (249, '4012.13.00', 0.063, 6702),
    (249, '5408.21.00', 0.031, 1365),
    (249, '2701.12.00', 0.1187, 2529),
    (249, '2937.23.99', 0.0145, 10121),
    (249, '8525.50.11', 0.0528, 1106),
    (249, '8454.30.10', 0.1061, 8191),
    (249, '3403.11.10', 0.0074, 2234),
    (249, '3003.31.00', 0.0929, 8987),
    (249, '3907.10.41', 0.0822, 12597),
    (249, '7409.31.90', 0.0443, 400),
    (249, '0713.20.90', 0.1543, 7590),
    (249, '8908.00.00', 0.0201, 400),
    (249, '1512.21.00', 0.0208, 9799),
    (249, '1512.11.20', 0.0309, 9769),
    (249, '0306.99.90', 0.08, 8530);

INSERT INTO relatorio_serv VALUES
    (249, '1.1103.4', '2023-01-19T08:54:42', 0.0513),
    (249, '1.0401.30.00', '2023-01-17T21:50:16', 0.0606),
    (249, '1.0301.10.00', '2023-01-14T08:22:33', 0.0137);

INSERT INTO relatorio VALUES
    (250, '2022-09-07', '2025-08-27', '01.274.895', '0001-40', '37.669.280/0001-29', 'Emissões em microempresas', NULL, NULL, NULL);

INSERT INTO relatorio_prod VALUES
    (250, '2915.50.20', 0.0939, 400);

INSERT INTO relatorio_serv VALUES
    (250, '1.0503.26.00', '2022-10-26T05:19:35', 0.1848),
    (250, '1.0501.14.30', '2022-10-15T03:21:27', 0.0592),
    (250, '1.1506.22.00', '2022-10-03T10:44:25', 0.0346),
    (250, '1.2601.90.00', '2022-10-07T04:57:20', 0.0161),
    (250, '1.1401.3', '2022-10-11T16:08:26', 0.0338),
    (250, '1.07', '2022-10-06T09:39:06', 0.0352),
    (250, '1.17', '2022-10-04T10:31:30', 0.0481),
    (250, '1.0502.11.30', '2022-10-19T10:46:30', 0.0258),
    (250, '1.2501.3', '2022-10-15T01:15:48', 0.0052),
    (250, '1.0402.22.00', '2022-10-02T19:25:41', 0.0146),
    (250, '1.0906.20.00', '2022-10-23T10:15:38', 0.0679),
    (250, '1.1805.13.00', '2022-10-19T04:47:06', 0.0196),
    (250, '1.0101.11.00', '2022-10-04T18:18:15', 0.0048),
    (250, '1.0904.32.00', '2022-10-22T01:59:11', 0.0277),
    (250, '1.1805.3', '2022-10-21T07:34:16', 0.0022),
    (250, '1.1405.1', '2022-10-14T20:35:21', 0.1126),
    (250, '1.1805', '2022-10-08T02:53:30', 0.1165),
    (250, '1.0101.21.00', '2022-10-03T12:28:50', 0.092),
    (250, '1.0502.34.40', '2022-10-22T20:13:49', 0.1257),
    (250, '1.0107.10.00', '2022-10-18T14:43:11', 0.0137),
    (250, '1.2403.3', '2022-10-17T14:16:39', 0.019),
    (250, '1.1403.21', '2022-10-14T19:44:07', 0.0766),
    (250, '1.2301.92.00', '2022-10-19T15:39:05', 0.0265),
    (250, '1.0401.2', '2022-10-05T21:25:37', 0.019),
    (250, '1.0404', '2022-10-09T22:04:54', 0.0375),
    (250, '1.1404.41.00', '2022-10-17T13:36:07', 0.0469),
    (250, '1.2503.20.00', '2022-10-16T06:19:07', 0.0704),
    (250, '1.0404.20.00', '2022-10-23T10:45:18', 0.0909),
    (250, '1.0502.21.30', '2022-10-29T10:54:30', 0.0323),
    (250, '1.1805.21.00', '2022-10-22T10:29:19', 0.0325),
    (250, '1.0502.12', '2022-10-02T03:48:05', 0.0562),
    (250, '1.0102.34.00', '2022-10-16T18:58:10', 0.0779),
    (250, '1.1409.25.00', '2022-10-25T16:13:40', 0.0574);

-- O histórico de CO2 é gerado inicialmente com uma query que não é tão eficiente,
-- porém isso não é um problema, pois a tabela será mantida atualizada posteriormente
-- por meio de triggers, a cada inserção de um relatório ou contribuição feita, ou seja,
-- o custo dessa query é pago apenas no contexto artificial de inicialização da base de dados.
WITH
    emissao_mensal(cnpj_filial_raiz, cnpj_filial_ordem, ano, mes, emissao) AS (
        SELECT
                r.cnpj_filial_raiz,
                r.cnpj_filial_ordem,
                date_part('year', r.dt_pedido + interval '1 month')::int AS ano,
                date_part('month', r.dt_pedido + interval '1 month')::int AS mes,
                SUM(p.tco2_p_un * p.qtde)
            FROM relatorio AS r
            JOIN relatorio_prod AS p ON r.id = p.id_relatorio
            GROUP BY
                r.cnpj_filial_raiz,
                r.cnpj_filial_ordem,
                ano, mes

        UNION

        SELECT
                r.cnpj_filial_raiz,
                r.cnpj_filial_ordem,
                date_part('year', s.ocorrencia)::int AS ano,
                date_part('month', s.ocorrencia)::int AS mes,
                SUM(s.tco2)
            FROM relatorio AS r
            JOIN relatorio_serv AS s ON r.id = s.id_relatorio
            GROUP BY
                r.cnpj_filial_raiz,
                r.cnpj_filial_ordem,
                ano, mes
    ),
    contrib_mensal(cnpj_filial_raiz, cnpj_filial_ordem, ano, mes, contrib) AS (
        SELECT
                v.cnpj_filial_raiz,
                v.cnpj_filial_ordem,
                date_part('year', dt)::int AS ano,
                date_part('month', dt)::int AS mes,
                SUM(valor)
            FROM contrib_co2 AS c
            JOIN vinc_contrib_co2 AS v ON v.id = c.id_contrib
            GROUP BY
                v.cnpj_filial_raiz,
                v.cnpj_filial_ordem,
                ano, mes
    )
INSERT INTO hist_co2 (
    SELECT
            cnpj_filial_raiz,
            cnpj_filial_ordem,
            ano,
            mes,
            SUM(emissao),
            COALESCE(
                (SELECT contrib
                    FROM contrib_mensal
                    WHERE (e.cnpj_filial_raiz, e.cnpj_filial_ordem, e.ano, e.mes) = (cnpj_filial_raiz, cnpj_filial_ordem, ano, mes)),
                0
            )
        FROM emissao_mensal AS e
        GROUP BY cnpj_filial_raiz, cnpj_filial_ordem, ano, mes
);

-- Remove regras legislativas contraditórias, ou seja, incentivos
-- fiscais cuja meta é maior que o limite de uma multa que se aplica
-- ao mesmo produto/serviço, na mesma jurisdição, em intervalos de
-- tempo não disjuntos.
CALL remove_contradictory_rules();

-- Remove todas as contribuições para ações de
-- compensação cujo valor limite foi atingido.
CALL remove_contrib_exceeding_lim();

COMMIT;
