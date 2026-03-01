import 'package:equatable/equatable.dart';
import 'package:video_downloader/features/downloads/domain/entities/video_download_entity.dart';

abstract class VideoDownloadEvent extends Equatable {
  const VideoDownloadEvent();
}

class DownloadVideoVideoDownloadEvent extends VideoDownloadEvent {
  final VideoDownloadEntity videoDownload;
  const DownloadVideoVideoDownloadEvent(this.videoDownload);
  @override
  List<Object?> get props => [videoDownload];
}

class GetDownloadsVideoDownloadEvent extends VideoDownloadEvent {
  const GetDownloadsVideoDownloadEvent();
  @override
  List<Object?> get props => [];
}
