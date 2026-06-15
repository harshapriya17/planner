import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/constants/hive_boxes.dart';
import '../../widgets/delete_dialog.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final Box settingsBox = Hive.box(HiveBoxes.settings);

  Future<void> _resetData(BuildContext context) async {
    bool confirm = await DeleteDialog.show(
      context,
      title: "Reset All Data",
      content: "This will permanently delete all your subjects, tasks, and schedules. Are you sure?",
    );

    if (confirm) {
      await Hive.box(HiveBoxes.subjects).clear();
      await Hive.box(HiveBoxes.tasks).clear();
      await Hive.box(HiveBoxes.sessions).clear();
      
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("All data has been reset")),
        );
      }
    }
  }

  void _editUserName(BuildContext context, String currentName) {
    final controller = TextEditingController(text: currentName);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Name"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: "Enter your name"),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                settingsBox.put('userName', controller.text.trim());
                Navigator.pop(context);
              }
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 85,
      );
      
      if (image != null) {
        settingsBox.put('profileImage', image.path);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error picking image: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: ValueListenableBuilder(
        valueListenable: settingsBox.listenable(),
        builder: (context, Box box, _) {
          final String userName = box.get('userName', defaultValue: "User Name");
          final bool isDarkMode = box.get('isDarkMode', defaultValue: false);
          final String? imagePath = box.get('profileImage');

          return ListView(
            padding: const EdgeInsets.symmetric(vertical: 10),
            children: [
              // Profile Section
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: _pickImage,
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.blue.withOpacity(0.1),
                            backgroundImage: imagePath != null ? FileImage(File(imagePath)) : null,
                            child: imagePath == null
                                ? const Icon(Icons.person, size: 50, color: Colors.blue)
                                : null,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userName,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                          ),
                          const Text("Student Profile"),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () => _editUserName(context, userName),
                            style: ElevatedButton.styleFrom(
                              visualDensity: VisualDensity.compact,
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                            ),
                            child: const Text("Edit Profile"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),

              // Theme Section
              SwitchListTile(
                secondary: Icon(
                  isDarkMode ? Icons.dark_mode : Icons.light_mode,
                  color: isDarkMode ? Colors.amber : Colors.orange,
                ),
                title: const Text("Theme Mode"),
                subtitle: Text(isDarkMode ? "Dark Theme" : "Light Theme"),
                value: isDarkMode,
                onChanged: (val) {
                  box.put('isDarkMode', val);
                },
              ),
              
              const Divider(),

              // Reset Data Section
              ListTile(
                leading: const Icon(Icons.restore, color: Colors.red),
                title: const Text(
                  "Reset All Data",
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
                ),
                subtitle: const Text("Delete everything and start over"),
                onTap: () => _resetData(context),
              ),
            ],
          );
        },
      ),
    );
  }
}
