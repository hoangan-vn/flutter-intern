import 'dart:async';

class XDebounce {
  Duration delay;
  Timer? _timer;
  bool _isFistTime = true;

  XDebounce(
    this.delay,
  );

  call(void Function() callback) {
    //Cancel old timer when calling multiple times
    _timer?.cancel();
    //Return callback for the fist time
    if (_isFistTime) {
      _isFistTime = false;
      callback();
      return;
    }
    //create new timer
    _timer = Timer(delay, callback);
  }

  dispose() {
    _timer?.cancel();
  }
}
