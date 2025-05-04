import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TopItemsRanking extends StatelessWidget {
  final List<Map<String, dynamic>> topItems = [
    {"item": "Soja", "valor": 31360000000.0},
    {"item": "Óleos de petróleo", "valor": 34250000000.0},
    {"item": "Minério de ferro", "valor": 27820000000.0},
    {"item": "Açúcar de cana", "valor": 34180000000.0},
    {"item": "Pastas químicas", "valor": 32450000000.0},
    {"item": "Bagaços e outros", "valor": 29610000000.0},
    {"item": "Café não torrado", "valor": 25080000000.0},
    {"item": "Milho (exceto m...)", "valor": 24820000000.0},
    {"item": "Veículos autom...", "valor": 26370000000.0},
    {"item": "Cortes de aves c...", "valor": 23530000000.0}
  ];

  @override
  Widget build(BuildContext context) {
    final maxValue = topItems
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
              'Ranking TOP Itens Exportados',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16),
            ...topItems.map((item) {
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
                            item['item'],
                            style: TextStyle(color: Colors.white70),
                            overflow: TextOverflow.ellipsis,
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
                                    color: Colors.lightGreenAccent,
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
