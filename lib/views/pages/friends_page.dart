import 'package:flutter/material.dart';

class FriendsPage extends StatelessWidget {
  const FriendsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Daftar Teman'),
      ),
      body: const Center(
        child: Text('Ini adalah halaman Daftar Teman'),
      ),
    );
  }
}
