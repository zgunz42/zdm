import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotFoundApp extends StatelessWidget {
  final String titleMessage;
  final String descMessage;
  final IconData iconPage;

  const NotFoundApp(
      {Key? key,
      this.titleMessage: "Not Found",
      this.descMessage: "",
      this.iconPage: Icons.cloud_off_rounded})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(iconPage,
                          color: Colors.black12, size: height * 25 / 100),
                      SizedBox(height: height * 3 / 100),
                      Text(
                        titleMessage,
                        style: TextStyle(
                            color: Colors.black26,
                            fontSize: height * 6 / 100,
                            fontWeight: FontWeight.w900),
                      ),
                      SizedBox(height: height * 0.5 / 100),
                      Flexible(
                        child: Text(
                          descMessage,
                          textAlign: TextAlign.center,
                          maxLines: 6,
                          style: TextStyle(
                              color: Colors.black26,
                              fontSize: height * 2 / 100,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                  height: height * 60 / 100,
                  width: width * 80 / 100)
            ],
          ),
        )
      ],
    );
  }
}