import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:faso_vote_client/app/widgets/custom_text.dart';
import 'dush_border_painter.dart';

class ImagePickerBox extends StatefulWidget {
  final String title;
  final Function(List<PlatformFile>)? onFilesSelected;
  final List<PlatformFile>? selectedFiles;
  final List<PlatformFile>? existingFiles;
  final bool multiple;

  const ImagePickerBox({
    super.key,
    required this.title,
    this.onFilesSelected,
    this.selectedFiles,
    this.existingFiles,
    this.multiple = false,
  });

  @override
  State<ImagePickerBox> createState() => _ImagePickerBoxState();
}

class _ImagePickerBoxState extends State<ImagePickerBox> {
  List<PlatformFile> _localFiles = [];
  List<PlatformFile> _existingFiles = [];
  List<PlatformFile> _allItems = [];
  @override
  void initState() {
    super.initState();

    setState(() {
      _localFiles = widget.selectedFiles ?? [];
      _existingFiles = widget.existingFiles ?? [];
      _updateAllItems();
    });
  }

  void _updateAllItems() {
    _allItems = [..._existingFiles, ..._localFiles];
    if (!widget.multiple && _allItems.length > 1) {
      _allItems = [_allItems.lastWhere((item) => item != null)];
    }
  }

  @override
  void didUpdateWidget(covariant ImagePickerBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedFiles != oldWidget.selectedFiles ||
        widget.existingFiles != oldWidget.existingFiles) {
      setState(() {
        _localFiles = widget.selectedFiles ?? [];
        _existingFiles = widget.existingFiles ?? [];
        _updateAllItems();
      });
    }
  }

  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: widget.multiple,
        withData: true,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'webp'],
      );

      if (result == null || result.files.isEmpty) return;

      setState(() {
        if (!widget.multiple) {
          _localFiles.clear();
          _existingFiles.clear();
        }
        _localFiles.addAll(result.files);
        _updateAllItems();
      });

      widget.onFilesSelected?.call(_localFiles);
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick files: ${e.toString()}');
    }
  }

  void _removeFile(int index) {
    if (index < 0 || index >= _existingFiles.length + _localFiles.length) {
      debugPrint('Invalid index: $index');
      return;
    }
    setState(() {
      if (index < _existingFiles.length) {
        _existingFiles.removeAt(index);
      } else {
        _localFiles.removeAt(index - _existingFiles.length);
      }
      _updateAllItems();
    });

    widget.onFilesSelected?.call(List.from(_allItems));
  }

  void _showImageDialog(int initialIndex) {
    final PageController pageController =
        PageController(initialPage: initialIndex);
    final ValueNotifier<int> currentPageNotifier =
        ValueNotifier<int>(initialIndex);
    showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header with close button and image counter
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        ValueListenableBuilder<int>(
                          valueListenable: currentPageNotifier,
                          builder: (context, currentIndex, _) {
                            return Text(
                              '${currentIndex + 1}/${_allItems.length}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          style: const ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(Colors.white)),
                          onPressed: () {
                            setState(() {
                              final currentIndex =
                                  pageController.page?.round() ?? initialIndex;
                              _removeFile(currentIndex);
                              if (_allItems.isEmpty) {
                                Navigator.of(context).pop();
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),

                  // Image viewer
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    width: double.infinity,
                    child: PageView.builder(
                      controller: pageController,
                      itemCount: _allItems.length,
                      onPageChanged: (index) {
                        currentPageNotifier.value = index;
                        (context as Element).markNeedsBuild();
                      },
                      itemBuilder: (context, index) {
                        final item = _allItems[index];
                        return InteractiveViewer(
                            minScale: 0.5,
                            maxScale: 4.0,
                            child: item.bytes != null
                                ? Image.memory(item.bytes!, fit: BoxFit.cover)
                                : item.path != null &&
                                        item.path!.startsWith('http')
                                    ? Image.network(item.path!,
                                        fit: BoxFit.cover)
                                    : const Icon(Icons.broken_image));
                      },
                    ),
                  ),

                  // Thumbnail preview
                  if (_allItems.length > 1)
                    Container(
                      height: 80,
                      padding: const EdgeInsets.all(8),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _allItems.length,
                        itemBuilder: (context, index) {
                          final item = _allItems[index];
                          return GestureDetector(
                            onTap: () {
                              pageController.animateToPage(
                                index,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                            child: Container(
                              width: 60,
                              height: 60,
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: pageController.page?.round() == index
                                      ? Colors.blue
                                      : Colors.transparent,
                                  width: 2,
                                ),
                                image: item.bytes != null
                                    ? DecorationImage(
                                        image: MemoryImage(item.bytes!),
                                        fit: BoxFit.cover)
                                    : item.path != null &&
                                            item.path!.startsWith('http')
                                        ? DecorationImage(
                                            image: NetworkImage(item.path!),
                                            fit: BoxFit.cover)
                                        : null,
                                color: Colors.grey[800],
                              ),
                              child: item.bytes == null
                                  ? const Center(
                                      child: Icon(Icons.broken_image, size: 20))
                                  : null,
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: widget.title),
        Container(
          height: 120,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: CustomPaint(
            painter: DashedBorderPainter(),
            child: InkWell(
              onTap: _pickFile,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Show first image preview if available
                  if (_allItems.isNotEmpty)
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: _allItems.isNotEmpty
                            ? _allItems.first.bytes != null
                                ? Image.memory(
                                    _allItems.first.bytes!,
                                    fit: BoxFit.cover,
                                  )
                                : _allItems.first.path != null &&
                                        _allItems.first.path!.startsWith('http')
                                    ? Image.network(
                                        _allItems.first.path!,
                                        fit: BoxFit.cover,
                                      )
                                    : null
                            : Container(
                                color: Colors.grey[200],
                                child: const Icon(Icons.image, size: 40),
                              ),
                      ),
                    ),

                  // Content overlay when no images
                  if (_allItems.isEmpty)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.cloud_upload_outlined, size: 40),
                        const SizedBox(height: 4),
                        Text(
                          widget.title,
                          style: const TextStyle(fontSize: 12),
                        ),
                        Text(
                          widget.multiple
                              ? "Click to upload multiple images"
                              : "Click to upload image",
                          style:
                              const TextStyle(fontSize: 10, color: Colors.grey),
                        ),
                      ],
                    ),

                  // Close button when images exist
                  if (_allItems.isNotEmpty)
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                        icon: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(Icons.close,
                              size: 18, color: Colors.white),
                        ),
                        onPressed: () {
                          setState(() {
                            _allItems.clear();
                          });
                          if (widget.onFilesSelected != null) {
                            widget.onFilesSelected!([]);
                          }
                        },
                      ),
                    ),

                  // Zoom button
                  if (_allItems.isNotEmpty)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                        icon: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(Icons.zoom_in_map,
                              size: 18, color: Colors.white),
                        ),
                        onPressed: () {
                          if (_allItems.isNotEmpty) {
                            final index = widget.multiple
                                ? 0 // For multiple files, show first image initially
                                : 0; // For single file, show the only image
                            _showImageDialog(index);
                          }
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),

        // Show thumbnails when multiple files are selected
        if (widget.multiple && _allItems.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: SizedBox(
              height: 80,
              child: ListView.builder(
                controller: ScrollController(),
                scrollDirection: Axis.horizontal,
                itemCount: _allItems.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => _showImageDialog(index),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Stack(
                        children: [
                          Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: _allItems[index].bytes != null
                                  ? DecorationImage(
                                      image:
                                          MemoryImage(_allItems[index].bytes!),
                                      fit: BoxFit.cover,
                                    )
                                  : _allItems[index].path != null &&
                                          _allItems[index]
                                              .path!
                                              .startsWith('http')
                                      ? DecorationImage(
                                          image: NetworkImage(
                                              _allItems[index].path!),
                                          fit: BoxFit.cover,
                                        )
                                      : null,
                              color: Colors.grey[200],
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: IconButton(
                              icon: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: const BoxDecoration(
                                  color: Colors.black54,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.close,
                                    size: 16, color: Colors.white),
                              ),
                              onPressed: () => _removeFile(index),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
      ],
    );
  }
}
