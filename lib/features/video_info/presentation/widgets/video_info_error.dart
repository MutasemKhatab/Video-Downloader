import 'package:flutter/material.dart';

class VideoInfoError extends StatelessWidget {
  const VideoInfoError(this._message, {super.key});
  final String _message;
  @override
  Widget build(BuildContext context) {
    return Center(child: Text(_message));
  }
}
