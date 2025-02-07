import 'package:flutter/material.dart';
import 'package:app/screens/home_screen.dart';
import 'package:flutter_prof_app/screens/sign_in.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/screens/signin_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});

    await Supabase.initialize(
      url: 'https://btnepspxakfjasxhjcys.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJ0bmVwc3B4YWtmamFzeGhqY3lzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzgyMjMxMTgsImV4cCI6MjA1Mzc5OTExOH0.93aYGDDUGK7M0Nmd0wxnp_YngX0CC39z9-i2e4P74h8',
    );
  });

  testWidgets("Вызов диалогового окна при некорректном Email", (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignIn()));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).first, "invalid-email");
    await tester.tap(find.text("Войти"));
    await tester.pumpAndSettle();
    expect(find.text("Ошибка"), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.text("Не верный формат почты name@domen.ru"), findsOneWidget);
  });

  testWidgets("Вызов диалогового окна при некорректном пароле",
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignIn()));

    await tester.enterText(find.byType(TextField).first, "test@example.com");
    await tester.enterText(find.byType(TextField).last, "");
    await tester.tap(find.text("Войти"));
    await tester.pumpAndSettle();

    expect(find.text("Ошибка"), findsOneWidget);
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();
    expect(find.text("Все поля должны быть заполнены"), findsOneWidget);
  });
  
  testWidgets("Провальная авторизация в системе", (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignIn()));

    await tester.enterText(find.byType(TextField).first, 'igarett@yandex.ru');
    await tester.enterText(find.byType(TextField).last, 'admin1Gelezo!');

    await tester.tap(find.text("Войти"));

    await tester.pumpAndSettle(Durations.extralong4);
    expect(find.text("Ошибка входа"), findsOneWidget)
  });
}
