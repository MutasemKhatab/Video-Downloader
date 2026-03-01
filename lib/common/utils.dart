import 'dart:math';

String formatFileSize(int numberOfBytes) {
  if (numberOfBytes <= 0) return "0 B";
  final suffixes = ['Bytes', 'KB', 'MB', 'GB'];
  int i = (log(numberOfBytes) / log(1024)).floor();
  double size = numberOfBytes / pow(1024, i);
  return '${size.toStringAsFixed(1)} ${suffixes[i]}';
}
