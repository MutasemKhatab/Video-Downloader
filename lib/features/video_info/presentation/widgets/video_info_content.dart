import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:video_downloader/features/downloads/presentation/pages/downloads_page.dart';
import 'package:video_downloader/features/video_info/domain/entities/video_format.dart';
import 'package:video_downloader/features/video_info/domain/entities/video_info_entity.dart';
import 'package:video_downloader/features/video_info/presentation/widgets/formats_bottom_sheet.dart';

class VideoInfoContent extends StatefulWidget {
  final VideoInfoEntity _videoInfo;

  const VideoInfoContent(this._videoInfo, {super.key});

  @override
  State<VideoInfoContent> createState() => _VideoInfoContentState();
}

class _VideoInfoContentState extends State<VideoInfoContent> {
  VideoFormat? _videoFormat;

  void _download(BuildContext context) {
    if (_videoFormat != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DownloadsPage(
            videoFormat: _videoFormat!,
            videoInfoEntity: widget._videoInfo,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select a format'),
          action: SnackBarAction(
            onPressed: () async {
              _videoFormat = await showFormatBottomSheet(
                widget._videoInfo.formats,
                context,
              );
            },
            label: 'Select',
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: .start,
        children: [
          SizedBox(
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: CachedNetworkImage(
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
                imageUrl: widget._videoInfo.thumbnailImageUrl,
                fadeInDuration: const Duration(milliseconds: 300),

                placeholder: (context, url) => Container(
                  color: Colors.grey.shade200,
                  child: const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                      color: Colors.grey,
                    ),
                  ),
                ),

                errorWidget: (context, url, error) => Container(
                  color: Colors.grey.shade100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.broken_image_outlined,
                        color: Colors.grey.shade400,
                        size: 48,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Preview not available',
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
            child: Marquee(
              text: widget._videoInfo.title,
              blankSpace: 30.0,
              velocity: 40.0,
              pauseAfterRound: const Duration(seconds: 2),
            ),
          ),
          Text(
            '${widget._videoInfo.channelName} uploaded ${widget._videoInfo.uploadDate}',
            maxLines: 1,
          ),
          Row(
            children: [
              FilledButton.tonalIcon(
                onPressed: () async {
                  _videoFormat = await showFormatBottomSheet(
                    widget._videoInfo.formats,
                    context,
                  );
                },
                label: Text('Format'),
                icon: Icon(Icons.video_file),
              ),
              IconButton.outlined(
                onPressed: () => _download(context),
                icon: Icon(Icons.save_alt_sharp),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
