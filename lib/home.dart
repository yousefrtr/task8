import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:task8/speech_to_text/andrid_and_ios_with_google/andrid_and_ios_with_google_screen.dart';
import 'package:task8/speech_to_text/android_witout_google/android_without_google_screen.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Get.to(() => AndroidWithoutGoogleScreen());
                },
                child: Text("AndroidWithoutGoogle")),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: ElevatedButton(
                  onPressed: () {
                    Get.to(() => AndridAndIosWithGoogleScreen());
                  },
                  child: Text("AndridAndIosWithGoogle")),
            ),
          ],
        ),
      ),
    );
  }
}
