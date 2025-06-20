import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import '../entity/urunler.dart';

class UrunRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;


  // Tüm ürünleri real-time stream olarak elde et
  Stream<List<Urunler>> getUrunler() {
    return _firestore
        .collection('urunler')
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => Urunler.fromJson(doc.data(), doc.id)).toList()
    );
  }

  // Yeni ürün ekle
  Future<void> addUrun(Urunler urun) async {
    await _firestore.collection('urunler').add(urun.toJson());
  }

  // Galeriden resim seç
  Future<File?> galeridenUrunResmiYukle() async {
    final picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.gallery);
    if (photo != null) {
      return File(photo.path);
    }
    return null;
  }
  // Seçilen resmi Storage'a yükle ve URL'yi döndür
  Future<String?> urunResmiYukleVeUrlGetir(File resimDosyasi) async {
    try {
      final String dosyaAdi = basename(resimDosyasi.path);
      final ref = _storage.ref().child("urun_resimleri").child(dosyaAdi);
      await ref.putFile(resimDosyasi);
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      print("Resim yükleme hatası: $e");
      return null;
    }
  }

  // Ürünü sil
  Future<void> deleteUrun(Urunler urun) async {
    try {
      await _firestore.collection('urunler').doc(urun.urunID).delete();
      print("Ürün başarıyla silindi.");
    } catch (e) {
      print("Ürün silinirken hata oluştu: $e");
    }
  }

  // Ürün ara
  Future<List<Urunler>> urunAra(String aranacakUrun) async {
    try {
      final querySnapshot = await _firestore
          .collection('urunler')
          .where('urunAdi', arrayContains: aranacakUrun.toLowerCase())
          .get();

      return querySnapshot.docs
          .map((doc) => Urunler.fromJson(doc.data(), doc.id))
          .toList();

    } catch (e) {
      print("Arama hatasında hata: $e");
      rethrow;
    }
  }
  Future<String?> cloudinaryUpload(File imageFile) async {
    // Cloudinary hesabındaki bilgiler
    const String cloudName = 'dtknplf8p';
    const String uploadPreset = 'ItShopApp';

    // Cloudinary API URL
    final Uri url = Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');

    try {
      // Multipart istek oluşturuluyor
      final request = http.MultipartRequest('POST', url)
        ..fields['upload_preset'] = uploadPreset
        ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

      // İstek gönderiliyor
      final response = await request.send();

      if (response.statusCode == 200) {
        // Başarılı yanıt alındıysa JSON verisi çekilir
        final resData = await http.Response.fromStream(response);
        final data = json.decode(resData.body);
        return data['secure_url']; // Yüklenen resmin URL'si
      } else {
        print(' Yükleme başarısız: HTTP ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print(' Hata oluştu: $e');
      return null;
    }
  }















}
