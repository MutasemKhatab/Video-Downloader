enum FileFormat {
  mp4('mp4'),
  webm('webm'),
  mp3('mp3'),
  unknown('unknown');

  final String value;
  const FileFormat(this.value);

  @override
  String toString() => value;

  static FileFormat fromString(String format) {
    return FileFormat.values.firstWhere(
      (e) => e.value == format.toLowerCase(),
      orElse: () => FileFormat.unknown,
    );
  }
}
