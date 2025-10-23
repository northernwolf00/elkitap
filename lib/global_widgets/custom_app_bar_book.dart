import 'package:elkitap/modules/library/controllers/library_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

PreferredSizeWidget customAppBar(ReadingListController controller) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    leadingWidth: 140,
    leading: Obx(() {
      if (controller.selectedBooks.isEmpty) {
        return Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () {
                Get.back();
              },
            ),
            Text(
              'Back',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
            ),
          ],
        );
      } else {
        return TextButton(
          onPressed: controller.selectAll,
          child: Text(
            controller.selectedBooks.length == controller.books.length
                ? 'Deselect All'
                : 'Select All',
            style: const TextStyle(color: Colors.black, fontSize: 16),
          ),
        );
      }
    }),
    titleSpacing: 0,
    actions: [
      Obx(() {
        if (controller.selectedBooks.isEmpty) {
          // 🔍 Normal mode (no selection)
          return Row(
            children: [
              IconButton(
                icon: const Icon(Icons.search, color: Colors.black),
                onPressed: () {
                  // Search action
                },
              ),
              PopupMenuButton<int>(
                icon: const Icon(Icons.more_vert, color: Colors.black),
                offset: const Offset(0, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                itemBuilder:
                    (context) => [
                      PopupMenuItem<int>(
                        value: 1,
                        child: Row(
                          children: [
                            const Icon(Icons.grid_view),
                            const SizedBox(width: 8),
                            const Text('Grid View'),
                            const Spacer(),
                            if (controller.isGridView.value)
                              const Icon(Icons.check, size: 18),
                          ],
                        ),
                      ),
                      PopupMenuItem<int>(
                        value: 2,
                        child: Row(
                          children: [
                            const Icon(Icons.list),
                            const SizedBox(width: 8),
                            const Text('List View'),
                            const Spacer(),
                            if (!controller.isGridView.value)
                              const Icon(Icons.check, size: 18),
                          ],
                        ),
                      ),
                    ],
                onSelected: (value) {
                  if (value == 1) controller.isGridView.value = true;
                  if (value == 2) controller.isGridView.value = false;
                },
              ),
            ],
          );
        } else {
          // ✅ Selection mode
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => controller.showRemoveDialog(Get.context!),
                  child: const Text(
                    'Remove',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => controller.selectedBooks.clear(),
                  child: const Text(
                    'Done',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      }),
    ],
  );
}
