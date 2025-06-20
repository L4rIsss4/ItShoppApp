import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itshop/ui/views/Pages/AdminPage/AdminProfilePhotoPage.dart';
import 'package:itshop/ui/views/Pages/AdminPage/AdminResetPassword.dart';
import '../../cubit/signUpCubit.dart';
import '../../viewUIsettings/viewUIsettings.dart';
import '../login.dart';

class AdminProfil extends StatefulWidget {
  const AdminProfil({super.key});

  @override
  State<AdminProfil> createState() => _AdminProfilState();
}

class _AdminProfilState extends State<AdminProfil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainThemeColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: secondaryThemeColor),
        backgroundColor: mainThemeColor,
        title: Text("Admin Profili", style: TextStyle(color: mainWriteColor, fontFamily: "Pacifico", fontSize: 20),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: secondaryThemeColor.withValues(alpha: 0.2),
                child: Icon(Icons.person, size: 60, color: secondaryThemeColor),
              ),
            ),
            Divider(color: Colors.white24,),
            const SizedBox(height: 50),
            Divider(color: Colors.white24,),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.white),
              title: Text("Profil Fotoğrafını Güncelle", style: TextStyle(color: Colors.white)),
              trailing: Icon(Icons.chevron_right, color: Colors.white),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminPhotoChange()));
              },
            ),
            Divider(color: Colors.white24),
            ListTile(
              leading: Icon(Icons.lock, color: Colors.white),
              title: Text(
                "Şifre Değiştir",
                style: TextStyle(color: Colors.white),
              ),
              trailing: Icon(Icons.chevron_right, color: Colors.white),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminPasswordReset()));
              },
            ),
            Divider(color: Colors.white24),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.redAccent),
              title: Text(
                "Çıkış Yap",
                style: TextStyle(color: Colors.redAccent),
              ),
              onTap: () async {
                await context.read<SignUpCubit>().signOut();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
