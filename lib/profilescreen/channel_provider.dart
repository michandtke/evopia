
import 'package:evopia/profilescreen/channel.dart';

class ChannelProvider {
  List<Channel> provide() {
    var channels = [
      const Channel(name: "Instagram", value: ""),
      const Channel(name: "Phone", value: ""),
      const Channel(name: "Email", value: ""),
      const Channel(name: "Signal", value: ""),
      const Channel(name: "SMS", value: "")
    ];
    return channels;
  }

  List<Channel> provideSome(List<String> some) {
    return provide().where((channel) => some.contains(channel.name)).toList();
  }

  List<Channel> provideExcept(List<String> some) {
    return provide().where((channel) => !some.contains(channel.name)).toList();
  }
}