import 'package:elkitap/core/constants/string_constants.dart';
import 'package:elkitap/modules/library/controllers/note_controller.dart';
import 'package:elkitap/modules/library/model/note_moc.dart';
import 'package:elkitap/modules/library/widgets/note_cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoteDetailScreen extends StatelessWidget {
  final Note note;

  const NoteDetailScreen({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NoteDetailController());
    controller.noteText.value = note.content;
    controller.selectedColor.value = note.accentColor;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          children: [
            NoteDetailAppBar(),
            Expanded(
              child: NoteDetailContent(note: note),
            ),
            ColorPicker(),
          ],
        ),
      ),
    );
  }
}

class NoteDetailAppBar extends StatelessWidget {
  const NoteDetailAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Note',
            style: TextStyle(
              fontSize: 17,
               fontFamily: StringConstants.SFPro,
              fontWeight: FontWeight.w600,
            ),
          ),
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Done',
              style: TextStyle(
                 fontFamily: StringConstants.SFPro,
                color: Colors.blue,
                fontSize: 17,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NoteDetailContent extends StatelessWidget {
  final Note note;

  const NoteDetailContent({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NoteDetailController>();

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Obx(
        () => Container(
          padding: const EdgeInsets.only(left: 12),
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: controller.selectedColor.value ?? note.accentColor,
                width: 3,
              ),
            ),
          ),
          child: TextField(
            controller: TextEditingController(text: note.content),
            maxLines: null,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Enter note...',
            ),
            style: TextStyle(
              fontSize: 15,
              height: 1.5,
            ),
            onChanged: (text) => controller.updateText(text),
          ),
        ),
      ),
    );
  }
}
