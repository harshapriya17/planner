import 'package:flutter/material.dart';

import '../../data/repositories/subject_repository.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

class AddSubjectPage extends StatefulWidget {
  const AddSubjectPage({super.key});

  @override
  State<AddSubjectPage> createState() =>
      _AddSubjectPageState();
}

class _AddSubjectPageState
    extends State<AddSubjectPage> {

  final nameController =
  TextEditingController();

  final targetController =
  TextEditingController();

  final SubjectRepository repository =
  SubjectRepository();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          "Add Subject",
        ),
      ),

      body: Padding(

        padding:
        const EdgeInsets.all(20),

        child: Column(

          children: [

            CustomTextField(

              controller:
              nameController,

              hintText:
              "Subject Name",

              icon:
              Icons.book,
            ),

            const SizedBox(
              height: 20,
            ),

            CustomTextField(
              controller: targetController,
              hintText: "Target Hours Per Week",
              icon: Icons.timer,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(
              height: 30,
            ),
            CustomButton(
              text: "Save Subject",
              onPressed: () async {
                /// VALIDATION
                if (nameController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please Enter Subject Name")),
                  );
                  return;
                }

                final targetHours = int.tryParse(targetController.text.trim());
                if (targetHours == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please Enter a Valid Number for Target Hours")),
                  );
                  return;
                }

                /// SAVE TO HIVE
                await repository.addSubject({
                  "name": nameController.text.trim(),
                  "targetHours": targetHours,
                });

                if (!mounted) return;

                ScaffoldMessenger
                    .of(context)
                    .showSnackBar(

                  const SnackBar(

                    content: Text(
                      "Subject Saved Successfully",
                    ),
                  ),
                );

                Navigator.pop(
                  context,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {

    nameController.dispose();

    targetController.dispose();

    super.dispose();
  }
}