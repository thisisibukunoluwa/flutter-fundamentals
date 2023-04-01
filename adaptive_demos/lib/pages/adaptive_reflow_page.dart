import 'package:adaptive_demos/app_model.dart';
import 'package:adaptive_demos/global/device_type.dart';
import 'package:adaptive_demos/global/styling.dart';
import 'package:adaptive_demos/widgets/scroll_view_with_scrollbars.dart';
import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// shows three types of layouts , a vertical for narrow screens , a wide for wide screens and a mixed mode

enum ReflowMode { Vertical, Horizontal, Mixed }

class AdaptiveReflowPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      ReflowMode reflowMode = ReflowMode.Mixed;
      if (constraints.maxWidth < 800) {
        reflowMode = ReflowMode.Vertical;
      } else if (constraints.maxHeight < 800) {
        reflowMode = ReflowMode.Horizontal;
      }

      //In Mixed mode, use a mix of column and row

      if (reflowMode == ReflowMode.Mixed) {
        return Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(child: _ContentPanel1()),
                  Expanded(child: _ContentPanel2()),
                ],
              )
            ),
            Expanded(child: _ContentPanel3()),
          ],
        );
      } 
      //In vertical or horizontal mode , use a ExpandedScrollingFlex with the same set of children 
      else {
        Axis direction = reflowMode == ReflowMode.Horizontal
            ? Axis.horizontal
            : Axis.vertical;
        return ExpandedScrollingFlex(
          
        );
      }
    });
  }
}

// Widget _ContentPanel1() => _ContentPanel1("Panel 1");
// Widget _ContentPanel2() => _ContentPanel2("Panel 2");
// Widget _ContentPanel3() => _ContentPanel3("Panel 3");

class _ContentPanel extends StatelessWidget {
  const _ContentPanel(this.label, {Key? key}) : super(key: key);
  final String label;

  @override
  Widget build(BuildContext context) {
    VisualDensity density = Theme.of(context).visualDensity;
    return ConstrainedBox(
        constraints: BoxConstraints(minHeight: 300, minWidth: 300),
        child: Padding(
            padding: EdgeInsets.all(Insets.large + density.vertical * 6),
            child: Container(
              alignment: Alignment.center,
              color: Colors.purple.shade100,
              child: Text(label),
            )));
  }
}
