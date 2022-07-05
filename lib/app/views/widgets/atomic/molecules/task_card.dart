import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:zdm/config/constants/assets.gen.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({Key? key, 
  required this.title, 
  required this.beginDate, required this.progress, 
  required this.image,
  required this.transferRate,
  required this.fileSize}) : super(key: key);
  
  final String title;
  final DateTime beginDate;
  final double progress;
  final String fileSize, transferRate;
  final SvgGenImage image;


  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(12),
      child: Row(
        children: [
          Container(width: 50, height: 50, 
          child: FittedBox(child: image.svg()),
          ),
          SizedBox(width: 16),
          Expanded(
              flex: 1,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Text(
                            title,
                            maxLines: 1,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                      Text(timeago.format(beginDate, locale: 'en_short'))
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 8, 0, 4),
                    constraints: BoxConstraints.expand(height: 16),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    child: LinearProgressIndicator(
                        value: progress,
                        backgroundColor: Colors.grey[400],
                        color: Colors.green),
                  ),
                  Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("$fileSize"), Text("${(progress * 100).toStringAsFixed(1)}%")],
                  )
                ],
              ))
        ],
      ),
      height: 90,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0,
              blurRadius: 2,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ]),
      margin: EdgeInsets.symmetric(horizontal: 16),
    );
  }
}
