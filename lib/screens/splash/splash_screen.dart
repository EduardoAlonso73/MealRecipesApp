import 'package:flutter/material.dart';

import '../../utils/app_route.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFFE9635),
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          Center(
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: -0.6, end: 0.0),
              duration: const Duration(milliseconds: 2000),
              curve: Curves.easeInOut,
              onEnd: () {
                Navigator.pushReplacementNamed(context, AppRoute.home.route);
              },
              builder: (BuildContext context, double value, Widget? child) {
                return Transform.translate(
                  offset: Offset(0, MediaQuery.of(context).size.height * value),
                  child: Image.asset(
                    'assets/ic_app.png',
                    fit: BoxFit.none,
                  ),
                );
              },
            ),
          ),
          // Indicador de progreso en bottomCenter
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              // espacio desde abajo
              child: SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeCap: StrokeCap.round,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
