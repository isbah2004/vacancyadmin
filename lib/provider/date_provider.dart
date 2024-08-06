import 'package:flutter/material.dart';

class DateProvider extends ChangeNotifier {
  Future<void> selectDate({
    required BuildContext context,
    required TextEditingController dateController,
  }) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      dateController.text = "${picked.toLocal()}".split(' ')[0]; // Format as yyyy-MM-dd
      notifyListeners();
    }
  }
}
