import 'package:video_downloader/core/data_state.dart';
import 'package:video_downloader/features/downloads/domain/entities/video_download_entity.dart';

abstract class VideoDownloadRepository {
  Future<DataState<void>> downloadVideo(VideoDownloadEntity videoToDownload);
  Future<DataState<List<VideoDownloadEntity>>> getDownloads();
}
