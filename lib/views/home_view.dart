import 'package:estate_app/widgets/input.dart';
import 'package:estate_app/widgets/txt.dart';
import 'package:flutter/material.dart';
import 'estate_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Txt('home page')),
      body: Column(
        children: const [
          Input(),
          Expanded(child: Estateview()),
        ],
      ),
    );
  }
}
