import 'tag.dart';

class TagProvider {
  List<Tag> provide() {
    var tags = [
      Tag(name: "Beachvolleyball"),
      Tag(name: "Sport"),
      Tag(name: "Bouldern"),
      Tag(name: "Shopping"),
      Tag(name: "Boardgames"),
      Tag(name: "PrayerNights"),
      Tag(name: "Worship"),
      Tag(name: "Movies")
    ];
    // return Future.value(tags);
    return tags;
  }

  List<Tag> provideSome(List<String> some) {
    return provide().where((tag) => some.contains(tag.name)).toList();
  }
}
