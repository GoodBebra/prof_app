import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient supabase = Supabase.instance.client;

  // Авторизация (вход в систему)
  Future<String?> signIn(String email, String password) async {
    try {
      await supabase.auth.signInWithPassword(email: email, password: password);
      return null; // Успешно
    } catch (e) {
      return e.toString(); // Ошибка входа
    }
  }
}
