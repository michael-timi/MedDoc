class BookingModel{
  String _startTime;
  String _lastTime;

  BookingModel(this._startTime, this._lastTime);

  String get lastTime => _lastTime;

  set lastTime(String value) {
    _lastTime = value;
  }

  String get startTime => _startTime;

  set startTime(String value) {
    _startTime = value;
  }
}