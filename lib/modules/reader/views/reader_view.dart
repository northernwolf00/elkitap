import 'package:elkitap/modules/reader/controllers/bg_color_controller.dart';
import 'package:elkitap/modules/reader/controllers/e_reading_progress_controller.dart';
import 'package:elkitap/modules/reader/controllers/reading_book_controller.dart';
import 'package:elkitap/modules/reader/controllers/text_style_controller.dart';
import 'package:elkitap/modules/reader/model/book_details_entity.dart';
import 'package:elkitap/modules/reader/widgets/reading_controls_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_epub_viewer/flutter_epub_viewer.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class ReadingPageE extends StatefulWidget {
  const ReadingPageE({
    super.key,
    required this.book,
    required this.startHref,
    required this.assetPath,
    this.startProgress,
  });

  final BookDetailsEntity book;
  final String assetPath;
  final String? startHref;
  final double? startProgress;

  @override
  State<ReadingPageE> createState() => _ReadingPageEState();
}

class _ReadingPageEState extends State<ReadingPageE> {
  final readingBookController = Get.put(ReadingBookController());
  final progressController = Get.put(EReadingProgressController());
  final textStyleController = Get.put(TextStyleController());
  final bgColorController = Get.put(BgColorController());

  final ValueNotifier<bool> _isDialogOpen = ValueNotifier<bool>(false);
  final epubController = EpubController();

  bool isLoading = true;
  List<EpubChapter> allChapters = [];

  @override
  void initState() {
    super.initState();
    readingBookController.initEpub(widget.book);
  }

  @override
  void dispose() {
    if (progressController.cfi != null) {
      readingBookController.saveLastCfi(
        progressController.cfi!,
        progressController.progress,
        progressController.totalReadPage,
      );
    } else if (widget.startHref != null) {
      readingBookController.saveLastCfi(
        widget.startHref!,
        progressController.progress,
        progressController.totalReadPage,
      );
    }
    super.dispose();
  }

  void changeFontSize(int size) async {
    epubController.setFontSize(fontSize: size.toDouble());
  }

