import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShortenerController extends GetxController {
  final TextEditingController urlController = TextEditingController();
  bool isLoading = false;

  void shortenUrl() {
    final url = urlController.text.trim();
    if (url.isEmpty) return;
    isLoading = true;
    update();

    // Simulate API delay
    Future.delayed(const Duration(seconds: 2), () {
      isLoading = false;
      urlController.clear();
      update();
      // Show toast/snackbar or update list
    });
  }
}
