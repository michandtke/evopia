import 'package:flutter/material.dart';

import 'channel.dart';

class ChannelSingle extends StatefulWidget {

  final Channel channel;

  const ChannelSingle({Key? key, required this.channel}) : super(key: key);

  @override
  State createState() => _ChannelSingleState();
}

class _ChannelSingleState extends State<ChannelSingle> {

  @override
  Widget build(BuildContext context) {
    return _singleChannel(widget.channel);
  }

  Widget _singleChannel(Channel channel) {
    return Padding(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [Text(channel.name), Text(channel.value)]),
        padding: const EdgeInsets.only(left: 20, right: 20));
  }
}