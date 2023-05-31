// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../USER/home/home.dart';
import '../app.dart';
import '../presentation/features/auth/auth_bloc.dart';

class GlobalBlocProviders extends StatelessWidget {
  const GlobalBlocProviders({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AuthBloc(), child: const OrderuytinApp());
  }
}

class GlobalBlocListener extends StatelessWidget {
  final Widget child;
  const GlobalBlocListener({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return BlocListener<AuthBloc, AuthState>(
        listenWhen: (previous, current) {
          return previous != current;
        },
        listener: (context, state) {
          if (state is AuthenticatedState) {
            // Navigator.pushNamedAndRemoveUntil<String>(
            //   context,
            //   HomePage.nameRoute,
            //   arguments: "ABC",
            //   (route) => false,
            // );
            Future.delayed(const Duration(seconds: 3)).then((value) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const HomePageOrder(
                    id: "a",
                  ),
                ),
              );
            });
          }
        },
        child: child,
      );
    });
  }
}
