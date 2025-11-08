// import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/models/task/task_model.dart';
// import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/statistics/bloc/statistics_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class StatisticsView extends StatelessWidget {
//   const StatisticsView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Task Statistics'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh),
//             onPressed: () => context.read<StatisticsBloc>().add(
//               const StatisticsEvent.refresh(),
//             ),
//           ),
//         ],
//       ),
//       body: BlocBuilder<StatisticsBloc, StatisticsState>(
//         builder: (context, state) {
//           return state.when(
//             initial: () => const Center(child: Text('Initializing...')),
//             loading: () => const Center(child: CircularProgressIndicator()),
//             loaded:
//                 (
//                   totalTasks,
//                   tasksByStatus,
//                   tasksByPriority,
//                   employeeStats,
//                   overdueTasks,
//                   recentTasks,
//                 ) => RefreshIndicator(
//                   onRefresh: () async {
//                     context.read<StatisticsBloc>().add(
//                       const StatisticsEvent.refresh(),
//                     );
//                   },
//                   child: ListView(
//                     padding: const EdgeInsets.all(16),
//                     children: [
//                       // Overview Cards
//                       _buildOverviewCards(totalTasks, overdueTasks),
//                       const SizedBox(height: 24),

//                       // Tasks by Status
//                       _buildStatusChart(tasksByStatus),
//                       const SizedBox(height: 24),

//                       // Tasks by Priority
//                       _buildPriorityChart(tasksByPriority),
//                       const SizedBox(height: 24),

//                       // Employee Workload
//                       _buildEmployeeStats(employeeStats),
//                       const SizedBox(height: 24),

//                       // Recent Tasks
//                       _buildRecentTasks(recentTasks),
//                     ],
//                   ),
//                 ),
//             error: (message) => Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text('Error: $message', textAlign: TextAlign.center),
//                   const SizedBox(height: 16),
//                   ElevatedButton.icon(
//                     onPressed: () => context.read<StatisticsBloc>().add(
//                       const StatisticsEvent.refresh(),
//                     ),
//                     icon: const Icon(Icons.refresh),
//                     label: const Text('Retry'),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildOverviewCards(int totalTasks, int overdueTasks) {
//     return Row(
//       children: [
//         Expanded(
//           child: _StatCard(
//             title: 'Total Tasks',
//             value: totalTasks.toString(),
//             icon: Icons.task,
//             color: Colors.blue,
//           ),
//         ),
//         const SizedBox(width: 16),
//         Expanded(
//           child: _StatCard(
//             title: 'Overdue',
//             value: overdueTasks.toString(),
//             icon: Icons.warning,
//             color: Colors.red,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildStatusChart(Map<String, int> tasksByStatus) {
//     return _SectionCard(
//       title: 'Tasks by Status',
//       child: Column(
//         children: tasksByStatus.entries.map((entry) {
//           return _ProgressRow(
//             label: entry.key.toUpperCase(),
//             value: entry.value,
//             total: tasksByStatus.values.fold(0, (a, b) => a + b),
//             color: _getStatusColor(entry.key),
//           );
//         }).toList(),
//       ),
//     );
//   }

//   Widget _buildPriorityChart(Map<String, int> tasksByPriority) {
//     return _SectionCard(
//       title: 'Tasks by Priority',
//       child: Column(
//         children: tasksByPriority.entries.map((entry) {
//           return _ProgressRow(
//             label: entry.key.toUpperCase(),
//             value: entry.value,
//             total: tasksByPriority.values.fold(0, (a, b) => a + b),
//             color: _getPriorityColor(entry.key),
//           );
//         }).toList(),
//       ),
//     );
//   }

//   Widget _buildEmployeeStats(List<EmployeeStats> employeeStats) {
//     return _SectionCard(
//       title: 'Employee Workload',
//       child: employeeStats.isEmpty
//           ? const Text('No employee data available')
//           : Column(
//               children: employeeStats.map((stat) {
//                 return ListTile(
//                   leading: CircleAvatar(
//                     child: Text(stat.employeeName[0].toUpperCase()),
//                   ),
//                   title: Text(stat.employeeName),
//                   trailing: Chip(
//                     label: Text('${stat.taskCount} tasks'),
//                     backgroundColor: Colors.blue.shade100,
//                   ),
//                 );
//               }).toList(),
//             ),
//     );
//   }

//   Widget _buildRecentTasks(List<Task> recentTasks) {
//     return _SectionCard(
//       title: 'Recent Tasks',
//       child: recentTasks.isEmpty
//           ? const Text('No recent tasks')
//           : Column(
//               children: recentTasks.map((task) {
//                 return ListTile(
//                   title: Text(task.title),
//                   subtitle: Text('Status: ${task.status}'),
//                   trailing: Text(
//                     task.createdAt.toLocal().toString().split(' ')[0],
//                     style: const TextStyle(fontSize: 12),
//                   ),
//                 );
//               }).toList(),
//             ),
//     );
//   }

//   Color _getStatusColor(String status) {
//     switch (status) {
//       case 'pending':
//         return Colors.orange;
//       case 'in_progress':
//         return Colors.blue;
//       case 'completed':
//         return Colors.green;
//       default:
//         return Colors.grey;
//     }
//   }

//   Color _getPriorityColor(String priority) {
//     switch (priority) {
//       case 'high':
//         return Colors.red;
//       case 'medium':
//         return Colors.orange;
//       case 'low':
//         return Colors.green;
//       default:
//         return Colors.grey;
//     }
//   }
// }

// class _StatCard extends StatelessWidget {
//   final String title;
//   final String value;
//   final IconData icon;
//   final Color color;

//   const _StatCard({
//     required this.title,
//     required this.value,
//     required this.icon,
//     required this.color,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             Icon(icon, size: 32, color: color),
//             const SizedBox(height: 8),
//             Text(
//               value,
//               style: Theme.of(context).textTheme.headlineMedium?.copyWith(
//                 fontWeight: FontWeight.bold,
//                 color: color,
//               ),
//             ),
//             Text(
//               title,
//               style: Theme.of(context).textTheme.bodySmall,
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _SectionCard extends StatelessWidget {
//   final String title;
//   final Widget child;

//   const _SectionCard({required this.title, required this.child});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               title,
//               style: Theme.of(
//                 context,
//               ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
//             ),
//             const Divider(),
//             child,
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _ProgressRow extends StatelessWidget {
//   final String label;
//   final int value;
//   final int total;
//   final Color color;

//   const _ProgressRow({
//     required this.label,
//     required this.value,
//     required this.total,
//     required this.color,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final percentage = total > 0 ? (value / total * 100).round() : 0;

//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: Row(
//         children: [
//           Expanded(flex: 2, child: Text(label)),
//           Expanded(
//             flex: 3,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [Text('$value'), Text('$percentage%')],
//                 ),
//                 const SizedBox(height: 4),
//                 LinearProgressIndicator(
//                   value: total > 0 ? value / total : 0,
//                   backgroundColor: color.withOpacity(0.2),
//                   valueColor: AlwaysStoppedAnimation<Color>(color),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// Helper to format Duration nicely
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/statistics/bloc/statistics_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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
      appBar: AppBar(title: const Text('Statistics')),
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

    // Sort employees by task count descending
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
