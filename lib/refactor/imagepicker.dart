import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileImagepicker extends StatefulWidget {
  const ProfileImagepicker({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileImagepicker> createState() => _AadhaarImagePickerState();
}

class _AadhaarImagePickerState extends State<ProfileImagepicker> {
  final ImagePicker _picker = ImagePicker();
  File? image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        image != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.file(
                  fit: BoxFit.cover,
                  image!,
                  height: 110,
                  width: 110,
                ),
              )
            : InkWell(
                onTap: () async {
                  var img = await _picker.pickImage(source: ImageSource.camera);

                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();

                  CroppedFile? val = await ImageCropper().cropImage(
                    aspectRatio: const CropAspectRatio(ratioX: 3, ratioY: 3),
                    cropStyle: CropStyle.circle,
                    uiSettings: [
                      AndroidUiSettings(
                        toolbarColor: Colors.white,
                        toolbarTitle: "Image Cropper",
                      )
                    ],
                    sourcePath: img!.path,
                    compressFormat: ImageCompressFormat.jpg,
                  );
                  final temp = File(val!.path);
                  setState(() {
                    image = temp;
                  });

                  prefs.setString('profileimage', val.path);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  width: 110,
                  height: 110,
                  child: Image.asset('assets/images/uploadpro.jpg'),
                ),
              ),
      ],
    );
  }
}
