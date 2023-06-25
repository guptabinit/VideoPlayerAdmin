import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:video_player_admin/resources/firestore_methods.dart';
import 'package:video_player_admin/widgets/custom_button.dart';
import 'package:video_player_admin/widgets/text_field.dart';

import '../resources/auth_methods.dart';
import '../utils/utils.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  TextEditingController videoLinkController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  Uint8List? _image;
  bool isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    videoLinkController.dispose();
    descController.dispose();
    titleController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "Upload a video",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextField(
              controller: videoLinkController,
              labelText: "Enter the video link",
            ),
            12.heightBox,
            CustomTextField(
              controller: titleController,
              labelText: "Enter the title",
            ),
            12.heightBox,
            CustomTextField(
              controller: descController,
              labelText: "Enter the description",
              maxLines: 3,
            ),
            12.heightBox,
            AspectRatio(
              aspectRatio: 4 / 3,
              child: GestureDetector(
                onTap: () {
                  selectImage();
                },
                child: _image != null
                    ? Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image(
                            image: MemoryImage(_image!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Text(
                            "Add a thumbnail",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
              ),
            ),
            24.heightBox,
            isLoading? const Center(child: CircularProgressIndicator(color: Colors.redAccent,),) : CustomButton(
              btnText: "Upload",
              onTap: () async {
                setState(() {
                  isLoading = true;
                });

                DateTime now = DateTime.now();
                String formattedDate = DateFormat('ddMMyykkmmss').format(now);

                if (_image == null) {
                  showSnackBar("Upload a thumbnail", context);
                } else {
                  await FirestoreMethods().uploadVideo(
                    vid: formattedDate,
                    uid: FirebaseAuth.instance.currentUser!.uid,
                    videoLink: videoLinkController.text,
                    file: _image!,
                    description: descController.text,
                    title: titleController.text,
                    context: context,
                  );
                }

                Get.back();

                setState(() {
                  isLoading = false;
                });

              },
            ),
          ],
        ),
      ),
    );
  }


}
