import 'package:flutter/material.dart';

import 'channel.dart';
import 'channel_provider.dart';

class ChannelList extends StatelessWidget {
  final List<Channel> channels;
  final void Function(Channel channel) fnUpsertChannel;

  const ChannelList(
      {Key? key, required this.channels, required this.fnUpsertChannel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  Widget body() {
    return Column(children: [
      ..._channelEntries(),
      _addChannel()
    ]);
  }

  List<Widget> _channelEntries() {
    return channels.map(_singleChannel).toList();
  }

  Widget _singleChannel(Channel channel) {
    return Padding(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [Text(channel.name), Text(channel.value)]),
        padding: const EdgeInsets.only(left: 20, right: 20));
  }

  Widget _addChannel() {
    List<String> alreadyAssignedChannelNames =
        channels.map((chan) => chan.name).toList();
    var possibleChannels =
        ChannelProvider().provideExcept(alreadyAssignedChannelNames);
    return DropdownButton<Channel>(
      hint: const Chip(label: Icon(Icons.add_sharp)),
      icon: Container(),
      underline: Container(),
      items: possibleChannels
          .map((channel) => DropdownMenuItem<Channel>(
              value: channel, child: Text(channel.name)))
          .toList(),
      onChanged: (channel) {
        if (channel != null) {
          fnUpsertChannel(channel);
        }
      },
    );
  }
}
