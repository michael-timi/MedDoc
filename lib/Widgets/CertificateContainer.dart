import 'package:flutter/cupertino.dart';
import 'package:meddoc/Styles/applayout.dart';

import 'LoadingContainer.dart';

class CertificateContainer extends StatefulWidget {
  String value,id;

   CertificateContainer({Key? key,required this.value,required this.id}) : super(key: key);

  @override
  State<CertificateContainer> createState() => _CertificateContainerState();
}

class _CertificateContainerState extends State<CertificateContainer> {
  @override
  Widget build(BuildContext context) {
    final size=AppLayout.getSize(context);
    return Container(
      width: size.width*0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
      ),
      child:   Image.network(
        widget.value,
        loadingBuilder: (BuildContext context,Widget child, ImageChunkEvent? loadingProgress){
          if (loadingProgress == null) return child;
          return LoadingContainer();
        },
        fit: BoxFit.contain,
      ),
    );
  }
}
