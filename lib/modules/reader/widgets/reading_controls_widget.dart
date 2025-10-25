import 'package:elkitap/modules/reader/controllers/bg_color_controller.dart';
import 'package:elkitap/modules/reader/controllers/text_style_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_epub_viewer/flutter_epub_viewer.dart';
import 'package:get/get.dart';

class ReadingPageAppBarE extends StatelessWidget {
  final String chapterTitle;
  final Color bgColor;
  final Color textColor;
  final ValueNotifier<bool> isDialogOpen;
  final VoidCallback settings;
  final VoidCallback pageSettings;
  final VoidCallback onTapTitle;
  final EpubController epubController;
  final List<EpubChapter> chapters;

  const ReadingPageAppBarE({
    super.key,
    required this.chapterTitle,
    required this.bgColor,
    required this.textColor,
    required this.isDialogOpen,
    required this.settings,
    required this.pageSettings,
    required this.onTapTitle,
    required this.epubController,
    required this.chapters,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: bgColor,
      title: GestureDetector(
        onTap: onTapTitle,
        child: Text(chapterTitle, style: TextStyle(color: textColor)),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.format_size, color: textColor),
          onPressed: pageSettings,
        ),
        IconButton(
          icon: Icon(Icons.settings, color: textColor),
          onPressed: settings,
        ),
      ],
    );
  }
}

class ReadingPageScrollE extends StatelessWidget {
  final double progress;
  final Function(double) onChanged;
  final Function(double) onChangedEnd;
  final Color sliderBgColor;
  final Color sliderColor;
  final Color pageNumberColor;
  final int currentPage;
  final int lastPage;
  final List<double> tickPositions;
  final Color bgColor;

  const ReadingPageScrollE({
    super.key,
    required this.progress,
    required this.onChanged,
    required this.onChangedEnd,
    required this.sliderBgColor,
    required this.sliderColor,
    required this.pageNumberColor,
    required this.currentPage,
    required this.lastPage,
    required this.tickPositions,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: bgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: sliderColor,
              inactiveTrackColor: sliderBgColor,
              thumbColor: sliderColor,
            ),
            child: Slider(
              value: progress,
              min: 0,
              max: 100,
              onChanged: onChanged,
              onChangeEnd: onChangedEnd,
            ),
          ),
          Text(
            '$currentPage / $lastPage',
            style: TextStyle(color: pageNumberColor, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class PageSettings extends StatelessWidget {
  final Color textColor;
  final Color sliderBgColor;
  final Color bottomSheetColor;
  final Function(BgColors) onColorChange;

  const PageSettings({
    super.key,
    required this.textColor,
    required this.sliderBgColor,
    required this.bottomSheetColor,
    required this.onColorChange,
  });

  @override
  Widget build(BuildContext context) {
    final textStyleController = Get.find<TextStyleController>();
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: bottomSheetColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Font Size', style: TextStyle(color: textColor)),
          Obx(() => Slider(
                value: textStyleController.fontSize.toDouble(),
                min: 10,
                max: 32,
                onChanged: (value) {
                  textStyleController.updateFontSize(value.toInt());
                },
              )),
          const SizedBox(height: 20),
          Text('Theme', style: TextStyle(color: textColor)),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildColorButton(Colors.white, BgColors.white),
              _buildColorButton(const Color(0xFFF4ECD8), BgColors.sepia),
              _buildColorButton(const Color(0xFF1E1E1E), BgColors.dark),
              _buildColorButton(Colors.black, BgColors.black),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildColorButton(Color color, BgColors type) {
    return GestureDetector(
      onTap: () => onColorChange(type),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey),
        ),
      ),
    );
  }
}

class SettingsDialog extends StatelessWidget {
  final double height;
  final Color textColor;
  final Color bgColor;
  final VoidCallback onClickShare;
  final VoidCallback onClickAdd;
  final VoidCallback onClickDownload;

  const SettingsDialog({
    super.key,
    required this.height,
    required this.textColor,
    required this.bgColor,
    required this.onClickShare,
    required this.onClickAdd,
    required this.onClickDownload,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: bgColor,
      child: Container(
        height: height,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.share, color: textColor),
              title: Text('Share', style: TextStyle(color: textColor)),
              onTap: onClickShare,
            ),
            ListTile(
              leading: Icon(Icons.add, color: textColor),
              title: Text('Add to Library', style: TextStyle(color: textColor)),
              onTap: onClickAdd,
            ),
            ListTile(
              leading: Icon(Icons.download, color: textColor),
              title: Text('Download', style: TextStyle(color: textColor)),
              onTap: onClickDownload,
            ),
          ],
        ),
      ),
    );
  }
}