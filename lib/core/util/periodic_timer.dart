import 'dart:async';

class PeriodicTimer {
  final Duration duration;
  final void Function() onTick;

  PeriodicTimer({required this.duration, required this.onTick});

  Timer? _timer;
  bool _isPaused = false;

  void start() {
    // Cancel any running timers
    _timer?.cancel();

    _timer = Timer.periodic(duration, (timer) {
      if (!_isPaused) {
        onTick();
      }
    },);
  }

  void pause() {
    _isPaused = true;
  }

  void resume() {
    _isPaused = false;
  }

  void cancel() {
    _timer?.cancel();
    _isPaused = false;
  }
}
