import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';

import 'package:vosk_flutter/vosk_flutter.dart';

class AndroidWithoutGoogleController extends GetxController {
  onInit() {
    loadModel();

    super.onInit();
  }

  bool isEn = true;

  var loadData = true;

  final sampleRate = 16000;

  final vosk = VoskFlutterPlugin.instance();
  final modelLoader = ModelLoader();

  String? fileRecognitionResult;
  String? error;
  Model? model;
  Recognizer? recognizer;
  String fullText = "";
  SpeechService? speechService;
  bool recognitionStarted = false;

  StreamSubscription? subscription;

  void loadModel() async {
    if (await modelLoader.isModelAlreadyLoaded(
        isEn ? "vosk-model-small-en-us-0.15" : "vosk-model-ar-mgb2-0.4")) {
      try {
        loadData = true;
        update();
        var modelCreate = vosk.createModel(await modelLoader.modelPath(
            isEn ? "vosk-model-small-en-us-0.15" : "vosk-model-ar-mgb2-0.4"));
        update();

        model = await modelCreate;
        update();
        loadData = false;
        update();
        var createRecognizer = vosk.createRecognizer(
          model: model!,
          sampleRate: sampleRate,
        );
        update();
        recognizer = await createRecognizer;
        update();

        initspeechService();
      } catch (e) {
        print(e);
      }
    } else {
      loadData = true;
      update();

      var loadModel = modelLoader
          .loadModelsList()
          .then((modelsList) => modelsList.firstWhere((model) =>
              model.name ==
              (isEn
                  ? "vosk-model-small-en-us-0.15"
                  : "vosk-model-ar-mgb2-0.4")))
          .then((modelDescription) =>
              modelLoader.loadFromNetwork(modelDescription.url));
      update();

      var modelCreate = vosk.createModel(await loadModel);
      update();
      model = await modelCreate;
      update();
      loadData = false;
      update();

      var createRecognizer =
          vosk.createRecognizer(model: model!, sampleRate: sampleRate);
      update();
      recognizer = await createRecognizer;
      update();
      initspeechService();
    }
  }

  void initspeechService() async {
    if (speechService == null) {
      try {
        speechService = await vosk.initSpeechService(recognizer!);
      } catch (e) {
        if (e.toString() ==
            "PlatformException(INITIALIZE_FAIL, SpeechService instance already exist., null, null)") {
          speechService = vosk.getSpeechService();
          update();
        } else {
          print(e);
          print("object");
        }
      }
    }
  }

  void startStopdRecord() async {
    if (recognitionStarted) {
      await speechService?.stop();
      subscription?.cancel();
      update();
    } else {
      await speechService!.start();
      fullText = "";
      update();

      subscription = speechService?.onResult().listen(
            (v) => Result(v),
          );
    }
    recognitionStarted = !recognitionStarted;
    update();
  }

  void langButton() {
    recognizer?.dispose();
    update();
    isEn = !isEn;
    update();

    loadModel();
    update();
  }

  void Result(String Result) {
    Map<String, dynamic> str = (jsonDecode(Result));

    String newStr = str['text'] ?? "";
    if (newStr.isNotEmpty) {
      fullText += " " + newStr;

      update();
    }
  }
}
