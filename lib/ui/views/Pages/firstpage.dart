import 'package:flutter/material.dart';
import 'package:itshop/ui/views/Pages/login.dart';
import 'package:itshop/ui/views/viewUIsettings/viewUIsettings.dart';

class firstPage extends StatefulWidget {
  const firstPage({super.key});

  @override
  State<firstPage> createState() => _firstPageState();
}

class _firstPageState extends State<firstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkTheme,
      appBar: AppBar(
        backgroundColor: mainThemeColor,
        title: Text(
          "Hoşgeldiniz!",
          style: TextStyle(
            color: mainWriteColor,
            fontFamily: "Pacifico",
            fontSize: 30,
          ),
        ),
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              verticalDirection: VerticalDirection.down,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset("assets/images/bigpcshopicon.png"),

                Text(
                  "Benim Mağazam",
                  style: TextStyle(
                    color: mainWriteColor,
                    fontSize: 30,
                    fontFamily: "Pacifico",
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: mainThemeColor,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              side: BorderSide(color: Colors.white, width: 2),
              shadowColor: Colors.black,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              overlayColor: mainThemeColor,
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
            child: Text(
              "Devam Etmek İçin Tıklayınız.",
              style: TextStyle(
                color: mainWriteColor,
                fontFamily: "NotoSerif",
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
