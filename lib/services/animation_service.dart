import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'dart:math';

class AnimationService {
  static Widget buildSnowAnimation() {
    return Stack(
      children: List.generate(20, (index) {
        final random = Random();
        final startPosition = random.nextDouble() * 400;
        final duration = Duration(seconds: 3 + random.nextInt(4));

        return Positioned(
          left: startPosition,
          child: TweenAnimationBuilder(
            tween: Tween<double>(begin: -50, end: 800),
            duration: duration,
            builder: (context, double value, child) {
              return Positioned(
                top: value,
                child: Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.2),
                        blurRadius: 4,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
              );
            },
            onEnd: () {
              // Animasyon bittiğinde tekrar başlat
              if (random.nextBool()) {
                buildSnowAnimation();
              }
            },
          ),
        );
      }),
    );
  }

  static Widget buildNewYearAnimation() {
    return Lottie.asset(
      'assets/animations/new_year.json',
      fit: BoxFit.contain,
      repeat: true,
      width: double.infinity,
      height: 200,
      errorBuilder: (context, error, stackTrace) {
        debugPrint('New Year animation error: $error');
        debugPrint('Stack trace: $stackTrace');
        return Container(
          color: Colors.yellow.withOpacity(0.1),
          child: const Center(
            child: Text('Yeni yıl animasyonu yüklenemedi'),
          ),
        );
      },
    );
  }

  static Widget buildSuccessAnimation() {
    return Lottie.asset(
      'assets/animations/success.json',
      repeat: false,
      errorBuilder: (context, error, stackTrace) {
        print('Success animation error: $error');
        return const Icon(
          Icons.check_circle_outline,
          size: 100,
          color: Colors.green,
        );
      },
    );
  }

  static Widget buildLoadingAnimation() {
    return Lottie.asset(
      'assets/animations/loading.json',
      width: 100,
      height: 100,
      errorBuilder: (context, error, stackTrace) {
        print('Loading animation error: $error');
        return const CircularProgressIndicator();
      },
    );
  }
}
