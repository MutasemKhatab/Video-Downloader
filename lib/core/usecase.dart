library;

import 'package:video_downloader/core/data_state.dart';

abstract class UseCase<T, Params> {
  Future<DataState<T>> call(Params params);
}
