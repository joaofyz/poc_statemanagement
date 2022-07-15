import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PocLoadingDialog {
  bool _isVisible = false;

  bool isVisible() => _isVisible;

  Future? show(BuildContext context) {
    if (!_isVisible) {
      _isVisible = true;
      return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => const CupertinoActivityIndicator(
          radius: 20,
          color: Colors.white,
        ),
      );
    }
    return null;
  }

  void close(BuildContext context) {
    if (_isVisible) {
      _isVisible = false;
      Navigator.of(context).pop();
    }
  }
}
