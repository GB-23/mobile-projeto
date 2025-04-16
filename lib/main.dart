import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';
import 'package:animations/animations.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with TickerProviderStateMixin {
  late List<AnimatedCircle> circles;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _isNameHovered = false;
  bool _isPasswordHovered = false;

  @override
  void initState() {
    super.initState();
    circles = List.generate(10, (index) {
      return AnimatedCircle(
        key: UniqueKey(),
        x: Random().nextDouble(),
        y: Random().nextDouble(),
        radius: Random().nextDouble() * 50 + 20,
        color: Colors.white.withOpacity(Random().nextDouble() * 0.3 + 0.1),
        animationControllerX: AnimationController(
          vsync: this,
          duration: Duration(seconds: Random().nextInt(10) + 5),
        )..repeat(reverse: true),
        animationControllerY: AnimationController(
          vsync: this,
          duration: Duration(seconds: Random().nextInt(10) + 5),
        )..repeat(reverse: true),
      );
    });
  }

  @override
  void dispose() {
    for (var circle in circles) {
      circle.animationControllerX.dispose();
      circle.animationControllerY.dispose();
    }
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              print('Back button pressed');
            },
          ),
        ),
        body: Stack(
          children: [
            AnimatedBackground(circles: circles),
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 54, 53, 53),
                    Color.fromARGB(255, 80, 70, 50),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 100),

                      // LOGIN Title
                      const Text(
                        'LOGIN',
                        style: TextStyle(
                          fontSize: 96,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: 2.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40),

                      // Input Fields
                      SizedBox(
                        width: 250,
                        child: FocusTraversalGroup(
                          child: MouseRegion(
                            cursor: SystemMouseCursors.text,
                            onEnter: (event) {
                              setState(() {
                                _isNameHovered = true;
                              });
                            },
                            onExit: (event) {
                              setState(() {
                                _isNameHovered = false;
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: _isNameHovered ? 260 : 250,
                              child: TextFormField(
                                textAlign: TextAlign.center,
                                controller: _nameController,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Nome',
                                  hintStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: 250,
                        child: FocusTraversalGroup(
                          child: MouseRegion(
                            cursor: SystemMouseCursors.text,
                            onEnter: (event) {
                              setState(() {
                                _isPasswordHovered = true;
                              });
                            },
                            onExit: (event) {
                              setState(() {
                                _isPasswordHovered = false;
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: _isPasswordHovered ? 260 : 250,
                              child: TextFormField(
                                textAlign: TextAlign.center,
                                controller: _passwordController,
                                obscureText: true,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Senha',
                                  hintStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Toggle Switch
                      SizedBox(
                        width: 250,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'LEMBRAR',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            Switch(
                              value: _rememberMe,
                              onChanged: (value) {
                                setState(() {
                                  _rememberMe = value;
                                });
                              },
                              activeColor: Colors.white,
                              inactiveTrackColor: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Buttons
                      SizedBox(
                        width: 250,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          onPressed: () {
                            print('CRIAR CONTA pressed');
                          },
                          child: const Text('CRIAR CONTA'),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: 250,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          onPressed: () {
                            print('LOGIN pressed');
                          },
                          child: const Text('LOGIN'),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Social Media Buttons
                      SizedBox(
                        width: 250,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          onPressed: () {
                            print('Sign in with Google pressed');
                          },
                          icon: const Icon(Icons.g_mobiledata),
                          label: const Text('Sign In with Google'),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: 250,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          onPressed: () {
                            print('Sign in with Apple pressed');
                          },
                          icon: const Icon(Icons.apple),
                          label: const Text('Sign In with Apple'),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Footer
                      Text(
                        'AO CRIAR UMA CONTA OU FAZER LOGIN VOCÊ CONCORDA COM AS POLITICAS DE PRIVACIDADE E NOSSOS TERMOS DE SERVIÇO.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 8),
                      InkWell(
                        onTap: () async {
                          const url = 'https://www.example.com/privacy';
                          final uri = Uri.parse(url);
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(uri);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        child: Text(
                          'POLITICA DE PRIVACIDADE',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.blue.shade300,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          const url = 'https://www.example.com/terms';
                          final uri = Uri.parse(url);
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(uri);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        child: Text(
                          'TERMOS DE SERVICO',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.blue.shade300,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'COPYRIGHT GB-23© 2025 ALL RIGHTS RESERVED',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedBackground extends StatelessWidget {
  const AnimatedBackground({Key? key, required this.circles}) : super(key: key);

  final List<AnimatedCircle> circles;

  @override
  Widget build(BuildContext context) {
    return Stack(children: circles);
  }
}

class AnimatedCircle extends AnimatedWidget {
  AnimatedCircle({
    Key? key,
    required this.x,
    required this.y,
    required this.radius,
    required this.color,
    required this.animationControllerX,
    required this.animationControllerY,
  }) : super(
         key: key,
         listenable: Listenable.merge([
           animationControllerX,
           animationControllerY,
         ]),
       );

  final double x;
  final double y;
  final double radius;
  final Color color;
  final AnimationController animationControllerX;
  final AnimationController animationControllerY;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final animatedX = x + animationControllerX.value * 0.1;
    final animatedY = y + animationControllerY.value * 0.1;

    return Positioned(
      left: animatedX * screenWidth,
      top: animatedY * screenHeight,
      child: OpenContainer(
        transitionDuration: const Duration(milliseconds: 500),
        openBuilder: (context, closedContainer) {
          return const SizedBox.shrink();
        },
        closedElevation: 0.0,
        closedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(100.0)),
        ),
        closedBuilder: (context, openContainer) {
          return GestureDetector(
            onTap: openContainer,
            child: Container(
              width: radius,
              height: radius,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
          );
        },
      ),
    );
  }
}
