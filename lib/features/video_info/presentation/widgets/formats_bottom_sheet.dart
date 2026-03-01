import 'package:flutter/material.dart';
import 'package:video_downloader/features/video_info/domain/entities/video_format.dart';

Future<VideoFormat?> showFormatBottomSheet(
  List<VideoFormat> formats,
  BuildContext context,
) async {
  return showModalBottomSheet<VideoFormat?>(
    context: context,
    builder: (context) {
      return ListView.builder(
        itemCount: formats.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(
            '${formats[index].resolution.name}${formats[index].frameRate.name}',
          ),
          leading: Text(formats[index].fileFormat.name),
          trailing: Text(formats[index].formattedSize),
          onTap: () => Navigator.of(context).pop(formats[index]),
        ),
      );
    },
  );
}
