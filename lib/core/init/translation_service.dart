import 'dart:ui';

import 'package:get/get.dart';

class TranslationService extends Translations {
  static final fallbackLocale = const Locale('tr', 'TR');

  static final supportedLocales = [
    const Locale('en', 'US'),
    const Locale('tr', 'TR'),
    const Locale('ru', 'RU'),
  ];

  @override
  Map<String, Map<String, String>> get keys => {
        'tr': {
          "succes_edit": "Üstünlikli üýtgedildi",
          "saved_edit_moder": "Siziň bildirişiňiz ýatda saklandy we moderasiýadan soň neşir ediler.",
          
        },
        'en': {
          'filter_deleted_successfully': 'Filter deleted successfully',
          "select_location": "Do you want to confirm the selected location?",
         
        },
        'ru': {
          "are_you_sure_to_save_image": "Вы уверены, что хотите сохранить изображение?",
          "successSendZalob": "Ваша жалоба отправлена",
          
        },
      };
}
