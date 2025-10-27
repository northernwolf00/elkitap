import 'package:elkitap/modules/library/controllers/library_controller.dart';
import 'package:elkitap/modules/library/model/book_moc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookGridItem extends StatefulWidget {
  final Book book;
  final ReadingListController controller;

  const BookGridItem({super.key, required this.book, required this.controller});

  @override
  State<BookGridItem> createState() => _BookGridItemState();
}

class _BookGridItemState extends State<BookGridItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.controller.toggleSelection(widget.book.id);
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.asset(widget.book.coverUrl),
                ),
                Obx(() {
                  if (widget.controller.isSelected(widget.book.id)) {
                    return Positioned(
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
                    );
                  }
                  return const SizedBox();
                }),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.book.title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            widget.book.author,
            style: TextStyle(color: Colors.grey[600], fontSize: 12),
          ),
        ],
      ),
    );
  }
}
