import 'package:elkitap/modules/library/controllers/library_controller.dart';
import 'package:elkitap/modules/library/model/book_moc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookListItem extends StatefulWidget {
  final Book book;
  final ReadingListController controller;

  const BookListItem({Key? key, required this.book, required this.controller})
    : super(key: key);

  @override
  State<BookListItem> createState() => _BookListItemState();
}

class _BookListItemState extends State<BookListItem> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isSelected = widget.controller.isSelected(widget.book.id);
      return GestureDetector(
        onTap: () {
          setState(() {
            widget.controller.toggleSelection(widget.book.id);
          });
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.controller.toggleSelection(widget.book.id);
                    });
                  },
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected ? Colors.orange : Colors.transparent,
                      border: Border.all(
                        color: isSelected ? Colors.orange : Colors.grey[400]!,
                        width: 2,
                      ),
                    ),
                    child:
                        isSelected
                            ? const Icon(
                              Icons.check,
                              size: 16,
                              color: Colors.white,
                            )
                            : null,
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  width: 60,
                  height: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Image.asset(widget.book.coverUrl),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.book.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.book.author,
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
