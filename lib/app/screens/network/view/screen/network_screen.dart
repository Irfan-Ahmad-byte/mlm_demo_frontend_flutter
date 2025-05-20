// Your imports
import 'package:flutter/material.dart';
import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mlm_demo_frontend_flutter/app/core/custom_widget/app_text_field.dart';
import 'package:mlm_demo_frontend_flutter/app/core/utils/app_colors.dart';
import 'package:mlm_demo_frontend_flutter/app/core/utils/app_spaces.dart';
import 'package:mlm_demo_frontend_flutter/app/core/utils/app_textstyle.dart';
import '../../components/network_node.dart';
import '../../controller/network_controller.dart';

class NetworkScreen extends GetView<NetworkController> {
  const NetworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NetworkController>(
      init: NetworkController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.scaffoldColor,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔵 Search Field
                AppTextField(
                  isClear: true,
                  onClear: () {
                    controller.clearSearch();
                  },
                  // label: "Search",
                  hint: "Search Child...",
                  controller: controller.textEditingController,
                  icon: Icons.search,
                  onChanged: (value) {
                    controller.searchQuery.value = value;
                    controller.searchTree(value, autoScroll: false);
                  },
                  onSubmitted: (value) {
                    controller.searchQuery.value = value;
                    controller.searchTree(value, autoScroll: true);
                  },
                ),
                height20,

                // 🔵 Searching Indicator
                Obx(() => controller.isSearching.value
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppColors.secondaryColor,
                                ),
                              ),
                              width10,
                              Text(
                                "Searching...",
                                style: AppTextstyle.text14.copyWith(
                                  fontSize:
                                      FontSizeManager.getFontSize(context, 14),
                                  color: AppColors.secondaryColor,
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    : const SizedBox.shrink()),

                // 🔵 Tree View
                Expanded(
                  child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.primaryDarkColor,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Obx(() {
                        final hasSearch =
                            controller.searchQuery.value.isNotEmpty;
                        final hasSearchResults =
                            controller.searchedNodes.isNotEmpty;
                        final hasDownline =
                            controller.treeController.roots.isNotEmpty;

                        // 🔍 No search results
                        if (hasSearch && !hasSearchResults) {
                          return Center(
                            child: Text(
                              "No results found!",
                              style: AppTextstyle.text14.copyWith(
                                fontSize:
                                    FontSizeManager.getFontSize(context, 18),
                                color: AppColors.secondaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        }

                        // 📭 No downline at all
                        if (!hasSearch && !hasDownline) {
                          return Center(
                            child: Text(
                              "No downline found!",
                              style: AppTextstyle.text14.copyWith(
                                fontSize:
                                    FontSizeManager.getFontSize(context, 18),
                                color: AppColors.secondaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        }

                        // ✅ TreeView
                        return Scrollbar(
                          controller: controller.horizontalScrollController,
                          thumbVisibility: true,
                          child: SingleChildScrollView(
                            controller: controller.horizontalScrollController,
                            scrollDirection: Axis.horizontal,
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minWidth: Get.width,
                                maxWidth: 2000,
                              ),
                              child: TreeView<NetworkNode>(
                                treeController: controller.treeController,
                                controller: controller.scrollController,
                                nodeBuilder: (context, entry) {
                                  final node = entry.node;
                                  final isSelected =
                                      controller.selectedNode.value == node;
                                  final isSearched =
                                      controller.searchedNodes.contains(node);
                                  final nodeKey = controller.nodeKeys
                                      .putIfAbsent(node, () => GlobalKey());

                                  return Padding(
                                    key: nodeKey,
                                    padding: EdgeInsets.only(
                                      left: entry.level * 20,
                                      top: 8,
                                      bottom: 8,
                                    ),
                                    child: AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? Colors.blue.shade100
                                            : (isSearched
                                                ? Colors.yellow.shade100
                                                : (controller.expandedNodes
                                                        .contains(node)
                                                    ? Colors.blue.shade50
                                                    : AppColors.primaryColor
                                                        .withOpacity(0.4))),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(12),
                                        onTap: () {
                                          if (node.children.isNotEmpty) {
                                            if (controller.expandedNodes
                                                .contains(node)) {
                                              controller.expandedNodes
                                                  .remove(node);
                                              controller.treeController
                                                  .collapse(node);
                                            } else {
                                              controller.expandedNodes
                                                  .add(node);
                                              controller.treeController
                                                  .expand(node);
                                            }
                                          }
                                          controller.selectNode(node);
                                        },
                                        onLongPress: () {
                                          _showNodeDetailsDialog(context, node);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 10),
                                          child: Row(
                                            children: [
                                              if (node.children.isNotEmpty)
                                                Icon(
                                                  controller.expandedNodes
                                                          .contains(node)
                                                      ? Icons
                                                          .keyboard_arrow_down
                                                      : Icons
                                                          .keyboard_arrow_right,
                                                  size: 24,
                                                  color: Colors.blueAccent,
                                                )
                                              else
                                                const SizedBox(width: 24),
                                              width8,
                                              CircleAvatar(
                                                radius: 18,
                                                backgroundColor: Colors
                                                    .blueAccent
                                                    .withOpacity(0.8),
                                                child: Text(
                                                  node.label[0],
                                                  style: AppTextstyle.text14
                                                      .copyWith(
                                                    fontSize: FontSizeManager
                                                        .getFontSize(
                                                            context, 11),
                                                    color: AppColors.whiteColor,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              width12,
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  buildHighlightedText(
                                                      'Level No #${node.label}',
                                                      controller
                                                          .searchQuery.value),
                                                  Text(
                                                    node.accountId ??
                                                        'No Account ID',
                                                    style: AppTextstyle.text14
                                                        .copyWith(
                                                      fontSize: FontSizeManager
                                                          .getFontSize(
                                                              context, 10),
                                                      color: isSearched
                                                          ? Colors.orangeAccent
                                                          : AppColors
                                                              .scaffoldColor,
                                                      fontWeight: isSearched
                                                          ? FontWeight.bold
                                                          : FontWeight.normal,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      })),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // 🔵 Show Node Details Dialog
  void _showNodeDetailsDialog(BuildContext context, NetworkNode node) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 36,
                  backgroundColor: Colors.blueAccent.withOpacity(0.8),
                  child: Text(
                    node.label[0],
                    style: AppTextstyle.text14.copyWith(
                      fontSize: FontSizeManager.getFontSize(context, 12),
                      fontWeight: FontWeight.bold,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
                height16,
                Text(
                  node.label,
                  style: AppTextstyle.text14.copyWith(
                    fontSize: FontSizeManager.getFontSize(context, 14),
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                height8,
                Text(
                  '${node.children.length} Child Nodes',
                  style: AppTextstyle.text14.copyWith(
                    fontSize: FontSizeManager.getFontSize(context, 12),
                    color: Colors.grey,
                  ),
                ),
                height24,
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(
                      'Close',
                      style: AppTextstyle.text14.copyWith(
                        fontSize: FontSizeManager.getFontSize(context, 16),
                        fontWeight: FontWeight.bold,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  // 🔵 Build highlighted text inside node
  Widget buildHighlightedText(String text, String query) {
    if (query.isEmpty) {
      return Text(
        text,
        style: AppTextstyle.text14.copyWith(
          fontSize: FontSizeManager.getFontSize(Get.context!, 12),
          fontWeight: FontWeight.w600,
          color: AppColors.secondaryColor,
        ),
      );
    }

    final lowerText = text.toLowerCase();
    final lowerQuery = query.toLowerCase();

    if (!lowerText.contains(lowerQuery)) {
      return Text(
        text,
        style: AppTextstyle.text14.copyWith(
          fontSize: FontSizeManager.getFontSize(Get.context!, 16),
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      );
    }

    final start = lowerText.indexOf(lowerQuery);
    final end = start + lowerQuery.length;

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text.substring(0, start),
            style: AppTextstyle.text14.copyWith(
              fontSize: FontSizeManager.getFontSize(Get.context!, 12),
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          TextSpan(
            text: text.substring(start, end),
            style: AppTextstyle.text14.copyWith(
              fontSize: FontSizeManager.getFontSize(Get.context!, 12),
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
          TextSpan(
            text: text.substring(end),
            style: AppTextstyle.text14.copyWith(
              fontSize: FontSizeManager.getFontSize(Get.context!, 12),
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
