import 'package:flutter/material.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Daftar Transaksi'),
      ),
      body: const Center(
        child: Text('Ini adalah halaman Daftar Transaksi'),
      ),
    );
  }
}
