class AppointmentModel{
  String _date;
  String _appointID;
  String _start;
  String _end;
  String _docID;
  String _patientID;
  String _completed;
  String _accepted;

  AppointmentModel(this._date, this._appointID, this._start, this._end,
      this._docID, this._patientID, this._completed, this._accepted);

  String get accepted => _accepted;

  set accepted(String value) {
    _accepted = value;
  }

  String get completed => _completed;

  set completed(String value) {
    _completed = value;
  }

  String get patientID => _patientID;

  set patientID(String value) {
    _patientID = value;
  }

  String get docID => _docID;

  set docID(String value) {
    _docID = value;
  }

  String get end => _end;

  set end(String value) {
    _end = value;
  }

  String get start => _start;

  set start(String value) {
    _start = value;
  }

  String get appointID => _appointID;

  set appointID(String value) {
    _appointID = value;
  }

  String get date => _date;

  set date(String value) {
    _date = value;
  }
}