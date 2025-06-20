import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itshop/data/repository/urunlerdao_repo.dart';
import '../../../data/entity/urunler.dart';

abstract class UrunState {}

class UrunInitial extends UrunState {}

class UrunlerEklendi extends UrunState {}

class UrunlerEklenemedi extends UrunState {}

class ArananUrunBulundu extends UrunState {
  final List<Urunler> urunlerListesi;

  ArananUrunBulundu(this.urunlerListesi);
}

class ArananUrunBulunamadi extends UrunState {}

class UrunlerListelendi extends UrunState {
  final List<Urunler> urunlerListesi;

  UrunlerListelendi(this.urunlerListesi);
}

class UrunlerListelenemedi extends UrunState {}

class UrunSilindi extends UrunState {}

class UrunSilinemedi extends UrunState {}

class ProductCubit extends Cubit<UrunState> {
  ProductCubit() : super(UrunInitial());

  final UrunRepo _urunler = UrunRepo();

  Future<void> urunleriListele() async {
    try {
      // getUrunler() bir Stream döndürüyor, ilk veriyi almak için .first kullanılır
      final urunlerListesi = await _urunler.getUrunler().first;
      emit(UrunlerListelendi(urunlerListesi));
    } catch (e) {
      emit(UrunlerListelenemedi());
      print("Ürün Listeleme Esnasında Hata oluştu : $e");
    }
  }

  Future<void> urunAra(String aranacakUrun) async {
    try {
      List<Urunler> bulunanlar = await _urunler.urunAra(aranacakUrun);
      if (bulunanlar.isNotEmpty) {
        emit(ArananUrunBulundu(bulunanlar));
      } else {
        emit(ArananUrunBulunamadi());
      }
    } catch (e) {
      emit(ArananUrunBulunamadi());
    }
  }
}
