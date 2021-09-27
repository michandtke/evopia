class Event {
  final String id;
  final String name;
  final String description;
  final String date;
  final String time;
  final String place;
  final List<String> tags;

  Event(this.name, this.id, this.description, this.date, this.time, this.tags, this.place);
}