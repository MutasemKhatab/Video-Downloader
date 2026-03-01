import 'package:video_downloader/features/downloads/data/models/video_download_model.dart';
import 'package:video_downloader/features/downloads/domain/entities/video_download_entity.dart';

abstract class VideoDownloadDatasource {
  Future<void> downloadVideo(VideoDownloadEntity videoToDownload);
  Future<List<VideoDownloadModel>> getDownloads();
}
