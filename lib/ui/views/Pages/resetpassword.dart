import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itshop/ui/views/viewUIsettings/signButtons.dart';
import 'package:itshop/ui/views/viewUIsettings/viewUIsettings.dart';

import '../cubit/resetpasswordCubit.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController _mailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.sizeOf(context).width;
    final double deviceHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: darkTheme,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Şifre Sıfırlama",
          style: TextStyle(
            color: mainWriteColor,
            fontFamily: "Pacifico",
            fontSize: 25,
          ),
        ),
        backgroundColor: mainThemeColor,
      ),

      body: BlocListener<PasswordResetCubit, PasswordReset>(
        listener: (context, state) {
          if (state is PasswordResetEmailSended) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Bağlantı Gönderildi.")),
            );
          } else if (state is PasswordResetEmaiNotFounded) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Girilen Mail İle Bağlantılı Hesap Bulunamadı")),
            );
          } else  {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Bir Hata Oluştu.")),
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
              labelText: "Şifrenizi Göndermek İstediğiniz E posta: ",
              hintText: "",
              controller: _mailController,
              anaYaziRengi: mainWriteColor,
              borderColor: secondaryThemeColor,
            ),
            ElevatedButton(
              onPressed: () {
                context.read<PasswordResetCubit>().sendPasswordResetEmail(

                  _mailController.text.trim(),

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
              child: Text("Gönder ", style: TextStyle(color: mainThemeColor)),
            ),
          ],
        ),
      ),
    );
  }
}
