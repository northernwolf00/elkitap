// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
// import 'package:image_picker/image_picker.dart';

// class TextScannerSheet extends StatefulWidget {
//   const TextScannerSheet({Key? key}) : super(key: key);

//   @override
//   State<TextScannerSheet> createState() => _TextScannerSheetState();
// }

// class _TextScannerSheetState extends State<TextScannerSheet> {
//   File? _image;
//   String _scannedText = '';
//   bool _isScanning = false;
//   final ImagePicker _picker = ImagePicker();
//   final TextRecognizer _textRecognizer = TextRecognizer();

//   @override
//   void dispose() {
//     _textRecognizer.close();
//     super.dispose();
//   }

//   Future<void> _pickImageFromCamera() async {
//     try {
//       final XFile? image = await _picker.pickImage(
//         source: ImageSource.camera,
//         imageQuality: 100,
//       );

//       if (image != null) {
//         setState(() {
//           _image = File(image.path);
//           _isScanning = true;
//         });
//         await _recognizeText();
//       }
//     } catch (e) {
//       print('Error picking image: $e');
//     }
//   }

//   Future<void> _pickImageFromGallery() async {
//     try {
//       final XFile? image = await _picker.pickImage(
//         source: ImageSource.gallery,
//         imageQuality: 100,
//       );

//       if (image != null) {
//         setState(() {
//           _image = File(image.path);
//           _isScanning = true;
//         });
//         await _recognizeText();
//       }
//     } catch (e) {
//       print('Error picking image: $e');
//     }
//   }

//   Future<void> _recognizeText() async {
//     if (_image == null) return;

//     try {
//       final inputImage = InputImage.fromFile(_image!);
//       final RecognizedText recognizedText =
//           await _textRecognizer.processImage(inputImage);

//       String text = recognizedText.text;

//       // Extract codes that look like promo codes (uppercase alphanumeric)
//       RegExp promoCodePattern = RegExp(r'\b[A-Z0-9]{5,}\b');
//       Iterable<Match> matches = promoCodePattern.allMatches(text);

//       String extractedCode = '';
//       if (matches.isNotEmpty) {
//         extractedCode = matches.first.group(0) ?? '';
//       }

//       setState(() {
//         _scannedText = extractedCode.isNotEmpty ? extractedCode : text;
//         _isScanning = false;
//       });
//     } catch (e) {
//       setState(() {
//         _isScanning = false;
//       });
//       print('Error recognizing text: $e');
//     }
//   }

//   void _useScannedText() {
//     Navigator.pop(context, _scannedText);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height * 0.95,
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(20),
//           topRight: Radius.circular(20),
//         ),
//       ),
//       child: Column(
//         children: [
//           // Header
//           Container(
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: Colors.grey[100],
//               borderRadius: const BorderRadius.only(
//                 topLeft: Radius.circular(20),
//                 topRight: Radius.circular(20),
//               ),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 IconButton(
//                   icon: const Icon(Icons.close, size: 28),
//                   onPressed: () => Navigator.pop(context),
//                 ),
//               ],
//             ),
//           ),

//           // Camera preview or instructions
//           Expanded(
//             child: _image == null ? _buildInstructions() : _buildImagePreview(),
//           ),

//           // Action buttons
//           _image == null ? _buildCameraButtons() : _buildActionButtons(),
//         ],
//       ),
//     );
//   }

//   Widget _buildInstructions() {
//     return Container(
//       color: Colors.grey[800],
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               width: 250,
//               height: 120,
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.white, width: 3),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Center(
//                 child: Container(
//                   width: 200,
//                   height: 80,
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.3),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 40),
//             const Text(
//               'Scan Code',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 28,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 12),
//             const Text(
//               'There is code on the card scan that',
//               style: TextStyle(
//                 color: Colors.white70,
//                 fontSize: 16,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildImagePreview() {
//     return Container(
//       color: Colors.black,
//       child: Column(
//         children: [
//           Expanded(
//             child: Center(
//               child: _isScanning
//                   ? const CircularProgressIndicator(color: Colors.white)
//                   : _image != null
//                       ? Image.file(_image!, fit: BoxFit.contain)
//                       : const SizedBox(),
//             ),
//           ),
//           if (_scannedText.isNotEmpty)
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(20),
//               color: Colors.grey[900],
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Scanned Text:',
//                     style: TextStyle(
//                       color: Colors.white70,
//                       fontSize: 14,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     _scannedText,
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       letterSpacing: 2,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   Widget _buildCameraButtons() {
//     return Container(
//       padding: const EdgeInsets.all(24),
//       child: Row(
//         children: [
//           Expanded(
//             child: ElevatedButton.icon(
//               onPressed: _pickImageFromCamera,
//               icon: const Icon(Icons.camera_alt),
//               label: const Text('Take Photo'),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFFFF5722),
//                 foregroundColor: Colors.white,
//                 padding: const EdgeInsets.symmetric(vertical: 16),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: ElevatedButton.icon(
//               onPressed: _pickImageFromGallery,
//               icon: const Icon(Icons.photo_library),
//               label: const Text('From Gallery'),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.grey[300],
//                 foregroundColor: Colors.grey[800],
//                 padding: const EdgeInsets.symmetric(vertical: 16),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildActionButtons() {
//     return Container(
//       padding: const EdgeInsets.all(24),
//       child: Row(
//         children: [
//           Expanded(
//             child: OutlinedButton(
//               onPressed: () {
//                 setState(() {
//                   _image = null;
//                   _scannedText = '';
//                 });
//               },
//               style: OutlinedButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(vertical: 16),
//                 side: BorderSide(color: Colors.grey[400]!),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               child: const Text('Retake'),
//             ),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             flex: 2,
//             child: ElevatedButton(
//               onPressed: _scannedText.isNotEmpty ? _useScannedText : null,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: _scannedText.isNotEmpty
//                     ? const Color(0xFFFF5722)
//                     : Colors.grey[300],
//                 padding: const EdgeInsets.symmetric(vertical: 16),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               child: Text(
//                 'Use Code',
//                 style: TextStyle(
//                   color:
//                       _scannedText.isNotEmpty ? Colors.white : Colors.grey[500],
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
