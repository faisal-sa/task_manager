import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/statistics/bloc/statistics_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';

String formatDuration(Duration? d) {
  if (d == null) return "N/A";
  d = Duration(microseconds: d.inMicroseconds.round());
  return [
    d.inDays,
    d.inHours.remainder(24),
    d.inMinutes.remainder(60),
  ].map((seg) => seg.toString().padLeft(2, '0')).join(':');
}

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Statistics'),
        backgroundColor: Colors.white,
      ),
      body: BlocBuilder<StatisticsBloc, StatisticsState>(
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox.shrink(),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (message) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(message, textAlign: TextAlign.center),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<StatisticsBloc>().add(
                        const StatisticsEvent.fetchStatistics(),
                      );
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
            loaded:
                (
                  totalTaskCount,
                  tasksByStatus,
                  tasksByPriority,
                  tasksPerEmployee,
                  averageCompletionTime,
                ) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<StatisticsBloc>().add(
                        const StatisticsEvent.fetchStatistics(),
                      );
                    },
                    child: ListView(
                      padding: const EdgeInsets.all(16.0),
                      children: [
                        _buildSummaryCard(
                          totalTaskCount,
                          averageCompletionTime,
                          context,
                        ),
                        const SizedBox(height: 20),
                        _buildPieChartCard(
                          'Tasks by Status',
                          tasksByStatus,
                          context,
                        ),
                        const SizedBox(height: 20),
                        _buildPieChartCard(
                          'Tasks by Priority',
                          tasksByPriority,
                          context,
                        ),
                        const SizedBox(height: 20),
                        _buildLeaderboardCard(
                          'Tasks per Employee',
                          tasksPerEmployee,
                          context,
                        ),
                      ],
                    ),
                  );
                },
          );
        },
      ),
    );
  }

  Widget _buildSummaryCard(int total, Duration? avgTime, BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text(
                  total.toString(),
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Total Tasks',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  formatDuration(avgTime),
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Avg. Completion',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPieChartCard(
    String title,
    Map<String, int> data,
    BuildContext context,
  ) {
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.red,
      Colors.purple,
      Colors.teal,
    ];
    int colorIndex = 0;

    // Ensure we don't show chart for empty data
    if (data.isEmpty) return const SizedBox.shrink();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 20),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: data.entries.map((entry) {
                    final sectionColor = colors[colorIndex++ % colors.length];
                    return PieChartSectionData(
                      color: sectionColor,
                      value: entry.value.toDouble(),
                      title: '${entry.value}',
                      radius: 80,
                      titleStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    );
                  }).toList(),
                  sectionsSpace: 2,
                  centerSpaceRadius: 40,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 16,
              runSpacing: 8,
              children: data.entries.map((entry) {
                final legendColor =
                    colors[data.keys.toList().indexOf(entry.key) %
                        colors.length];
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(width: 16, height: 16, color: legendColor),
                    const SizedBox(width: 8),
                    Text('${entry.key} (${entry.value})'),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeaderboardCard(
    String title,
    Map<String, int> data,
    BuildContext context,
  ) {
    if (data.isEmpty) return const SizedBox.shrink();

    final sortedEntries = data.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            ...sortedEntries.map(
              (entry) => ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(child: Text(entry.key.substring(0, 1))),
                title: Text(entry.key),
                trailing: Text(
                  entry.value.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
