class HistoryModel{
  String _date;
  String _title;
  String _description;
  String _from;
  String _to;

  HistoryModel(
      this._date, this._title, this._description, this._from, this._to);

  String get date => _date;

  set date(String value) {
    _date = value;
  }

  String get title => _title;

  String get to => _to;

  set to(String value) {
    _to = value;
  }

  String get from => _from;

  set from(String value) {
    _from = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  set title(String value) {
    _title = value;
  }
}