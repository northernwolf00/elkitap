import 'package:elkitap/modules/library/model/note_moc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotesController extends GetxController {
  final notes = <Note>[].obs;
  final selectedNotes = <String>[].obs;
  final isSelectionMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadNotes();
  }

  void loadNotes() {
    notes.value = [
      Note(
        id: '1',
        title: 'Stop over thinking',
        author: 'Rebecca Roanhorse',
        content:
            'What happens if, instead, we decide to stop lying? What does this even mean? We are limited in our knowledge, after all. We must make decisions, here and now, even though the best means and the best goals can never be discerned with certainty.',
        comment: 'This quote is amazing!',
        timestamp: DateTime(2025, 7, 27, 22, 30),
        accentColor: Colors.orange,
      ),
      Note(
        id: '2',
        title: 'Stop over thinking',
        author: 'Rebecca Roanhorse',
        content:
            'What happens if, instead, we decide to stop lying? What does this even mean? We are limited in our knowledge, after all. We must make decisions, here and now, even though the best means and the best goals can never be discerned with certainty.',
        comment: 'This quote is amazing!',
        timestamp: DateTime(2025, 7, 27, 22, 30),
        accentColor: Colors.green,
      ),
      Note(
        id: '3',
        title: 'Stop over thinking',
        author: 'Rebecca Roanhorse',
        content:
            'What happens if, instead, we decide to stop lying? What does this even mean? We are limited in our knowledge, after all. We must make decisions, here and now, even though the best means and the best goals can never be discerned with certainty.',
        comment: 'This quote is amazing!',
        timestamp: DateTime(2025, 7, 27, 22, 30),
        accentColor: Colors.orange,
      ),
    ];
  }

  void toggleSelection(String id) {
    if (selectedNotes.contains(id)) {
      selectedNotes.remove(id);
      if (selectedNotes.isEmpty) {
        isSelectionMode.value = false;
      }
    } else {
      selectedNotes.add(id);
      isSelectionMode.value = true;
    }
  }

  void deleteNote(String id) {
    notes.removeWhere((note) => note.id == id);
  }

  void clearSelection() {
    selectedNotes.clear();
    isSelectionMode.value = false;
  }
}

class NoteDetailController extends GetxController {
  final selectedColor = Rx<Color?>(null);
  final noteText = ''.obs;

  void updateColor(Color color) {
    selectedColor.value = color;
  }

  void updateText(String text) {
    noteText.value = text;
  }
}