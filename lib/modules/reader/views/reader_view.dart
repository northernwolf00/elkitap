import 'package:elkitap/modules/reader/controllers/reader_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cosmos_epub/cosmos_epub.dart';

class EpubReaderScreen extends StatelessWidget {
  final EpubController controller = Get.put(EpubController());

  EpubReaderScreen({super.key});

  Future<void> _openEpub(BuildContext context) async {
    await CosmosEpub.initialize();

    await CosmosEpub.openAssetBook(
      assetPath: 'assets/books/7.epub',
      context: context,
      bookId: '1',
      onPageFlip: (currentPage, totalPages) {
        controller.onPageFlip(currentPage, totalPages);
      },
      onLastPage: (lastPageIndex) {
        controller.onLastPage(lastPageIndex);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('EPUB Reader')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => Text(
                'Page: ${controller.currentPage.value}/${controller.totalPages.value}',
                style: const TextStyle(fontSize: 20))),
            const SizedBox(height: 16),
            Obx(() => Text(
                controller.isAtLastPage.value
                    ? 'You reached the last page!'
                    : 'Reading...',
                style: TextStyle(
                  fontSize: 18,
                  color: controller.isAtLastPage.value
                      ? Colors.green
                      : Colors.grey[700],
                ))),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => _openEpub(context),
              child: const Text('Open EPUB Book'),
            ),
          ],
        ),
      ),
    );
  }
}
