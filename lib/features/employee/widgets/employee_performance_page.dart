import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EmployeePerformancePage extends StatefulWidget {
  final int completed;
  final int inProgress;
  final double completionRate;

  const EmployeePerformancePage({
    super.key,
    required this.completed,
    required this.inProgress,
    required this.completionRate,
  });

  @override
  State<EmployeePerformancePage> createState() =>
      _EmployeePerformancePageState();
}

class _EmployeePerformancePageState extends State<EmployeePerformancePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Performance Overview'), elevation: 0),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              //  circular performance
              TweenAnimationBuilder<double>(
                tween: Tween<double>(
                  begin: 0,
                  end: widget.completionRate / 100,
                ),
                duration: const Duration(seconds: 2),
                curve: Curves.easeOutCubic,
                builder: (context, value, child) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 180,
                        height: 180,
                        child: CircularProgressIndicator(
                          value: value,
                          strokeWidth: 14,
                          backgroundColor: theme.colorScheme.primaryContainer
                              .withOpacity(0.3),
                          color: theme.colorScheme.primary,
                          strokeCap: StrokeCap.round,
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            '${(value * 100).toStringAsFixed(1)}%',
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                          Text(
                            'Completion',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 40),

              // Animated Cards Section
              Wrap(
                alignment: WrapAlignment.center,
                runSpacing: 16,
                spacing: 16,
                children: [
                  _AnimatedStatCard(
                    icon: Icons.done_all,
                    title: "Completed Tasks",
                    value: widget.completed.toString(),
                    color: Colors.green.shade600,
                    delay: 0,
                  ),
                  _AnimatedStatCard(
                    icon: Icons.timelapse,
                    title: "In Progress",
                    value: widget.inProgress.toString(),
                    color: Colors.blue.shade600,
                    delay: 200,
                  ),
                  _AnimatedStatCard(
                    icon: Icons.assessment,
                    title: "Total Tasks",
                    value: (widget.completed + widget.inProgress).toString(),
                    color: Colors.purple.shade600,
                    delay: 400,
                  ),
                ],
              ),

              const SizedBox(height: 48),

              // Smooth modern back button
              ElevatedButton.icon(
                onPressed: () => context.go('/employee_page'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 14,
                  ),
                ),
                icon: const Icon(Icons.arrow_back),
                label: const Text(
                  "Back to Tasks",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Added  animated
class _AnimatedStatCard extends StatefulWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final int delay;

  const _AnimatedStatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.delay,
  });

  @override
  State<_AnimatedStatCard> createState() => _AnimatedStatCardState();
}

class _AnimatedStatCardState extends State<_AnimatedStatCard>
    with SingleTickerProviderStateMixin {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) setState(() => _visible = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOutBack,
      opacity: _visible ? 1 : 0,
      child: Transform.translate(
        offset: Offset(0, _visible ? 0 : 50),
        child: Container(
          width: 150,
          decoration: BoxDecoration(
            color: widget.color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: widget.color.withOpacity(0.2)),
            boxShadow: [
              BoxShadow(
                color: widget.color.withOpacity(0.15),
                blurRadius: 10,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(widget.icon, color: widget.color, size: 32),
              const SizedBox(height: 12),
              Text(
                widget.value,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: widget.color,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black87),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
