import 'package:elkitap/core/constants/string_constants.dart';
import 'package:elkitap/global_widgets/custom_icon.dart';
import 'package:elkitap/modules/library/controllers/note_controller.dart';
import 'package:elkitap/modules/library/model/note_moc.dart';
import 'package:elkitap/modules/library/widgets/note_cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  Widget build(BuildContext context) {
    final NotesController controller = Get.put(NotesController());

    return Obx(() => Scaffold(
          backgroundColor: controller.isSelectionMode.value
              ? (Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey[700] // darker grey for dark mode
                  : Colors.grey[300]) // light grey for light mode
              : (Theme.of(context).brightness == Brightness.dark
                  ? Colors.black // black for dark mode
                  : Colors.white),
          appBar: AppBar(
            backgroundColor: controller.isSelectionMode.value
                ? (Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey[700]
                    : Colors.grey[300])
                : (Theme.of(context).brightness == Brightness.dark
                    ? Colors.black
                    : Colors.white),
            elevation: 0,
            leadingWidth: 120,
            leading: controller.isSelectionMode.value
                ? TextButton(
                    onPressed: () => controller.toggleSelectAll(),
                    child: Obx(() => Text(
                          controller.isAllSelected ? 'Deselect' : 'Select All',
                          style: TextStyle(
                              fontFamily: StringConstants.SFPro,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 17),
                        )),
                  )
                : Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                          ),
                        ),
                        Text(
                          'leading_text'.tr,
                          style: TextStyle(fontFamily: StringConstants.SFPro),
                        )
                      ],
                    ),
                  ),
            actions: controller.isSelectionMode.value
                ? [
                    TextButton(
                      onPressed: () => controller.showCupertinoMenu(context),
                      child: const Text(
                        'Remove',
                        style: TextStyle(
                            color: Colors.red,
                            fontFamily: StringConstants.SFPro,
                            fontSize: 17),
                      ),
                    ),
                    TextButton(
                      onPressed: () => controller.toggleSelectionMode(),
                      child: Text(
                        'Done',
                        style: TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                            fontSize: 17),
                      ),
                    ),
                  ]
                : controller.notes.isEmpty
                    ? [Container()]
                    : [
                        TextButton(
                          onPressed: () => controller.toggleSelectionMode(),
                          child: Text(
                            'Select',
                            style: TextStyle(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                                fontFamily: StringConstants.SFPro,
                                fontSize: 17),
                          ),
                        ),
                      ],
          ),
          body: Obx(() {
            final notes = controller.notes;

            if (notes.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomIcon(
                          title: 'assets/icons/library_filled.svg',
                          height: 60,
                          width: 60,
                          color: Colors.black),
                      SizedBox(height: 16),
                      Text(
                        'This collection is empty',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Your finished books will appear here..',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];

                return Obx(() {
                  final isSelected = controller.selectedNotes.contains(note.id);
                  return NoteCard(
                    note: note,
                    isSelectionMode: controller.isSelectionMode.value,
                    isSelected: isSelected,
                    onTap: () {
                      if (controller.isSelectionMode.value) {
                        controller.toggleNoteSelection(note.id);
                      }
                    },
                    onLongPress: () {
                      if (!controller.isSelectionMode.value) {
                        controller.isSelectionMode.value = true;
                        controller.toggleNoteSelection(note.id);
                      }
                    },
                    onEdit: () =>
                        _showEditBottomSheet(context, note, controller),
                    onDelete: () => controller.deleteNote(note.id),
                  );
                });
              },
            );
          }),
        ));
  }

  void _showEditBottomSheet(
      BuildContext context, NoteItem note, NotesController controller) {
    final TextEditingController textController =
        TextEditingController(text: note.quote + '\n\n' + note.comment);
    final Rx<Color> selectedColor = note.color.obs;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Obx(() => Container(
            height: MediaQuery.of(context).size.height * 0.9,
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.black // black for dark mode
                  : Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Note',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          controller.updateNoteColor(
                              note.id, selectedColor.value);
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Done',
                          style: TextStyle(
                            fontSize: 17,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                            fontFamily: StringConstants.SFPro,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 4,
                          margin: const EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                            color: selectedColor.value,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            controller: textController,
                            maxLines: null,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Note',
                            ),
                            style: const TextStyle(fontSize: 17),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildColorButton(Colors.grey, selectedColor.value,
                          (color) {
                        selectedColor.value = color;
                      }),
                      _buildColorButton(Colors.red, selectedColor.value,
                          (color) {
                        selectedColor.value = color;
                      }),
                      _buildColorButton(Colors.amber, selectedColor.value,
                          (color) {
                        selectedColor.value = color;
                      }),
                      _buildColorButton(Colors.brown, selectedColor.value,
                          (color) {
                        selectedColor.value = color;
                      }),
                      _buildColorButton(Colors.purple, selectedColor.value,
                          (color) {
                        selectedColor.value = color;
                      }),
                      _buildColorButton(Colors.green, selectedColor.value,
                          (color) {
                        selectedColor.value = color;
                      }),
                      _buildColorButton(Colors.blue, selectedColor.value,
                          (color) {
                        selectedColor.value = color;
                      }),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                )
              ],
            ),
          )),
    );
  }

  Widget _buildColorButton(
      Color color, Color selectedColor, Function(Color) onTap) {
    bool isSelected = color == selectedColor;
    return GestureDetector(
      onTap: () => onTap(color),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: isSelected ? Border.all(color: Colors.black, width: 3) : null,
        ),
      ),
    );
  }
}
