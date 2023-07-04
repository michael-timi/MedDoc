import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

class LoadingContainer extends StatefulWidget {
  const LoadingContainer({Key? key}) : super(key: key);

  @override
  State<LoadingContainer> createState() => _LoadingContainerState();
}

class _LoadingContainerState extends State<LoadingContainer> {
  @override
  Widget build(BuildContext context) {
    return Lottie.asset("animations/loadingnew.json",repeat: true);
  }
}
