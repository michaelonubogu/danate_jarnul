import 'package:dante/Core/AppRoutes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title:
            Center(
              child: Text(
          "dante",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
            ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.center,
            children: [Container(),
              const SizedBox(height: 200.0),

              Text(
                "Coming Soon....",
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
