import 'package:flutter/material.dart';

class LoadingScreenWidget extends StatelessWidget {
  const LoadingScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height,
      width: MediaQuery.sizeOf(context).width,
      color: Colors.black38,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: const CircularProgressIndicator.adaptive(),
        ),
      ),
    );
  }
}
