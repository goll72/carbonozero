import random

ALLOWED_UF_VALUES = ["SP", "MG", "RJ", "PR", "DF", "AM", "SC", "RS", "BA", "ES", "PE"]
ALLOWED_UF_CDF = [0.3, 0.55, 0.65, 0.75, 0.8, 0.85, 0.9, 0.93, 0.95, 0.97, 1.0]

UF_CEP_RANGES = {
    "SP": [(1_000_000, 19_999_999)],
    "RJ": [(20_000_000, 28_999_999)],
    "ES": [(29_000_000, 29_999_999)],
    "MG": [(30_000_000, 39_999_999)],
    "BA": [(40_000_000, 48_999_999)],
    "SE": [(49_000_000, 49_999_999)],
    "PE": [(50_000_000, 56_999_999)],
    "AL": [(57_000_000, 57_999_999)],
    "PB": [(58_000_000, 58_999_999)],
    "RN": [(59_000_000, 59_999_999)],
    "CE": [(60_000_000, 63_999_999)],
    "PI": [(64_000_000, 64_999_999)],
    "MA": [(65_000_000, 65_999_999)],
    "PA": [(66_000_000, 68_899_999)],
    "AP": [(68_900_000, 68_999_999)],
    "AM": [(69_000_000, 69_899_999)],
    "RR": [(69_300_000, 69_399_999)],
    "AC": [(69_900_000, 69_999_999)],
    "DF": [
        (70_000_000, 72_799_999),
        (73_000_000, 73_699_999),
    ],
    "GO": [
        (72_800_000, 72_999_999),
        (73_700_000, 76_799_999),
    ],
    "RO": [(76_800_000, 76_999_999)],
    "TO": [(77_000_000, 77_999_999)],
    "MT": [(78_000_000, 78_899_999)],
    "MS": [(79_000_000, 79_999_999)],
    "PR": [(80_000_000, 87_999_999)],
    "SC": [(88_000_000, 89_999_999)],
    "RS": [(90_000_000, 99_999_999)],
}

UF_CEP_MAP = {
    uf: (
        lambda ranges=ranges: random.randint(*random.choice(ranges))
    )
    for uf, ranges in UF_CEP_RANGES.items()
}


def random_cep_for_uf(uf: str) -> str:
    cep = UF_CEP_MAP[uf.upper()]()
    return f"{cep:08d}"


ALLOWED_NGO_VALUES = [
    ('35.179.804/0001-84', 'Pandas Sorridentes'),
    ('74.029.536/0001-76', 'WWF Brasil'),
    ('52.061.387/0001-90', 'EnxofreZero'),
    ('37.186.429/0001-25', 'Recicla+'),
    ('68.532.497/0001-22', 'Inova'),
    ('20.594.183/0001-28', 'Anti-Shell'),
    ('63.754.089/0001-00', 'Nature Collective'),
    ('07.219.354/0001-70', 'Associação Cultura Sustentável'),
    ('64.253.970/0001-81', 'Metrosus'),
    ('14.679.502/0001-03', 'Acolhe Agora'),
]

ALLOWED_NGO_CDF = [
    0.05,
    0.35,
    0.47,
    0.57,
    0.63,
    0.73,
    0.78,
    0.81,
    0.90,
    1.0
]

ENTES_FEDERATIVOS = [
    # UF
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
    ('ES', '32'),
    # Mun.
    ('Batatais', 'SP', '3505906'),
    ('São Carlos', 'SP', '3548906'),
    ('Amparo', 'SP', '3501905'),
    ('São Paulo', 'SP', '3550308'),
    ('Belo Horizonte', 'MG', '3106200'),
    ('Ouro Verde de Minas', 'MG', '3146206'),
    ('Ouro Preto', 'MG', '3146107'),
    ('Rio de Janeiro', 'RJ', '3304557'),
    ('Volta Redonda', 'RJ', '3306305'),
    ('Vitória', 'ES', '3205309'),
    ('Salvador', 'BA', '2927408'),
    ('Lençóis', 'BA', '2919306'),
    ('Itapema', 'SC', '4208302'),
    ('Porto Alegre', 'RS', '4314902'),
    ('Florianópolis', 'SC', '4205407'),
    ('Floriano Peixoto', 'RS', '4308250'),
    ('Brasília', 'DF', '5300108'),
    ('Manaus', 'AM', '1302603'),
    ('Curitiba', 'PR', '4106902')
]

