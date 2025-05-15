import 'package:faso_vote_client/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/functions/function.dart';
import 'tooltipContent.dart';

enum FieldType { text, number, date, select, multiSelect }

// texte tooltip content
// ignore: must_be_immutable
class TooltipContentText extends StatefulWidget implements TooltipContent {
  String? defaultValue;

  @override
  // ignore: library_private_types_in_public_api
  final GlobalKey<_TooltipContentTextState> key =
      GlobalKey<_TooltipContentTextState>();
  void Function(String?)? onChanged;
  TooltipContentText({super.key, this.defaultValue, this.onChanged});
  @override
  String getValue() {
    return key.currentState!.value ?? "";
  }

  @override
  double getMaxHeight() {
    return 70.0;
  }

  @override
  double getMaxWidth(BuildContext context) {
    return context.width;
  }

  @override
  State<TooltipContentText> createState() => _TooltipContentTextState();
}

class _TooltipContentTextState extends State<TooltipContentText> {
  String? value;
  late FocusNode textFocusNode;
  bool autoFocus = false;
  @override
  void initState() {
    super.initState();
    value = widget.defaultValue;
    autoFocus = true;
    textFocusNode = FocusNode();
    buildNodeFocus(textFocusNode);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(value ?? ''),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: GestureDetector(
              onTap: () {
                Functions.copyText(
                    text: value ?? "",
                    message: LocaleKeys.id_transaction_copied.tr);
              },
              child: const Icon(Icons.copy, size: 20, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}

void buildNodeFocus(FocusNode focusNode) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    focusNode.requestFocus();
  });
}
