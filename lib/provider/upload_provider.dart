import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vacancy_admin/utils/utils.dart';

class UploadProvider extends ChangeNotifier {
  Future<void> addTable({
    required BuildContext context,
    required TextEditingController nameController,
    required TextEditingController dateController,
    required TextEditingController designationController,
    required TextEditingController gradeController,
    required String departmentName,
  }) async {
    try {
      setLoading(true);

      await firestore.collection(departmentName).add({
        'name': nameController.text,
        'date': dateController.text,
        'designation': designationController.text,
        'grade': gradeController.text,
      }).then((value) {
        Utils.toastMessage(
            message: 'Table Added Successfully', context: context);
      });
    } catch (e) {
      Utils.toastMessage(message: 'Failed to upload data', context: context);
    } finally {
      setLoading(false);
    }
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> uploadData({
    required BuildContext context,
    required TextEditingController departmentController,
    required TextEditingController approvedNumberController,
    required TextEditingController manpowerNumberController,
    required TextEditingController vacancyController,
    required TextEditingController numberController,
  }) async {
    if (departmentController.text.isNotEmpty &&
        approvedNumberController.text.isNotEmpty &&
        manpowerNumberController.text.isNotEmpty &&
        vacancyController.text.isNotEmpty &&
        numberController.text.isNotEmpty) {
      try {
        setLoading(true);
        await firestore.collection('vacancies').add({
          'department': departmentController.text,
          'approved_numbers': approvedNumberController.text,
          'manpower_numbers': manpowerNumberController.text,
          'vacancy': vacancyController.text,
          'number': numberController.text,
        }).then((value) {
          Navigator.pop(context);
          Utils.toastMessage(
              message: 'Data uploaded successfully', context: context);
        });
      } catch (e) {
        Utils.toastMessage(message: 'Failed to upload data', context: context);
      } finally {
        setLoading(false);
      }
    } else {
      Utils.toastMessage(message: 'Please fill all fields', context: context);
    }
  }

  Future<void> updateData({
    required BuildContext context,
    required String docId,
    required TextEditingController departmentController,
    required TextEditingController approvedNumberController,
    required TextEditingController manpowerNumberController,
    required TextEditingController vacancyController,
    required TextEditingController numberController,
  }) async {
    try {
      setLoading(true);
      await firestore.collection('vacancies').doc(docId).update({
        'department': departmentController.text,
        'approved_numbers': approvedNumberController.text,
        'manpower_numbers': manpowerNumberController.text,
        'vacancy': vacancyController.text,
        'number': numberController.text,
      }).then((value) {
        Utils.toastMessage(
            message: 'Data updated successfully', context: context);
        Navigator.pop(context);
      });
    } catch (e) {
      Utils.toastMessage(message: 'Failed to update data', context: context);
    } finally {
      setLoading(false);
    }
  }

  Future<void> updateTable({
    required BuildContext context,
    required String docId,
    required TextEditingController nameController,
    required TextEditingController dateController,
    required TextEditingController designationController,
    required TextEditingController gradeController,
    required String collectionName,
  }) async {
    try {
      setLoading(true);
      await firestore.collection(collectionName).doc(docId).update({
        'department': nameController.text,
        'approved_numbers': dateController.text,
        'manpower_numbers': designationController.text,
        'vacancy': gradeController.text,
      }).then((value) {
        Utils.toastMessage(
            message: 'Data updated successfully', context: context);
        Navigator.pop(context);
      });
    } catch (e) {
      Utils.toastMessage(message: 'Failed to update data', context: context);
    } finally {
      setLoading(false);
    }
  }

  Future<void> deleteFile({
    required String docId,
    required BuildContext context,
  }) async {
    DocumentReference docRef = firestore.collection('vacancies').doc(docId);
    DocumentSnapshot docSnapshot = await docRef.get();
    try {
      if (docSnapshot.exists) {
        String? name = docSnapshot.get('department');
        var collection = FirebaseFirestore.instance.collection(name!);
        var snapshots = await collection.get();
        for (var doc in snapshots.docs) {
          await doc.reference.delete();
        }
      }
      firestore.collection('vacancies').doc(docId).delete().then((value) {
        Utils.toastMessage(
            message: 'Data deleted successfully', context: context);
      });
    } catch (e) {
      Utils.toastMessage(message: 'Failed to delete data', context: context);
    } finally {
      Navigator.pop(context);
    }
  }

  Future<void> deleteTable(
      {required String docId,
      required BuildContext context,
      required collectionName}) async {
    try {
      firestore.collection(collectionName).doc(docId).delete().then((value) {
        Utils.toastMessage(
            message: 'Data deleted successfully', context: context);
      });
    } catch (e) {
      Utils.toastMessage(message: 'Failed to delete data', context: context);
    } finally {
      Navigator.pop(context);
    }
  }
}
