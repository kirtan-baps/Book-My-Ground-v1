import 'package:flutter/material.dart';

class ListViewGenrated extends StatefulWidget {
  const ListViewGenrated({super.key});

  @override
  State<ListViewGenrated> createState() => _ListViewGenratedState();
}

class _ListViewGenratedState extends State<ListViewGenrated> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemCount: 80, itemBuilder: (context, index) => Text("KIK$index"));
  }
}
