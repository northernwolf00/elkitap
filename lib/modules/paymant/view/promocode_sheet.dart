import 'package:elkitap/modules/paymant/widget/text_scanner_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PromocodeSheet extends StatefulWidget {
  const PromocodeSheet({Key? key}) : super(key: key);

  @override
  State<PromocodeSheet> createState() => _PromocodeSheetState();
}

class _PromocodeSheetState extends State<PromocodeSheet> {
  final TextEditingController _promoController = TextEditingController();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _promoController.addListener(() {
      setState(() {
        _hasText = _promoController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _promoController.dispose();
    super.dispose();
  }

  void _openTextScanner() async {
    // final result = await showModalBottomSheet<String>(
    //   context: context,
    //   isScrollControlled: true,
    //   backgroundColor: Colors.transparent,
    //   builder: (context) => const TextScannerSheet(),
    // );

    // if (result != null && result.isNotEmpty) {
    //   setState(() {
    //     _promoController.text = result;
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () => Navigator.pop(context),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      'promocode'.tr,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.help_outline),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Container(
                    width: 200,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.card_giftcard,
                        size: 80,
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'use_gift_card_t'.tr,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'promo_code_prompt_t'.tr,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextField(
                            controller: _promoController,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration(
                              hintText: 'enter_promo_code_hint_t'.tr,
                              hintStyle: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 16,
                              ),
                              filled: true,
                              fillColor: Colors.grey[200],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.qr_code_scanner,
                            color: Colors.grey[700],
                            size: 28,
                          ),
                          onPressed: _openTextScanner,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(24),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _hasText ? () {} : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      _hasText ? const Color(0xFFFF5722) : Colors.grey[300],
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'use_promo_code_button_t'.tr,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: _hasText ? Colors.white : Colors.grey[500],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
