import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';
import 'package:image_picker/image_picker.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<File> selectedImages = [];

  // Pick multiple images from gallery
  Future<void> _Gallery() async {
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

  // Pick single image from camera
  Future<void> _Camera() async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        selectedImages.add(File(pickedFile.path));
      });
      saveImagesToPrefs();
    }
  }


  // Save image paths to SharedPreferences
  Future<void> saveImagesToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      final paths = selectedImages.map((file) => file.path).toList();
      await prefs.setStringList('saved_images_$uid', paths);
    }
  }


  // Load image paths from SharedPreferences
  Future<void> loadImagesFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      final imagePaths = prefs.getStringList('saved_images_$uid') ?? [];
      setState(() {
        selectedImages = imagePaths.map((path) => File(path)).toList();
      });
    }
  }


  // Delete single image
  void deleteImage(int index) {
    setState(() {
      selectedImages.removeAt(index);
    });
    saveImagesToPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(15),
            bottomLeft: Radius.circular(15),
          ),
        ),
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("Upload", style: TextStyle(color: Colors.white)),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(

            children: [
              Column(
                children: [
                  ElevatedButton(
                    onPressed: _Gallery,
                    child:  Text('Select from Gallery', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[900],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding:  EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    ),
                  ),
               SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _Camera,
                    child:  Text('Take Photo from Camera', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[900],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding:  EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    ),
                  ),
                  SizedBox(height: 20),
                  selectedImages.isEmpty
                      ?  Center(
                    child: Text(
                      "Please Upload image",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  )
                      : CarouselSlider.builder(
                    itemCount: selectedImages.length,
                    itemBuilder: (context, index, realIdx) {
                      return Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            child: Image.file(
                              selectedImages[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 10,
                            right: 10,
                            child: IconButton(
                              icon:  Icon(Icons.delete, color: Colors.red),
                              onPressed: () => deleteImage(index),
                            ),
                          ),
                        ],
                      );
                    },
                    options: CarouselOptions(
                      height: 300,
                      autoPlay: false,
                      enlargeCenterPage: true,
                      viewportFraction: 1.0,
                      enlargeFactor: 1,
                      scrollDirection: Axis.horizontal,
                    ),

                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(height: 150,),
                  ElevatedButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const Login()),
                            (route) => false,
                      );
                    },
                    child: const Text("Sign out", style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[400],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
