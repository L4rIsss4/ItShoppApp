import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/entity/urunler.dart';
import '../../cubit/adminPageCubit.dart';
import '../../viewUIsettings/signButtons.dart';
import '../../viewUIsettings/viewUIsettings.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';


class AdminNewUrun extends StatefulWidget {
  const AdminNewUrun({super.key});

  @override
  State<AdminNewUrun> createState() => _AdminNewUrunState();
}

class _AdminNewUrunState extends State<AdminNewUrun> {
  bool isSearching = false;
  final TextEditingController _UrunAdi = TextEditingController();
  final TextEditingController _UrunAciklama = TextEditingController();
  final TextEditingController _UrunFiyat = TextEditingController();
  final TextEditingController _UrunKategori = TextEditingController();
  File? _secilenResim;


  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: mainThemeColor,
      appBar: AppBar(
        backgroundColor: mainThemeColor,
        centerTitle: true,
        title: Text("Ürün Ekleme", style: TextStyle(color: mainWriteColor , fontFamily: "Pacifico", fontSize: 20)
          ,)
      ),
      body: ListView(
        padding: EdgeInsets.all(8),
        children: [
          ListTile(
            title: Text("Ürün Adı", style: TextStyle(color: mainWriteColor)),
            subtitle: TextField(
              controller: _UrunAdi,
              style: TextStyle(color: mainWriteColor),
              decoration: InputDecoration(

                hintStyle: TextStyle(color: Colors.white54),
                border: UnderlineInputBorder(),
              ),
            ),
          ),
          ListTile(
            title: Text("Ürün Açıklama", style: TextStyle(color: mainWriteColor)),
            subtitle: TextField(
              controller: _UrunAciklama,
              style: TextStyle(color: mainWriteColor),
              decoration: InputDecoration(

                hintStyle: TextStyle(color: Colors.white54),
                border: UnderlineInputBorder(),
              ),
            ),
          ),
          ListTile(
            title: Text("Ürün Fiyat", style: TextStyle(color: mainWriteColor)),
            subtitle: TextField(
              controller: _UrunFiyat,
              style: TextStyle(color: mainWriteColor),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.white54),
                border: UnderlineInputBorder(),
              ),
            ),
          ),
          ListTile(
            title: Text("Ürün Kategorisi (Telefon,Televizyon.. vb)", style: TextStyle(color: mainWriteColor)),
            subtitle: TextField(
              controller: _UrunKategori,
              style: TextStyle(color: mainWriteColor),
              decoration: InputDecoration(

                hintStyle: TextStyle(color: Colors.white54),
                border: UnderlineInputBorder(),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.image, color: secondaryThemeColor),
            title: Text("Resim Seç", style: TextStyle(color: secondaryThemeColor)),
            tileColor: Colors.transparent,
            onTap: () async {
              final picker = ImagePicker();
              final XFile? photo =
              await picker.pickImage(source: ImageSource.gallery);
              if (photo != null) {
                setState(() {
                  _secilenResim = File(photo.path);
                });
              }
            },
          ),
          if (_secilenResim != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    _secilenResim!,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
          else
            ListTile(
              title: Text(
                "Henüz resim seçilmedi.",
                style: TextStyle(color: mainWriteColor.withOpacity(0.6)),
                textAlign: TextAlign.center,
              ),
            ),
          Padding(
            padding: EdgeInsets.only(top: deviceHeight / 40),
            child: ListTile(
              title: ElevatedButton.icon(
                onPressed: () {
                  final urunAdi = _UrunAdi.text.trim();
                  final urunAciklama = _UrunAciklama.text.trim();
                  final urunKategori = _UrunKategori.text.trim();
                  final fiyat = _UrunFiyat.text.trim();

                  if (urunAdi.isNotEmpty && _secilenResim != null) {
                    final yeniUrun = Urunler(
                      urunAdi: urunAdi,
                      urunAciklama: urunAciklama,
                      urunKategori: urunKategori,
                      urunFiyat: fiyat,
                    );

                    context.read<AdminPageCubit>().urunEkleCloudinary(yeniUrun, _secilenResim);
                    context.read<AdminPageCubit>().urunleriListele();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Ürün başarıyla eklendi")),
                    );

                    setState(() {
                      _UrunAdi.clear();
                      _UrunAciklama.clear();
                      _UrunFiyat.clear();
                      _UrunKategori.clear();
                      _secilenResim = null;
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Lütfen tüm alanları ve resmi doldurun.")),
                    );
                  }
                },
                icon: Icon(Icons.save, color: mainWriteColor),
                label: Text("Kaydet", style: TextStyle(color: mainWriteColor)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.only(top: 3 , right: 20 , left: 20 , bottom : 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
