import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_downloader/core/di.dart';
import 'package:video_downloader/features/downloads/domain/entities/video_download_entity.dart';
import 'package:video_downloader/features/downloads/presentation/bloc/video_download_bloc.dart';
import 'package:video_downloader/features/downloads/presentation/bloc/video_download_event.dart';
import 'package:video_downloader/features/downloads/presentation/bloc/video_download_state.dart';

// Assuming this is the path to your VideoFormat class
import 'package:video_downloader/features/video_info/domain/entities/video_format.dart';
import 'package:video_downloader/features/video_info/domain/entities/video_info_entity.dart';

class DownloadsPage extends StatelessWidget {
  final VideoFormat videoFormat;
  final VideoInfoEntity videoInfoEntity;

  const DownloadsPage({
    super.key,
    required this.videoFormat,
    required this.videoInfoEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Download Manager')),
      body: BlocProvider(
        create: (context) => sl<VideoDownloadBloc>()
          ..add(
            DownloadVideoVideoDownloadEvent(
              VideoDownloadEntity(
                videoInfoEntity: videoInfoEntity,
                progressStream: StreamController.broadcast(),
                totalDownloadedBytes: 0,
                videoFormat: videoFormat,
              ),
            ),
          ),
        child: _DownloadsPage(
          videoFormat: videoFormat,
          videoInfoEntity: videoInfoEntity,
        ),
      ),
    );
  }
}

class _DownloadsPage extends StatelessWidget {
  final VideoFormat videoFormat;
  final VideoInfoEntity videoInfoEntity;

  const _DownloadsPage({
    required this.videoFormat,
    required this.videoInfoEntity,
  });
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoDownloadBloc, VideoDownloadState>(
      builder: (context, state) {
        if (state is LoadingVideoDownloadState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is LoadedVideoDownloadState) {
          return ListView.builder(
            itemCount: state.videoDownloadEntities.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  state.videoDownloadEntities[index].videoInfoEntity.title,
                ),
                trailing: StreamBuilder(
                  stream:
                      state.videoDownloadEntities[index].progressStream.stream,
                  builder: (context, snapshot) {
                    return CircularProgressIndicator(value: snapshot.data);
                  },
                ),
              );
            },
          );
        }
        return Text('no data');
      },
    );
  }
}
