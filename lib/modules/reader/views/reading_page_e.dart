// import 'package:flutter/material.dart';


// class ReadingPageE extends StatefulWidget {
//   const ReadingPageE({
//     super.key,
//     required this.book,
//     required this.startHref,
//     required this.bookUrl,
//     this.startProgress,
//   });

//   final BookDetailsEntity book;

//   final String? bookUrl;
//   final String? startHref;
//   final double? startProgress;

//   @override
//   State<ReadingPageE> createState() => _ReadingPageEState();
// }

// class _ReadingPageEState extends State<ReadingPageE> {
//   final readingPageController = locator<ReadingBookController>();
//   final ValueNotifier<bool> _isDialogOpen = ValueNotifier<bool>(false);
//   final EReadingProgressController progressController =
//       EReadingProgressController();

//   final EpubController epubController = EpubController();

//   bool isLoading = true;
//   List<EpubChapter> allChapters = [];

//   // var textSelectionCfi = '';

//   @override
//   void initState() {
//     readingPageController.initEpub(widget.book);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     if (progressController.cfi != null) {
//       readingPageController.saveLastCfi(progressController.cfi!,
//           progressController.progress, progressController.totalReadPage);
//     } else if (widget.startHref != null) {
//       readingPageController.saveLastCfi(widget.startHref!,
//           progressController.progress, progressController.totalReadPage);
//     }
//     progressController.dispose();
//   }

//   changeFontSize(int size) async {
//     epubController.setFontSize(fontSize: size.toDouble());
//   }

//   changeTheme(BgColorsState theme) async {
//     if (epubController.webViewController != null) {
//       try {
//         await epubController.webViewController?.evaluateJavascript(
//           source: 'setTheme("${theme.bgColorHex}", "${theme.fgColorHex}")',
//         );
//       } catch (e) {
//         debugPrint(e.toString());
//       }
//     } else {}
//   }

//   @override
//   Widget build(BuildContext context) {
//     final int fontSize = context.watch<TextStyleCubit>().state.fontSize;

//     return BlocListener<TextStyleCubit, TextStyleState>(
//       listener: (context, state) {
//         changeFontSize(state.fontSize);
//       },
//       child: ListenableBuilder(
//         listenable: readingPageController,
//         builder: (context, child) {
//           if (readingPageController.hasError) {
//             return Scaffold(appBar: AppBar(), body: const KErrorWidget());
//           } else if (readingPageController.hasInternetError) {
//             return Scaffold(appBar: AppBar(), body: const OfflineWidget());
//           } else if (readingPageController.isLoading) {
//             return Scaffold(
//               appBar: AppBar(),
//               body: const Center(child: CircularProgressIndicator.adaptive()),
//             );
//           } else {
//             return Stack(
//               children: [
//                 BlocConsumer<BgColorCubit, BgColorsState>(
//                   listener: (context, state) {
//                     if (mounted) {
//                       changeTheme(state);
//                     }
//                   },
//                   builder: (context, themeState) {
//                     Color textColor = themeState.textColor;
//                     Color bgColor = themeState.bgColor;
//                     Color sliderColor = themeState.sliderColor;
//                     Color sliderBgColor = themeState.sliderBgColor;
//                     Color pageNumberColor = themeState.pageNumberColor;
//                     Color bottomSheetColor = themeState.bottomSheetColor;

//                     return Scaffold(
//                       appBar: PreferredSize(
//                           preferredSize: const Size.fromHeight(65),
//                           child: ReadingPageAppBarE(
//                             chapterTitle: widget.book.name,
//                             bgColor: bgColor,
//                             textColor: textColor,
//                             isDialogOpen: _isDialogOpen,
//                             settings: () {
//                               _settings(textColor, bottomSheetColor);
//                             },
//                             pageSettings: () {
//                               _openPageSettings(
//                                 textColor: textColor,
//                                 sliderBgColor: sliderBgColor,
//                                 bottomSheetColor: bottomSheetColor,
//                               );
//                             },
//                             onTapTitle: () async {
//                               _showTitle(widget.book.name, textColor,
//                                   bottomSheetColor);
//                             },
//                             epubController: epubController,
//                             chapters: allChapters,
//                           )),
//                       body: Column(
//                         children: [
//                           Expanded(
//                             child: EpubViewer(
//                               initialBgColorHex: themeState.bgColorHex,
//                               initialFgColorHex: themeState.fgColorHex,
//                               epubSource: readingPageController.isDownloaded
//                                   ? EpubSource.fromFile(
//                                       readingPageController.localBooks!)
//                                   : EpubSource.fromUrl(
//                                       ApiEndpoints.baseUrl + widget.bookUrl!,
//                                     ),
//                               epubController: epubController,
//                               initialCfi: widget.startHref ??
//                                   readingPageController.lastCfi,
//                               displaySettings: EpubDisplaySettings(
//                                 fontSize: fontSize,
//                                 flow: EpubFlow.paginated,
//                                 useSnapAnimationAndroid: true,
//                                 snap: true,
//                                 allowScriptedContent: true,
//                               ),
//                               selectionContextMenu: ContextMenu(
//                                 settings: ContextMenuSettings(
//                                   hideDefaultSystemContextMenuItems: true,
//                                 ),
//                               ),

