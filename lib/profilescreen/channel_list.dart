import 'package:evopia/profilescreen/channel_single.dart';
import 'package:flutter/material.dart';

import 'channel.dart';
import 'channel_provider.dart';

class ChannelList extends StatelessWidget {
  final List<Channel> channels;
  final void Function(Channel channel) fnUpsertChannel;
  final void Function(Channel channel) fnDeleteChannel;

  const ChannelList(
      {Key? key,
      required this.channels,
      required this.fnUpsertChannel,
      required this.fnDeleteChannel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  Widget body() {
    return Column(children: [
      ListView(shrinkWrap: true, children: [..._channelEntries()]),
      _addChannel()
    ]);
  }

  List<Widget> _channelEntries() {
    return channels
        .map((chan) => ChannelSingle(
            key: Key(chan.name),
            channel: chan,
            fnSave: fnUpsertChannel,
            fnDelete: fnDeleteChannel))
        .toList();
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
