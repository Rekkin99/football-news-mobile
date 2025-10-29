import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final String nama = "Farrell Bagoes Rahmantyo"; //nama
  final String npm = "2406420596"; //npm
  final String kelas = "E"; //kelas

  final List<ItemHomePage> items = [
    ItemHomePage("See Football News", Icons.newspaper),
    ItemHomePage("Add News", Icons.add),
    ItemHomePage("Logout", Icons.logout),
  ];

  @override
  Widget build(BuildContext context){
    // Scaffold Menyediakan Struktur Dasar AppBar dan Body
    return Scaffold(
      // Appbar : bagian atas halaman yang menampilkan judul
      appBar: AppBar(
        title: const Text(
          'Football News',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        // Warna BG App
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      // Body Halaman dengan padding di sekililingnya
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        // Menyusun Widget Secara Vertikal dalam sebuah Kolom
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // Row untuk menampilkan 3 InfoCard secara Horizontal
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InfoCard(title: 'NPM', content: npm),
                InfoCard(title: 'Name', content: nama),
                InfoCard(title: 'Class', content: kelas),
              ],
            ),
            // Memberikan Jarak Vertikal
            const SizedBox(height: 16.0,),
            // Menempatkan Widget Berikutnya di tengah halaman
            Center(
              child: Column(
                // Menyusun teks dan grid secara vertikal
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top:16.0),
                    child: Text(
                      'Selamat Datang di Football News',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                    ),
                  ),

                  // Grid untuk menampilkan ItemCard dalam bentuk grid 3 kolom.
                  GridView.count(
                    primary: true,
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 3,
                    // Agar grid menyesuaikan tinggi kontennya.
                    shrinkWrap: true,

                    // Menampilkan ItemCard untuk setiap item dalam list items.
                    children: items.map(
                        (ItemHomePage item) {
                          return ItemCard(item);
                        }
                    ).toList(),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// Info Card
class InfoCard extends StatelessWidget{

  final String title;
  final String content;

  const InfoCard({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      // Membuat Card dengan bayangan di bawah
      elevation: 2.0,
      child: Container(
        // Mengatur Jarak dan Ukuran Kartu
        width: MediaQuery.of(context).size.width/3,
        padding: const EdgeInsets.all(16.0),
        // Menyusun title dan Content secara Vertical
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),

      ),

    );
  }
}

// Item Home Page
class ItemHomePage {
  final String name;
  final IconData icon;
  ItemHomePage(this.name, this.icon);
}

// Item Card
class ItemCard extends StatelessWidget{
  // Menampilkan Kartu dengan nama dan Icon

  final ItemHomePage item;

  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context){
    return Material(
      // Warna Latar Belakang dari Tema Applikasi
      color: Theme.of(context).colorScheme.secondary,
      // Membuat Sudut Kartu Rounder
      borderRadius: BorderRadius.circular(12),

      child: InkWell(
        // Aksi Ketika Kartu dipencet
        onTap:(){
          // Tampilkan Pesan SnackBar
          ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(content: Text("Kamu telah menekan tombol ${item.name}!"),)
              );
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