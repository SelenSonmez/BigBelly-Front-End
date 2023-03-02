import 'package:flutter/material.dart';

void main() => runApp(const MyAppExample());

class MyAppExample extends StatelessWidget {
  const MyAppExample({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Form Validation Demo';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: const MyCustomForm(),
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();

  Map<String, dynamic> fields = {
    'name': null
  }; // bizim formun tüm değerlerini bu tutucak http sorgusu atarken bunu kullanıcaz direkt

  String url = ''; // sorgu atılacak url bu olucak

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            onSaved: (newValue) => fields['name'] =
                newValue, // Burada name değerini güncelliyor form fieldın değeri ile
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                _formKey.currentState!
                    .save(); // bu method formfieldların hepsinin onSaved methodunu tetikliyor

                //Burada da gerekli http sorgusu atılıcak
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
