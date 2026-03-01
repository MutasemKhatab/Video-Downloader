import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_downloader/core/di.dart';
import 'package:video_downloader/features/video_info/presentation/bloc/video_info_bloc.dart';
import 'package:video_downloader/features/video_info/presentation/bloc/video_info_event.dart';
import 'package:video_downloader/features/video_info/presentation/bloc/video_info_state.dart';
import 'package:video_downloader/features/video_info/presentation/widgets/video_info_content.dart';
import 'package:video_downloader/features/video_info/presentation/widgets/video_info_error.dart';
import 'package:video_downloader/features/video_info/presentation/widgets/video_info_loading.dart';

class VideoInfoPage extends StatelessWidget {
  final String url;
  const VideoInfoPage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<VideoInfoBloc>()..add(FetchVideoInfoEvent(videoUrl: url)),
      child: _VideoInfoPage(),
    );
  }
}

class _VideoInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.bookmark_outline)),
        ],
      ),
      body: BlocBuilder<VideoInfoBloc, VideoInfoState>(
        builder: (context, state) {
          if (state is LoadedVideoInfoState) {
            return VideoInfoContent(state.videoInfo);
          }
          if (state is ErrorVideoInfoState) {
            return VideoInfoError(state.message);
          }
          // temproraly make this defualt state until i create proper empty state widget
          if (state is LoadingVideoInfoState || true) return VideoInfoLoading();
        },
      ),
    );
  }
}
