import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itshop/data/repository/kisilerdao_repo.dart';

abstract class LoginState{}


class LoginInitial extends LoginState {}

class LoginAdmin extends LoginState{}

class LoginKullanici extends LoginState{}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {}



class LoginCubit extends Cubit<LoginState> {
  LoginCubit(): super(LoginInitial());

  final AuthRepository _repo = AuthRepository();

  Future<void> loginbyRole (String email , String sifre ) async
  {
    bool success = await _repo.loginUser(email, sifre);
    try {
      if (success) {
        String? role = await _repo.getuserRole();
        if (role == "admin") {
          emit (LoginAdmin());
        }
        else if (role == "kullanici"){
          emit(LoginKullanici());
        }
      }else{
        emit(LoginFailure());

      }
    } catch(e)
    {
      emit(LoginFailure());
      print("Girişte Bir hata oluştu : $e");
    }




  }
















}