  void changeTheme(BgColorState theme) async {
    if (epubController.webViewController != null) {
      try {
        await epubController.webViewController?.evaluateJavascript(
          source: 'setTheme("${theme.bgColorHex}", "${theme.fgColorHex}")',
        );
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (readingBookController.hasError) {
        return Scaffold(
          appBar: AppBar(),
          body: const Center(child: Text('Error loading book')),
        );
      } else if (readingBookController.hasInternetError) {
        return Scaffold(
          appBar: AppBar(),
          body: const Center(child: Text('No internet connection')),
        );
      } else if (readingBookController.isLoading) {
        return Scaffold(
          appBar: AppBar(),
          body: const Center(child: CircularProgressIndicator.adaptive()),
        );
      }

      return Obx(() {
        final themeState = bgColorController.state;
        final fontSize = textStyleController.fontSize;

        return Stack(
          children: [
            Scaffold(
              backgroundColor: themeState.bgColor,
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(65),
                child: ReadingPageAppBarE(
                  chapterTitle: widget.book.name,
                  bgColor: themeState.bgColor,
                  textColor: themeState.textColor,
                  isDialogOpen: _isDialogOpen,
                  settings: () {
                    _settings(
                      themeState.textColor,
                      themeState.bottomSheetColor,
                    );
                  },
                  pageSettings: () {
                    _openPageSettings(
                      textColor: themeState.textColor,
                      sliderBgColor: themeState.sliderBgColor,
                      bottomSheetColor: themeState.bottomSheetColor,
                    );
                  },
                  onTapTitle: () async {
                    _showTitle(
                      widget.book.name,
                      themeState.textColor,
                      themeState.bottomSheetColor,
                    );
                  },
                  epubController: epubController,
                  chapters: allChapters,
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: EpubViewer(
                      // initialBgColorHex: themeState.bgColorHex,
                      // initialFgColorHex: themeState.fgColorHex,
                      epubSource: EpubSource.fromAsset(widget.assetPath),
                      epubController: epubController,
                      initialCfi:
                          widget.startHref ?? readingBookController.lastCfi,
                      displaySettings: EpubDisplaySettings(
                        fontSize: fontSize,
                        flow: EpubFlow.paginated,
                        useSnapAnimationAndroid: true,
                        snap: true,
                        allowScriptedContent: true,
                      ),
                      selectionContextMenu: ContextMenu(
                        settings: ContextMenuSettings(
                          hideDefaultSystemContextMenuItems: true,
                        ),
                      ),
                      onChaptersLoaded: (chapters) {
                        setState(() {
                          isLoading = false;
                        });
                      },
                      onEpubLoaded: () async {
                        allChapters = epubController.getChapters();
                        readingBookController.setChapters(allChapters);

                        epubController.webViewController?.setSettings(
                          settings: InAppWebViewSettings(
                            transparentBackground: true,
                            builtInZoomControls: false,
                            useWideViewPort: false,
                            supportZoom: false,
                            displayZoomControls: false,
                            disableHorizontalScroll: false,
                            disableVerticalScroll: true,
                            verticalScrollBarEnabled: false,
                            horizontalScrollBarEnabled: false,
                          ),
                        );
                      },
                      onRelocated: (value) async {
                        if (widget.startProgress != null &&
                            value.progress == 0.000) {
                          progressController.setProgress(widget.startProgress!);
                          progressController.calculatePage(
                            widget.book.totalPages,
                          );
                          return;
                        } else if (widget.startProgress == null &&
                            value.progress == 0.000) {
                          progressController.setLastProgress(
                            readingBookController.lastProgress! * 100,
                          );
                          progressController.calculatePage(
                            widget.book.totalPages,
                          );
                          return;
                        }

                        progressController.changeProgress(
                          value.progress,
                          value.endCfi,
                        );
                        progressController.calculatePage(
                          widget.book.totalPages,
                        );
                      },
                      onAnnotationClicked: (cfi) {},
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      progressController.toggle();
                    },
                    child: Container(
                      height: 70.0,
                      width: double.infinity,
                      color: themeState.bgColor,
                      child: Obx(() {
                        return Visibility(
                          visible: progressController.showIndicator,
                          child: ReadingPageScrollE(
                            progress: progressController.progress,
                            onChanged: (v) {},
                            onChangedEnd: (double value) {},
                            sliderBgColor: themeState.sliderBgColor,
                            sliderColor: themeState.sliderColor,
                            pageNumberColor: themeState.pageNumberColor,
                            currentPage: progressController.currentPage,
                            lastPage: widget.book.totalPages,
                            tickPositions: readingBookController.tickPositions,
                            bgColor: themeState.bgColor,
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
            if (isLoading)
              Scaffold(
                appBar: AppBar(),
                body: const Center(child: CircularProgressIndicator.adaptive()),
              ),
          ],
        );
      });
    });
  }

  void _openPageSettings({
    required Color textColor,
    required Color sliderBgColor,
    required Color bottomSheetColor,
  }) {
    Get.bottomSheet(
      PageSettings(
        textColor: textColor,
        sliderBgColor: sliderBgColor,
        bottomSheetColor: bottomSheetColor,
        onColorChange: (BgColors newColor) {
          bgColorController.updateColor(newColor);
          Get.back();
        },
      ),
      backgroundColor: bottomSheetColor,
      isScrollControlled: true,
    );
  }

  void _showTitle(String title, Color textColor, Color? bottomSheetColor) {
    Get.dialog(
      Dialog(
        backgroundColor: bottomSheetColor ?? Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        alignment: Alignment.topCenter,
        insetPadding: const EdgeInsets.only(top: 50, left: 16, right: 16),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
            maxLines: null,
            overflow: TextOverflow.visible,
          ),
        ),
      ),
    );
  }

  void _settings(Color textColor, Color bottomSheetColor) {
    _isDialogOpen.value = true;
    Get.dialog(
      SettingsDialog(
        height: 150,
        textColor: textColor,
        bgColor: bottomSheetColor,
        onClickShare: () {
          Get.back();
          _isDialogOpen.value = false;
          // Share implementation
        },
        onClickAdd: () {
          Get.back();
          _isDialogOpen.value = false;
          // Add to bookshelf implementation
        },
        onClickDownload: () {
          Get.back();
          _isDialogOpen.value = false;
          // Download implementation
        },
      ),
      barrierColor: Colors.transparent,
    ).then((_) {
      _isDialogOpen.value = false;
    });
  }
}
