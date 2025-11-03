import 'package:elkitap/core/constants/string_constants.dart';
import 'package:elkitap/global_widgets/custom_icon.dart';
import 'package:elkitap/modules/library/controllers/library_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

PreferredSizeWidget customAppBar(
    ReadingListController controller, BuildContext context) {
  return AppBar(
    elevation: 0,
    leadingWidth: 140,
    leading: Obx(() {
      if (controller.selectedBooks.isEmpty) {
        return Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
              ),
              onPressed: () {
                Get.back();
              },
            ),
             Text(
              'leading_text'.tr,
              style: TextStyle(
                  fontSize: 17,
                  fontFamily: StringConstants.SFPro,
                  fontWeight: FontWeight.w500),
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
            style: TextStyle(
                fontFamily: StringConstants.SFPro,
                fontSize: 16,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black),
          ),
        );
      }
    }),
    titleSpacing: 0,
    actions: [
      Obx(() {
        if (controller.selectedBooks.isEmpty) {
          return Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.search,
                ),
                onPressed: () {},
              ),
              PopupMenuButton<int>(
                icon: const Icon(
                  Icons.more_vert,
                ),
                offset: const Offset(0, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: Colors.grey.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.black.withOpacity(0.6) // dark mode
                    : Colors.white.withOpacity(0.85),
                elevation: 8,
                itemBuilder: (context) => [
                  PopupMenuItem<int>(
                    value: 1,
                    child: SizedBox(
                      width: 200,
                      child: Row(
                        children: [
                          // if (controller.isGridView.value)
                          //   const Icon(Icons.check,
                          //       size: 18, color: Colors.black54),
                          const SizedBox(width: 8),
                          Text(
                              controller.selectedBooks.length ==
                                      controller.books.length
                                  ? 'Deselect All'
                                  : 'Select All',
                              style: TextStyle()),
                          const Spacer(),
                          CustomIcon(
                              title: 'assets/icons/d5.svg',
                              height: 24,
                              width: 24,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black)

                          //  const Icon(Icons.grid_view, color: Colors.black54),
                        ],
                      ),
                    ),
                  ),
                  const PopupMenuDivider(
                    height: 4,
                  ),
                  PopupMenuItem<int>(
                    value: 1,
                    child: SizedBox(
                      width: 200,
                      child: Row(
                        children: [
                          if (controller.isGridView.value)
                            const Icon(
                              Icons.check,
                              size: 18,
                            ),
                          const SizedBox(width: 8),
                          const Text('Grid View',
                              style: TextStyle(
                                fontFamily: StringConstants.SFPro,
                              )),
                          const Spacer(),
                          CustomIcon(
                              title: 'assets/icons/d8.svg',
                              height: 24,
                              width: 24,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black)
                        ],
                      ),
                    ),
                  ),
                  const PopupMenuDivider(),
                  PopupMenuItem<int>(
                    value: 2,
                    child: SizedBox(
                      width: 200,
                      child: Row(
                        children: [
                          if (!controller.isGridView.value)
                            const Icon(
                              Icons.check,
                              size: 18,
                            ),
                          const SizedBox(width: 8),
                          const Text('List View',
                              style: TextStyle(
                                fontFamily: StringConstants.SFPro,
                              )),
                          const Spacer(),
                          CustomIcon(
                              title: 'assets/icons/d9.svg',
                              height: 24,
                              width: 24,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black),
                        ],
                      ),
                    ),
                  ),
                ],
                onSelected: (value) {
                  // if (value == 1) controller.selectAll;
                  if (value == 1) controller.isGridView.value = true;
                  if (value == 2) controller.isGridView.value = false;
                },
              ),
            ],
          );
        } else {
          // ... (Selection mode code remains the same)
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
                      fontFamily: StringConstants.SFPro,
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => controller.selectedBooks.clear(),
                  child: Text(
                    'Done',
                    style: TextStyle(
                      fontFamily: StringConstants.SFPro,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
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
