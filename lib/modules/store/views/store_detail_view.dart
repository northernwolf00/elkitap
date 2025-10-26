
import 'package:elkitap/modules/store/controllers/store_controller.dart';
import 'package:elkitap/modules/store/views/author_view.dart';
import 'package:elkitap/modules/store/widgets/book_detail_widget.dart';
import 'package:elkitap/utils/dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookDetailView extends StatelessWidget {
  const BookDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final BookDetailController controller = Get.put(BookDetailController());
    final Color accent = const Color(0xFFFF5A3C);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(46),
        child: AppBar(
          backgroundColor: const Color(0xFFF5F5F5),
          elevation: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(top: 60, left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Close button
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.close,
                        size: 18, color: Colors.black54),
                  ),
                ),
                SizedBox(
                  width: 34,
                  height: 34,
                ),
                // Center tabs
                Obx(
                  () => Container(
                    height: 32,
                    width: 126,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: controller.toggleToText,
                          child: Padding(
                            padding: const EdgeInsets.all(1.5),
                            child: Container(
                              width: 60,
                              decoration: BoxDecoration(
                                color: !controller.isAudio.value
                                    ? Colors.grey[200]
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text(
                                  "Text",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: !controller.isAudio.value
                                        ? FontWeight.w500
                                        : FontWeight.normal,
                                    color: !controller.isAudio.value
                                        ? Colors.black
                                        : Colors.black45,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: controller.toggleToAudio,
                          child: Padding(
                            padding: const EdgeInsets.all(1.5),
                            child: Container(
                              width: 60,
                              decoration: BoxDecoration(
                                color: controller.isAudio.value
                                    ? Colors.grey[200]
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text(
                                  "Audio",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: controller.isAudio.value
                                        ? FontWeight.w600
                                        : FontWeight.normal,
                                    color: controller.isAudio.value
                                        ? Colors.black
                                        : Colors.black45,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Right side buttons
                Row(
                  children: [
                   Obx(() => GestureDetector(
                      onTap: () {
                        controller.toggleAddToWantToRead();
                             DialogUtils.showAddedDialog(context, controller.isAddedToWantToRead.value );
                        
                      },
                      child: Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: controller.isAddedToWantToRead.value 
                              ? accent 
                              : Colors.grey[200],
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          controller.isAddedToWantToRead.value 
                              ? Icons.check 
                              : Icons.add,
                          size: 18,
                          color: controller.isAddedToWantToRead.value 
                              ? Colors.white 
                              : Colors.black54,
                        ),
                      ),
                    )),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => DialogUtils.showOptionsPopupMenu(context, controller),
                      child: Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          size: 18,
                          Icons.more_horiz,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),

            // --- Book Cover
            Obx(
              () => Container(
                width: 200,
                height: 280,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                  image: DecorationImage(
                    image: AssetImage(
                      controller.isAudio.value
                          ? 'assets/images/b1.png'
                          : 'assets/images/b4.png',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            GestureDetector(
              onTap: () => DialogUtils.showLanguagePopup(context, controller),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.black.withOpacity(0.1),
                  //     blurRadius: 10,
                  //     offset: const Offset(0, 2),
                  //   ),
                  // ],
                ),
                child: Obx(() => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.language, size: 18, color: Colors.black54),
                    const SizedBox(width: 6),
                    Text(
                      controller.selectedLanguage.value,
                      style: const TextStyle(color: Colors.black87,
                      fontSize: 16),
                    ),
                  ],
                )),
              ),
            ),
            const SizedBox(height: 16),

            // --- Title & Author
            GestureDetector(
              onTap:  () => DialogUtils.showBookDetailsBottomSheet(context),
              child: const Text(
                "The subtle art of not giving a f*ck",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  height: 1.3,
                ),
              ),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                Get.to(BookAuthorView());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Mark Manson",
                    style: TextStyle(color: Colors.black54, fontSize: 16),
                  ),
                  SizedBox(width: 4),
                  Icon(Icons.chevron_right, size: 18, color: Colors.black54),
                ],
              ),
            ),
            const SizedBox(height: 8),
            GestureDetector(
             
              child: const Text(
                "Health, Mind & Body • 18+",
                style: TextStyle(color: Colors.black45, fontSize: 14),
              ),
            ),
            const SizedBox(height: 24),

            // --- Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Read",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Listen",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // --- AI mazmuny Button
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: const LinearGradient(
                  colors: [Color(0xFFAA5AFF), Color(0xFFFB6B78)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              alignment: Alignment.center,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.auto_awesome, color: Colors.white, size: 20),
                  SizedBox(width: 8),
                  Text(
                    "AI mazmuny",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // --- About Section
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "About",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "Сегодня в рубрике «Профессии» наш гость — региональный директор Üйрекçi. "
              "Он расскажет о трёх книгах, которые научат договариваться, продавать и понимать...",
              style: TextStyle(
                color: Colors.black87,
                fontSize: 15,
                height: 1.5,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                "Eще",
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // --- Similar Books Section
            sectionTitle("Similar books"),
            const SizedBox(height: 12),
            horizontalBookList([
              'assets/images/b1.png',
              'assets/images/b2.png',
              'assets/images/b3.png',
            ]),
            const SizedBox(height: 24),

            // --- More Section
            sectionTitle("More in Health, Mind & Body"),
            const SizedBox(height: 12),
            horizontalBookList([
              'assets/images/b4.png',
              'assets/images/b5.png',
              'assets/images/b6.png',
            ]),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }






}
