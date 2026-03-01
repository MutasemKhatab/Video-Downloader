import 'dart:async';
import 'dart:io';

import 'package:ffmpeg_kit_flutter_new/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_new/return_code.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_downloader/features/downloads/data/datasources/video_download_datasource.dart';
import 'package:video_downloader/features/downloads/data/models/video_download_model.dart';
import 'package:video_downloader/features/downloads/domain/entities/video_download_entity.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class VideoDownloadDatasourceImpl extends VideoDownloadDatasource {
  final List<VideoDownloadModel> downloads = [];
  @override
  Future<void> downloadVideo(VideoDownloadEntity videoToDownload) async {
    final model = addToDownloads(videoToDownload);
    _processDownload(model);
    return;
  }

  Future<void> _processDownload(VideoDownloadModel videoToDownload) async {
    final (tempVideoPath, tempAudioPath, finalOutputPath) = await _getFilesPath(
      videoToDownload,
    );
    int totalBytesDownloaded = 0;
    final totalSize = videoToDownload.videoFormat.sizeInBytes;

    try {
      await _downloadStream(
        videoToDownload.videoFormat.videoStreamInfo,
        tempVideoPath,
        (bytes) {
          totalBytesDownloaded += bytes;
          videoToDownload.progressStream.add(totalBytesDownloaded / totalSize);
        },
      );
      await _downloadStream(
        videoToDownload.videoFormat.audioStreamInfo,
        tempAudioPath,
        (bytes) {
          totalBytesDownloaded += bytes;
          videoToDownload.progressStream.add(totalBytesDownloaded / totalSize);
        },
      );

      final command =
          '-y -i "$tempVideoPath" -i "$tempAudioPath" -c copy -map 0:v:0 -map 1:a:0 -shortest "$finalOutputPath"';
      final session = await FFmpegKit.execute(command);

      if (ReturnCode.isSuccess(await session.getReturnCode())) {
        await OpenFilex.open(finalOutputPath);
      }
    } catch (e) {
      print('Download Error: $e');
    } finally {
      if (File(tempVideoPath).existsSync()) File(tempVideoPath).deleteSync();
      if (File(tempAudioPath).existsSync()) File(tempAudioPath).deleteSync();
    }
  }

  Future<(String, String, String)> _getFilesPath(
    VideoDownloadModel video,
  ) async {
    final downloadDir = await _getDownloadDir();
    final timestamp = DateTime.now().millisecondsSinceEpoch;

    final tempVideoPath = '${downloadDir.path}/temp_v_$timestamp.mp4';
    final tempAudioPath = '${downloadDir.path}/temp_a_$timestamp.mp4';
    final finalOutputPath =
        '${downloadDir.path}/${video.videoInfoEntity.title.replaceAll(RegExp(r'[^\w\s]+'), '')}_$timestamp.mp4';
    return (tempVideoPath, tempAudioPath, finalOutputPath);
  }

  VideoDownloadModel addToDownloads(VideoDownloadEntity videoToDownload) {
    final model = VideoDownloadModel.fromEntity(videoToDownload);
    downloads.add(model);
    return model;
  }

  Future<void> _downloadStream(
    StreamInfo info,
    String path,
    Function(int) onBytes,
  ) async {
    final yt = YoutubeExplode();
    final stream = yt.videos.streamsClient.get(info);
    final file = File(path);
    final ios = file.openWrite();

    await for (final data in stream) {
      ios.add(data);
      onBytes(data.length);
    }
    await ios.flush();
    await ios.close();
    yt.close();
  }

  Future<Directory> _getDownloadDir() async {
    final baseDir = await getExternalStorageDirectory();
    final downloadDir = Directory('${baseDir!.path}/downloads');
    if (!await downloadDir.exists()) {
      await downloadDir.create(recursive: true);
    }
    return downloadDir;
  }

  @override
  Future<List<VideoDownloadModel>> getDownloads() async {
    return downloads;
  }
}
