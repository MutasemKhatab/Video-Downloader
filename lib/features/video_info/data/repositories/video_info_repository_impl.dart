import 'package:video_downloader/core/data_state.dart';
import 'package:video_downloader/features/video_info/data/datasources/video_info_datasource.dart';
import 'package:video_downloader/features/video_info/domain/entities/video_info_entity.dart';
import 'package:video_downloader/features/video_info/domain/repositories/video_info_repository.dart';

class VideoInfoRepositoryImpl extends VideoInfoRepository {
  final VideoInfoDatasource _datasource;
  VideoInfoRepositoryImpl(this._datasource);
  @override
  Future<DataState<VideoInfoEntity>> fetchVideoInfo(String videoUrl) async {
    try {
      final result = await _datasource.fetchVideoInfo(videoUrl);
      return DataSuccess(result);
    } catch (e) {
      return DataFailure(e.toString());
    }
  }
}
