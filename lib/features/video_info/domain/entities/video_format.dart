import 'package:equatable/equatable.dart';
import 'package:video_downloader/common/utils.dart';
import 'package:video_downloader/features/video_info/domain/entities/file_format.dart';
import 'package:video_downloader/features/video_info/domain/entities/frame_rate.dart';
import 'package:video_downloader/features/video_info/domain/entities/resolution.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class VideoFormat extends Equatable {
  final FileFormat fileFormat;
  final Resolution resolution;
  final FrameRate frameRate;
  final int sizeInBytes;
  final VideoStreamInfo videoStreamInfo;
  final AudioStreamInfo audioStreamInfo;

  const VideoFormat({
    required this.fileFormat,
    required this.resolution,
    required this.frameRate,
    required this.sizeInBytes,
    required this.videoStreamInfo,
    required this.audioStreamInfo,
  });

  @override
  List<Object?> get props => [
    videoStreamInfo,
    audioStreamInfo,
    sizeInBytes,
    fileFormat,
    resolution,
    frameRate,
  ];

  String get formattedSize {
    return formatFileSize(sizeInBytes);
  }

  static List<VideoFormat> extractFormatsFromStreamManifest(
    StreamManifest manifest,
  ) {
    // Change your audio extraction to this:
    final bestAudio = manifest.audioOnly
        .where(
          (audio) =>
              audio.container.name == 'mp4' || audio.container.name == 'm4a',
        )
        .withHighestBitrate();
    final Map<String, VideoFormat> uniqueFormatsMap = {};

    for (var videoStream in manifest.videoOnly) {
      final res = Resolution.fromHeight(videoStream.videoResolution.height);
      final fileFormat = FileFormat.fromString(videoStream.container.name);
      final fps = FrameRate.fromFps(
        videoStream.framerate.framesPerSecond.toInt(),
      );

      if (res == Resolution.unknown) continue;

      final parsedFormat = VideoFormat(
        fileFormat: fileFormat,
        resolution: res,
        frameRate: fps,
        sizeInBytes: videoStream.size.totalBytes + bestAudio.size.totalBytes,
        videoStreamInfo: videoStream,
        audioStreamInfo: bestAudio,
      );
      final key = '$res$fps$fileFormat';
      if (!uniqueFormatsMap.containsKey(key)) {
        uniqueFormatsMap[key] = parsedFormat;
      }
    }

    final sortedFormats = uniqueFormatsMap.values.toList();
    sortedFormats.sort(
      (a, b) => b.resolution.height.compareTo(a.resolution.height),
    );

    return sortedFormats;
  }
}
