class CommonUserModel{
  String _userID;
  String _email;
  String _image;
  String _name;

  CommonUserModel(this._userID, this._email, this._image, this._name);

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get image => _image;

  set image(String value) {
    _image = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get userID => _userID;

  set userID(String value) {
    _userID = value;
  }
}