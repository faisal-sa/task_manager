enum TaskFilter {
  all('All'),
  pending('Pending'),
  inProgress('In Progress'),
  completed('Completed');

  const TaskFilter(this.displayName);
  final String displayName;
}
