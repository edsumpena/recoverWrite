import 'package:flutter/material.dart';

class BuildPage extends StatelessWidget {


  final String urlImage;
  final String title;
  final String subtitle;

  const BuildPage({ required this.urlImage,required this.title, required this.subtitle });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Image.asset(
            urlImage,
            width: 250,
            height: 200,
          ),

          SizedBox(height: height * 0.05),

          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xff4e1dc2),
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: height * 0.05),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 17,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    ); }}