//                               onChaptersLoaded: (chapters) {
//                                 setState(() {
//                                   isLoading = false;
//                                 });
//                               },
//                               onEpubLoaded: () async {
//                                 allChapters = epubController.getChapters();

//                                 readingPageController.setChapters(allChapters);

//                                 epubController.webViewController?.setSettings(
//                                     settings: InAppWebViewSettings(
//                                   transparentBackground: true,
//                                   builtInZoomControls: false,
//                                   // Disable zoom settings
//                                   useWideViewPort: false,
//                                   supportZoom: false,
//                                   // For Android
//                                   displayZoomControls: false,
//                                   // Disable scrolling settings
//                                   disableHorizontalScroll: false,
//                                   disableVerticalScroll: true,
//                                   verticalScrollBarEnabled: false,
//                                   horizontalScrollBarEnabled: false,
//                                 ));
//                               },
//                               onRelocated: (value) async {
//                                 if (widget.startProgress != null &&
//                                     value.progress == 0.000) {
//                                   progressController
//                                       .setProgress(widget.startProgress!);

//                                   progressController
//                                       .calculatePage(widget.book.totalPages);
//                                   return;
//                                 } else if (widget.startProgress == null &&
//                                     value.progress == 0.000) {
//                                   progressController.setLastProgress(
//                                       readingPageController.lastProgress! *
//                                           100);

//                                   progressController
//                                       .calculatePage(widget.book.totalPages);
//                                   return;
//                                 }

//                                 progressController.changeProgress(
//                                   value.progress,
//                                   value.endCfi,
//                                 );
//                                 progressController
//                                     .calculatePage(widget.book.totalPages);
//                               },
//                               onAnnotationClicked: (cfi) {},
//                               // onTextSelected: (epubTextSelection) {
//                               //   textSelectionCfi =
//                               //       epubTextSelection.selectionCfi;
//                               // },
//                             ),
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               progressController.toggle();
//                             },
//                             child: Container(
//                               height: 70.0,
//                               width: double.infinity,
//                               color: bgColor,
//                               child: ListenableBuilder(
//                                   listenable: progressController,
//                                   builder: (context, child) {
//                                     return Visibility(
//                                       visible: progressController.showIndicator,
//                                       child: ReadingPageScrollE(
//                                         progress: progressController.progress,
//                                         onChanged: (v) {},
//                                         onChangedEnd: (double value) {
//                                           // epubController.toProgressPercentage(value);
//                                         },
//                                         sliderBgColor: sliderBgColor,
//                                         sliderColor: sliderColor,
//                                         pageNumberColor: pageNumberColor,
//                                         currentPage:
//                                             progressController.currentPage,
//                                         lastPage: widget.book.totalPages,
//                                         tickPositions:
//                                             readingPageController.tickPositions,
//                                         bgColor: bgColor,
//                                       ),
//                                     );
//                                   }),
//                             ),
//                           )
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//                 Visibility(
//                   visible: isLoading,
//                   child: Scaffold(
//                     appBar: AppBar(),
//                     body: const Center(
//                       child: CircularProgressIndicator.adaptive(),
//                     ),
//                   ),
//                 )
//               ],
//             );
//           }
//         },
//       ),
//     );
//   }

//   void _openPageSettings({
//     required Color textColor,
//     required Color sliderBgColor,
//     required Color bottomSheetColor,
//   }) {
//     bottomSheetWidget(
//       context: context,
//       isScrollControlled: true,
//       color: bottomSheetColor,
//       child: PageSettings(
//         textColor: textColor,
//         sliderBgColor: sliderBgColor,
//         bottomSheetColor: bottomSheetColor,
//         onColorChange: (BgColors newColor) {
//           final bgColorCubit = context.read<BgColorCubit>();
//           if (!bgColorCubit.isClosed) {
//             bgColorCubit.updateColor(newColor);

