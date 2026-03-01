import 'package:video_downloader/features/video_info/domain/entities/video_info_entity.dart';

class VideoInfoModel extends VideoInfoEntity {
  const VideoInfoModel({
    required super.title,
    required super.videoUrl,
    required super.thumbnailImageUrl,
    required super.channelName,
    required super.uploadDate,
    required super.formats,
  });

  factory VideoInfoModel.fromJson(Map<String, dynamic> json) => VideoInfoModel(
    title: json['title'],
    videoUrl: json['videoUrl'],
    thumbnailImageUrl: json['thumbnailImageUrl'],
    channelName: json['channelName'],
    uploadDate: json['uploadDate'],
    formats: json['formats'],
  );
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'videoUrl': videoUrl,
      'thumbnailImageUrl': thumbnailImageUrl,
      'channelName': channelName,
      'uploadDate': uploadDate,
      'formats': formats,
    };
  }
}
