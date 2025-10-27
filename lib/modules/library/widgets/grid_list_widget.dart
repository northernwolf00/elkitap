import 'package:elkitap/modules/library/controllers/library_controller.dart';
import 'package:elkitap/modules/library/widgets/book_grid_item.dart';
import 'package:elkitap/modules/library/widgets/book_item_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class GridViewWidget extends StatelessWidget {
  final ReadingListController controller;

  const GridViewWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Obx(() => GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.65,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: controller.books.length,
            itemBuilder: (context, index) {
              return BookGridItem(
                book: controller.books[index],
                controller: controller,
              );
            },
          )),
    );
  }
}


class ListViewWidget extends StatelessWidget {
  final ReadingListController controller;

  const ListViewWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.books.length,
          itemBuilder: (context, index) {
            return BookListItem(
              book: controller.books[index],
              controller: controller,
            );
          },
        ));
  }
}
