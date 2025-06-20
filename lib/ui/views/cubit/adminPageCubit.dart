import 'dart:async';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/entity/urunler.dart';
import '../../../data/repository/urunlerdao_repo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class AdminPageState{}

class AdminPageInitial extends AdminPageState{}

class AdminUrunleriListeledi extends AdminPageState{
  final List<Urunler> urunlerListesi;
  AdminUrunleriListeledi(this.urunlerListesi);
}

class ArananUrunBulundu extends AdminPageState {
  final List<Urunler> urunlerListesi;

  ArananUrunBulundu(this.urunlerListesi);
}

class AdminPageCubit extends Cubit<AdminPageState> {
  AdminPageCubit() : super(AdminPageInitial());

  final UrunRepo _urunler = UrunRepo();

  StreamSubscription<List<Urunler>>? _urunlerSubscription;

  void urunleriListele() {
    _urunlerSubscription = _urunler.getUrunler().listen((urunListesi) {
      emit(AdminUrunleriListeledi(urunListesi));
    });
  }

  Future<void> urunEkle(Urunler urun ,File? resimDosyasi) async {
    if (resimDosyasi != null) {
      final resimUrl = await _urunler.urunResmiYukleVeUrlGetir(resimDosyasi);
      if (resimUrl != null) {
        urun.urunResimUrl = resimUrl;
      }
    }
    await _urunler.addUrun(urun);
    // Stream zaten real-time, ayrıca refresh yapmana gerek kalmadı
  }

  Future<void> urunSil(Urunler urun) async {
    await _urunler.deleteUrun(urun);
    // Stream zaten real-time, ayrıca refresh yapmana gerek kalmadı
  }

  Future<void> urunAra(String aranacakUrun) async {
    List<Urunler> bulunanlar = await _urunler.urunAra(aranacakUrun);
    emit(ArananUrunBulundu(bulunanlar));
  }

  @override
  Future<void> close() async {
    await _urunlerSubscription?.cancel();
    return super.close();
  }

  Future<void> urunEkleCloudinary(Urunler urun, File? resimDosyasi) async {
    if (resimDosyasi != null) {
      final resimUrl = await _urunler.cloudinaryUpload(resimDosyasi);
      if (resimUrl != null) {
        urun.urunResimUrl = resimUrl;
      } else {
        print("Cloudinary yükleme başarısız.");
      }
    }
    await _urunler.addUrun(urun);
  }



  //CLOUDINARY_URL=cloudinary://<465621352317798>:<jHsbkMJMQVj2tdoOMjyAG4cgvIw>@dtknplf8p


}
