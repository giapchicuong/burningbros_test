import 'package:burningbros_test/common/check_connection/presentation/bloc/check_connection_bloc.dart';
import 'package:burningbros_test/core/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckConnectionScreen extends StatelessWidget {
  const CheckConnectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CheckConnectionBloc>().state;

    void handleSubmit() {
      if (state is CheckConnectionError) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppTexts.noInternetConnection)));
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text(AppTexts.checkNetworkConnection)),
      body: Center(
        child: ElevatedButton(
          onPressed: handleSubmit,
          child: Text(AppTexts.checkConnection),
        ),
      ),
    );
  }
}
