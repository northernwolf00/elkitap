import 'package:elkitap/core/constants/string_constants.dart';
import 'package:elkitap/modules/library/model/book_moc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReadingListController extends GetxController {
  var books = <Book>[].obs;
  var selectedBooks = <String>[].obs;
  var isGridView = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadBooks();
  }

  void loadBooks() {
    books.value = [
      Book(
        id: '1',
        title: '12 Rules for life',
        author: 'Rebecca Roanhorse',
        coverColor: 'white',
        coverUrl: 'assets/images/b1.png',
      ),
      Book(
        id: '2',
        title: 'Stop over thinking',
        author: 'Rebecca Roanhorse',
        coverColor: 'red',
        coverUrl: 'assets/images/b2.png',
      ),
      Book(
        id: '3',
        title: 'Falling bodies',
        author: 'Rebecca Roanhorse',
        coverColor: 'black',
        coverUrl: 'assets/images/b3.png',
      ),
      Book(
        id: '4',
        title: 'How to Unfolds',
        author: 'James S. Corey',
        coverColor: 'purple',
        coverUrl: 'assets/images/b4.png',
      ),
      Book(
        id: '5',
        title: 'Power',
        author: 'Rebecca Roanhorse',
        coverColor: 'pink',
        coverUrl: 'assets/images/b5.png',
      ),
      Book(
        id: '6',
        title: 'The subtle art',
        author: 'Mark Manson',
        coverColor: 'orange',
        coverUrl: 'assets/images/b6.png',
      ),
      Book(
        id: '7',
        title: 'Atomic habits',
        author: 'James Clear',
        coverColor: 'beige',
        coverUrl: 'assets/images/b7.png',
      ),
    ];
  }

  void toggleSelection(String bookId) {
    if (selectedBooks.contains(bookId)) {
      selectedBooks.remove(bookId);
    } else {
      selectedBooks.add(bookId);
    }
  }

  void selectAll() {
    if (selectedBooks.length == books.length) {
      selectedBooks.clear();
    } else {
      selectedBooks.value = books.map((book) => book.id).toList();
    }
  }

  void toggleView() {
    isGridView.value = !isGridView.value;
  }

  void removeSelected() {
    books.removeWhere((book) => selectedBooks.contains(book.id));
    selectedBooks.clear();
  }

  bool isSelected(String bookId) {
    return selectedBooks.contains(bookId);
  }

  void showRemoveDialog(BuildContext context) {
    if (selectedBooks.isEmpty) return;


    final selected =
        books.where((book) => selectedBooks.contains(book.id)).take(4).toList();

    // final remainingCount = selectedBooks.length - selected.length;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 24,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 120,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: SizedBox(
                              height: 120,
                              // use Stack for fine control over overlap + centering
                              child: Stack(
                                alignment: Alignment.center,
                                children: List.generate(selected.length, (
                                  index,
                                ) {
                                  final book = selected[index];
                                  // calculate symmetrical offset around center
                                  final totalWidth = (selected.length - 1) * 50;
                                  final offsetX =
                                      (index * 50) - (totalWidth / 2);

                                  return Transform.translate(
                                    offset: Offset(offsetX, 0),
                                    child: Container(
                                      width: 80,
                                      height: 110,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                              0.15,
                                            ),
                                            blurRadius: 5,
                                            offset: const Offset(2, 2),
                                          ),
                                        ],
                                        image: DecorationImage(
                                          image: AssetImage(book.coverUrl),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ),

                          // if (remainingCount > 0)
                          //   Positioned(
                          //     right: 0,
                          //     top: 35,
                          //     child: Container(
                          //       width: 60,
                          //       height: 60,
                          //       decoration: BoxDecoration(
                          //         color: Colors.black.withOpacity(0.7),
                          //         shape: BoxShape.circle,
                          //       ),
                          //       alignment: Alignment.center,
                          //       child: Text(
                          //         '+$remainingCount',
                          //         style: const TextStyle(
                          //           color: Colors.white,
                          //           fontSize: 20,
                          //           fontWeight: FontWeight.bold,
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // 📝 Message
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "Do you want to ${selectedBooks.length}",
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          TextSpan(
                            text: " remove",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          const TextSpan(
                            text: " these books from\n",
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          const TextSpan(
                            text: "Want to Read?",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),

                    const Divider(height: 1),

                    // 🗑️ Remove
                    TextButton(
                      onPressed: () {
                        books.removeWhere(
                          (book) => selectedBooks.contains(book.id),
                        );
                        selectedBooks.clear();
                        Get.back();
                      },
                      style: TextButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                      ),
                      child: const Text(
                        "Remove",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 18,
                           fontFamily: StringConstants.SFPro,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    const Divider(height: 1),
                    TextButton(
                      onPressed: () => Get.back(),
                      style: TextButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                      ),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                           fontFamily: StringConstants.SFPro,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
