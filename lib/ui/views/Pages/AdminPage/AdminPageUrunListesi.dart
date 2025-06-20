import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/adminPageCubit.dart';
import '../../viewUIsettings/viewUIsettings.dart';


class AdminPageView extends StatefulWidget {
  const AdminPageView({super.key});

  @override
  State<AdminPageView> createState() => _AdminPageViewState();
}

class _AdminPageViewState extends State<AdminPageView> {
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AdminPageCubit()..urunleriListele(),
      child: Scaffold(
        backgroundColor: mainThemeColor,
        appBar: AppBar(
          backgroundColor: mainThemeColor,
          title: isSearching
              ? TextField(
            style: TextStyle(color: mainWriteColor),
            decoration: InputDecoration(

              hintText: "Ara",
              hintStyle: TextStyle(color: mainWriteColor),
            ),
            onChanged: (aramaSonucu) {
              context.read<AdminPageCubit>().urunAra(aramaSonucu);
            },
          )
              : Text("Admin Sayfası", style: TextStyle(color: mainWriteColor , fontFamily: "Pacifico", fontSize: 20),),
          actions: [
            isSearching
                ? IconButton(
              onPressed: () {
                setState(() {
                  isSearching = false;
                });
                context.read<AdminPageCubit>().urunleriListele();
              },
              icon: const Icon(Icons.clear, color: Colors.white),
            )
                : IconButton(
              onPressed: () {
                setState(() {
                  isSearching = true;
                });
              },
              icon: const Icon(Icons.search, color: Colors.white),
            ),
          ],
        ),
        body: BlocBuilder<AdminPageCubit, AdminPageState>(
          builder: (context, state) {
            if (state is AdminPageInitial) {
              return Center(child: CircularProgressIndicator());
            } else if (state is AdminUrunleriListeledi || state is ArananUrunBulundu) {
              final urunler = state is AdminUrunleriListeledi
                  ? state.urunlerListesi
                  : (state as ArananUrunBulundu).urunlerListesi;

              return  ListView.builder(
                itemCount: urunler.length,
                itemBuilder: (context, index) {
                  final urun = urunler[index];

                  // Fiyat renkleri
                  Color fiyatRenk;
                  try {
                    final fiyat = double.parse(urun.urunFiyat);
                    if (fiyat >= 1000) {
                      fiyatRenk = Colors.redAccent;
                    } else if (fiyat >= 500) {
                      fiyatRenk = Colors.orangeAccent;
                    } else {
                      fiyatRenk = Colors.greenAccent;
                    }
                  } catch (e) {
                    fiyatRenk = Colors.grey;
                  }

                  return Card(
                    color: Colors.white10,
                    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child:Image.network(
                          urun.urunResimUrl ?? 'https://via.placeholder.com/60x60.png?text=YOK',
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        )

                      ),
                      title: Text(
                        urun.urunAdi,
                        style: TextStyle(
                          color: mainWriteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 6),
                          Text(
                            "Fiyat: ${urun.urunFiyat}₺",
                            style: TextStyle(color: fiyatRenk),
                          ),
                          Text(
                            "Kategori: ${urun.urunKategori}",
                            style: TextStyle(color: mainWriteColor.withOpacity(0.8)),
                          ),
                          Text(
                            "Açıklama: ${urun.urunAciklama}",
                            style: TextStyle(color: mainWriteColor.withOpacity(0.6)),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: secondaryThemeColor),
                        onPressed: () {
                          context.read<AdminPageCubit>().urunSil(urun);
                        },
                      ),
                      onTap: () {
                        // TODO: Ürün detay/düzenleme ekranına yönlendir
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => UrunDetaySayfasi(urun: urun)));
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("${urun.urunAdi} detayları açılacak (şimdilik geçici)"),
                          duration: Duration(seconds: 1),
                        ));
                      },
                    ),
                  );
                },
              );

            }
            return Center(child: Text("Bir şeyler ters gitti."));
          },
        ),
      ),
    );
  }
}

