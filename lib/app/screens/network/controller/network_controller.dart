import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';
import 'package:get/get.dart';
import 'package:mlm_demo_frontend_flutter/app/screens/network/repository/network_repository.dart';

import '../../../api/api_preference.dart';
import '../../../core/custom_widget/custom_snackbar.dart';
import '../../../core/custom_widget/loading.dart';
import '../../../core/utils/app_colors.dart';
import '../components/network_node.dart';
import '../model/downline_model.dart';

class NetworkController extends GetxController {
  late final TreeController<NetworkNode> treeController;
  final Map<NetworkNode, GlobalKey> nodeKeys = {};
  final isSearching = false.obs;
  final horizontalScrollController = ScrollController();

  final scrollController = ScrollController();
  final expandedNodes = <NetworkNode>{}.obs;
  final textEditingController = TextEditingController();
  final selectedNode = Rx<NetworkNode?>(null);
  final searchedNodes = <NetworkNode>[].obs;
  final searchQuery = ''.obs;
  Timer? _debounce;

  @override
  void onInit() {
    super.onInit();
    treeController = TreeController<NetworkNode>(
      roots: [],
      childrenProvider: (node) => node.children,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchDownlineTree(); // ✅ Called after build
    });
  }

  void clearSearch() {
    textEditingController.clear();
    searchQuery.value = '';
    searchedNodes.clear();
    treeController.collapseAll();
  }

  void selectNode(NetworkNode node) {
    selectedNode.value = node;
  }

  void searchTree(String query, {bool autoScroll = false}) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    isSearching.value = true; // 👈 Start showing spinner

    _debounce = Timer(const Duration(milliseconds: 400), () {
      if (query.isEmpty) {
        searchedNodes.clear();
        treeController.collapseAll();
        isSearching.value = false; // 👈 Hide spinner
        return;
      }

      final results = <NetworkNode>[];
      _searchRecursive(
          treeController.roots.toList(), query.toLowerCase(), results);

      searchedNodes.assignAll(results);

      for (var node in results) {
        expandParents(node);
      }

      if (autoScroll && results.isNotEmpty) {
        Future.delayed(const Duration(milliseconds: 300), () {
          scrollToNode(results.first);
          Future.delayed(const Duration(milliseconds: 400), () {
            isSearching.value = false; // 👈 Hide spinner after scroll
          });
        });
      } else {
        isSearching.value = false; // 👈 Hide spinner
      }
    });
  }

  void scrollToNode(NetworkNode targetNode) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final key = nodeKeys[targetNode];
      if (key != null && key.currentContext != null) {
        final renderBox = key.currentContext!.findRenderObject() as RenderBox?;
        final scrollableBox = scrollController
            .position.context.notificationContext
            ?.findRenderObject() as RenderBox?;

        if (renderBox != null && scrollableBox != null) {
          final renderBoxOffset =
              renderBox.localToGlobal(Offset.zero, ancestor: scrollableBox);
          final double scrollOffset =
              scrollController.offset + renderBoxOffset.dy;

          scrollController.animateTo(
            scrollOffset -
                100, // Optional: Adjust if you want some margin from top
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

  List<NetworkNode> _getAllVisibleNodes() {
    final nodes = <NetworkNode>[];

    void visit(NetworkNode node) {
      nodes.add(node);
      if (expandedNodes.contains(node)) {
        for (final child in node.children) {
          visit(child);
        }
      }
    }

    for (final root in treeController.roots) {
      visit(root);
    }

    return nodes;
  }

  void expandParents(NetworkNode targetNode) {
    void recursiveExpand(NetworkNode currentNode) {
      if (currentNode.children.contains(targetNode)) {
        treeController.expand(currentNode);

        // ✅ FIX: safely add to expandedNodes
        Future.microtask(() {
          expandedNodes.add(currentNode);
        });

        expandParents(currentNode);
      } else {
        for (final child in currentNode.children) {
          recursiveExpand(child);
        }
      }
    }

    for (final root in treeController.roots) {
      recursiveExpand(root);
    }
  }

  void _searchRecursive(
      List<NetworkNode> nodes, String query, List<NetworkNode> result) {
    for (var node in nodes) {
      if (node.label.toLowerCase().contains(query)) {
        result.add(node);
      }
      if (node.children.isNotEmpty) {
        _searchRecursive(node.children, query, result);
      }
    }
  }

  final networkRepository = NetworkRepository();
  @override
  void onClose() {
    treeController.dispose();
    super.onClose();
  }

  Future<void> fetchDownlineTree({String? userId}) async {
    CustomLoading.show();
    try {
      final accessToken = await ApiPreference.getApiToken;
      if (accessToken == null || accessToken.isEmpty) {
        CustomSnackBar.show(
          message: "Token missing. Please login again.",
          backColor: AppColors.errorColor,
        );
        return;
      }

      downlines.clear();
      downlines.addAll(await networkRepository.getDownline({
        "token": accessToken.toString(),
      }));

      if (downlines.isNotEmpty) {
        /// Convert each DownlineModel to NetworkNode
        final rootNodes = downlines.map(convertToTree).toList();

        treeController.roots = rootNodes;
        treeController.rebuild();
        update();
      }
    } catch (e) {
      Get.log("Fetch Downline Error: $e");
    } finally {
      CustomLoading.hide();
    }
  }

  NetworkNode convertToTree(DownlineModel model) {
    return NetworkNode(
      label: model.level.toString(),
      accountId: model.id ?? "No ID",
      children: model.children?.map((child) {
            return convertChildToNode(child);
          }).toList() ??
          [],
    );
  }

  final List<DownlineModel> downlines = [];

  NetworkNode convertChildToNode(Children child) {
    return NetworkNode(
      label: child.level.toString(),
      accountId: child.id ?? "No ID",
      children: child.children?.map(convertChildToNode).toList() ?? [],
    );
  }
}
