import 'package:elkitap/modules/reader/controllers/reader_controller.dart';
import 'package:elkitap/modules/reader/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cosmos_epub/cosmos_epub.dart';



class EpubReaderScreen extends StatefulWidget {
  const EpubReaderScreen({super.key});

  @override
  State<EpubReaderScreen> createState() => _EpubReaderScreenState();
}

class _EpubReaderScreenState extends State<EpubReaderScreen> {
  final EpubController controller = Get.put(EpubController());
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Show loading screen for 2 seconds, then open book
    Future.delayed(const Duration(seconds: 2), () {
      _openEpub();
    });
  }

  Future<void> _openEpub() async {
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
    
    if (mounted) {
      Get.back(); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // When user presses back, go to BookDetailView
        Get.back();
        return false;
      },
      child: _isLoading ? const LoadingScreen() : const SizedBox.shrink(),
    );
  }
}
