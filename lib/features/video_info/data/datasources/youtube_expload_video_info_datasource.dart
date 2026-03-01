import 'package:video_downloader/features/video_info/data/datasources/video_info_datasource.dart';
import 'package:video_downloader/features/video_info/data/models/video_info_model.dart';
import 'package:video_downloader/features/video_info/domain/entities/video_format.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YoutubeExplodeVideoInfoDatasource extends VideoInfoDatasource {
  @override
  Future<VideoInfoModel> fetchVideoInfo(String videoUrl) async {
    final yt = YoutubeExplode();
    try {
      final (video, manifest) = await (
        yt.videos.get(videoUrl),
        yt.videos.streams.getManifest(videoUrl),
      ).wait;

      final formats = VideoFormat.extractFormatsFromStreamManifest(manifest);
      return VideoInfoModel(
        title: video.title,
        videoUrl: video.url,
        thumbnailImageUrl: video.thumbnails.highResUrl,
        channelName: video.author,
        uploadDate: video.publishDate ?? DateTime.now(),
        formats: formats,
      );
    } catch (e) {
      rethrow;
    } finally {
      yt.close();
    }
  }
}
