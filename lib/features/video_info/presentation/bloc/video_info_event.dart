import 'package:equatable/equatable.dart';

abstract class VideoInfoEvent extends Equatable {
  const VideoInfoEvent();
}

class FetchVideoInfoEvent extends VideoInfoEvent {
  final String videoUrl;
  const FetchVideoInfoEvent({required this.videoUrl});

  @override
  List<Object?> get props => [videoUrl];
}
