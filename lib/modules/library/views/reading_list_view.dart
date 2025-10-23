import 'package:elkitap/global_widgets/custom_app_bar_book.dart';
import 'package:elkitap/modules/library/controllers/library_controller.dart';
import 'package:elkitap/modules/library/widgets/grid_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReadingListScreen extends StatelessWidget {
  const ReadingListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReadingListController());

    return Scaffold(
      appBar: customAppBar(controller),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header text showing selected books count
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Obx(() {
              return Text(
                controller.selectedBooks.isEmpty
                    ? 'Want to Read'
                    : '${controller.selectedBooks.length} selected',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              );
            }),
          ),

          // Book list area (takes remaining space)
          Expanded(
            child: Obx(() {
              return controller.isGridView.value
                  ? GridViewWidget(controller: controller)
                  : ListViewWidget(controller: controller);
            }),
          ),
        ],
      ),
    );
  }
}
