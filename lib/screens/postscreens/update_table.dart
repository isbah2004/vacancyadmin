import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vacancy_admin/provider/upload_provider.dart';
import 'package:vacancy_admin/reusablewidgets/reusable_button.dart';
import 'package:vacancy_admin/reusablewidgets/reusable_text_field.dart';
import 'package:vacancy_admin/theme/theme.dart';
import 'package:vacancy_admin/utils/utils.dart';
import 'package:provider/provider.dart';

class UpdateTable extends StatefulWidget {
  final String docId, collectionName;
  final QueryDocumentSnapshot<Object?> existingData;

  const UpdateTable(
      {super.key,
      required this.docId,
      required this.existingData,
      required this.collectionName});

  @override
  State<UpdateTable> createState() => _UpdateTableState();
}

class _UpdateTableState extends State<UpdateTable> {
  late TextEditingController nameController;
  late TextEditingController dateController;
  late TextEditingController designationController;
  late TextEditingController gradeController;
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode dateFocusNode = FocusNode();
  final FocusNode designationFocusNode = FocusNode();
  final FocusNode gradeFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.existingData['name']);
    dateController = TextEditingController(text: widget.existingData['date']);
    designationController =
        TextEditingController(text: widget.existingData['designation']);
    gradeController = TextEditingController(text: widget.existingData['grade']);
  }

  void computeAvailableVacancies() {
    setState(() {
      int approvedNumber = int.tryParse(dateController.text) ?? 0;
      int manpowerNumber = int.tryParse(designationController.text) ?? 0;
      int availableVacancies = approvedNumber - manpowerNumber;
      gradeController.text = availableVacancies.toString();
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    dateController.dispose();
    designationController.dispose();
    gradeController.dispose();
    nameFocusNode.dispose();
    dateFocusNode.dispose();
    designationFocusNode.dispose();
    gradeFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Consumer<UploadProvider>(builder: (context, value, child) {
            return IconButton(
              onPressed: () {
                value.deleteTable(
                    docId: widget.existingData.id, context: context, collectionName: widget.collectionName);
              },
              icon: const Icon(Icons.delete),
            );
          })
        ],
        centerTitle: true,
        title: Text(
          'Update Data',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: AppTheme.whiteColor,
              fontSize: 25,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            ReusableTextField(
              hintText: 'Name',
              controller: nameController,
              keyboardType: TextInputType.text,
              focusNode: nameFocusNode,
              onFieldSubmitted: (value) {
                Utils.changeFocus(
                    currentFocus: nameFocusNode,
                    nextFocus: dateFocusNode,
                    context: context);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ReusableTextField(
              hintText: 'Resignation Date',
              controller: dateController,
              keyboardType: TextInputType.text,
              focusNode: dateFocusNode,
              onFieldSubmitted: (value) {
                Utils.changeFocus(
                    currentFocus: dateFocusNode,
                    nextFocus: designationFocusNode,
                    context: context);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ReusableTextField(
              hintText: 'Designation',
              controller: designationController,
              keyboardType: TextInputType.text,
              focusNode: designationFocusNode,
              onFieldSubmitted: (value) {
                Utils.changeFocus(
                    currentFocus: designationFocusNode,
                    nextFocus: gradeFocusNode,
                    context: context);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ReusableTextField(
              hintText: 'Grade',
              controller: gradeController,
              keyboardType: TextInputType.text,
              focusNode: gradeFocusNode,
            ),
            const SizedBox(
              height: 20,
            ),
            Consumer<UploadProvider>(
              builder:
                  (BuildContext context, UploadProvider value, Widget? child) {
                return ReusableButton(
                    title: 'Update Data',
                    onTap: () {
                      value.updateTable(
                        context: context,
                        docId: widget.docId,
                        nameController: nameController,
                        dateController: dateController,
                        designationController: designationController,
                        gradeController: gradeController,
                        collectionName: widget.collectionName,
                      );
                    },
                    loading: value.loading);
              },
            ),
          ],
        ),
      ),
    );
  }
}
