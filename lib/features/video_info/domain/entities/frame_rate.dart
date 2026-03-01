enum FrameRate {
  fps60(60),
  fps30(30),
  unknown(0);

  final int value;
  const FrameRate(this.value);

  @override
  String toString() => '${value}fps';

  static FrameRate fromFps(int fps) {
    if (fps >= 60) return FrameRate.fps60;
    if (fps > 0 && fps < 60) return FrameRate.fps30;
    return FrameRate.unknown;
  }
}
