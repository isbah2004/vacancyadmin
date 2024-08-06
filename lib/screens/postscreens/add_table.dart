import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vacancy_admin/provider/date_provider.dart';
import 'package:vacancy_admin/provider/upload_provider.dart';
import 'package:vacancy_admin/reusablewidgets/reusable_button.dart';
import 'package:vacancy_admin/reusablewidgets/reusable_text_field.dart';
import 'package:vacancy_admin/theme/theme.dart';
import 'package:vacancy_admin/utils/utils.dart';
import 'package:provider/provider.dart';

class AddTable extends StatefulWidget {
  final String departmentName;

  const AddTable({super.key, required this.departmentName, required String docId});

  @override
  State<AddTable> createState() => _AddTableState();
}

class _AddTableState extends State<AddTable> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController designationController = TextEditingController();
  final TextEditingController gradeController = TextEditingController();

  final FocusNode nameFocusNode = FocusNode();
  final FocusNode dateFocusNode = FocusNode();
  final FocusNode gradeFocusNode = FocusNode();
  final FocusNode designationFocusNode = FocusNode();

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
        centerTitle: true,
        title: Text(
          'Add Table',
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
            Consumer<DateProvider>(
              builder:
                  (BuildContext context, DateProvider value, Widget? child) {
                return ReusableTextField(
                  suffix: IconButton(
                      onPressed: () {
                        value.selectDate(
                            context: context, dateController: dateController);
                      },
                      icon: const Icon(Icons.calendar_month_outlined)),
                  hintText: 'Date',
                  controller: dateController,
                  keyboardType: TextInputType.datetime,
                  focusNode: dateFocusNode,
                  onFieldSubmitted: (value) {
                    Utils.changeFocus(
                        currentFocus: dateFocusNode,
                        nextFocus: designationFocusNode,
                        context: context);
                  },
                );
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
                    title: 'Add Data',
                    onTap: () {
                      value.addTable(
                        context: context,
                        nameController: nameController,
                        dateController: dateController,
                        designationController: designationController,
                        gradeController: gradeController,
                        departmentName: widget.departmentName,
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
