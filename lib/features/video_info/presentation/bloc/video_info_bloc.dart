import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_downloader/core/data_state.dart';
import 'package:video_downloader/features/video_info/domain/usecases/fetch_video_info_usecase.dart';
import 'package:video_downloader/features/video_info/presentation/bloc/video_info_event.dart';
import 'package:video_downloader/features/video_info/presentation/bloc/video_info_state.dart';

class VideoInfoBloc extends Bloc<VideoInfoEvent, VideoInfoState> {
  final FetchVideoInfoUsecase _usecase;
  VideoInfoBloc(this._usecase) : super(const LoadingVideoInfoState()) {
    on<FetchVideoInfoEvent>(_onFetchVideoInfo);
  }
  Future<void> _onFetchVideoInfo(
    FetchVideoInfoEvent event,
    Emitter<VideoInfoState> emit,
  ) async {
    emit(LoadingVideoInfoState());
    final result = await _usecase(event.videoUrl);
    if (result is DataSuccess) {
      emit(LoadedVideoInfoState(videoInfo: result.data!));
    } else if (result is DataFailure) {
      emit(ErrorVideoInfoState(message: result.message!));
    }
    return;
  }
}
