import 'package:flutter/material.dart';
import 'package:itshop/ui/views/viewUIsettings/viewUIsettings.dart';

class AdminPasswordReset extends StatefulWidget {
  const AdminPasswordReset({super.key});

  @override
  State<AdminPasswordReset> createState() => _AdminPasswordResetState();
}

class _AdminPasswordResetState extends State<AdminPasswordReset> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: mainThemeColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: secondaryThemeColor),
        backgroundColor: mainThemeColor,
        title: Text("Admin Şifre Sıfırlama", style: TextStyle(color: mainWriteColor , fontFamily: "Pacifico",fontSize: 20),),
      ),


    );
  }
}
