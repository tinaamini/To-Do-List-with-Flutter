import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todolist_front/screens/home.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
        child:Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Image.asset('assets/images/Splash.jpg', fit: BoxFit.cover),
          ),
          SizedBox(height: 55),
          Text('To-Do List',
              style: TextStyle(
                  fontSize: 24, color: Color(0xFF774BF1), height: -4,fontWeight: FontWeight.w800,)),
          Text('Task Managment',
              style: TextStyle(
                  fontSize: 24, color: Color(0xFF774BF1), height: -1,fontWeight: FontWeight.w800,)),
          SizedBox(height: 55),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            // child: ClipPath(
            //   clipper: CurvedClipper(),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,MaterialPageRoute(builder:(context)=>Home())
                    );

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
                  )),
            ),
          // ),
        ],
      ),
    )));
  }
}

// class CurvedClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path = Path();
//     // شروع از گوشه بالا سمت چپ
//     path.lineTo(0, size.height - 12); // حرکت به پایین با فاصله قوس
//     path.quadraticBezierTo(
//       size.width / 2, size.height, // نقطه کنترل برای قوس پایین
//       size.width, size.height - 12, // پایان قوس پایین
//     );
//     path.lineTo(size.width, 12); // حرکت به بالا
//     path.quadraticBezierTo(
//       size.width / 2, 0, // نقطه کنترل برای قوس بالا
//       0, 10, // پایان قوس بالا
//     );
//     path.close(); // بستن مسیر
//     return path;
//   }
//
//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) {
//     return false; // فقط یک بار رسم شود
//   }
// }
