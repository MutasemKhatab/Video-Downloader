import 'package:video_downloader/core/data_state.dart';
import 'package:video_downloader/features/downloads/data/datasources/video_download_datasource.dart';
import 'package:video_downloader/features/downloads/data/models/video_download_model.dart';
import 'package:video_downloader/features/downloads/domain/entities/video_download_entity.dart';
import 'package:video_downloader/features/downloads/domain/repositories/video_download_repository.dart';

class VideoDownloadRepositoryImpl extends VideoDownloadRepository {
  final VideoDownloadDatasource _datasource;

  VideoDownloadRepositoryImpl(this._datasource);
  @override
  Future<DataState<void>> downloadVideo(
    VideoDownloadEntity videoToDownload,
  ) async {
    try {
      await _datasource.downloadVideo(videoToDownload);
      return DataSuccess(null);
    } catch (e) {
      return DataFailure(e.toString());
    }
  }

  @override
  Future<DataState<List<VideoDownloadModel>>> getDownloads() async {
    try {
      final result = await _datasource.getDownloads();
      return DataSuccess(result);
    } catch (e) {
      return DataFailure(e.toString());
    }
  }
}
