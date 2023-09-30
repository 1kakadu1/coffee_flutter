import 'dart:developer';
import 'dart:io';
import 'package:coffe_flutter/generated/l10n.dart';
import 'package:coffe_flutter/theme/theme_const.dart';
import 'package:coffe_flutter/widgets/buttons/btn_default.dart';
import 'package:coffe_flutter/widgets/snack.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadImgInFirebase extends StatefulWidget {
  final void Function(String value) onUploadSuccess;

  final String? path;
  const UploadImgInFirebase(
      {Key? key, required this.onUploadSuccess, this.path = 'images/users'})
      : super(key: key);

  @override
  State<UploadImgInFirebase> createState() => _UploadImgInFirebaseState();
}

class _UploadImgInFirebaseState extends State<UploadImgInFirebase> {
  late double _progress;
  late bool _isUploading;
  late String _error;

  @override
  void initState() {
    _progress = 0.0;
    _isUploading = false;
    _error = "";
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
        child: ButtonDefault(
          text: Text(
            _isUploading == false
                ? S.of(context).btnUpload
                : "${S.of(context).btnProgress} ${_progress.toStringAsFixed(0)}%",
            style: const TextStyle(color: AppColors.write),
          ),
          onPress: () {
            _openGallery(context);
          },
        ));
  }

  void _openGallery(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      await _uploadImg(image);
    } else {
      debugPrint("Error open gallery");
    }
  }

  Future<void> _uploadImg(
    XFile file,
  ) async {
    File largeFile = File(file.path);
    firebase_storage.UploadTask task = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('/${widget.path}/${file.name}')
        .putFile(largeFile);
    setState(() {
      _isUploading = true;
      _error = "";
    });
    task.snapshotEvents.listen((snapshot) {
      log("uploding: ${(snapshot.bytesTransferred.toDouble() / snapshot.totalBytes.toDouble()) * 100}");
      setState(() {
        _progress = ((snapshot.bytesTransferred.toDouble() /
                    snapshot.totalBytes.toDouble()) *
                100)
            .roundToDouble();
      });
    }, onError: (e) {
      String error = task.snapshot.toString();
      if (e.code == 'permission-denied') {
        error = 'User does not have permission to upload to this reference.';
      }
      setState(() {
        _error = error;
      });
      ScaffoldMessenger.of(context).showSnackBar(snackBar(error));
    });

    try {
      await task;
      setState(() {
        _isUploading = false;
        _progress = 0.0;
        _error = "";
      });
      final url = await task.snapshot.ref.getDownloadURL();
      widget.onUploadSuccess(url);
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        setState(() {
          _error = 'User does not have permission to upload to this reference.';
        });
        ScaffoldMessenger.of(context).showSnackBar(snackBar(
            'User does not have permission to upload to this reference.'));
      }
    }
  }
}
