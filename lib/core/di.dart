import 'package:get_it/get_it.dart';
import 'package:video_downloader/features/downloads/data/datasources/video_download_datasource.dart';
import 'package:video_downloader/features/downloads/data/datasources/video_download_datasource_impl.dart';
import 'package:video_downloader/features/downloads/data/repositories/video_download_repository_impl.dart';
import 'package:video_downloader/features/downloads/domain/repositories/video_download_repository.dart';
import 'package:video_downloader/features/downloads/domain/usecases/download_video_usecase.dart';
import 'package:video_downloader/features/downloads/domain/usecases/get_downloads_usecase.dart';
import 'package:video_downloader/features/downloads/presentation/bloc/video_download_bloc.dart';
import 'package:video_downloader/features/video_info/data/datasources/video_info_datasource.dart';
import 'package:video_downloader/features/video_info/data/datasources/youtube_expload_video_info_datasource.dart';
import 'package:video_downloader/features/video_info/data/repositories/video_info_repository_impl.dart';
import 'package:video_downloader/features/video_info/domain/repositories/video_info_repository.dart';
import 'package:video_downloader/features/video_info/domain/usecases/fetch_video_info_usecase.dart';
import 'package:video_downloader/features/video_info/presentation/bloc/video_info_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDeps() async {
  sl.registerLazySingleton<VideoInfoDatasource>(
    () => YoutubeExplodeVideoInfoDatasource(),
  );
  sl.registerLazySingleton<VideoInfoRepository>(
    () => VideoInfoRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<FetchVideoInfoUsecase>(
    () => FetchVideoInfoUsecase(sl()),
  );
  sl.registerFactory<VideoInfoBloc>(() => VideoInfoBloc(sl()));

  sl.registerLazySingleton<VideoDownloadDatasource>(
    () => VideoDownloadDatasourceImpl(),
  );
  sl.registerLazySingleton<VideoDownloadRepository>(
    () => VideoDownloadRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<GetDownloadsUsecase>(
    () => GetDownloadsUsecase(sl()),
  );

  sl.registerLazySingleton<DownloadVideoUsecase>(
    () => DownloadVideoUsecase(sl()),
  );
  sl.registerFactory<VideoDownloadBloc>(
    () => VideoDownloadBloc(
      getDownloadsUsecase: sl(),
      downloadVideoUsecase: sl(),
    ),
  );
}
