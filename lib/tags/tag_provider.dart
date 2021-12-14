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
      Tag(name: "Worhsip"),
      Tag(name: "Movies")
    ];
    // return Future.value(tags);
    return tags;
  }
}