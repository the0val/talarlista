import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controls.dart';
import 'list.dart';
import 'model.dart';
import 'filepicker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SpeakersQueue(),
      child: MaterialApp(
        title: 'Talarlista',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFEC008C)),
          useMaterial3: true,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: Text('Talarlista'),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: IdForm(),
        ),
      ),
      body: ListView(
        children: [
          OrderList(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: Filepicker(Provider.of(context, listen: false)).show,
        child: const Icon(Icons.file_open),
      ),
    );
  }
}
