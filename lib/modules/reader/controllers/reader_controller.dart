// import 'package:elkitap/modules/reader/model/epub_chapter.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';

// class EpubController extends GetxController {
//   InAppWebViewController? webViewController;
  
//   final _isLoading = true.obs;
//   final _currentChapter = Rxn<EpubChapter>();
//   final _chapters = <EpubChapter>[].obs;
//   final _currentCfi = Rxn<String>();
//   final _currentProgress = 0.0.obs;

//   // Getters
//   bool get isLoading => _isLoading.value;
//   EpubChapter? get currentChapter => _currentChapter.value;
//   List<EpubChapter> get chapters => _chapters;
//   String? get currentCfi => _currentCfi.value;
//   double get currentProgress => _currentProgress.value;

//   // Set WebView Controller
//   void setWebViewController(InAppWebViewController controller) {
//     webViewController = controller;
//   }

//   // Get all chapters
//   List<EpubChapter> getChapters() {
//     return _chapters;
//   }

//   // Set chapters
//   void setChapters(List<EpubChapter> newChapters) {
//     _chapters.value = newChapters;
//   }

//   // Change font size
//   Future<void> setFontSize({required double fontSize}) async {
//     if (webViewController != null) {
//       try {
//         await webViewController!.evaluateJavascript(
//           source: '''
//             document.body.style.fontSize = '${fontSize}px';
//           ''',
//         );
//       } catch (e) {
//         debugPrint('Error setting font size: $e');
//       }
//     }
//   }

//   // Navigate to specific chapter by href
//   Future<void> gotoChapter(String href) async {
//     if (webViewController != null) {
//       try {
//         await webViewController!.evaluateJavascript(
//           source: 'rendition.display("$href")',
//         );
//       } catch (e) {
//         debugPrint('Error navigating to chapter: $e');
//       }
//     }
//   }

//   // Navigate to CFI (Canonical Fragment Identifier)
//   Future<void> gotoCfi(String cfi) async {
//     if (webViewController != null) {
//       try {
//         await webViewController!.evaluateJavascript(
//           source: 'rendition.display("$cfi")',
//         );
//       } catch (e) {
//         debugPrint('Error navigating to CFI: $e');
//       }
//     }
//   }

//   // Navigate to progress percentage (0.0 to 1.0)
//   Future<void> toProgressPercentage(double percentage) async {
//     if (webViewController != null) {
//       try {
//         final progress = percentage / 100;
//         await webViewController!.evaluateJavascript(
//           source: '''
//             var cfi = book.locations.cfiFromPercentage($progress);
//             rendition.display(cfi);
//           ''',
//         );
//       } catch (e) {
//         debugPrint('Error navigating to percentage: $e');
//       }
//     }
//   }

//   // Go to next page
//   Future<void> nextPage() async {
//     if (webViewController != null) {
//       try {
//         await webViewController!.evaluateJavascript(
//           source: 'rendition.next()',
//         );
//       } catch (e) {
//         debugPrint('Error going to next page: $e');
//       }
//     }
//   }

//   // Go to previous page
//   Future<void> previousPage() async {
//     if (webViewController != null) {
//       try {
//         await webViewController!.evaluateJavascript(
//           source: 'rendition.prev()',
//         );
//       } catch (e) {
//         debugPrint('Error going to previous page: $e');
//       }
//     }
//   }

//   // Update current CFI
//   void updateCfi(String cfi) {
//     _currentCfi.value = cfi;
//   }

//   // Update progress
//   void updateProgress(double progress) {
//     _currentProgress.value = progress;
//   }

//   // Update current chapter
//   void updateCurrentChapter(EpubChapter chapter) {
//     _currentChapter.value = chapter;
//   }

//   @override
//   void onClose() {
//     _chapters.clear();
//     webViewController = null;
//     super.onClose();
//   }
// }

// // ============================================
// // EPUB SOURCE
// // ============================================

// enum EpubSourceType { asset, file, url }

// class EpubSource {
//   final EpubSourceType type;
//   final String path;

//   EpubSource._({required this.type, required this.path});

