import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';
import 'package:get/get.dart';

import '../components/network_node.dart';

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
    final root = buildTree();
    treeController = TreeController<NetworkNode>(
      roots: [root],
      childrenProvider: (node) => node.children,
    );
  }

  void clearSearch() {
    textEditingController.clear();
    searchQuery.value = '';
    searchedNodes.clear();
    treeController.collapseAll();
  }

  NetworkNode buildTree() {
    return NetworkNode(
      label: 'Root Node',
      children: [
        NetworkNode(
          label: 'Child 1',
          children: [
            NetworkNode(
              label: 'Grandchild 1.1',
              accountId: '1234456545',
            ),
            NetworkNode(
              label: 'Grandchild 1.2',
              accountId: '1234456545',
            ),
          ],
          accountId: '1234456545',
        ),
        NetworkNode(
          label: 'Child 2',
          children: [
            NetworkNode(
              label: 'Grandchild 2.1',
              accountId: '1234456545',
            ),
          ],
          accountId: '1234456545',
        ),
        NetworkNode(
          label: 'Child 3',
          children: [
            NetworkNode(
              label: 'Grandchild 3.1',
              accountId: '1234456545',
            ),
            NetworkNode(
              label: 'Grandchild 3.2',
              accountId: '1234456545',
            ),
          ],
          accountId: '1234456545',
        ),
        NetworkNode(
          label: 'Child 4',
          children: [
            NetworkNode(
              label: 'Grandchild 4.1',
              accountId: '1234456545',
            ),
            NetworkNode(
              label: 'Grandchild 4.2',
              accountId: '1234456545',
            ),
          ],
          accountId: '1234456545',
        ),
      ],
      accountId: '1234456545',
    );
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
        treeController.expand(currentNode); // expand this parent
        expandParents(currentNode); // keep going upwards
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

  @override
  void onClose() {
    treeController.dispose();
    super.onClose();
  }
}
