import 'package:elkitap/core/constants/string_constants.dart';
import 'package:elkitap/core/theme/app_colors.dart';
import 'package:elkitap/modules/library/controllers/library_controller.dart';
import 'package:elkitap/modules/library/model/book_moc.dart';
import 'package:elkitap/modules/store/views/store_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookListItem extends StatefulWidget {
  final Book book;
  final ReadingListController controller;

  const BookListItem({
    super.key,
    required this.book,
    required this.controller,
  });

  @override
  State<BookListItem> createState() => _BookListItemState();
}

class _BookListItemState extends State<BookListItem> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isSelected = widget.controller.isSelected(widget.book.id);
      final isInSelectionMode = widget.controller.selectedBooks.isNotEmpty;

      return GestureDetector(
        onTap: () {
          if (isInSelectionMode) {
            widget.controller.toggleSelection(widget.book.id);
          } else {
            Get.to(() => BookDetailView());
          }
        },
        onLongPress: () {
          widget.controller.toggleSelection(widget.book.id);
        },
        child: Stack(
          children: [
            // Main list item content
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                  // border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
                  ),
              child: Row(
                children: [
                  // Selection indicator circle
                  Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.black
                            : Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: const Color.fromARGB(255, 223, 220, 220),
                            width: 1)),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isSelected
                              ? AppColors.mainColor
                              : Colors.transparent,
                          border: Border.all(
                            color:
                                isSelected ? AppColors.mainColor : Colors.white,
                            width: 2,
                          ),
                        ),
                        child: isSelected
                            ? const Icon(Icons.check,
                                size: 16, color: Colors.white)
                            : null,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),

                  // Book cover
                  Container(
                    width: 60,
                    height: 90,
                    decoration: BoxDecoration(),
                    clipBehavior: Clip.antiAlias,
                    child: Image.asset(widget.book.coverUrl, fit: BoxFit.cover),
                  ),
                  const SizedBox(width: 16),

                  // Book info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.book.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: StringConstants.SFPro,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.book.author,
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: StringConstants.SFPro,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // 🔹 White glass overlay when in selection mode but not selected
            if (isInSelectionMode && !isSelected)
              Positioned.fill(
                child: Container(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.black.withOpacity(0.6)
                      : Colors.white.withOpacity(0.55),
                ),
              ),
          ],
        ),
      );
    });
  }
}
