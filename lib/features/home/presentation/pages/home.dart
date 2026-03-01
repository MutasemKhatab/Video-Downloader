import 'package:flutter/material.dart';
import 'package:video_downloader/features/video_info/presentation/pages/video_info_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final urlController = TextEditingController();

  final urlKey = GlobalKey<FormFieldState>();

  void _handleUrlSubmit() {
    if (!urlKey.currentState!.validate()) return;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => VideoInfoPage(url: urlController.text),
      ),
    );
  }

  String? _validateUrl(String? value) {
    value = value?.trim();
    final regex = RegExp(
      r'^https?://(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
    );
    final result = regex.hasMatch(value ?? '');
    if (!result) return 'Please enter a valid URL';

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.download_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //TODO make "paste from clipboard" a button
            const Text('Enter video url or paste from clipboard'),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    key: urlKey,
                    controller: urlController,
                    validator: _validateUrl,
                  ),
                ),
                IconButton(
                  onPressed: _handleUrlSubmit,
                  icon: const Icon(Icons.keyboard_arrow_right_rounded),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
