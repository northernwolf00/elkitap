import 'package:get/get.dart';

class EReadingProgressController extends GetxController {
  final _progress = 0.0.obs;
  final _currentPage = 0.obs;
  final _totalReadPage = 0.obs;
  final _showIndicator = true.obs;
  final _cfi = Rxn<String>();

  // Getters
  double get progress => _progress.value;
  int get currentPage => _currentPage.value;
  int get totalReadPage => _totalReadPage.value;
  bool get showIndicator => _showIndicator.value;
  String? get cfi => _cfi.value;

  void setProgress(double value) {
    _progress.value = value;
  }

  void setLastProgress(double value) {
    _progress.value = value;
  }

  void changeProgress(double progress, String? endCfi) {
    _progress.value = progress * 100;
    _cfi.value = endCfi;
  }

  void calculatePage(int totalPages) {
    _currentPage.value = ((_progress.value / 100) * totalPages).round();
    _totalReadPage.value = _currentPage.value;
  }

  void toggle() {
    _showIndicator.value = !_showIndicator.value;
  }

  @override
  void onClose() {
    _progress.close();
    _currentPage.close();
    _totalReadPage.close();
    _showIndicator.close();
    _cfi.close();
    super.onClose();
  }
}
