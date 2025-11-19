import 'package:flutter/material.dart';
import 'package:football_news/screens/news_entry_list.dart';
import 'package:football_news/screens/newslist_form.dart';
import 'package:football_news/screens/menu.dart';
import 'package:football_news/screens/login.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

// Item Card
class ItemCard extends StatelessWidget{
  // Menampilkan Kartu dengan nama dan Icon

  final ItemHomePage item;

  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context){
    final request = context.watch<CookieRequest>();
    return Material(
      // Warna Latar Belakang dari Tema Applikasi
      color: Theme.of(context).colorScheme.secondary,
      // Membuat Sudut Kartu Rounder
      borderRadius: BorderRadius.circular(12),

      child: InkWell(
        // Aksi Ketika Kartu dipencet
        onTap:() async{
          // Tampilkan Pesan SnackBar
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
                SnackBar(content: Text("Kamu telah menekan tombol ${item.name}!"),)
            );

          if (item.name == "Add News") {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsFormPage(),
                ));
          } else if (item.name == "See Football News"){
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsEntryListPage(),
                ));
          } else if (item.name == "Logout"){
            // TODO: Replace the URL with your app's URL and don't forget to add a trailing slash (/)!
            // To connect Android emulator with Django on localhost, use URL http://10.0.2.2/
            // If you using chrome,  use URL http://localhost:8000

            final response = await request.logout(
                "https://farrell-bagoes-footballnews.pbp.cs.ui.ac.id/auth/logout/");
            String message = response["message"];
            if (context.mounted) {
              if (response['status']) {
                String uname = response["username"];
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("$message See you again, $uname."),
                ));
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                  ),
                );
              }
            }
          }
        },

        // Container untuk menyimpan Text dan Icon
        child: Container(
          padding: const EdgeInsets.all(8),
          child:Center(
            child: Column(
              // Menyusun Ikon dan Teks di Tengah Kartu
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color : Colors.white),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}