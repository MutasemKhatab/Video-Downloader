import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:video_downloader/common/utils.dart';
import 'package:video_downloader/features/video_info/domain/entities/video_format.dart';
import 'package:video_downloader/features/video_info/domain/entities/video_info_entity.dart';

class VideoDownloadEntity extends Equatable {
  final VideoInfoEntity videoInfoEntity;
  final StreamController<double> progressStream;
  final int totalDownloadedBytes;
  final VideoFormat videoFormat;

  const VideoDownloadEntity({
    required this.videoInfoEntity,
    required this.progressStream,
    required this.totalDownloadedBytes,
    required this.videoFormat,
  });

  String get formattedTotalDownloadedBytes {
    return formatFileSize(totalDownloadedBytes);
  }

  @override
  List<Object?> get props => [
    videoInfoEntity,
    progressStream,
    totalDownloadedBytes,
    videoFormat,
  ];
}
