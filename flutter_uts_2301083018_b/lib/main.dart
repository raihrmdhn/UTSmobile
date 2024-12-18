import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'APLIKASI Peminjaman',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: const Color.fromARGB(255, 33, 243, 65)),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              title: Text('Peminjaman'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PeminjamanInputScreen()),
                );
              },
            ),
            ListTile(
              title: Text('Tentang'),
              onTap: () {
                Navigator.pop(context); 
              },
            ),
          ],
        ),
      ),
      body: Center(child: Text('Selamat Datang di Aplikasi Peminjaman')),
    );
  }
}

class Peminjaman {
  final String kode;
  final String nama;
  final String kodePeminjaman;
  final DateTime tanggal;
  final String kodeNasabah;
  final String namaNasabah;
  final double jumlahPinjaman;
  final int lamaPinjaman; 
  final double bunga; 

  Peminjaman({
    required this.kode,
    required this.nama,
    required this.kodePeminjaman,
    required this.tanggal,
    required this.kodeNasabah,
    required this.namaNasabah,
    required this.jumlahPinjaman,
    required this.lamaPinjaman,
  }) : bunga = 12.0; 

  double get angsuranPokok => jumlahPinjaman / lamaPinjaman;

  double get totalBunga => (jumlahPinjaman * (bunga / 100));

  double get bungaPerBulan => totalBunga / lamaPinjaman;

  double get angsuranPerBulan => angsuranPokok + bungaPerBulan;

  double get totalHutang => jumlahPinjaman + totalBunga;
}

class PeminjamanInputScreen extends StatefulWidget {
  @override
  _PeminjamanInputScreenState createState() => _PeminjamanInputScreenState();
}

class _PeminjamanInputScreenState extends State<PeminjamanInputScreen> {
  final TextEditingController _kodeController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _kodePeminjamanController = TextEditingController();
  final TextEditingController _kodeNasabahController = TextEditingController();
  final TextEditingController _namaNasabahController = TextEditingController();
  final TextEditingController _jumlahPinjamanController = TextEditingController();
  final TextEditingController _lamaPinjamanController = TextEditingController();

  void _showResult() {
    final peminjaman = Peminjaman(
      kode: _kodeController.text,
      nama: _namaController.text,
      kodePeminjaman: _kodePeminjamanController.text,
      tanggal: DateTime.now(),
      kodeNasabah: _kodeNasabahController.text,
      namaNasabah: _namaNasabahController.text,
      jumlahPinjaman: double.parse(_jumlahPinjamanController.text),
      lamaPinjaman: int.parse(_lamaPinjamanController.text),
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Detail Peminjaman'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Jumlah Pinjaman: ${peminjaman.jumlahPinjaman.toStringAsFixed(2)}'),
            Text('Lama Pinjaman: ${peminjaman.lamaPinjaman} bulan'),
            Text('Bunga: ${peminjaman.bunga} %'),
            Text('Angsuran Pokok: ${peminjaman.angsuranPokok.toStringAsFixed(2)}'),
            Text('Bunga Per Bulan: ${peminjaman.bungaPerBulan.toStringAsFixed(2)}'),
            Text('Angsuran Per Bulan: ${peminjaman.angsuranPerBulan.toStringAsFixed(2)}'),
            Text('Total Hutang: ${peminjaman.totalHutang.toStringAsFixed(2)}'),
          ],
        ),
        actions: [
          TextButton(
            child: Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Input Peminjaman')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _kodeController,
              decoration: InputDecoration(labelText: 'Kode'),
            ),
            TextField(
              controller: _namaController,
              decoration: InputDecoration(labelText: 'Nama'),
            ),
            TextField(
              controller: _kodePeminjamanController,
              decoration: InputDecoration(labelText: 'Kode Peminjaman'),
            ),
            TextField(
              controller: _kodeNasabahController,
              decoration: InputDecoration(labelText: 'Kode Nasabah'),
            ),
            TextField(
              controller: _namaNasabahController,
              decoration: InputDecoration(labelText: 'Nama Nasabah'),
            ),
            TextField(
              controller: _jumlahPinjamanController,
              decoration: InputDecoration(labelText: 'Jumlah Pinjaman'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _lamaPinjamanController,
              decoration: InputDecoration(labelText: 'Lama Pinjaman (bulan)'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _showResult,
              child: Text('Hitung'),
            ),
          ],
        ),
      ),
    );
  }
}
