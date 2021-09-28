class Event {
  final String id;
  final String name;
  final String description;
  final String date;
  final String time;
  final String place;
  final List<String> tags;

  Event({
    required this.name,
    required this.id,
    required this.description,
    required this.date,
    required this.time,
    required this.tags,
    required this.place});
}