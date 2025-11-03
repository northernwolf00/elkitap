import 'package:elkitap/modules/library/model/note_moc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotesController extends GetxController {
  var notes = <NoteItem>[
    NoteItem(
      id: '1',
      title: 'stopOverThinking'.tr,
      author: 'Rebecca Roanhorse',
      quote: 'quoteText'.tr,
      comment: 'quoteComment'.tr,
      date: '22:30 July 27, 2025',
      color: Colors.blue,
    ),
    NoteItem(
      id: '2',
      quote: 'quoteText'.tr,
      author: 'Rebecca Roanhorse',
      date: '22:30 July 27, 2025',
      title: 'stopOverThinking'.tr,
      comment: 'quoteComment'.tr,
      color: Colors.yellow,
    ),
    NoteItem(
      id: '3',
      title: 'stopOverThinking'.tr,
      author: 'Rebecca Roanhorse',
      quote: 'quoteText'.tr,
      comment: 'quoteComment'.tr,
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

  void showCupertinoMenu(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text(
          'remove_this_note_question'.tr,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              deleteSelectedNotes();
            },
            isDestructiveAction: true,
            child: Text('remove'.tr),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'cancel'.tr,
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
