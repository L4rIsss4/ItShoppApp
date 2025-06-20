import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itshop/data/entity/kisiler.dart';
import 'package:itshop/data/repository/kisilerdao_repo.dart';

abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpSuccess extends SignUpState {}

class SignUpFailure extends SignUpState {}

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());
  final AuthRepository _repo = AuthRepository();

  Future<void> signUp(
    String ad,
    String soyad,
    String email,
    String sifre,
  ) async {
    try {
      Kullanicilar yeniKullanici = Kullanicilar(
        kullaniciID: "",
        kullaniciAdi: ad,
        kullaniciSoyadi: soyad,
        email: email,
      );
      await _repo.signUpUser(yeniKullanici, sifre);
      emit(SignUpSuccess());
    } catch (e) {
      emit(SignUpFailure());
      print("Giriş Esnasında Hata oluştu : $e" );
    }
  }


  Future <void> signOut() async{
    await _repo.signOut();
  }









}
