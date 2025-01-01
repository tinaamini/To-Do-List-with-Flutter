class Task {
  final int id;
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime createdAt;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.createdAt,
  });
}