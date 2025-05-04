import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'widgets.dart';
import 'tables.dart';
import 'rankings.dart';

void main() {
  runApp(AgroSenseAIApp());
}

class AgroSenseAIApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AgroSense AI',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xFF121212),
        primaryColor: Color(0xFF00FF00),
        accentColor: Color(0xFF00FF00),
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.white),
          bodyText2: TextStyle(color: Colors.white70),
        ),
      ),
      home: DashboardPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int selectedYearStart = 2015;
  int selectedYearEnd = 2020;
  String selectedFilter = 'Todos';

  final List<String> filters = ['Todos', 'Exportações', 'Importações'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Sidebar(
            filters: filters,
            selectedFilter: selectedFilter,
            onFilterChanged: (val) {
              setState(() {
                selectedFilter = val;
              });
            },
            selectedYearStart: selectedYearStart,
            selectedYearEnd: selectedYearEnd,
            onYearRangeChanged: (start, end) {
              setState(() {
                selectedYearStart = start;
                selectedYearEnd = end;
              });
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Comparativo do Valor Exportado Atual vs. Ano Anterior',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12),
                  SizedBox(
                    height: 200,
                    child: LineChartWidget(),
                  ),
                  SizedBox(height: 24),
                  SummaryCards(),
                  SizedBox(height: 24),
                  ExportacaoTable(),
                  SizedBox(height: 24),
                  DestinationRanking(),
                  SizedBox(height: 24),
                  TopItemsRanking(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Sidebar extends StatelessWidget {
  final List<String> filters;
  final String selectedFilter;
  final ValueChanged<String> onFilterChanged;
  final int selectedYearStart;
  final int selectedYearEnd;
  final Function(int, int) onYearRangeChanged;

  Sidebar({
    required this.filters,
    required this.selectedFilter,
    required this.onFilterChanged,
    required this.selectedYearStart,
    required this.selectedYearEnd,
    required this.onYearRangeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      color: Color(0xFF1E1E1E),
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'OPERAÇÃO',
            style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          ...filters.map((filter) {
            final isSelected = filter == selectedFilter;
            return GestureDetector(
              onTap: () => onFilterChanged(filter),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 6),
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  color: isSelected ? Color(0xFF00FF00) : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  filter,
                  style: TextStyle(
                    color: isSelected ? Colors.black : Colors.white70,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          }).toList(),
          SizedBox(height: 24),
          Text(
            'BALANÇA',
            style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          Text('Balança Comercial', style: TextStyle(color: Colors.white70)),
          SizedBox(height: 8),
          Text('Em Real (R\$)', style: TextStyle(color: Colors.white70)),
          SizedBox(height: 8),
          Text('Em Real Acumulado', style: TextStyle(color: Colors.white70)),
          SizedBox(height: 24),
          Text(
            'FILTROS',
            style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          DropdownButton<String>(
            value: selectedFilter,
            dropdownColor: Color(0xFF2E2E2E),
            items: filters
                .map((f) => DropdownMenuItem(
                      value: f,
                      child: Text(f, style: TextStyle(color: Colors.white)),
                    ))
                .toList(),
            onChanged: (val) {
              if (val != null) onFilterChanged(val);
            },
          ),
          SizedBox(height: 12),
          Text('Ano', style: TextStyle(color: Colors.white70)),
          Row(
            children: [
              Expanded(
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: '2015',
                    hintStyle: TextStyle(color: Colors.white38),
                    filled: true,
                    fillColor: Color(0xFF2E2E2E),
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  ),
                  onChanged: (val) {
                    final year = int.tryParse(val);
                    if (year != null) {
                      onYearRangeChanged(year, selectedYearEnd);
                    }
                  },
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: '2020',
                    hintStyle: TextStyle(color: Colors.white38),
                    filled: true,
                    fillColor: Color(0xFF2E2E2E),
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  ),
                  onChanged: (val) {
                    final year = int.tryParse(val);
                    if (year != null) {
                      onYearRangeChanged(selectedYearStart, year);
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LineChartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Mock data for line chart
    final spots1 = [
      FlSpot(0, 50),
      FlSpot(1, 60),
      FlSpot(2, 55),
      FlSpot(3, 70),
      FlSpot(4, 65),
      FlSpot(5, 80),
      FlSpot(6, 75),
      FlSpot(7, 90),
      FlSpot(8, 85),
      FlSpot(9, 95),
      FlSpot(10, 90),
      FlSpot(11, 100),
    ];
    final spots2 = [
      FlSpot(0, 45),
      FlSpot(1, 55),
      FlSpot(2, 50),
      FlSpot(3, 65),
      FlSpot(4, 60),
      FlSpot(5, 75),
      FlSpot(6, 70),
      FlSpot(7, 85),
      FlSpot(8, 80),
      FlSpot(9, 90),
      FlSpot(10, 85),
      FlSpot(11, 95),
    ];

    return LineChart(
      LineChartData(
        gridData: FlGridData(show: true, drawVerticalLine: false),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              getTitlesWidget: (value, meta) {
                const months = [
                  'jan', 'fev', 'mar', 'abr', 'mai', 'jun',
                  'jul', 'ago', 'set', 'out', 'nov', 'dez'
                ];
                final index = value.toInt();
                if (index < 0 || index >= months.length) return Container();
                return Text(months[index], style: TextStyle(color: Colors.white70, fontSize: 10));
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true, interval: 20),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: spots1,
            isCurved: true,
            color: Colors.greenAccent,
            barWidth: 3,
            dotData: FlDotData(show: false),
          ),
          LineChartBarData(
            spots: spots2,
            isCurved: true,
            color: Colors.grey,
            barWidth: 3,
            dotData: FlDotData(show: false),
            dashArray: [5, 5],
          ),
        ],
      ),
    );
  }
}

// Additional widgets for SummaryCards, ExportacaoTable, DestinationRanking, TopItemsRanking would be implemented similarly with mock data and styled accordingly.
