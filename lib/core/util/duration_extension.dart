extension IntDurationExtension on int {
  Duration get ms => Duration(milliseconds: this);
  Duration get s => Duration(seconds: this);
  Duration get m => Duration(minutes: this);
  Duration get h => Duration(hours: this);
  Duration get d => Duration(days: this);
}
