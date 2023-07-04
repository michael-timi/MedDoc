class NotificationModel{
  String _time;
  String _type;
  String _from;
  String _notID;

  NotificationModel(this._time, this._type, this._from, this._notID);

  String get notID => _notID;

  set notID(String value) {
    _notID = value;
  }

  String get from => _from;

  set from(String value) {
    _from = value;
  }

  String get type => _type;

  set type(String value) {
    _type = value;
  }

  String get time => _time;

  set time(String value) {
    _time = value;
  }
}