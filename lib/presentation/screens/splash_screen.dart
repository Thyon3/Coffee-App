import 'package:coffe_app_ui/presentation/widgets/common_button.dart';
import 'package:coffe_app_ui/presentation/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/splash_screen.png',
                fit: BoxFit.cover,
                height: size.height * 0.6,
              ),
            ),
            Positioned(
              top: MediaQuery.sizeOf(context).height * 0.7,
              left: 100,
              right: 60,
              child: Text(
                'Fall In Love With Coffee',
                style: GoogleFonts.bungee(
                  textStyle: const TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.sizeOf(context).height * 0.01,
        ),
        child: CommonButton(
          title: 'Get Started',
          onTap: () => context.go(AppRoutes.main),
        ),
      ),
    );
  }
}
