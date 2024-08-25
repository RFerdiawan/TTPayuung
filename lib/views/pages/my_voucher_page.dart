import 'package:flutter/material.dart';

class MyVoucherPage extends StatelessWidget {
  const MyVoucherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Voucher Saya'),
      ),
      body: const Center(
        child: Text('Ini adalah halaman Voucher Saya'),
      ),
    );
  }
}