//             Navigator.pop(context);
//           }
//         },
//       ),
//     );
//   }

//   void _showTitle(String title, Color textColor, Color? bottomSheetColor) {
//     showDialog(
//         context: context,
//         builder: (context) {
//           return Dialog(
//             backgroundColor: bottomSheetColor ??
//                 Theme.of(context).bottomSheetTheme.backgroundColor!,
//             elevation: 4,
//             shadowColor: Theme.of(context).shadowColor.withOpacity(0.5),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(8.0),
//             ),
//             alignment: Alignment.topCenter,
//             insetPadding: const EdgeInsets.only(top: 50, left: 16, right: 16),
//             child: Padding(
//               padding: const EdgeInsets.all(10),
//               child: Text(
//                 title,
//                 style: Theme.of(context)
//                     .textTheme
//                     .titleMedium!
//                     .copyWith(color: textColor),
//                 maxLines: null, // Allows text to wrap to multiple lines
//                 overflow: TextOverflow.visible,
//               ),
//             ),
//           );
//         });
//   }

//   void _settings(Color textColor, Color bottomSheetColor) {
//     _isDialogOpen.value = true;
//     showDialog(
//       barrierColor: Colors.transparent,
//       context: context,
//       builder: (
//         context,
//       ) {
//         return SettingsDialog(
//           height: 150,
//           textColor: textColor,
//           bgColor: bottomSheetColor,
//           onClickShare: () {
//             Navigator.of(context).pop();
//             _isDialogOpen.value = false;
//             shareBook(
//                 slug: widget.book.slug,
//                 title: widget.book.name,
//                 path: widget.book.image.url);
//           },
//           onClickAdd: () {
//             Navigator.of(context).pop();
//             _isDialogOpen.value = false;
//             final authState = context.read<UserAuthBloc>().state;

//             if (authState is UserAuthenticated) {
//               context
//                   .read<StatisticsBloc>()
//                   .add(AddToStatistics(CreateStatisticsParams(
//                     bookId: widget.book.id,
//                   )));
//               final bookState = context.read<StatisticsBloc>().state;
//               if (bookState is StatisticsLoaded) {
//                 toastification.show(
//                   context: context,
//                   title: Text(AppLocalizations.of(context)!.addedToMyBooks),
//                   autoCloseDuration: const Duration(seconds: 3),
//                 );
//               } else if (bookState is StatisticsError) {
//                 toastification.show(
//                   context: context,
//                   title: Text(AppLocalizations.of(context)!.smthWentWrong),
//                   autoCloseDuration: const Duration(seconds: 3),
//                 );
//               }
//             } else {
//               _notLoggedIn(AppLocalizations.of(context)!.bookshelfSignup);
//             }
//           },
//           onClickDownload: () {
//             Navigator.of(context).pop();
//             _isDialogOpen.value = false;
//             final authState = context.read<UserAuthBloc>().state;
//             if (authState is UserAuthenticated) {
//               final format = getFileFormat(widget.book.electronic);
//               locator<DownloadEpubCubit>()
//                   .addQueue(widget.book.slug, format, widget.book.id);

//               var message = locator<DownloadEpubCubit>().message;

//               download(message);
//             } else {
//               _notLoggedIn(AppLocalizations.of(context)!.sigupForDownload);
//             }
//           },
//         );
//       },
//     ).then((_) {
//       _isDialogOpen.value = false;
//     });
//   }

//   void download(String message) {
//     final toast = toastification;
//     late final ToastificationItem toastId;

//     if (message == '') {
//       toastId = toast.showCustom(
//         builder: (context, _) {
//           return BlocConsumer<DownloadEpubCubit, DownloadEpubState>(
//             listener: (context, state) {
//               if (state is DownloadEpubCompleted) {
//                 toast.dismiss(toastId);
//                 locator<DownloadedBooksBloc>().add(GetDownloadedBooks());
//               }
//             },
//             builder: (context, progressState) {
//               if (progressState is DownloadEpubProgress) {
//                 return DownloadToast(value: progressState.progress / 100);
//               }
//               return const SizedBox();
//             },
//           );
//         },
//         autoCloseDuration: null,
//       );
//     } else {
//       toast.show(
//         context: context,
//         title: Text(message),
//         autoCloseDuration: const Duration(seconds: 3),
//       );
//     }
//   }

//   void _notLoggedIn(String message) {
//     bottomSheetWidget(
//       context: context,
//       isScrollControlled: false,
//       child: DetailNotLoggedInWidget(message: message),
//     );
//   }
// }
