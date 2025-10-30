import 'package:elkitap/core/constants/string_constants.dart';
import 'package:flutter/material.dart';

class EditAccountBottomSheet extends StatefulWidget {
  const EditAccountBottomSheet({super.key});

  @override
  State<EditAccountBottomSheet> createState() => _EditAccountBottomSheetState();
}

class _EditAccountBottomSheetState extends State<EditAccountBottomSheet> {
  final TextEditingController _nameController = TextEditingController(text: "Murat"); // Changed initial text for demo
  final String _phoneNumber = "+993 61626406";

  late FocusNode _nameFocusNode;
  bool _isSaveButtonActive = false;

  @override
  void initState() {
    super.initState();
    _nameFocusNode = FocusNode();
    _nameFocusNode.addListener(_updateSaveButtonState);
    _nameController.addListener(_updateSaveButtonState);
    _updateSaveButtonState(); // Initial check
  }

  @override
  void dispose() {
    _nameFocusNode.removeListener(_updateSaveButtonState);
    _nameFocusNode.dispose();
    _nameController.removeListener(_updateSaveButtonState);
    _nameController.dispose();
    super.dispose();
  }

  void _updateSaveButtonState() {
    final bool hasFocus = _nameFocusNode.hasFocus;
    final bool hasText = _nameController.text.isNotEmpty;
    final bool newIsActive = hasFocus || hasText;

    if (_isSaveButtonActive != newIsActive) {
      setState(() {
        _isSaveButtonActive = newIsActive;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Determine screen height and keyboard height
    final double screenHeight = MediaQuery.of(context).size.height;
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    // Adjust the sheet height dynamically based on keyboard presence
    // We want the sheet to be visible above the keyboard.
    // A common approach is to make the sheet tall enough to show its content + button
    // or set a fixed height that keyboard can push up.
    // Let's make it fixed 70% of screen height, and the SingleChildScrollView will handle keyboard push.
    final double sheetHeight = screenHeight * 0.70; // 70% of screen height

    // Define button colors based on state and theme
    final Color activeSaveButtonColor = Colors.deepOrange;
    final Color inactiveSaveButtonColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.grey[700]!
        : Colors.grey[200]!;

    final Color activeSaveButtonTextColor = Colors.white;
    final Color inactiveSaveButtonTextColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white.withOpacity(0.5)
        : Colors.grey[500]!;

    return Container(
      height: sheetHeight + keyboardHeight, // Add keyboard height to total sheet height
                                          // This allows the sheet to "push up" and not be resized
                                          // by the keyboard overlay, but rather use the scroll view.
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView( // Wrap content in SingleChildScrollView
          child: Padding(
            padding: EdgeInsets.only(bottom: keyboardHeight > 0 ? keyboardHeight : 0), // Add padding for keyboard
            child: Column(
              mainAxisSize: MainAxisSize.min, // Now crucial for SingleChildScrollView to wrap content
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Container(
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Text(
                  "Edit account",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                     fontFamily: StringConstants.SFPro,
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.purple.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.person_outline,
                          color: Colors.purple.shade700,
                          size: 28,
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Account",
                          style: TextStyle(
                            fontSize: 13,
                             fontFamily: StringConstants.SFPro,
                            color: Theme.of(context).textTheme.bodySmall!.color,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _phoneNumber,
                          style: TextStyle(
                            fontSize: 16,
                             fontFamily: StringConstants.SFPro,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).textTheme.bodyLarge!.color,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Name",
                    style: TextStyle(
                      fontSize: 13,
                       fontFamily: StringConstants.SFPro,
                      color: Theme.of(context).textTheme.bodySmall!.color,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey[800]
                        : Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: _nameController,
                    focusNode: _nameFocusNode,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                      fontSize: 16,
                    ),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                      border: InputBorder.none,
                      isDense: true,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                GestureDetector(
                  onTap: _isSaveButtonActive ? () {
                    print("Saving name: ${_nameController.text}");
                    FocusScope.of(context).unfocus(); // Dismiss keyboard
                    Navigator.of(context).pop();
                  } : null,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: _isSaveButtonActive ? activeSaveButtonColor : inactiveSaveButtonColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        "Save",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                           fontFamily: StringConstants.SFPro,
                          color: _isSaveButtonActive ? activeSaveButtonTextColor : inactiveSaveButtonTextColor,
                        ),
                      ),
                    ),
                  ),
                ),
                // Remove the fixed bottom padding, SingleChildScrollView's padding will handle it
                // SizedBox(height: MediaQuery.of(context).padding.bottom > 0 ? MediaQuery.of(context).padding.bottom : 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