//   // Create from asset
//   factory EpubSource.fromAssets(String assetPath) {
//     return EpubSource._(
//       type: EpubSourceType.asset,
//       path: assetPath,
//     );
//   }

//   // Create from file path
//   factory EpubSource.fromFile(String filePath) {
//     return EpubSource._(
//       type: EpubSourceType.file,
//       path: filePath,
//     );
//   }

//   // Create from URL
//   factory EpubSource.fromUrl(String url) {
//     return EpubSource._(
//       type: EpubSourceType.url,
//       path: url,
//     );
//   }
// }

// // ============================================
// // EPUB DISPLAY SETTINGS
// // ============================================

// enum EpubFlow { paginated, scrolled }

// class EpubDisplaySettings {
//   final int fontSize;
//   final EpubFlow flow;
//   final bool useSnapAnimationAndroid;
//   final bool snap;
//   final bool allowScriptedContent;
//   final String? fontFamily;
//   final double? lineHeight;
//   final int? width;
//   final int? height;

//   EpubDisplaySettings({
//     this.fontSize = 16,
//     this.flow = EpubFlow.paginated,
//     this.useSnapAnimationAndroid = false,
//     this.snap = true,
//     this.allowScriptedContent = false,
//     this.fontFamily,
//     this.lineHeight,
//     this.width,
//     this.height,
//   });
// }

// // ============================================
// // EPUB VIEWER WIDGET
// // ============================================

// class EpubViewer extends StatefulWidget {
//   final String initialBgColorHex;
//   final String initialFgColorHex;
//   final EpubSource epubSource;
//   final EpubController epubController;
//   final String? initialCfi;
//   final EpubDisplaySettings displaySettings;
//   final ContextMenu? selectionContextMenu;
//   final Function(List<EpubChapter>)? onChaptersLoaded;
//   final Function()? onEpubLoaded;
//   final Function(EpubRelocatedData)? onRelocated;
//   final Function(String)? onAnnotationClicked;

//   const EpubViewer({
//     super.key,
//     required this.initialBgColorHex,
//     required this.initialFgColorHex,
//     required this.epubSource,
//     required this.epubController,
//     this.initialCfi,
//     required this.displaySettings,
//     this.selectionContextMenu,
//     this.onChaptersLoaded,
//     this.onEpubLoaded,
//     this.onRelocated,
//     this.onAnnotationClicked,
//   });

//   @override
//   State<EpubViewer> createState() => _EpubViewerState();
// }

// class _EpubViewerState extends State<EpubViewer> {
//   @override
//   Widget build(BuildContext context) {
//     return InAppWebView(
//       initialSettings: InAppWebViewSettings(
//         transparentBackground: true,
//         javaScriptEnabled: true,
//         allowFileAccess: true,
//       ),
//       onWebViewCreated: (controller) {
//         widget.epubController.setWebViewController(controller);
//         _loadEpubReader(controller);
//       },
//       onLoadStop: (controller, url) async {
//         // Initialize EPUB after page load
//         await _initializeEpub(controller);
//       },
//     );
//   }

//   Future<void> _loadEpubReader(InAppWebViewController controller) async {
//     // Load HTML with EPUB.js library
//     final html = '''
//     <!DOCTYPE html>
//     <html>
//     <head>
//         <meta name="viewport" content="width=device-width, initial-scale=1.0">
//         <script src="https://cdn.jsdelivr.net/npm/epubjs/dist/epub.min.js"></script>
//         <style>
//             body {
//                 margin: 0;
//                 padding: 0;
//                 background-color: ${widget.initialBgColorHex};
//                 color: ${widget.initialFgColorHex};
//             }
//             #viewer {
//                 width: 100vw;
//                 height: 100vh;
//             }
//         </style>
//     </head>
//     <body>
//         <div id="viewer"></div>
//         <script>
//             var book;
//             var rendition;
            
//             function initEpub(bookPath) {
//                 book = ePub(bookPath);
//                 rendition = book.renderTo("viewer", {
//                     width: "100%",
//                     height: "100%",
//                     flow: "${widget.displaySettings.flow == EpubFlow.paginated ? 'paginated' : 'scrolled'}",
//                     snap: ${widget.displaySettings.snap}
//                 });
                
