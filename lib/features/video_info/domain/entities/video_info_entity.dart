import 'package:equatable/equatable.dart';
import 'package:video_downloader/features/video_info/domain/entities/video_format.dart';

class VideoInfoEntity extends Equatable {
  final String title, videoUrl, thumbnailImageUrl, channelName;
  final DateTime uploadDate;
  final List<VideoFormat> formats;

  const VideoInfoEntity({
    required this.title,
    required this.videoUrl,
    required this.thumbnailImageUrl,
    required this.channelName,
    required this.uploadDate,
    required this.formats,
  });

  @override
  List<Object?> get props => [
    title,
    videoUrl,
    thumbnailImageUrl,
    channelName,
    uploadDate,
    formats,
  ];
}
