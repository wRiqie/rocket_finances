import 'package:flutter/material.dart';

abstract class _BaseSnackbar {
  _BaseSnackbar(BuildContext context,
      {String? title,
      required String message,
      Widget? icon,
      required Color backgroundColor,
      Color? textColor,
      ShapeBorder? border}) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        shape: border,
        content: Row(
          children: [
            icon != null
                ? Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: icon,
                  )
                : const SizedBox(),
            Expanded(
              child: Text(
                message,
                style: TextStyle(color: textColor),
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
      ),
    );
  }
}

class SuccessSnackbar extends _BaseSnackbar {
  SuccessSnackbar(
    super.context, {
    required super.message,
    super.title,
    Widget? icon,
  }) : super(
          backgroundColor: const Color(0x5E317433),
          textColor: Colors.white,
          icon: icon ??
              const Icon(
                Icons.check,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
          border: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
            side: BorderSide(
              color: const Color(0xFF317433),
            ),
          ),
        );
}

class AlertSnackbar extends _BaseSnackbar {
  AlertSnackbar(
    super.context, {
    required super.message,
    super.title,
    Widget? icon,
  }) : super(
          backgroundColor: const Color.fromARGB(102, 221, 134, 4),
          textColor: const Color.fromARGB(221, 255, 255, 255),
          icon: icon ??
              const Icon(
                Icons.warning,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
          border: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
            side: BorderSide(
              color: const Color(0xFFDD8604),
            ),
          ),
        );
}

class ErrorSnackbar extends _BaseSnackbar {
  ErrorSnackbar(
    super.context, {
    String? message,
    super.title,
    Widget? icon,
  }) : super(
          message: message ?? 'Ocorreu um erro inesperado, tente novamente',
          backgroundColor: const Color(0x62F64343),
          textColor: const Color(0xFFFCFCFC),
          icon: icon ??
              const Icon(
                Icons.error,
                color: Color(0xFFFCFCFC),
              ),
          border: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
            side: BorderSide(
              color: const Color(0xFFF64343),
            ),
          ),
        );
}
