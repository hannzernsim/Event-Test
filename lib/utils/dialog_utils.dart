import 'package:flutter/material.dart';
import 'package:event_app/constants/dimens_constants.dart';

Future<void> showInfoDialog(
  BuildContext context, {
  required String desc,
  required String buttonText,
  GestureTapCallback? onButtonTapped,
}) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
          padding: EdgeInsets.all(largeSpace),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(5.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: commonSpace),
                child: Text(
                  desc,
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
              ElevatedButton(
                child: Text(buttonText),
                onPressed: () {
                  Navigator.pop(context);
                  if (onButtonTapped != null) {
                    onButtonTapped();
                  }
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}
