import 'package:elkitap/modules/library/controllers/library_controller.dart';
import 'package:elkitap/modules/library/model/book_moc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookGridItem extends StatefulWidget {
  final Book book;
  final ReadingListController controller;

  const BookGridItem({
    super.key,
    required this.book,
    required this.controller,
  });

  @override
  State<BookGridItem> createState() => _BookGridItemState();
}

class _BookGridItemState extends State<BookGridItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Only toggle selection if already in selection mode
        if (widget.controller.selectedBooks.isNotEmpty) {
          widget.controller.toggleSelection(widget.book.id);
        }
      },
      onLongPress: () {
        // Long press enters selection mode and selects this book
        widget.controller.toggleSelection(widget.book.id);
      },
      child: Obx(() {
        final isSelected = widget.controller.isSelected(widget.book.id);
        final isInSelectionMode = widget.controller.selectedBooks.isNotEmpty;

        return Stack(
          children: [
            // Book cover image
            Container(
              decoration: BoxDecoration(),
              clipBehavior: Clip.antiAlias,
              child: Image.asset(
                widget.book.coverUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),

            // 🔹 White glass overlay (for all items in selection mode, except selected ones)
            if (isInSelectionMode && !isSelected)
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.55),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),

            // 🔸 Orange check icon (only for selected)
            if (isSelected)
              Positioned(
                right: 8,
                bottom: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
          ],
        );
      }),
    );
  }
}
