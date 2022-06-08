import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';


class WidgetsViewModel with ChangeNotifier{

  bool _circular = false;
  bool get circular => _circular;

  void setCircular(bool circular){
    _circular = circular;
    notifyListeners();
  }

  String _userManager = "User";
  String get userManager => _userManager;

  void setUserManager(String userManager){
    _userManager = userManager;
    notifyListeners();
  }

  File? _imageFile;
  File? get imageFile => _imageFile;

  void selectGalleryImage() async {
    image = await _picker.pickImage(source: ImageSource.gallery);
    _imageFile = File(image!.path);
    notifyListeners();
  }

  String? _imageUrlDownload;
  String? get imageUrlDownload => _imageUrlDownload;

  XFile? image;
  ImagePicker _picker = ImagePicker();
  Reference? task;

  Future uploadImage(BuildContext context) async {

    String imageName = basename(_imageFile!.path);


    final destination = 'users/images/$imageName';
    task = FirebaseStorage.instance.ref(destination);

    if(imageFile == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Please Upload your Picture")));
    }

    await task!.putFile(File(imageFile!.path));
    _imageUrlDownload = await task!.getDownloadURL();
    print('Download-link: $imageUrlDownload');
  }

  int _toggleButton = 0;
  int get toggleButton => _toggleButton;

  void setToggleButton(int toggleButton){
    _toggleButton = toggleButton;
    notifyListeners();
  }

  String _selectedStartDate = "";
  String? get selectedStartDate => _selectedStartDate;

  void setStartDate(DateTime selectedStartDate){
    String formattedDate = DateFormat('dd-MMM-yyyy').format(selectedStartDate);
    _selectedStartDate = formattedDate;
    notifyListeners();
  }

  String _selectedEndDate = "";
  String? get selectedEndDate => _selectedEndDate;

  void setEndDate(DateTime selectedEndDate){
    String formattedDate = DateFormat('dd-MMM-yyyy').format(selectedEndDate);
    _selectedEndDate = formattedDate;
    notifyListeners();
  }

  String _selectUser = "";
  String get selectUser => _selectUser;

  void setSelectUser(String selectUser){
    _selectUser = selectUser;
    notifyListeners();
  }

  String _selectPriority = "Low";
  String get selectPriority => _selectPriority;

  void setPriority(String selectPriority){
    _selectPriority = selectPriority;
    notifyListeners();
  }

  File? _file;
  File? get file => _file;

  void filePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
       _file = File(result.files.single.path!);
    } else {
      // User canceled the picker
    }
    notifyListeners();
  }


  String? _fileUrlDownload;
  String? get fileUrlDownload => _fileUrlDownload;
  Reference? task2;

  Future uploadFile(BuildContext context) async {
    String fileName = basename(_file!.path);
    final destination = 'users/files/$fileName';
    task2 = FirebaseStorage.instance.ref(destination);
    if(_file == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Please Upload your file")));
    }
    await task2!.putFile(File(_imageFile!.path));
    _fileUrlDownload = await task2!.getDownloadURL();
    print('Download-link: $imageUrlDownload');
  }


  int _bottomNavIndex = 0;
  int get bottomNavIndex => _bottomNavIndex;

  void setBottomNav(int bottomNavIndex){
    _bottomNavIndex = bottomNavIndex;
    notifyListeners();
  }

  Stream<QuerySnapshot>? _chatMessageStream;
  Stream<QuerySnapshot>? get chatMessageStream => _chatMessageStream;

  void setChatStream(Stream<QuerySnapshot> chatMessageStream){
    _chatMessageStream = chatMessageStream;
    notifyListeners();
  }



}