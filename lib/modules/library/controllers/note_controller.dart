import 'package:elkitap/modules/library/model/note_moc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotesController extends GetxController {
  var notes = <NoteItem>[
    NoteItem(
      id: '1',
      title: 'Stop over thinking',
      author: 'Rebecca Roanhorse',
      quote:
          'What happens if, instead, we decide to stop lying? What does this even mean? We are limited in our knowledge, after all. We must make decisions, here and now, even though the best means and the best goals can never be discerned with certainty.',
      comment: 'This quote is amazing!',
      date: '22:30 July 27, 2025',
      color: Colors.blue,
    ),
    NoteItem(
      id: '2',
      title: 'Stop over thinking',
      author: 'Rebecca Roanhorse',
      quote:
          'What happens if, instead, we decide to stop lying? What does this even mean? We are limited in our knowledge, after all. We must make decisions, here and now, even though the best means and the best goals can never be discerned with certainty.',
      comment: 'This quote is amazing!',
      date: '22:30 July 27, 2025',
      color: Colors.yellow,
    ),
    NoteItem(
      id: '3',
      title: 'Stop over thinking',
      author: 'Rebecca Roanhorse',
      quote:
          'What happens if, instead, we decide to stop lying? What does this even mean? We are limited in our knowledge, after all. We must make decisions, here and now, even though the best means and the best goals can never be discerned with certainty.',
      comment: 'This quote is amazing!',
      date: '22:30 July 27, 2025',
      color: Colors.green,
    ),
  ].obs;

  var isSelectionMode = false.obs;
  var selectedNotes = <String>[].obs;

  void toggleSelectionMode() {
    isSelectionMode.value = !isSelectionMode.value;
    if (!isSelectionMode.value) {
      selectedNotes.clear();
    }
  }

  void selectAll() {
    selectedNotes.clear();
    for (var note in notes) {
      selectedNotes.add(note.id);
    }
  }

  void toggleNoteSelection(String id) {
    if (selectedNotes.contains(id)) {
      selectedNotes.remove(id);
    } else {
      selectedNotes.add(id);
    }

    if (selectedNotes.isEmpty && isSelectionMode.value) {
      isSelectionMode.value = false;
    }
  }

  void deleteSelectedNotes() {
    notes.removeWhere((note) => selectedNotes.contains(note.id));
    selectedNotes.clear();
    isSelectionMode.value = false;
  }

  void deleteNote(String id) {
    notes.removeWhere((note) => note.id == id);
  }

  void updateNoteColor(String id, Color color) {
    final index = notes.indexWhere((note) => note.id == id);
    if (index != -1) {
      notes[index] = NoteItem(
        id: notes[index].id,
        title: notes[index].title,
        author: notes[index].author,
        quote: notes[index].quote,
        comment: notes[index].comment,
        date: notes[index].date,
        color: color,
      );
      notes.refresh();
    }
  }

  bool get isAllSelected =>
      notes.isNotEmpty && selectedNotes.length == notes.length;

  void toggleSelectAll() {
    if (isAllSelected) {
      selectedNotes.clear();
    } else {
      selectAll();
    }
  }

  void showDeleteConfirmation(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Text(
                'Do you want to remove this note?',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const Divider(height: 1),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                deleteSelectedNotes();
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: const Text(
                  'Remove',
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.red,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const Divider(height: 1),
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
