import 'package:equatable/equatable.dart';
import 'package:video_downloader/features/downloads/domain/entities/video_download_entity.dart';

abstract class VideoDownloadState extends Equatable {
  const VideoDownloadState();
}

class LoadingVideoDownloadState extends VideoDownloadState {
  const LoadingVideoDownloadState();
  @override
  List<Object?> get props => [];
}

class LoadedVideoDownloadState extends VideoDownloadState {
  const LoadedVideoDownloadState(this.videoDownloadEntities);
  final List<VideoDownloadEntity> videoDownloadEntities;
  @override
  List<Object?> get props => [videoDownloadEntities];
}

class ErrorVideoDownloadState extends VideoDownloadState {
  final String message;
  const ErrorVideoDownloadState(this.message);

  @override
  List<Object?> get props => [message];
}
