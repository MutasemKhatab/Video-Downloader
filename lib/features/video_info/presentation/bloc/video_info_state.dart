import 'package:equatable/equatable.dart';
import 'package:video_downloader/features/video_info/domain/entities/video_info_entity.dart';

abstract class VideoInfoState extends Equatable {
  const VideoInfoState();
}

class LoadingVideoInfoState extends VideoInfoState {
  const LoadingVideoInfoState();

  @override
  List<Object?> get props => [];
}

class LoadedVideoInfoState extends VideoInfoState {
  final VideoInfoEntity videoInfo;
  const LoadedVideoInfoState({required this.videoInfo});
  @override
  List<Object?> get props => [videoInfo];
}

class ErrorVideoInfoState extends VideoInfoState {
  final String message;
  const ErrorVideoInfoState({required this.message});

  @override
  List<Object?> get props => [message];
}
