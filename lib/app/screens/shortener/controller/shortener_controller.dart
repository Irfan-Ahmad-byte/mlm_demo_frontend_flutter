import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mlm_demo_frontend_flutter/app/api/api_preference.dart';
import 'package:mlm_demo_frontend_flutter/app/screens/shortener/repository/shortener_repository.dart';
import '../../../core/custom_widget/custom_snackbar.dart';
import '../../../core/custom_widget/loading.dart';
import '../../../core/utils/app_colors.dart';
import '../models/shortened_links_model.dart';
import '../storage/history_storage.dart';
import '../storage/stat_storage.dart';

class ShortenerController extends GetxController {
  final TextEditingController urlController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final RxList<ShortenedLink> recentLinks = <ShortenedLink>[].obs;

  final RxBool isLoading = false.obs;
  final RxString shortenedCode = ''.obs;
  final RxString originalUrl = ''.obs;
  final RxList<ShortenedLink> allLinks = <ShortenedLink>[].obs;
  final RxBool sortDescending = true.obs;

  /// Sorted and filtered list (extendable with domain filter if needed)
  List<ShortenedLink> get filteredLinks {
    final links = [...allLinks]; // copy list
    links.sort((a, b) => sortDescending.value
        ? b.createdAt.compareTo(a.createdAt)
        : a.createdAt.compareTo(b.createdAt));
    return links;
  }

  final userId = ApiPreference.getUserId;

  void loadRecentLinks() {
    allLinks.value = LinkStorage.getAllLinks(userId);
  }

  void addNewLink(ShortenedLink link) {
    LinkStorage.addLink(userId, link);
    allLinks.insert(0, link);
  }

  void toggleSortOrder() {
    sortDescending.value = !sortDescending.value;
  }

  final ShortenerRepository shortenerRepository = ShortenerRepository();
  final RxInt totalLinks = 0.obs;
  final RxInt totalClicks = 0.obs;
  final RxInt linksToday = 0.obs;
  @override
  void onInit() {
    LocalStatsStorage.resetIfNewDay(userId);
    totalLinks.value = LocalStatsStorage.getTotalLinks(userId);
    totalClicks.value = LocalStatsStorage.getTotalClicks(userId);
    linksToday.value = LocalStatsStorage.getLinksToday(userId);
    loadRecentLinks();

    super.onInit();
  }

  void clearAllLinks() {
    LinkStorage.clearAll(userId);
    recentLinks.clear();
  }

  /// Shorten a long URL and return the short code
  void shortenerUrl({
    required String originalUrl,
    required void Function(String shortCode) onSuccess,
  }) async {
    if (originalUrl.isEmpty) {
      CustomSnackBar.show(
        message: "Please enter a URL",
        backColor: AppColors.errorColor,
      );
      return;
    }

    try {
      isLoading.value = true;
      CustomLoading.show();

      final body = {"original_url": originalUrl};
      final response = await shortenerRepository.shortUrl(body: body);

      if (response != null && response['short_url'] != null) {
        final shortCode = response['short_url'];
        shortenedCode.value = shortCode.toString();
        onSuccess(shortCode); // ✅ Call the callback here
        totalLinks.value += 1;
        linksToday.value += 1;
        final link = ShortenedLink(
          originalUrl: originalUrl,
          shortUrl: " $shortCode",
          createdAt: DateTime.now(),
        );

        addNewLink(link);

        LocalStatsStorage.incrementTotalLinks(userId);
        LocalStatsStorage.incrementLinksToday(userId);
        CustomSnackBar.show(
          message: "Shortened successfully",
          backColor: AppColors.lightGreen,
        );
      } else {
        CustomSnackBar.show(
          message: response['detail'] ?? "Failed to shorten URL",
          backColor: AppColors.errorColor,
        );
      }
    } catch (e) {
      Get.log("Shortening failed: $e");
      CustomSnackBar.show(
        message: "Something went wrong",
        backColor: AppColors.errorColor,
      );
    } finally {
      isLoading.value = false;
      CustomLoading.hide();
    }
  }

  void getOriginalUrlFromCode({
    required String shortCode,
    required void Function(String originalUrl) onSuccess,
  }) async {
    if (shortCode.isEmpty) {
      CustomSnackBar.show(
        message: "Please enter a short code",
        backColor: AppColors.errorColor,
      );
      return;
    }

    try {
      isLoading.value = true;
      CustomLoading.show();

      final response = await shortenerRepository.getShortenCode(
        shortCode: shortCode,
      );

      if (response != null && response['url'] != null) {
        // ✅ FIXED here
        final url = response['url'];
        originalUrl.value = url;
        onSuccess(url);
        CustomSnackBar.show(
          message: "Original URL fetched",
          backColor: AppColors.lightGreen,
        );
      } else {
        CustomSnackBar.show(
          message: response?['detail'] ?? "Failed to retrieve URL",
          backColor: AppColors.errorColor,
        );
      }
    } catch (e) {
      Get.log("Failed to fetch original URL: $e");
      CustomSnackBar.show(
        message: "Something went wrong",
        backColor: AppColors.errorColor,
      );
    } finally {
      isLoading.value = false;
      CustomLoading.hide();
    }
  }
}
