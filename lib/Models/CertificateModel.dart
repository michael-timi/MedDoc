class CertificateModel{
  String _id;
  String _value;

  CertificateModel(this._id, this._value);

  String get value => _value;

  set value(String value) {
    _value = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }
}