import 'package:elkitap/modules/reader/controllers/reader_controller.dart';
import 'package:elkitap/modules/reader/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EpubReaderScreen extends StatelessWidget {
  const EpubReaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ReaderController controller = Get.put(ReaderController());

    return Obx(() => controller.isLoading.value
        ? const LoadingScreen()
        : Scaffold(
            backgroundColor: controller.backgroundColor.value,
            body: SafeArea(
              child: GestureDetector(
                onTap: controller.toggleControls,
                child: Stack(
                  children: [
                    // EPUB Viewer Content
                    Positioned.fill(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.menu_book,
                              size: 80,
                              color: Colors.grey,
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton.icon(
                              onPressed: controller.openEpubBook,
                              icon: const Icon(Icons.play_arrow),
                              label: const Text('Open EPUB Book'),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 32,
                                  vertical: 16,
                                ),
                                backgroundColor: const Color(0xFFFF6B35),
                                foregroundColor: Colors.white,
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              controller.bookPath.value.isNotEmpty
                                  ? 'Book loaded successfully!'
                                  : 'Place your book.epub in assets/books/',
                              style: TextStyle(
                                color:
                                    controller.textColor.value.withOpacity(0.6),
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Top Controls
                    if (controller.showControls.value)
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: controller.backgroundColor.value,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: Icon(Icons.close,
                                    color: controller.textColor.value),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: Icon(Icons.more_horiz,
                                    color: controller.textColor.value),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      ),

                    // Bottom Controls
                    if (controller.showControls.value)
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: controller.backgroundColor.value,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, -2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: Icon(Icons.menu,
                                    color: controller.textColor.value),
                                onPressed: () {},
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  '${controller.currentPage.value} / ${controller.totalPages.value}',
                                  style: TextStyle(
                                    color: controller.textColor.value
                                        .withOpacity(0.7),
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.text_fields,
                                    color: controller.textColor.value),
                                onPressed: controller.toggleSettings,
                              ),
                            ],
                          ),
                        ),
                      ),

                    // Page Sliding Indicator
                    if (controller.showControls.value &&
                        !controller.showSettings.value)
                      Positioned(
                        bottom: 80,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Page 121',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'The Truth, Instead',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.7),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                    // Settings Panel
                    if (controller.showSettings.value)
                      Positioned(
                        right: 0,
                        top: 0,
                        bottom: 0,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.85,
                          decoration: BoxDecoration(
                            color: controller.backgroundColor.value,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 20,
                                offset: const Offset(-5, 0),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 24),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Themes & Settings',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: controller.textColor.value,
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.close,
                                          color: controller.textColor.value),
                                      onPressed: controller.toggleSettings,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 30),
                              // Font Size Controls
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 24),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.text_decrease,
                                          size: 20),
                                      onPressed: controller.decreaseFontSize,
                                    ),
                                    const Text('A',
                                        style: TextStyle(fontSize: 20)),
                                    Expanded(
                                      child: Slider(
                                        value: controller.fontSize.value,
                                        min: 12,
                                        max: 28,
                                        divisions: 8,
                                        onChanged: (value) =>
                                            controller.fontSize.value = value,
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.brightness_2,
                                          size: 20),
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 30),
                              // Theme Options
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 24),
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 12,
                                    mainAxisSpacing: 12,
                                    childAspectRatio: 1.2,
                                  ),
                                  itemCount: controller.themes.length,
                                  itemBuilder: (context, index) {
                                    final theme = controller.themes[index];
                                    final isSelected =
                                        controller.selectedTheme.value ==
                                            theme.name;
                                    return GestureDetector(
                                      onTap: () =>
                                          controller.selectTheme(theme.name),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: theme.backgroundColor,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                            color: isSelected
                                                ? Colors.blue
                                                : Colors.grey.withOpacity(0.3),
                                            width: isSelected ? 3 : 1,
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Aa',
                                              style: TextStyle(
                                                fontSize: 28,
                                                fontWeight: FontWeight.bold,
                                                color: theme.textColor,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              theme.name,
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: theme.textColor
                                                    .withOpacity(0.7),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ));
  }
}
