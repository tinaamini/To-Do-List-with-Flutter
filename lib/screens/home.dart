import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Text(
              'Home',
              style: TextStyle(
                fontSize: 19,
                color: Color(0xFF000000),
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Spacer(), // فضای خالی دینامیک
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0), // فاصله از پایین
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Home()));
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                minimumSize: Size(331.0, 54.0),
                backgroundColor: Color(0xFF774BF1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(20)), // تنظیم شعاع گردی
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      "Let's Start",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1),
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/svg/ArrowLeft.svg',
                    width: 24,
                    height: 24,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
