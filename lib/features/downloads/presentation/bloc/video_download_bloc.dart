import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_downloader/core/data_state.dart';
import 'package:video_downloader/features/downloads/domain/usecases/download_video_usecase.dart';
import 'package:video_downloader/features/downloads/domain/usecases/get_downloads_usecase.dart';
import 'package:video_downloader/features/downloads/presentation/bloc/video_download_event.dart';
import 'package:video_downloader/features/downloads/presentation/bloc/video_download_state.dart';

class VideoDownloadBloc extends Bloc<VideoDownloadEvent, VideoDownloadState> {
  final GetDownloadsUsecase getDownloadsUsecase;
  final DownloadVideoUsecase downloadVideoUsecase;

  VideoDownloadBloc({
    required this.getDownloadsUsecase,
    required this.downloadVideoUsecase,
  }) : super(const LoadingVideoDownloadState()) {
    on<DownloadVideoVideoDownloadEvent>(_onDownloadVideo);
    on<GetDownloadsVideoDownloadEvent>(_onGetDownloads);
  }

  Future<void> _onDownloadVideo(
    DownloadVideoVideoDownloadEvent event,
    Emitter<VideoDownloadState> emit,
  ) async {
    emit(LoadingVideoDownloadState());
    final result = await downloadVideoUsecase(event.videoDownload);
    if (result is DataSuccess) {
      add(GetDownloadsVideoDownloadEvent());
    } else if (result is DataFailure) {
      emit(ErrorVideoDownloadState(result.message!));
    }
    return;
  }

  Future<void> _onGetDownloads(
    GetDownloadsVideoDownloadEvent event,
    Emitter<VideoDownloadState> emit,
  ) async {
    if (state is! LoadingVideoDownloadState) {
      emit(const LoadingVideoDownloadState());
    }
    final result = await getDownloadsUsecase();
    if (result is DataSuccess) {
      emit(LoadedVideoDownloadState(result.data!));
    } else if (result is DataFailure) {
      emit(ErrorVideoDownloadState(result.message!));
    }
    return;
  }
}
