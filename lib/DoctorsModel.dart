class DoctorsModel{
  String _UID;
  String _address;
  String _age;
  String _email;
  String _experience;
  String _gender;
  String _hospitalAddress;
  String _imgURL;
  String _name;
  String _password;
  String _specialization;
  String _type;

  String get UID => _UID;

  set UID(String value) {
    _UID = value;
  }

  DoctorsModel(
      this._UID,
      this._address,
      this._age,
      this._email,
      this._experience,
      this._gender,
      this._hospitalAddress,
      this._imgURL,
      this._name,
      this._password,
      this._specialization,
      this._type);

  String get address => _address;

  String get type => _type;

  set type(String value) {
    _type = value;
  }

  String get specialization => _specialization;

  set specialization(String value) {
    _specialization = value;
  }

  String get password => _password;

  set password(String value) {
    _password = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get imgURL => _imgURL;

  set imgURL(String value) {
    _imgURL = value;
  }

  String get hospitalAddress => _hospitalAddress;

  set hospitalAddress(String value) {
    _hospitalAddress = value;
  }

  String get gender => _gender;

  set gender(String value) {
    _gender = value;
  }

  String get experience => _experience;

  set experience(String value) {
    _experience = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get age => _age;

  set age(String value) {
    _age = value;
  }

  set address(String value) {
    _address = value;
  }
}
