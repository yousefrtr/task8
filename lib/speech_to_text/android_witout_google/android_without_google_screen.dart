import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task8/speech_to_text/android_witout_google/android_without_google_controller.dart';

class AndroidWithoutGoogleScreen extends StatelessWidget {
  const AndroidWithoutGoogleScreen({super.key});
  static AndroidWithoutGoogleController controller =
      Get.put(AndroidWithoutGoogleController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: controller,
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
                leading: controller.loadData
                    ? Container()
                    : IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () => Get.back(),
                      )),
            body: controller.loadData
                ? Center(child: Text("Loading model...", style: TextStyle()))
                : androidExample(context),
          );
        });
  }

  Widget androidExample(BuildContext context) {
    return GetBuilder(
        init: controller,
        builder: (controller) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    child: Text(
                      controller.fullText,
                      style: TextStyle(fontSize: 25),
                    ),
                    width: double.infinity,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 50.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * .6,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: controller.langButton,
                        child: controller.isEn ? Text("EN") : Text("AR"),
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Colors.amber),
                        ),
                      ),
                      MicButton(controller),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }

  Widget MicButton(AndroidWithoutGoogleController controller) {
    return AvatarGlow(
      animate: controller.recognitionStarted,
      glowColor: Colors.red,
      child: ElevatedButton(
        style: ButtonStyle(
          iconColor: WidgetStatePropertyAll(Colors.white),
          backgroundColor: WidgetStatePropertyAll(Colors.red),
        ),
        onPressed: controller.startStopdRecord,
        child: controller.recognitionStarted
            ? Icon(
                Icons.mic,
              )
            : Icon(
                Icons.mic_off,
              ),
      ),
    );
  }
}
