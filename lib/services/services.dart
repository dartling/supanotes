import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:supabase/supabase.dart';
import 'package:supanotes/secrets.dart';

import 'auth_service.dart';

class Services extends InheritedWidget {
  final AuthService authService;

  Services._({
    required this.authService,
    required Widget child,
  }) : super(child: child);

  factory Services({required Widget child}) {
    final client = SupabaseClient(supabaseUrl, supabaseKey);
    final authService = AuthService(client.auth);
    return Services._(authService: authService, child: child);
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }

  static Services of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Services>()!;
  }
}
