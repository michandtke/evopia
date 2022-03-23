import 'package:flutter/material.dart';

import 'channel.dart';

class ChannelSingle extends StatefulWidget {
  final Channel channel;
  final void Function(Channel channel) fnSave;

  const ChannelSingle({Key? key, required this.channel, required this.fnSave})
      : super(key: key);

  @override
  State createState() => _ChannelSingleState();
}

class _ChannelSingleState extends State<ChannelSingle> {
  late TextEditingController _valueController;

  @override
  void initState() {
    super.initState();
    _valueController = TextEditingController(text: widget.channel.value);
  }

  @override
  void dispose() {
    _valueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _singleChannel(widget.channel);
  }

  Widget _singleChannel(Channel channel) {
    return Padding(
        child: Row(children: [
          Text(channel.name),
          Expanded(child: TextField(controller: _valueController)),
          IconButton(onPressed: _save, icon: const Icon(Icons.save))
        ]),
        padding: const EdgeInsets.only(left: 20, right: 20));
  }

  _save() {
    widget.fnSave(
        Channel(name: widget.channel.name, value: _valueController.text));
  }
}
