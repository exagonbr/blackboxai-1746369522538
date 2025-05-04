import 'package:flutter/material.dart';

class SummaryCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildCard('Qtd Países Destino', '253', Icons.flag),
        _buildCard('Valor Exportado (USD)', '\$1 Tri', Icons.attach_money),
        _buildCard('KGs Exportados', '3,5 Tri', Icons.inventory),
      ],
    );
  }

  Widget _buildCard(String title, String value, IconData icon) {
    return Expanded(
      child: Card(
        color: Color(0xFF1E1E1E),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.greenAccent,
                child: Icon(icon, color: Colors.black),
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(color: Colors.white70)),
                  SizedBox(height: 4),
                  Text(value, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Additional widgets for ExportacaoTable, DestinationRanking, TopItemsRanking to be implemented similarly.
