import 'package:video_downloader/core/data_state.dart';
import 'package:video_downloader/core/usecase.dart';
import 'package:video_downloader/features/video_info/domain/entities/video_info_entity.dart';
import 'package:video_downloader/features/video_info/domain/repositories/video_info_repository.dart';

class FetchVideoInfoUsecase extends UseCase<VideoInfoEntity, String> {
  final VideoInfoRepository _repository;
  FetchVideoInfoUsecase(this._repository);
  @override
  Future<DataState<VideoInfoEntity>> call(String params) {
    return _repository.fetchVideoInfo(params);
  }
}