ENTES_FEDERATIVOS_V = [x[-1] for x in ENTES_FEDERATIVOS]

FILIAIS_VALIDAS = [
    ("01.274.895", "0001-23", "DF"),
    ("01.274.895", "0001-40", "SP"),
    ("01.274.895", "0001-13", "MG"),
    ("65.172.380", "0001-61", "MG"),
    ("65.172.380", "0001-53", "MG"),
    ("79.821.563", "0001-65", "SP"),
    ("79.821.563", "0001-00", "SC"),
    ("79.821.563", "0001-99", "SC"),
    ("79.821.563", "0001-43", "RJ"),
    ("45.690.123", "0001-36", "AM"),
    ("27.401.593", "0001-66", "SP"),
    ("53.921.807", "0001-18", "RS"),
    ("13.690.872", "0001-54", "MG"),
    ("13.690.872", "0001-09", "MG"),
    ("09.723.145", "0001-78", "RJ"),
    ("09.723.145", "0001-93", "PR"),
    ("09.723.145", "0001-56", "MG"),
    ("51.360.297", "0001-43", "SP"),
    ("18.024.935", "0001-76", "SP"),
    ("64.087.915", "0001-27", "SP"),
    ("48.912.037", "0001-48", "SP"),
    ("48.912.037", "0001-38", "SP"),
    ("12.905.674", "0001-18", "MG"),
    ("71.498.635", "0001-06", "SP"),
    ("39.605.871", "0001-83", "PR"),
    ("48.603.715", "0001-45", "MG"),
    ("48.603.715", "0001-78", "MG"),
    ("20.978.635", "0001-10", "MG"),
    ("56.738.014", "0001-69", "SP"),
    ("75.893.062", "0001-33", "RS"),
    ("75.893.062", "0001-31", "SC"),
    ("28.659.130", "0001-07", "SC"),
    ("33.738.001", "0001-77", "BA"),
    ("88.635.333", "0001-98", "ES"),
]

EQUIPES_VALIDAS = [
    ("58.826.745/0001-34", "Emissões a alto nível", "SP"),
    ("58.826.745/0001-34", "Emissões e as metas da ONU", "SP"),
    ("58.826.745/0001-34", "Impacto das técnicas de produção em emissões", "SP"),
    ("37.669.280/0001-29", "Pesquisa de campo em emissões", "SP"),
    ("37.669.280/0001-29", "Emissões em microempresas", "SP"),
    ("11.679.309/0001-01", "Impacto de programas de incentivo fiscal na redução de emissões", "SP"),
    ("11.679.309/0001-01", "Análise de emissões em São Paulo na última década", "SP"),
    ("53.396.825/0001-34", "Formas de reduzir o impacto de emissões", "MG"),
    ("09.850.333/0001-77", "Emissões: e eu com isso?", "RJ"),
    ("87.888.161/0001-65", "Impacto de atividades agropecuárias na Amazônia", "AM"),
    ("00.001.333/0001-99", "Tipos de emissão em empresas de refinaria", "BA"),
    ("54.777.163/0001-46", "O capitalismo como motor da exploração dos recursos naturais", "MG"),
    ("54.777.163/0001-46", "Andamento das metas da ONU", "MG"),
]

