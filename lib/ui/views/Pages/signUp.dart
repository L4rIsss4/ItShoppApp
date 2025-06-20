import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itshop/ui/views/Pages/login.dart';
import 'package:itshop/ui/views/viewUIsettings/signButtons.dart';
import 'package:itshop/ui/views/viewUIsettings/viewUIsettings.dart';

import '../cubit/signUpCubit.dart';

class signUp extends StatefulWidget {
  const signUp({super.key});

  @override
  State<signUp> createState() => _signUpState();
}

class _signUpState extends State<signUp> {

  final TextEditingController _sifresignController = TextEditingController();
  final TextEditingController _kullanicisignadiController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.sizeOf(context).width;
    final double deviceHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: darkTheme,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Kayıt Ekranı",
          style: TextStyle(color: mainWriteColor, fontFamily: "Pacifico"),
        ),
        backgroundColor: mainThemeColor,
      ),
      body: BlocListener<SignUpCubit, SignUpState>(
        listener: (context, state) {
          if (state is SignUpSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Kayıt başarılı! Giriş Sayfasına Yönlendiriliyorsunuz.")),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Login()),
            );
          } else if (state is SignUpFailure) {
            // Hata durumunda
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Kayıt başarısız!")),
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
              controller: _kullanicisignadiController,
              anaYaziRengi: mainWriteColor,
              borderColor: secondaryThemeColor,
            ),
            SignTextField(
              labelText: "Şifre",
              hintText: "",
              controller: _sifresignController,
              anaYaziRengi: mainWriteColor,
              borderColor: secondaryThemeColor,
            ),
            ElevatedButton(
              onPressed: () {
                context.read<SignUpCubit>().signUp(
                  _kullanicisignadiController.text.trim(), // ad
                  "Soyad", // soyad (isterse TextField oluşturabilir)
                  _kullanicisignadiController.text.trim(), // email
                  _sifresignController.text.trim(), // şifre
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
              child: Text("Kayıt Ol", style: TextStyle(color: mainThemeColor)),
            )
          ],
        ),
      ),
    );

  }
}
