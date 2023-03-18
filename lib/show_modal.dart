import 'package:flutter/material.dart';

Future<T?> showModal<T>(BuildContext context) {
  return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      context: context,
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height / 2,
          child: Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('CLOSE MODAL'),
            ),
          ),
        );
      });
}
