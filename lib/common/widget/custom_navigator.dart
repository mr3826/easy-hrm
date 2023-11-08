import 'package:flutter/cupertino.dart';

Future customNavigator({context, pageName}) {
  return Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => pageName,
      ));
}

Future defaultNavigator({ required context,required routeName}) {
 return Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (_, __, ___) => routeName,
      transitionDuration: const Duration(microseconds: 0),
      transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
    ),
  );

}
Future defaultOffNavigator({ required context,required routeName}) {
 return Navigator.pushReplacement(
    context,
    PageRouteBuilder(
      pageBuilder: (_, __, ___) => routeName,
      transitionDuration: const Duration(microseconds: 0),
      transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
    ),
  );

}


