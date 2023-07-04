class Chat{
 String _sender;
  String _receiver;
  String _message;
  String _isseen;
   String _time;

 String get sender => _sender;

  set sender(String value) {
    _sender = value;
  }

  Chat(this._sender, this._receiver, this._message, this._isseen, this._time);

 String get receiver => _receiver;

 String get time => _time;

  set time(String value) {
    _time = value;
  }

  String get isseen => _isseen;

  set isseen(String value) {
    _isseen = value;
  }

  String get message => _message;

  set message(String value) {
    _message = value;
  }

  set receiver(String value) {
    _receiver = value;
  }
}