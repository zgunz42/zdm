import 'package:zdm/app/views/widgets/base_components/not_found_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UnknownRouteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: NotFoundApp(
          iconPage: Icons.image_not_supported_outlined,
        ));
  }
}