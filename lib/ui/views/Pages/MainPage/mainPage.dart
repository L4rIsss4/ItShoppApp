import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/mainPageCubit.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductCubit()..urunleriListele(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Ürünler"),
          backgroundColor: Colors.deepPurple,
        ),
        body: BlocBuilder<ProductCubit, UrunState>(
          builder: (context, state) {
            if (state is UrunInitial) {
              return Center(child: CircularProgressIndicator());
            } else if (state is UrunlerListelenemedi) {
              return Center(child: Text("Ürünler yüklenemedi."));
            } else if (state is UrunlerListelendi) {
              final urunlerListesi = state.urunlerListesi;

              if (urunlerListesi.isEmpty) {
                return Center(child: Text("Hiç ürün yok."));
              }

              return GridView.builder(
                padding: const EdgeInsets.all(12),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.7,
                ),
                itemCount: urunlerListesi.length,
                itemBuilder: (context, index) {
                  final urun = urunlerListesi[index];

                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Ürün fotoğrafı - yerine ağdan gelen URL varsa onu koyarsın
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                          child: Image.network(
                           'https://via.placeholder.com/150',
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                urun.urunAdi,
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4),
                              Text(
                                urun.urunAciklama,
                                style: TextStyle(fontSize: 13),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );

                },
              );
            } else {
              return Center(child: Text("Bilinmeyen durum."));
            }
          },
        ),
      ),
    );
  }
}
