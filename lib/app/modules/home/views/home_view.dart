import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:zdm/services/downloader_service.dart';
import 'package:zdm/app/routes/app_pages.dart';
import 'package:zdm/app/views/widgets/atomic/molecules/task_card.dart';
import 'package:zdm/config/constants/colors.gen.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: Text('Beranda'),
        backgroundColor: ColorName.crimsonRed[800],
        centerTitle: true,
      ),
      body: CustomScrollView(
          // height: .height,
          slivers: [
            SliverToBoxAdapter(child: SizedBox(height: 80)),
            SliverToBoxAdapter(
              child: SizedBox(
                  height: 120,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        boxShadow: [
                          BoxShadow(
                              color: Theme.of(context).shadowColor,
                              blurRadius: 1)
                        ]),
                    child: Container(
                      // constraints: BoxConstraints.expand(height: 40),
                      height: 40,
                      margin: EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: GetBuilder(
                                init: controller,
                                builder: (_) => TextField(
                                    controller: controller.inputController,
                                    onSubmitted: (s) => controller
                                        .rootController.link.value = s,
                                    autocorrect: false,
                                    maxLines: 1,
                                    expands: false,
                                    showCursor: false,
                                    minLines: 1,
                                    maxLengthEnforcement:
                                        MaxLengthEnforcement.enforced,
                                    autofocus: false,
                                    textAlignVertical: TextAlignVertical.top,
                                    decoration: InputDecoration(
                                      hintText: "http",
                                      contentPadding: EdgeInsets.all(4),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey, width: 2)),
                                    )),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                DownloaderService.to
                                    .download(controller.inputController.text);
                              },
                              child: Text("download"))
                        ],
                      ),
                    ),
                  )),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 16)),
            SliverToBoxAdapter(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          "Download List",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.more_horiz))
                    ],
                  ),
                ),
              ),
            ),

            SliverList(
                delegate: SliverChildBuilderDelegate((xtx, index) {
                  final e = DownloaderService.to.tasks["$index"]; 
                  if(e != null) {
                    return Obx(() => Container(
                          margin: EdgeInsets.only(bottom: 12),
                          child: TaskCard(
                              title: e.name, 
                              beginDate: e.timeCreated,
                              progress: e.progress/100,
                              image: DownloaderService.to.getImageFile(e.type),
                              fileSize: e.size,
                            )
                          ));
                  }
                })
            )
          ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.SCANNER);
        },
        child: const Icon(
          Icons.qr_code,
          color: Colors.white,
        ),
        backgroundColor: Colors.green,
      ),
    );
  }
}
