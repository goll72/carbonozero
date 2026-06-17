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
ON CONFLICT DO UPDATE;

INSERT INTO org_adm_mun VALUES
    ('3505906', '92.574.068/0001-00', 'Prefeitura da Estância Turística de Batatais', 'Trevo de das Neves', 9509, 'Batatais', 'SP'),
    ('3548906', '18.653.207/0001-20', 'Defesa Civil de São Carlos', 'Passarela Santos', 5710, 'São Carlos', 'SP'),
    ('3501905', '92.657.083/0001-04', 'Prefeitura de Amparo', 'Avenida Olivia Mendonça', 4953, 'Amparo', 'SP'),
    ('3550308', '51.840.276/0001-19', 'Órgão Gestor Ambiental de São Paulo', 'Conjunto de Pacheco', 7448, 'São Paulo', 'SP'),
    ('3106200', '30.618.594/0001-60', 'Gerência Ambiental de Belo Horizonte', 'Largo Moraes', 4052, 'Belo Horizonte', 'MG'),
    ('3146206', '43.061.298/0001-52', 'Prefeitura de Ouro Verde de Minas', 'Chácara Montenegro', 2949, 'Ouro Verde de Minas', 'MG'),
    ('3146107', '39.861.402/0001-16', 'Defesa Civil de Ouro Preto', 'Praça Pedro Novais', 2354, 'Ouro Preto', 'MG'),
    ('3304557', '29.086.354/0001-82', 'Administração Ambiental', 'Feira Erick Correia', 6806, 'Rio de Janeiro', 'RJ'),
    ('3306305', '12.736.805/0001-87', 'Prefeitura de Volta Redonda', 'Largo de Freitas', 4809, 'Volta Redonda', 'RJ'),
    ('3205309', '01.264.593/0001-66', 'Defesa Civil de Vitória', 'Aeroporto Leão', 2211, 'Vitória', 'ES'),
    ('2927408', '04.576.382/0001-57', 'Fiscalização Ambiental da Macrorregião de Salvador', 'Rua de Araújo', 7522, 'Salvador', 'BA'),
    ('2919306', '25.169.804/0001-40', 'Prefeitura de Lençóis', 'Passarela João Felipe Lopes', 1187, 'Lençóis', 'BA'),
    ('4208302', '97.581.432/0001-75', 'Prefeitura de Itapema', 'Quadra de da Mota', 6137, 'Itapema', 'SC'),
    ('4314902', '16.982.453/0001-09', 'Tribunal Regional de Porto Alegre', 'Feira da Costa', 1641, 'Porto Alegre', 'RS'),
    ('4205407', '40.932.671/0001-05', 'Prefeitura de Florianópolis', 'Vila de Costela', 3978, 'Florianópolis', 'SC'),
    ('4308250', '89.512.704/0001-57', 'Administração Ambiental', 'Ladeira Vieira', 7142, 'Floriano Peixoto', 'RS'),
    ('5300108', '58.247.031/0001-21', 'Gestão e Planejamento Ambiental de Brasília', 'Chácara Vinicius Casa Grande', 7905, 'Brasília', 'DF'),
    ('1302603', '25.683.971/0001-04', 'Defesa Civil de Manaus', 'Fazenda Carlos Eduardo Nunes', 8647, 'Manaus', 'AM');

-- XXX: this could be a trigger
INSERT INTO ent_fed (SELECT cod_ibge, 'mun' FROM org_adm_mun);
INSERT INTO ent_fed (SELECT cod_ibge, 'uf' FROM uf);

INSERT INTO empresa VALUES
    ('01.274.895', '2910-7/01', '1994-12-17', 'Melo', '207-0', '2024-06-23'),
    ('65.172.380', '6204-0/00', '1995-10-29', 'Machado', '204-6', '2021-03-03'),
    ('79.821.563', '4721-1/02', '1994-04-13', 'Nunes - ME', '230-5', '2021-03-18'),
    ('45.690.123', '4711-3/01', '2006-01-24', 'Carvalho Ltda.', '', '2021-02-20'),
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
    ('28.659.130', '6202-3/00', '2014-07-04', 'Porto S/A', '204-6', '2021-05-26');

COPY serv_nbs FROM 'db/nbs.csv' WITH DELIMITER AS ';' CSV HEADER;
COPY prod_ncm FROM 'db/ncm.csv' WITH DELIMITER AS ';' CSV HEADER;
