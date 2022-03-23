import 'package:flutter/material.dart';

import 'channel.dart';

class ChannelSingle extends StatefulWidget {
  final Channel channel;
  final void Function(Channel channel) fnSave;
  final void Function(Channel channel) fnDelete;

  const ChannelSingle(
      {Key? key,
      required this.channel,
      required this.fnSave,
      required this.fnDelete})
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
        padding: const EdgeInsets.only(left: 10),
        child: Row(children: [
          SizedBox(width: 70, child: Text(channel.name)),
          Expanded(child: TextField(controller: _valueController)),
          _icons()
        ]));
  }

  _save() {
    widget.fnSave(
        Channel(name: widget.channel.name, value: _valueController.text));
  }

  _delete() {
    widget.fnDelete(widget.channel);
  }

  Widget _icons() {
    return Row(children: [
      IconButton(onPressed: _save, icon: const Icon(Icons.save)),
      IconButton(onPressed: _delete, icon: const Icon(Icons.delete))
    ]);
  }
}
