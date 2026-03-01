import 'package:video_downloader/features/downloads/domain/entities/video_download_entity.dart';

class VideoDownloadModel extends VideoDownloadEntity {
  const VideoDownloadModel({
    required super.videoInfoEntity,
    required super.progressStream,
    required super.totalDownloadedBytes,
    required super.videoFormat,
  });

  factory VideoDownloadModel.fromEntity(VideoDownloadEntity entity) {
    return VideoDownloadModel(
      videoInfoEntity: entity.videoInfoEntity,
      progressStream: entity.progressStream,
      totalDownloadedBytes: entity.totalDownloadedBytes,
      videoFormat: entity.videoFormat,
    );
  }

  factory VideoDownloadModel.fromJson(Map<String, dynamic> json) {
    return VideoDownloadModel(
      videoInfoEntity: json[' videoInfoEntity'],
      progressStream: json['progressStream'],
      totalDownloadedBytes: json['totalDownloadedBytes'],
      videoFormat: json['videoFormat'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'videoInfoEntity': videoInfoEntity,
      'progressStream': progressStream,
      'totalDownloadedBytes': totalDownloadedBytes,
      'videoFormat': videoFormat,
    };
  }
}
