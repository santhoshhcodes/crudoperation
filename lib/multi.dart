import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ImageCarouselPage extends StatefulWidget {
  const ImageCarouselPage({Key? key}) : super(key: key);

  @override
  State<ImageCarouselPage> createState() => _ImageCarouselPageState();
}

class _ImageCarouselPageState extends State<ImageCarouselPage> {
  List<File> _images = [];
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    loadImagesFromPrefs();
  }

  // Load saved paths from SharedPreferences
  Future<void> loadImagesFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? paths = prefs.getStringList('images');
    if (paths != null) {
      setState(() {
        _images = paths.map((path) => File(path)).toList();
      });
    }
  }

  // Save current list of image paths
  Future<void> saveImagesToPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> paths = _images.map((file) => file.path).toList();
    await prefs.setStringList('images', paths);
  }

  // Pick single image and add to list
  Future<void> pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _images.add(File(pickedFile.path));
      });
      await saveImagesToPrefs(); // Save updated list
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Image Carousel")),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: pickImage,
            child: const Text("Pick Image"),
          ),
          const SizedBox(height: 10),
          _images.isNotEmpty
              ? CarouselSlider(
            items: _images.map((file) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Image.file(file, fit: BoxFit.cover),
                  );
                },
              );
            }).toList(),
            options: CarouselOptions(
              height: 300.0,
              autoPlay: true,
              enlargeCenterPage: true,
            ),
          )
              : const Text("No images selected"),
        ],
      ),
    );
  }
}
