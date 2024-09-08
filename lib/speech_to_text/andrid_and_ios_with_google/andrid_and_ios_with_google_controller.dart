import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class AndridAndIosWithGoogleController extends GetxController {
  @override
  void onInit() {
    initSpeech();
    super.onInit();
  }

  final SpeechToText speechToText = SpeechToText();
  bool recognitionStarted = false;
  String fullText = "";
  double confidenceLevel = 0;
  bool isEn = true;
  var locales = [];

  void startStopRecord() async {
    if (recognitionStarted) {
      await speechToText.stop();
      update();
    } else {
      await speechToText.listen(
        onResult: (result) => Result(result),
        localeId: isEn ? "en-US" : "ar-SA",
      );

      fullText = "";
      update();
    }
    recognitionStarted = !recognitionStarted;
    update();
  }

  Result(SpeechRecognitionResult Result) {
    fullText = Result.recognizedWords;
    update();
  }

  void setArab() async {
    locales = await speechToText.locales();
    locales.clear();
    locales.add(LocaleName('ar_DZ', 'العربية (الجزائر)'));
  }

  void setEn() async {
    locales = await speechToText.locales();
    locales.clear();
    locales.add(LocaleName("en-US", "English (United States)"));
  }

  void langButton() {
    if (isEn) {
      setEn();
    } else {
      setArab();
    }
    update();
    isEn = !isEn;
    update();
  }

  void initSpeech() async {
    setEn();
    update();
    await speechToText.initialize();

    locales;
    update();
  }
}
