import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileImagepickerupdate extends StatefulWidget {
  final String image;
  const ProfileImagepickerupdate({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  State<ProfileImagepickerupdate> createState() => _AadhaarImagePickerState();
}

class _AadhaarImagePickerState extends State<ProfileImagepickerupdate> {
  final ImagePicker _picker = ImagePicker();
  File? image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        image != null
            ? ClipOval(
                child: Image.file(
                  fit: BoxFit.cover,
                  image!,
                  height: 80,
                  width: 80,
                ),
              )
            : ClipOval(
                child: Image.network(
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                  'http://phpstack-598410-2859373.cloudwaysapps.com/${widget.image}',
                  height: 80,
                  width: 80,
                ),
              ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
          onPressed: () async {
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
          child: const Text('Change Profile'),
        ),
      ],
    );
  }
}
