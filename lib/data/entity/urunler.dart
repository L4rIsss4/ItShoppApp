class Urunler {
  String? urunID;
  String urunAdi;
  String urunFiyat;
  String urunAciklama;
  String urunKategori;
  String? urunResimUrl; // <-- EKLENDİ

  Urunler({
    this.urunID,
    this.urunResimUrl,
    required this.urunAdi,
    required this.urunKategori,
    required this.urunAciklama,
    required this.urunFiyat,
  });

  Map<String, dynamic> toJson() => {
    "urunID": urunID,
    "urunAdi": urunAdi,
    "urunKategori": urunKategori,
    "urunAciklama" : urunAciklama,
    "urunFiyat": urunFiyat,
    "urunResimUrl": urunResimUrl,

  };

  factory Urunler.fromJson(Map<String, dynamic> json, String id) {
    return Urunler(
      urunID: id,
      urunAdi: json["urunAdi"],
      urunFiyat: json["urunFiyat"],
      urunAciklama: json["urunAciklama"],
      urunKategori: json["urunKategori"],
      urunResimUrl: json["urunResimUrl"], // <-- EKLENDİ
    );
  }
}
