import 'dart:async';

import 'package:flutter/material.dart';
import 'package:crud_example/custom_button.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final TextEditingController controller = TextEditingController();
  final List<String> items = [];
  int currentIndex = 0;
  String? selectedItem;
  bool isCreating = false;
  bool isAdding = false;

  void isCreate() {
    setState(() {
      isCreating = true;
      isAdding = true;
      selectedItem = null;
    });
  }

  void isAdd() {
    setState(() {
      String inputText = controller.text;
      if (inputText.isNotEmpty) {
        items.add(inputText);
        controller.clear();
        isCreating = false;
        isAdding = false;
      }
    });
    setState(() {
      selectedItem = null;
    });
  }

  Future<void> isRead() async {
    String inputText = controller.text;
    if (inputText.isNotEmpty) {
      if (items.contains(inputText)) {
        setState(() {
          selectedItem = inputText;
        });

        await Future.delayed(const Duration(seconds: 2));

        setState(() {
          selectedItem = null;
        });
      }
    }
  }

  void isUpdate() {
    setState(() {
      String inputText = controller.text;
      if (inputText.isNotEmpty) {
        items[currentIndex] = inputText;
        controller.clear();
        isCreating = false;
        isAdding = false;
      }
    });
    setState(() {
      selectedItem = null;
    });
  }

  void isDelete() {
    String inputText = controller.text;
    if (inputText.isNotEmpty) {
      setState(() {
        // items.remove(inputText);
        items.removeAt(currentIndex);
        controller.clear();
      });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('CRUD Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (isCreating)
              TextFormField(
                controller: controller,
                decoration: const InputDecoration(
                  labelText: 'Eingabe',
                  border: OutlineInputBorder(),
                ),
              ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(items[index]),
                    onTap: () {
                      controller.text = items[index];
                      print(index);
                      currentIndex = index;
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            if (selectedItem != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Aktuell ausgewählt: $selectedItem',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            SizedBox(
              height: 400,
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  CustomButton(
                    name: isAdding ? 'Hinzufügen' : 'Create',
                    icon: const Icon(Icons.create),
                    onPressed: isAdding ? isAdd : isCreate,
                  ),
                  CustomButton(
                    name: 'Read',
                    icon: const Icon(Icons.read_more),
                    onPressed: isRead,
                  ),
                  CustomButton(
                    name: 'Update',
                    icon: const Icon(Icons.update),
                    onPressed: isAdding ? isUpdate : isCreate,
                  ),
                  CustomButton(name: 'Delete', icon: const Icon(Icons.delete), onPressed: isDelete),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
