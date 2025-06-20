import 'package:flutter/material.dart';
import 'package:itshop/ui/views/viewUIsettings/viewUIsettings.dart';

class AdminPhotoChange extends StatefulWidget {
  const AdminPhotoChange({super.key});

  @override
  State<AdminPhotoChange> createState() => _AdminPhotoChangeState();
}

class _AdminPhotoChangeState extends State<AdminPhotoChange> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainThemeColor,
      appBar: AppBar(
        backgroundColor: mainThemeColor,
        iconTheme: IconThemeData(color: secondaryThemeColor),
        centerTitle: true,
        title: Text("Fotoğraf Değiştirme Sayfası",style: TextStyle(color: mainWriteColor , fontFamily: "Pacifico", fontSize: 20),),
      ),
    );
  }
}
