import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImageCarouselPicker extends StatefulWidget {
  const ImageCarouselPicker({super.key});

  @override
  State<ImageCarouselPicker> createState() => _ImageCarouselPickerState();
}

class _ImageCarouselPickerState extends State<ImageCarouselPicker> {
  List<File> selectedImages = [];

  @override
  void initState() {
    super.initState();
    loadImagesFromPrefs();
  }

  Future<void> pickImages() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );

    if (result != null) {
      final newFiles = result.paths.map((path) => File(path!)).toList();
      setState(() {
        selectedImages.addAll(newFiles);
      });
      saveImagesToPrefs();
    }
  }

  void deleteImage(int index) {
    setState(() {
      selectedImages.removeAt(index);
    });
    saveImagesToPrefs();
  }

  Future<void> saveImagesToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final imagePaths = selectedImages.map((file) => file.path).toList();
    await prefs.setStringList('saved_images', imagePaths);
  }

  Future<void> loadImagesFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final imagePaths = prefs.getStringList('saved_images') ?? [];

    setState(() {
      selectedImages = imagePaths.map((path) => File(path)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Multi Image Carousel")),
      body: Column(
        children: [
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: pickImages,
            child: const Text("Pick Images"),
          ),
          const SizedBox(height: 20),
          selectedImages.isEmpty
              ? const Text("No images selected")
              : CarouselSlider.builder(
            itemCount: selectedImages.length,
            itemBuilder: (context, index, realIndex) {
              return Stack(
                children: [
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    child: Image.file(
                      selectedImages[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => deleteImage(index),
                    ),
                  ),
                ],
              );
            },
            options: CarouselOptions(
              height: 300,
              autoPlay: false,
            ),
          ),
        ],
      ),
    );
  }
}
