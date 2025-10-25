

// class PdfReadingPage extends StatefulWidget {
//   const PdfReadingPage({super.key, required this.book});

//   final BookDetailsEntity book;

//   @override
//   State<PdfReadingPage> createState() => _PdfReadingPageState();
// }

// class _PdfReadingPageState extends State<PdfReadingPage> {
//   final ValueNotifier<bool> _isDialogOpen = ValueNotifier<bool>(false);

//   final Completer<PDFViewController> _controller =
//       Completer<PDFViewController>();

//   final pdfController = locator<PdfController>();

//   final progressCtrl = PdfProgressController();

//   @override
//   void initState() {
//     super.initState();
//     pdfController.initPdf(widget.book);
//   }

//   @override
//   void dispose() {
//     pdfController.saveLastPage(progressCtrl.progress, progressCtrl.currentPage,
//         progressCtrl.totalReadPage);
//     progressCtrl.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final brightness = Theme.of(context).brightness;
//     final isDarkMode = brightness == Brightness.dark;

//     return ListenableBuilder(
//         listenable: pdfController,
//         builder: (context, child) {
//           if (pdfController.hasError) {
//             return Scaffold(appBar: AppBar(), body: const KErrorWidget());
//           } else if (pdfController.hasInternetError) {
//             return Scaffold(appBar: AppBar(), body: const OfflineWidget());
//           } else if (pdfController.isLoading) {
//             return Scaffold(
//               appBar: AppBar(),
//               body: const Center(
//                 child: CircularProgressIndicator.adaptive(),
//               ),
//             );
//           }

//           return Scaffold(
//             appBar: PreferredSize(
//                 preferredSize: const Size.fromHeight(65),
//                 child: ReadingPageAppBarE(
//                   chapterTitle: widget.book.name,
//                   bgColor: Theme.of(context).scaffoldBackgroundColor,
//                   textColor: Theme.of(context).textTheme.bodyMedium!.color!,
//                   isDialogOpen: _isDialogOpen,
//                   settings: () {
//                     _settings();
//                   },
//                   onTapTitle: () async {
//                     _showTitle(widget.book.name);
//                   },
//                   chapters: const [],
//                 )),
//             body: Column(
//               children: [
//                 Expanded(
//                   child: PDFView(
//                     filePath: pdfController.isDownloaded
//                         ? pdfController.localBook?.path
//                         : null,
//                     nightMode: isDarkMode,
//                     pdfData: pdfController.isDownloaded
//                         ? null
//                         : pdfController.pdfData,
//                     enableSwipe: true,
//                     swipeHorizontal: true,
//                     autoSpacing: false,
//                     pageFling: true,
//                     pageSnap: true,
//                     defaultPage: pdfController.lastStoredPage,
//                     fitPolicy: FitPolicy.BOTH,
//                     preventLinkNavigation: false,
//                     backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//                     onRender: (pages) {
//                       progressCtrl
//                           .setTotalPage(pages ?? widget.book.totalPages);
//                       progressCtrl.setCurrentPage(pdfController.lastStoredPage);
//                     },
//                     onError: (error) {
//                       pdfController.hasError = true;
//                     },
//                     onPageError: (page, error) {},
//                     onViewCreated: (PDFViewController pdfViewController) {
//                       _controller.complete(pdfViewController);
//                     },
//                     onLinkHandler: (String? uri) {
//                       if (uri != null) {
//                         final Uri url = Uri.parse(uri);

//                         launchUrlLink(url);
//                       }
//                     },
//                     onPageChanged: (int? page, int? total) {
//                       progressCtrl.setCurrentPage(page);
//                     },
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     progressCtrl.toggle();
//                   },
//                   child: Container(
//                     height: 70.0,
//                     width: double.infinity,
//                     color: Theme.of(context).scaffoldBackgroundColor,
//                     child: ListenableBuilder(
//                         listenable: progressCtrl,
//                         builder: (context, child) {
//                           return Visibility(
//                             visible: progressCtrl.showIndicator,
//                             child: ReadingPageScrollE(
//                               progress: progressCtrl.progress,
//                               //(currentPage ! / pages!),
//                               onChanged: (v) {},
//                               onChangedEnd: (double value) async {
//                                 await progressCtrl.navigatePage(
//                                     value, _controller);
//                               },
//                               sliderBgColor:
//                                   Theme.of(context).colorScheme.outline,
//                               sliderColor: Theme.of(context)
//                                   .sliderTheme
//                                   .valueIndicatorColor!,
//                               pageNumberColor: Theme.of(context)
//                                   .sliderTheme
//                                   .valueIndicatorTextStyle!
//                                   .color!,
//                               currentPage: progressCtrl.currentPage,
//                               lastPage: progressCtrl.totalBookPages,
//                               tickPositions: pdfController.tickPositions,
//                               bgColor:
//                                   Theme.of(context).scaffoldBackgroundColor,
//                             ),
//                           );
//                         }),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         });
//   }

//   void _showTitle(String title) {
//     showDialog(
//         context: context,
//         builder: (context) {
//           return Dialog(
//             backgroundColor:
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
//                 style: Theme.of(context).textTheme.titleMedium!,
//                 maxLines: null,
//                 overflow: TextOverflow.visible,
//               ),
//             ),
//           );
//         });
//   }

//   void _settings() {
//     _isDialogOpen.value = true;
//     showDialog(
//       barrierColor: Colors.transparent,
//       context: context,
//       builder: (
//         context,
//       ) {
//         return SettingsDialog(
//           height: 150,
//           textColor: Theme.of(context).textTheme.bodyMedium!.color!,
//           bgColor: Theme.of(context).scaffoldBackgroundColor,
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
