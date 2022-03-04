import 'package:flutter/material.dart';

import 'channel.dart';

class ChannelList extends StatelessWidget {
  final List<Channel> channels;
  final void Function(Channel channel) fnAddChannel;

  const ChannelList(
      {Key? key, required this.channels, required this.fnAddChannel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  Widget body() {
    return Column(
        children: [..._channelEntries(), TextButton(onPressed: _addChannel, child: const Text("ADD CHANNEL"))]);
  }

  List<Text> _channelEntries() {
    return channels
          .map((chan) => Text(chan.name + ": " + chan.value))
          .toList();
  }

  _addChannel() {
    var newChannel = const Channel(name: "Instagram", value: "0160");
    fnAddChannel(newChannel);
  }
}
