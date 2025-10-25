import 'package:elkitap/modules/reader/model/book_details_entity.dart';
import 'package:flutter_epub_viewer/flutter_epub_viewer.dart';
import 'package:get/get.dart';

class ReadingBookController extends GetxController {
  final _isLoading = false.obs;
  final _hasError = false.obs;
  final _hasInternetError = false.obs;
  final _isDownloaded = false.obs;
  
  final _localBooks = Rxn<String>();
  final _lastCfi = Rxn<String>();
  final _lastProgress = Rxn<double>();
  final _chapters = <EpubChapter>[].obs;
  final _tickPositions = <double>[].obs;
  
  BookDetailsEntity? _currentBook;

  // Getters
  bool get isLoading => _isLoading.value;
  bool get hasError => _hasError.value;
  bool get hasInternetError => _hasInternetError.value;
  bool get isDownloaded => _isDownloaded.value;
  String? get localBooks => _localBooks.value;
  String? get lastCfi => _lastCfi.value;
  double? get lastProgress => _lastProgress.value;
  List<EpubChapter> get chapters => _chapters;
  List<double> get tickPositions => _tickPositions;

  Future<void> initEpub(BookDetailsEntity book) async {
    try {
      _isLoading.value = true;
      _hasError.value = false;
      _hasInternetError.value = false;
      _currentBook = book;

      // Load saved progress from storage
      await _loadSavedProgress(book.id);

      _isLoading.value = false;
    } catch (e) {
      _hasError.value = true;
      _isLoading.value = false;
    }
  }

  Future<void> _loadSavedProgress(int bookId) async {
    // Load from local storage (SharedPreferences, Hive, etc.)
    // Example:
    // final prefs = await SharedPreferences.getInstance();
    // _lastCfi.value = prefs.getString('book_${bookId}_cfi');
    // _lastProgress.value = prefs.getDouble('book_${bookId}_progress');
  }

  void setChapters(List<EpubChapter> newChapters) {
    _chapters.value = newChapters;
    _calculateTickPositions();
  }

  void _calculateTickPositions() {
    if (_chapters.isEmpty) return;
    
    // Calculate tick positions based on chapters
    _tickPositions.clear();
    final totalChapters = _chapters.length;
    
    for (int i = 0; i < totalChapters; i++) {
      _tickPositions.add((i / totalChapters) * 100);
    }
  }

  Future<void> saveLastCfi(String cfi, double progress, int totalReadPages) async {
    if (_currentBook == null) return;
    
    _lastCfi.value = cfi;
    _lastProgress.value = progress;

    // Save to local storage
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.setString('book_${_currentBook!.id}_cfi', cfi);
    // await prefs.setDouble('book_${_currentBook!.id}_progress', progress);
    // await prefs.setInt('book_${_currentBook!.id}_pages', totalReadPages);
  }

  @override
  void onClose() {
    _chapters.clear();
    _tickPositions.clear();
    super.onClose();
  }
}
