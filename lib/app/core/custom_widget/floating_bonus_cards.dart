import 'package:flutter/material.dart';
import 'package:mlm_demo_frontend_flutter/app/screens/index/controller/index_controller.dart';
import 'package:mlm_demo_frontend_flutter/app/screens/index/controller/layout_controller.dart';

import 'bonus_button.dart';

class FloatingBonusCards extends StatefulWidget {
  final LayoutController layoutController;
  final IndexController controller;

  const FloatingBonusCards({
    super.key,
    required this.layoutController,
    required this.controller,
  });

  @override
  State<FloatingBonusCards> createState() => _FloatingBonusCardsState();
}

class _FloatingBonusCardsState extends State<FloatingBonusCards> {
  final GlobalKey _localKey = GlobalKey();
  LayoutController get layoutController => widget.layoutController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ctx = _localKey.currentContext;
      if (ctx != null) {
        final box = ctx.findRenderObject() as RenderBox;
        layoutController.bonusWidth.value = box.size.width;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _localKey,
      child: BonusButtons(
        controller: widget.controller,
        layoutController: widget.layoutController,
      ),
    );
  }
}
