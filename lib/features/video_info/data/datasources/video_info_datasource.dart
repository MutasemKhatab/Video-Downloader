import 'package:video_downloader/features/video_info/data/models/video_info_model.dart';

abstract class VideoInfoDatasource {
  Future<VideoInfoModel> fetchVideoInfo(String videoUrl);
}
