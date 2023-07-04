class ReviewsModel{

  String _time;
  String _review;
  String _from;
  String _revID;
  String _stars;


  String get stars => _stars;

  set stars(String value) {
    _stars = value;
  }

  ReviewsModel(this._time, this._review, this._from, this._revID, this._stars);

  String get revID => _revID;

  set revID(String value) {
    _revID = value;
  }

  String get from => _from;

  set from(String value) {
    _from = value;
  }

  String get review => _review;

  set review(String value) {
    _review = value;
  }

  String get time => _time;

  set time(String value) {
    _time = value;
  }
}