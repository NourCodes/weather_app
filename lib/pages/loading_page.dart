import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);
// helps to ensure that users see a loading indication until the weather data is retrieved and available for display.
  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      backgroundColor: Colors.white12,
       body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 200.0,
        ),
      ),
    );
  }
}
