import 'package:video_downloader/core/data_state.dart';
import 'package:video_downloader/core/usecase.dart';
import 'package:video_downloader/features/downloads/domain/entities/video_download_entity.dart';
import 'package:video_downloader/features/downloads/domain/repositories/video_download_repository.dart';

class DownloadVideoUsecase extends UseCase<void, VideoDownloadEntity> {
  final VideoDownloadRepository _repository;

  DownloadVideoUsecase(this._repository);

  @override
  Future<DataState<void>> call(VideoDownloadEntity params) {
    return _repository.downloadVideo(params);
  }
}
