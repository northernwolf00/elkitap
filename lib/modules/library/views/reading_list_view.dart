import 'package:elkitap/core/constants/string_constants.dart';
import 'package:elkitap/global_widgets/custom_app_bar_book.dart';
import 'package:elkitap/modules/library/controllers/library_controller.dart';
import 'package:elkitap/modules/library/widgets/grid_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReadingListScreen extends StatelessWidget {
  const ReadingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReadingListController());

    return Scaffold(
      appBar: customAppBar(controller, context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header text showing selected books count
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Obx(() {
              return Text(
                controller.selectedBooks.isEmpty
                    ? 'wantToRead'.tr
                    : controller.selectedBooks.length.toString() +
                        'selectedBooksCount'.tr,
                style: const TextStyle(
                  fontSize: 28,
                  fontFamily: StringConstants.NewYork,
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
