class Event {
  final int id;
  final String name;
  final String description;
  final DateTime from;
  final DateTime to;
  final String place;
  final List<String> tags;

  Event({
    required this.id,
    required this.name,
    required this.description,
    required this.from,
    required this.to,
    required this.tags,
    required this.place});
}