ACOES_VALIDAS = [
    ("74.029.536/0001-76", "2020-06-21", "Campanha de reflorestamento local"),
    ("64.253.970/0001-81", "2025-04-10", "Campanha de reflorestamento no Amazonas"),
    ("74.029.536/0001-76", "2026-02-25", "Incentivos de transporte sustentável"),
    ("52.061.387/0001-90", "2024-08-26", "Implantação de painéis solares em estabelecimentos públicos"),
    ("68.532.497/0001-22", "2021-12-25", "Compensação de emissões no transporte urbano"),
    ("37.186.429/0001-25", "2021-03-21", "Programa de neutralização de carbono logístico"),
    ("63.754.089/0001-00", "2021-11-01", "Mobilidade sustentável com baixa emissão"),
    ("14.679.502/0001-03", "2022-11-12", "Transporte coletivo carbono neutro"),
    ("64.253.970/0001-81", "2020-03-22", "Frota verde para redução de emissões"),
    ("37.186.429/0001-25", "2022-06-02", "Compensação de viagens corporativas"),
    ("20.594.183/0001-28", "2025-01-07", "Neutralização de emissões de entregas"),
    ("68.532.497/0001-22", "2023-01-16", "Corredores verdes de mobilidade"),
    ("52.061.387/0001-90", "2021-12-16", "Transporte limpo para comunidades"),
    ("52.061.387/0001-90", "2023-11-04", "Redução de carbono no deslocamento diário"),
    ("64.253.970/0001-81", "2022-06-27", "Geração comunitária de energia solar"),
    ("74.029.536/0001-76", "2025-03-15", "Energia renovável para todos"),
    ("52.061.387/0001-90", "2022-04-07", "Transição energética sustentável"),
    ("14.679.502/0001-03", "2026-05-11", "Eficiência energética em edificações"),
    ("63.754.089/0001-00", "2025-04-04", "Energia limpa para organizações sociais"),
    ("35.179.804/0001-84", "2023-07-28", "Compensação de emissões por energia renovável"),
    ("14.679.502/0001-03", "2021-02-16", "Modernização energética de baixo carbono"),
    ("20.594.183/0001-28", "2022-03-18", "Rede de energia solar comunitária"),
    ("14.679.502/0001-03", "2020-02-10", "Programa de economia de energia e carbono"),
    ("74.029.536/0001-76", "2020-06-24", "Substituição de fontes fósseis por renováveis"),
    ("63.754.089/0001-00", "2023-12-04", "Reciclagem solidária com compensação ambiental"),
    ("35.179.804/0001-84", "2020-02-01", "Gestão circular de resíduos urbanos"),
    ("52.061.387/0001-90", "2021-06-26", "Coleta seletiva para redução de carbono"),
    ("74.029.536/0001-76", "2022-10-02", "Reciclagem inclusiva e sustentável"),
    ("52.061.387/0001-90", "2021-10-30", "Valorização de resíduos para mitigação climática"),
    ("74.029.536/0001-76", "2024-01-23", "Economia circular em comunidades locais"),
    ("74.029.536/0001-76", "2025-11-17", "Reaproveitamento de materiais pós-consumo"),
    ("37.186.429/0001-25", "2026-03-25", "Programa de resíduos com baixa emissão"),
    ("74.029.536/0001-76", "2020-06-26", "Cadeia sustentável de reciclagem"),
    ("37.186.429/0001-25", "2023-12-02", "Transformação de resíduos em impacto positivo"),
    ("64.253.970/0001-81", "2025-12-20", "Reflorestamento para neutralização de carbono"),
    ("52.061.387/0001-90", "2025-08-07", "Recuperação de áreas degradadas e clima"),
    ("63.754.089/0001-00", "2022-04-13", "Corredores ecológicos para captura de carbono"),
    ("68.532.497/0001-22", "2021-04-25", "Plantio de árvores para compensação ambiental"),
    ("68.532.497/0001-22", "2021-06-25", "Conservação florestal e créditos de carbono"),
    ("52.061.387/0001-90", "2021-06-23", "Restauração de nascentes e sequestro de carbono"),
    ("74.029.536/0001-76", "2023-10-17", "Florestas comunitárias para o clima"),
    ("68.532.497/0001-22", "2023-04-22", "Recuperação da vegetação nativa"),
    ("52.061.387/0001-90", "2021-09-22", "Proteção de biomas e compensação climática"),
    ("52.061.387/0001-90", "2023-11-20", "Neutralização de emissões de eventos"),
    ("52.061.387/0001-90", "2025-01-03", "Compensação ambiental de operações organizacionais"),
    ("14.679.502/0001-03", "2023-09-21", "Ação climática para organizações sociais"),
    ("07.219.354/0001-70", "2024-04-07", "Gestão sustentável da pegada de carbono"),
    ("63.754.089/0001-00", "2025-09-22", "Programa integrado de mitigação climática"),
]
