import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cari Kebutuhanmu'),
      ),
      body: const Center(
        child: Text('Ini adalah halaman Search'),
      ),
    );
  }
}
