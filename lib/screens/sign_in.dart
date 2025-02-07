import 'dart:ffi';

import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import 'home_screen.dart';



class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscureText = true;
  bool _isLoading = false;

  final AuthService _authService = AuthService();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool validateEmptyFields(String email, String password) {

    if (email.isEmpty || password.isEmpty) {
      _showErrorDialog("Ошибка", "Все поля должны быть заполнены");
      return false;
    }
    return true;
  }

  bool validateEmail(String email) {
    
    final RegExp emailRegExp = RegExp(r'^[a-z0-9]+@[a-z0-9]+\.[a-z]{2,}$');

    if (!emailRegExp.hasMatch(email)) {
      _showErrorDialog("Ошибка", "Не верный формат почты name@domen.ru");
      return false;
    }
    return true;
  }

  Future<void> _authenticateUser(String email, String password) async {
    setState(() {
      _isLoading = true;
    });

    final String? errorMessage = await _authService.signIn(email, password);

    setState(() {
      _isLoading = false;
    });

    if (errorMessage != null) {
      _showErrorDialog("Ошибка входа", errorMessage);
    } else {
      _navigateToHome();
    }
  }

  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

    void _signIn() {
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    if (!validateEmail(email)) return;
    if (!validateEmptyFields(email, password)) return;
    _authenticateUser(email, password);
  }

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          surfaceTintColor: Color.fromARGB(255, 231, 62, 62),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("ОК"),
            ),
          ],
        );
      },
    );
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [_buildHeader(), _buildFooter()],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(top: 121),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Привет!",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            'Заполните Свои Данные Или\nПродолжите Через Социальные Медиа',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Color(0xFF707B81)),
          ),
          const SizedBox(
            height: 35,
          ),
          _buildForm()
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel("Email"),
        _buildTextField(),
        const SizedBox(height: 26),
        _buildLabel("Пароль"),
        _buildPasswordField(),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () {},
            child: const Text(
              "Востановить",
              style: TextStyle(color: Color(0xFF707B81), fontSize: 12),
            ),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        _buildLoginButton(),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _buildTextField() {
    return TextField(
      controller: _emailController,
      decoration: InputDecoration(
        hintText: "email@ya.ru",
        hintStyle: const TextStyle(
          color: Color(0xFF6A6A6A),
          fontWeight: FontWeight.normal,
          fontSize: 14,
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none),
        filled: true,
        fillColor: const Color(0xFFF7F7F9),
      ),
    );
  }

  Widget _buildPasswordField() {
    return TextField(
      controller: _passwordController,
      obscureText: _obscureText,
      decoration: InputDecoration(
        hintText: "••••••••",
        hintStyle: const TextStyle(
          color: Color(0xFF6A6A6A),
          fontSize: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: const Color(0xFFF7F7F9),
        suffixIcon: IconButton(
          icon: Image.asset(
            _obscureText
                ? "assets/images/icons/eye-close.png"
                : "assets/images/icons/eye-open.png",
            width: 24,
            height: 24,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _signIn,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF48B2E7),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        child: const Text("Войти"),
      ),
    );
  }

  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: Center(
        child: GestureDetector(
          onTap: () {},
          child: const Text(
            "Вы впервые? Создать пользователя",
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
