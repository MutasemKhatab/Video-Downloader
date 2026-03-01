import 'package:video_downloader/core/data_state.dart';
import 'package:video_downloader/features/video_info/domain/entities/video_info_entity.dart';

abstract class VideoInfoRepository {
  Future<DataState<VideoInfoEntity>> fetchVideoInfo(String videoUrl);
}
