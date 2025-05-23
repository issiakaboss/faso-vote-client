import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:super_tooltip/super_tooltip.dart';
import 'tooltipContent.dart';

class CustomTooltip extends StatefulWidget {
  final dynamic label;
  final double valueWidth;
  final TooltipContent content;

  final void Function(dynamic)? onValidate;

  const CustomTooltip(
      {super.key,
      required this.label,
      this.valueWidth = 100.0,
      required this.content,
      required this.onValidate});

  @override
  // ignore: library_private_types_in_public_api
  _CustomTooltipState createState() => _CustomTooltipState();
}

class _CustomTooltipState extends State<CustomTooltip> {
  late SuperTooltipController tooltipController;
  late TooltipDirection direction;
  final GlobalKey _key = GlobalKey();
  static SuperTooltipController staticTooltipController =
      SuperTooltipController();
  @override
  void initState() {
    super.initState();
    tooltipController = SuperTooltipController();
    direction = TooltipDirection.down;
  }

  Color labelBackroundColor = Colors.transparent;
// fonction to set the backgroundColor on the text  after validation
  Future<void> setBackgroundToText() async {
    setState(() {
      labelBackroundColor = const Color.fromARGB(255, 174, 211, 5);
    });
  }

  bool showBarrier = true;

  @override
  void dispose() {
    super.dispose();
  }

  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(date);
  }

  final bool _tooltipDirectionCalculated = false;

  @override
  Widget build(BuildContext context) {
    if (!_tooltipDirectionCalculated) {
      WidgetsBinding.instance.addPostFrameCallback((_) {});
    }
    return Container(
      alignment: Alignment.centerLeft,
      child: SuperTooltip(
        controller: tooltipController,
        arrowTipDistance: 10.0,
        arrowBaseWidth: 20.0,
        arrowLength: 15.0,
        showBarrier: showBarrier,
        barrierColor: Colors.transparent,
        hideTooltipOnBarrierTap: true,
        popupDirection: direction,
        borderWidth: 0.7,
        shadowColor: Colors.black12,
        snapsFarAwayVertically: false,
        borderRadius: 5.0,
        hasShadow: true,
        bubbleDimensions:
            const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
        touchThroughAreaShape: ClipAreaShape.rectangle,
        content: Container(
          constraints: BoxConstraints(
            maxWidth: widget.content.getMaxWidth(context),
            maxHeight: widget.content.getMaxHeight(),
          ),
          child: widget.content as Widget,
        ),
        child: InkWell(
          key: _key,
          onLongPress: () {
          
          },
          onTap: () async {
            WidgetsBinding.instance.addPostFrameCallback((_) {});

            if (staticTooltipController != tooltipController &&
                staticTooltipController.isVisible) {
              staticTooltipController.hideTooltip();
            }
            staticTooltipController = tooltipController;
            // widget.content.setValue(widget.label);
            if (tooltipController.isVisible) {
              tooltipController.hideTooltip();
            } else if (!tooltipController.isVisible) {
              tooltipController.showTooltip();
            }
          },
          child: AnimatedContainer(
            duration: const Duration(seconds: 1),
            curve: Curves.fastLinearToSlowEaseIn,
            decoration: BoxDecoration(
              color: labelBackroundColor,
            ),
            onEnd: () {
              setState(() {
                labelBackroundColor = Colors.transparent;
              });
            },
            child: Text(
              textAlign: TextAlign.center,
              widget.label.toString(),
              style: const TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.blueAccent,
                  decorationThickness: 1.6,
                  decorationStyle: TextDecorationStyle.dotted,
                  decorationColor: Colors.blue),
            ),
          ),
        ),
      ),
    );
  }
}
