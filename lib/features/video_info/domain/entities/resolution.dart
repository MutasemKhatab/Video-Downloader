enum Resolution {
  p2160(2160, '2160p'),
  p1440(1440, '1440p'),
  p1080(1080, '1080p'),
  p720(720, '720p'),
  p480(480, '480p'),
  p360(360, '360p'),
  p240(240, '240p'),
  p144(144, '144p'),
  unknown(0, 'Unknown');

  final int height;
  final String label;

  const Resolution(this.height, this.label);

  @override
  String toString() => label;

  static Resolution fromHeight(int height) {
    return Resolution.values.firstWhere(
      (e) => e.height == height,
      orElse: () => Resolution.unknown,
    );
  }
}
