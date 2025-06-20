
class Kullanicilar {
  String kullaniciID;
  String kullaniciAdi;
  String email;
  String kullaniciSoyadi;
  String? kullaniciFoto; // Kişi fotoğrafları entegre edilecek

  Kullanicilar({
    required this.kullaniciID,
    required this.kullaniciAdi,
    required this.kullaniciSoyadi,
    required this.email,
    this.kullaniciFoto
  });

  Map<String, dynamic> toJson() => {
    "kullaniciID": kullaniciID,
    "kullaniciAdi": kullaniciAdi,
    "email": email,
    "kullaniciSoyadi": kullaniciSoyadi,
    "kullaniciFoto" : kullaniciFoto
  };

  factory Kullanicilar.fromJson(Map<String, dynamic> json, String id) {
    return Kullanicilar(
      kullaniciID: id,
      kullaniciAdi: json["kullaniciAdi"],
      kullaniciSoyadi: json["kullaniciSoyadi"],
      email: json["email"],
      kullaniciFoto: json["kullaniciFoto"]
    );
  }
}
