import 'package:elkitap/modules/reader/controllers/reader_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// ---------------------------
/// THEME SETTINGS SHEET
/// ---------------------------
class ThemeSettingsSheet extends StatelessWidget {
  // Safely register or find controller
  final BookReaderController controller = Get.put(BookReaderController());

  ThemeSettingsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      // ✅ Provides Material context for Slider, etc.
      color: Colors.white,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      child: SafeArea(
        // ✅ Prevents overflow behind system UI
        top: false,
        child: SingleChildScrollView(
          // ✅ Prevents RenderFlex overflow
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Themes & Settings',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Get.back(),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Font size controls
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('A', style: TextStyle(fontSize: 16)),
                  Expanded(child: SizedBox()),
                  Text('A',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(width: 24),
                  Icon(Icons.wb_sunny_outlined),
                ],
              ),
              const SizedBox(height: 16),

              // Brightness slider
              Row(
                children: [
                  const Icon(Icons.brightness_low, size: 20),
                  Expanded(
                    child: Obx(() => Slider(
                          value: controller.brightness.value,
                          onChanged: (value) =>
                              controller.changeBrightness(value),
                          activeColor: Colors.grey[400],
                          inactiveColor: Colors.grey[300],
                        )),
                  ),
                  const Icon(Icons.wb_sunny, size: 24),
                ],
              ),
              const SizedBox(height: 24),

              // Theme options - Row 1
              Row(
                children: [
                  Expanded(
                      child: _buildThemeOption(
                          'Bold', 'Aa', 0, Colors.white, Colors.black)),
                  const SizedBox(width: 12),
                  Expanded(
                      child: _buildThemeOption(
                          'Quiet', 'Aa', 1, Color(0xFF3D3D3D), Colors.white)),
                  const SizedBox(width: 12),
                  Expanded(
                      child: _buildThemeOption(
                          'Paper', 'Aa', 2, Color(0xFFF5F1E8), Colors.black)),
                ],
              ),
              const SizedBox(height: 12),

              // Theme options - Row 2
              Row(
                children: [
                  Expanded(
                      child: _buildThemeOption(
                          'Bold', 'Aa', 3, Colors.white, Colors.black)),
                  const SizedBox(width: 12),
                  Expanded(
                      child: _buildThemeOption('Calm', 'Aa', 4,
                          Color(0xFFE8D5C4), Color(0xFF8B6F47))),
                  const SizedBox(width: 12),
                  Expanded(
                      child: _buildThemeOption(
                          'Focus', 'Aa', 5, Colors.white, Colors.black)),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildThemeOption(
      String label, String preview, int index, Color bgColor, Color textColor) {
    return Obx(() => GestureDetector(
          onTap: () => controller.changeTheme(index),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: controller.selectedThemeIndex.value == index
                    ? Colors.blue
                    : Colors.grey[300]!,
                width: controller.selectedThemeIndex.value == index ? 2 : 1,
              ),
            ),
            child: Column(
              children: [
                Text(
                  preview,
                  style: TextStyle(
                    fontSize: 24,
                    color: textColor,
                    fontWeight:
                        label == 'Bold' ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: textColor.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

/// ---------------------------
/// BOOK LIBRARY SCREEN
/// ---------------------------
class BookLibraryScreen extends StatelessWidget {
  final BookReaderController controller = Get.put(BookReaderController());

  BookLibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Books'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Obx(() => controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Book cover image
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(child: Image.asset('assets/images/b4.png')),
                  ),
                  const SizedBox(height: 32),

                  // Open from Assets button
                  ElevatedButton(
                    onPressed: () {
                      controller.openBookFromAsset('assets/books/7.epub');
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Open Book from Assets',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Open from URL button
                  OutlinedButton(
                    onPressed: () {
                      controller.openBookFromUrl(
                        'https://www.example.com/sample.epub',
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: const BorderSide(color: Colors.blue, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Open Book from URL',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Show theme settings button
                  TextButton(
                    onPressed: () {
                      Get.bottomSheet(
                        ThemeSettingsSheet(),
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                      );
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.palette_outlined, size: 20),
                        SizedBox(width: 8),
                        Text('Preview Theme Settings'),
                      ],
                    ),
                  ),
                ],
              ),
            )),
    );
  }
}
