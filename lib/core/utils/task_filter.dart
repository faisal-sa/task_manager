enum TaskFilter {
  all,
  inProgress,
  completed;

  String get displayName {
    switch (this) {
      case TaskFilter.all:
        return 'All';
      case TaskFilter.inProgress:
        return 'In Progress';
      case TaskFilter.completed:
        return 'Completed';
    }
  }
}
