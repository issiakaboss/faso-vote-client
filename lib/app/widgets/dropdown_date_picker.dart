import 'package:faso_vote_client/app/themes/app_colors.dart';
import 'package:faso_vote_client/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../themes/app_text_styles.dart';
import 'custom_text.dart';

class DropdownDateTimePicker extends StatefulWidget {
  final void Function(DateTime) onDateTimeChanged;
  final String? labelText;
  final TextStyle? labelStyle;

  const DropdownDateTimePicker({
    super.key,
    required this.onDateTimeChanged,
    this.labelText,
    this.labelStyle,
  });

  @override
  State<DropdownDateTimePicker> createState() => _DropdownDateTimePickerState();
}

class _DropdownDateTimePickerState extends State<DropdownDateTimePicker> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  DateTime? _selectedDateTime;
  DateTime _tempDate = DateTime.now();
  TimeOfDay _tempTime = TimeOfDay.now();

  void _toggleDropdown() {
    if (_overlayEntry == null) {
      _tempDate = _selectedDateTime ?? DateTime.now();
      _tempTime = TimeOfDay.fromDateTime(_tempDate);
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
    } else {
      _removeOverlay();
    }
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _confirmSelection() {
    final selected = DateTime(
      _tempDate.year,
      _tempDate.month,
      _tempDate.day,
      _tempTime.hour,
      _tempTime.minute,
    );
    setState(() {
      _selectedDateTime = selected;
    });
    widget.onDateTimeChanged(selected);
    _removeOverlay();
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);
    final screenHeight = MediaQuery.of(context).size.height;
    final availableHeight = screenHeight - offset.dy - size.height - 20;

    return OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: offset.dy + size.height + 5,
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: const Offset(0.0, 0.0),
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(8),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: availableHeight > 100 ? availableHeight : 100,
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CalendarDatePicker(
                        initialDate: _tempDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                        onDateChanged: (date) {
                          setState(() => _tempDate = date);
                        },
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Text("Heure: "),
                          const SizedBox(width: 8),
                          Expanded(
                            child: DropdownMenu<int>(
                              initialSelection: _tempTime.hour,
                              onSelected: (value) {
                                if (value != null) {
                                  setState(() => _tempTime = TimeOfDay(
                                      hour: value, minute: _tempTime.minute));
                                }
                              },
                              menuHeight: 130,
                              dropdownMenuEntries: List.generate(
                                24,
                                (i) => DropdownMenuEntry(
                                  value: i,
                                  label: i.toString().padLeft(2, '0'),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Text("Minute: "),
                          const SizedBox(width: 8),
                          Expanded(
                            child: DropdownMenu<int>(
                              initialSelection: _tempTime.minute,
                              onSelected: (value) {
                                if (value != null) {
                                  setState(() => _tempTime = TimeOfDay(
                                      hour: _tempTime.hour, minute: value));
                                }
                              },
                              menuHeight: 130,
                              dropdownMenuEntries: List.generate(
                                60,
                                (i) => DropdownMenuEntry(
                                  value: i,
                                  label: i.toString().padLeft(2, '0'),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: _confirmSelection,
                          style: const ButtonStyle(
                              foregroundColor:
                                  WidgetStatePropertyAll(AppColors.primary)),
                          child: Text(LocaleKeys.buttons_confirm.tr),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formatted = _selectedDateTime != null
        ? DateFormat('dd/MM/yyyy HH:mm').format(_selectedDateTime!)
        : 'Choisissez la date et l’heure';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: widget.labelText ?? '',
            style: widget.labelStyle ?? AppTextStyles.inputLabel(),
            overflow: TextOverflow.visible,
          ),
          CompositedTransformTarget(
            link: _layerLink,
            child: GestureDetector(
              onTap: _toggleDropdown,
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: null,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 0.0)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 0.0)),
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: Icon(Icons.arrow_drop_down),
                ),
                child: Text(
                  formatted,
                  style: TextStyle(
                    color:
                        _selectedDateTime != null ? Colors.black : Colors.grey,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
