import 'package:video_downloader/core/data_state.dart';
import 'package:video_downloader/core/usecase.dart';
import 'package:video_downloader/features/downloads/domain/entities/video_download_entity.dart';
import 'package:video_downloader/features/downloads/domain/repositories/video_download_repository.dart';

class GetDownloadsUsecase extends UseCase<List<VideoDownloadEntity>, void> {
  final VideoDownloadRepository _repository;

  GetDownloadsUsecase(this._repository);

  @override
  Future<DataState<List<VideoDownloadEntity>>> call([void params]) {
    return _repository.getDownloads();
  }
}
