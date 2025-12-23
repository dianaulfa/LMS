import 'package:flutter/material.dart';
import '../constants.dart';
import 'base_screen.dart';

import '../data/mock_database.dart'; // Import MockDatabase

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    setState(() => _isLoading = true);
    
    // Simulate login
    final user = await MockDatabase().login(
      _emailController.text, 
      _passwordController.text
    );

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => BaseScreen(user: user)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Stack(
                  children: [
                    // Bottom Wave Background
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: ClipPath(
                        clipper: BottomWaveClipper(),
                        child: Container(
                          height: 200,
                          color: AppColors.primary,
                        ),
                      ),
                    ),

                    // Content Column
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                         // Top Section with Image and Curve
                         Stack(
                           clipBehavior: Clip.none,
                           alignment: Alignment.bottomCenter,
                           children: [
                             ClipPath(
                               clipper: TopCurveClipper(),
                               child: Container(
                                 height: constraints.maxHeight * 0.35, 
                                 width: double.infinity,
                                 decoration: const BoxDecoration(
                                   image: DecorationImage(
                                     image: AssetImage('assets/DSC_9198-min-1024x681-1.jpg'),
                                     fit: BoxFit.cover,
                                   ),
                                 ),
                                 child: Container(
                                   color: AppColors.primary.withValues(alpha: 0.2), 
                                 ),
                               ),
                             ),
                             // Overlapping Logo
                             Positioned(
                               bottom: -45, 
                               child: CircleAvatar(
                                 radius: 45, 
                                 backgroundColor: Colors.white,
                                 child: CircleAvatar(
                                   radius: 40,
                                   backgroundColor: AppColors.primary,
                                   child: const Padding(
                                     padding: EdgeInsets.all(8.0),
                                     child: Icon(Icons.school, size: 40, color: Colors.white),
                                   ),
                                 ),
                               ),
                             ),
                           ],
                         ),
                   
                   const SizedBox(height: 60), 

                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 24.0),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         const Text(
                           'Login',
                           style: TextStyle(
                             fontSize: 32,
                             fontWeight: FontWeight.bold,
                             color: Colors.black,
                           ),
                         ),
                         const SizedBox(height: 32),

                         // Email Input
                         const Text(
                           'Email 365', 
                           style: TextStyle(
                             fontWeight: FontWeight.bold, 
                             color: Colors.grey
                           ),
                         ),
                         TextField(
                           controller: _emailController,
                           decoration: const InputDecoration(
                             hintText: '',
                             contentPadding: EdgeInsets.symmetric(vertical: 8),
                             isDense: true,
                             enabledBorder: UnderlineInputBorder(
                               borderSide: BorderSide(color: Colors.grey),
                             ),
                             focusedBorder: UnderlineInputBorder(
                               borderSide: BorderSide(color: AppColors.primary, width: 2),
                             ),
                           ),
                         ),
                         
                         const SizedBox(height: 24),
                         
                         // Password Input
                         const Text(
                           'Password', 
                           style: TextStyle(
                             fontWeight: FontWeight.bold, 
                             color: Colors.grey
                           ),
                         ),
                         TextField(
                           controller: _passwordController,
                           obscureText: true,
                           decoration: const InputDecoration(
                             hintText: '',
                             contentPadding: EdgeInsets.symmetric(vertical: 8),
                             isDense: true,
                             suffixIcon: Icon(Icons.visibility_off_outlined),
                             enabledBorder: UnderlineInputBorder(
                               borderSide: BorderSide(color: Colors.grey),
                             ),
                             focusedBorder: UnderlineInputBorder(
                               borderSide: BorderSide(color: AppColors.primary, width: 2),
                             ),
                           ),
                         ),

                         const SizedBox(height: 48),

                         // Login Button
                         SizedBox(
                           width: double.infinity,
                           child: ElevatedButton(
                             onPressed: _isLoading ? null : _handleLogin,
                             style: ElevatedButton.styleFrom(
                               backgroundColor: AppColors.primary, 
                               foregroundColor: Colors.white,
                               padding: const EdgeInsets.symmetric(vertical: 16),
                               shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(30),
                               ),
                               elevation: 5,
                             ),
                             child: _isLoading 
                               ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                               : const Text(
                               'Log In',
                               style: TextStyle(
                                 fontSize: 18,
                                 fontWeight: FontWeight.bold,
                               ),
                             ),
                           ),
                         ),

                         const SizedBox(height: 24),
                         
                         // Help Text
                         const Center(
                           child: Text(
                             'Bantuan ?',
                             style: TextStyle(
                               color: Colors.red, 
                               fontSize: 14,
                             ),
                           ),
                         ),
                       ],
                     ),
                   ),
                   const SizedBox(height: 24),
                ],
              ),
            ],
          ),
        ),
      ),
    ); 
      },
    ),
    );
  }
}

// Custom Clipper for the Top Header (Gentle Convex Curve)
class TopCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 60);

    var firstControlPoint = Offset(size.width / 2, size.height + 40);
    var firstEndPoint = Offset(size.width, size.height - 60);

    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// Custom Clipper for the Bottom Footer (Simple Wave)
class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, size.height);
    path.lineTo(0, size.height - 100);

    var firstControlPoint = Offset(size.width / 2, size.height - 20);
    var firstEndPoint = Offset(size.width, size.height - 80);

    path.quadraticBezierTo(
        firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);

    path.lineTo(size.width, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
