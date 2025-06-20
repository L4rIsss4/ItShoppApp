import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itshop/ui/views/cubit/loginCubit.dart';
import 'package:itshop/ui/views/Pages/MainPage/mainPage.dart';
import 'package:itshop/ui/views/Pages/resetpassword.dart';
import 'package:itshop/ui/views/Pages/signUp.dart';
import 'package:itshop/ui/views/viewUIsettings/signButtons.dart';
import 'package:itshop/ui/views/viewUIsettings/viewUIsettings.dart';

import 'AdminPage/AdminPageGnav.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _sifreController = TextEditingController();
  final TextEditingController _kullaniciadiController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.sizeOf(context).width;
    final double deviceHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: darkTheme,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Giriş Ekranı",
          style: TextStyle(
            color: mainWriteColor,
            fontFamily: "Pacifico",
            fontSize: 25,
          ),
        ),
        backgroundColor: mainThemeColor,
      ),

      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginKullanici) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MainPage()),
            );
          } else if (state is LoginAdmin) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => AdminPageGnav()),
            );
          } else if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Giriş başarısız. E-Posta veya şifre hatalı.")),
            );
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: deviceWidth / 3,
              height: deviceHeight / 4,
              child: Image.asset("assets/images/icons8-login-100.png"),
            ),
            SignTextField(
              labelText: "E-Posta ",
              hintText: "",
              controller: _kullaniciadiController,
              anaYaziRengi: mainWriteColor,
              borderColor: secondaryThemeColor,
            ),
            SignTextField(
              labelText: "Şifre",
              hintText: "",
              controller: _sifreController,
              anaYaziRengi: mainWriteColor,
              borderColor: secondaryThemeColor,
            ),
            ElevatedButton(
              onPressed: () {
                context.read<LoginCubit>().loginbyRole(
                    _kullaniciadiController.text.trim(),
                    _sifreController.text.trim()
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: secondaryThemeColor,
                foregroundColor: mainThemeColor,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(color: mainThemeColor, width: 1),
                ),
              ),
              child: Text("Giriş Yap", style: TextStyle(color: mainThemeColor)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Hesabınız Mı Yok?", style: TextStyle(color: mainWriteColor, fontFamily: "Pacifico", fontSize: 15)),
                TextButton(onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => signUp()),
                  );
                },
                    child: Text("Kayıt Olun", style: TextStyle(color: mainWriteColor))),



              ],
            ),
            TextButton(onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ResetPassword()),
              );
            },
                child: Text("Şifrenizi mi Unuttunuz?", style: TextStyle(color: mainWriteColor , fontSize: 12))),

          ],
        ),
      ),
    );
  }
}
