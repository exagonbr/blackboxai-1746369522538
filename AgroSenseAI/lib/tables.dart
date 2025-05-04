import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExportacaoTable extends StatelessWidget {
  final currencyFormat = NumberFormat.currency(locale: 'en_US', symbol: '\$');
  final percentFormat = NumberFormat.decimalPercentPattern(decimalDigits: 2);

  final List<Map<String, dynamic>> exportData = [
    {
      "grupo": "MATERIAS EM BRUTO, NAO COMESTIVEIS, EXC...",
      "valor": 317506784761.0,
      "percentual": 0.2866
    },
    {
      "grupo": "PRODUTOS ALIMENTICIOS E ANIMAIS VIVOS",
      "valor": 238017196602.0,
      "percentual": 0.2146
    },
    {
      "grupo": "MAQUINAS E EQUIPAMENTOS DE TRANSPORTE",
      "valor": 180844640159.0,
      "percentual": 0.1633
    },
    {
      "grupo": "ARTIGOS MANUFATURADOS, CLASSIFICADOS P...",
      "valor": 130374382241.0,
      "percentual": 0.1177
    },
    {
      "grupo": "COMBUSTIVEIS MINERAIS, LUBRIFICANTES E MA...",
      "valor": 112382190630.0,
      "percentual": 0.1016
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFF1E1E1E),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Exportação por Grupo e Subgrupo de Produtos',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 24,
                headingTextStyle: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                ),
                dataTextStyle: TextStyle(color: Colors.white),
                columns: [
                  DataColumn(label: Text('Grupo')),
                  DataColumn(
                    label: Text('Valor Exportado (USD)'),
                    numeric: true,
                  ),
                  DataColumn(
                    label: Text('% Valor Exportado'),
                    numeric: true,
                  ),
                ],
                rows: exportData.map((item) {
                  return DataRow(
                    cells: [
                      DataCell(Text(item['grupo'])),
                      DataCell(Text(
                        currencyFormat.format(item['valor']),
                      )),
                      DataCell(Text(
                        percentFormat.format(item['percentual']),
                      )),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DestinationRanking extends StatelessWidget {
  final List<Map<String, dynamic>> destinationData = [
    {"pais": "China", "valor": 93618000000.0},
    {"pais": "Estados Unidos", "valor": 137744000000.0},
    {"pais": "Argentina", "valor": 70700000000.0},
    {"pais": "Países Baixos", "valor": 54899000000.0},
    {"pais": "Alemanha", "valor": 25860000000.0},
  ];

  @override
  Widget build(BuildContext context) {
    final maxValue = destinationData
        .map((e) => e['valor'])
        .reduce((a, b) => a > b ? a : b);

    return Card(
      color: Color(0xFF1E1E1E),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Principais Países Destino por:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16),
            ...destinationData.map((item) {
              final percentage = item['valor'] / maxValue;
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 120,
                          child: Text(
                            item['pais'],
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                        Expanded(
                          child: Stack(
                            children: [
                              Container(
                                height: 24,
                                decoration: BoxDecoration(
                                  color: Colors.white10,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              FractionallySizedBox(
                                widthFactor: percentage,
                                child: Container(
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: Colors.greenAccent,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 8),
                        SizedBox(
                          width: 100,
                          child: Text(
                            NumberFormat.compactCurrency(
                              locale: 'en_US',
                              symbol: '\$',
                            ).format(item['valor']),
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