//                 rendition.display("${widget.initialCfi ?? ''}");
                
//                 // Listen for relocated events
//                 rendition.on("relocated", function(location) {
//                     window.flutter_inappwebview.callHandler('onRelocated', {
//                         progress: book.locations.percentageFromCfi(location.start.cfi),
//                         endCfi: location.end.cfi,
//                         startCfi: location.start.cfi
//                     });
//                 });
                
//                 // Load chapters
//                 book.loaded.navigation.then(function(toc) {
//                     window.flutter_inappwebview.callHandler('onChaptersLoaded', toc);
//                 });
                
//                 // Notify loaded
//                 window.flutter_inappwebview.callHandler('onEpubLoaded');
//             }
            
//             function setTheme(bgColor, fgColor) {
//                 rendition.themes.override('color', fgColor);
//                 rendition.themes.override('background', bgColor);
//             }
//         </script>
//     </body>
//     </html>
//     ''';

//     await controller.loadData(data: html);
//   }

//   Future<void> _initializeEpub(InAppWebViewController controller) async {
//     // Add handlers
//     controller.addJavaScriptHandler(
//       handlerName: 'onRelocated',
//       callback: (args) {
//         if (widget.onRelocated != null && args.isNotEmpty) {
//           final data = args[0] as Map<dynamic, dynamic>;
//           widget.onRelocated!(EpubRelocatedData(
//             progress: (data['progress'] ?? 0.0).toDouble(),
//             endCfi: data['endCfi']?.toString(),
//             startCfi: data['startCfi']?.toString(),
//           ));
//         }
//       },
//     );

//     controller.addJavaScriptHandler(
//       handlerName: 'onChaptersLoaded',
//       callback: (args) {
//         if (widget.onChaptersLoaded != null) {
//           // Parse chapters from TOC
//           final chapters = _parseChapters(args);
//           widget.epubController.setChapters(chapters);
//           widget.onChaptersLoaded!(chapters);
//         }
//       },
//     );

//     controller.addJavaScriptHandler(
//       handlerName: 'onEpubLoaded',
//       callback: (args) {
//         if (widget.onEpubLoaded != null) {
//           widget.onEpubLoaded!();
//         }
//       },
//     );

//     // Initialize EPUB with source
//     String bookPath = '';
//     switch (widget.epubSource.type) {
//       case EpubSourceType.asset:
//         bookPath = widget.epubSource.path;
//         break;
//       case EpubSourceType.file:
//         bookPath = widget.epubSource.path;
//         break;
//       case EpubSourceType.url:
//         bookPath = widget.epubSource.path;
//         break;
//     }

//     await controller.evaluateJavascript(source: "initEpub('$bookPath')");
//   }

//   List<EpubChapter> _parseChapters(List<dynamic> args) {
//     // Parse TOC data into EpubChapter objects
//     final List<EpubChapter> chapters = [];
    
//     if (args.isEmpty) return chapters;
    
//     final tocData = args[0];
//     if (tocData is List) {
//       for (var item in tocData) {
//         if (item is Map) {
//           chapters.add(EpubChapter(
//             id: item['id']?.toString() ?? '',
//             title: item['label']?.toString() ?? 'Untitled',
//             href: item['href']?.toString() ?? '',
//           ));
//         }
//       }
//     }
    
//     return chapters;
//   }
// }

// // ============================================
// // EPUB RELOCATED DATA
// // ============================================

// class EpubRelocatedData {
//   final double progress;
//   final String? endCfi;
//   final String? startCfi;

//   EpubRelocatedData({
//     required this.progress,
//     this.endCfi,
//     this.startCfi,
//   });
// }

// // ============================================
// // CONTEXT MENU
// // ============================================

// class ContextMenuEPUB {
//   final ContextMenuSettings settings;

//   ContextMenuEPUB({required this.settings});
// }

// class ContextMenuSettingsEpub {
//   final bool hideDefaultSystemContextMenuItems;

//   ContextMenuSettingsEpub({
//     this.hideDefaultSystemContextMenuItems = false,
//   });
// }
