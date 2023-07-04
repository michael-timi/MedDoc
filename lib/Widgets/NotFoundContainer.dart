import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

class NotFoundContainer extends StatefulWidget {
  const NotFoundContainer({Key? key}) : super(key: key);

  @override
  State<NotFoundContainer> createState() => _NotFoundContainerState();
}

class _NotFoundContainerState extends State<NotFoundContainer> {
  @override
  Widget build(BuildContext context) {
    return Lottie.asset("animations/notfound.json",repeat: false);
  }
}
