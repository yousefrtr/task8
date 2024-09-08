import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task8/speech_to_text/andrid_and_ios_with_google/andrid_and_ios_with_google_controller.dart';

class AndridAndIosWithGoogleScreen extends StatelessWidget {
  const AndridAndIosWithGoogleScreen({super.key});
  static AndridAndIosWithGoogleController controller =
      Get.put(AndridAndIosWithGoogleController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: controller,
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(),
            body: androidExample(context),
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

  Widget MicButton(AndridAndIosWithGoogleController controller) {
    return AvatarGlow(
      animate: controller.recognitionStarted,
      glowColor: Colors.red,
      child: ElevatedButton(
        style: ButtonStyle(
          iconColor: WidgetStatePropertyAll(Colors.white),
          backgroundColor: WidgetStatePropertyAll(Colors.red),
        ),
        onPressed: controller.startStopRecord,
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
