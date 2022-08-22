import 'dart:async';

import 'package:flutter/material.dart';

class SapiSaya extends StatelessWidget {
  const SapiSaya({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sapi Saya'),
        actions: [Icon(Icons.filter_list)],
      ),
      bottomNavigationBar: ElevatedButton(
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(
            Size(double.infinity, 60),
          ),
        ),
        onPressed: () {
          // TODO : navigate to add sapi form
          Navigator.pushNamed(context, '/');
        },
        child: Text('Tambah'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextFormField(
              onChanged: (text) {
                Timer? _debounce;
                if (_debounce?.isActive ?? false) _debounce?.cancel();
                _debounce = Timer(const Duration(milliseconds: 500), () {
                  // Do Search here
                });
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 12),
                fillColor: Color(0xffF6F6F6),
                isDense: true,
                filled: true,
                hintText: "Cari berdasarkan nama sapi, kode sapi ...",
                prefixIcon: Icon(
                  Icons.search,
                  size: 24,
                  color: Theme.of(context).primaryColor,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Color(0xffe8e8e8), width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Color(0xffe8e8e8), width: 1.0),
                ),
              ),
            ),
            Expanded(child: Center(child: Text('Not Found')))
          ],
        ),
      ),
    );
  }
}
