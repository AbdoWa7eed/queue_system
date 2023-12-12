extension StringToNum on String? {
  double toDouble() {
    if (this != null) {
      return double.parse(this!);
    }
    return 0.0;
  }

  int toInt() {
    if (this != null) {
      return int.parse(this!);
    }
    return 0;
  }
}
