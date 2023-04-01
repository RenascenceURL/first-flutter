import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app2/common/Global.dart';
import 'package:intl/intl.dart';

void main() {
  Global.init().then((e) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timestamp Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Timestamp Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();
  String _year = '';

  final _timestampFormatter = FilteringTextInputFormatter.digitsOnly;

  void _handleSubmitted(String value) {
    final DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(int.parse(value));
    final DateFormat formatter = DateFormat('yyyy');
    setState(() {
      _year = formatter.format(dateTime);
    });
  }

  void _handleButtonPressed() {
    if (_controller.text.isNotEmpty) {
      _handleSubmitted(_controller.text);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter a timestamp',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [_timestampFormatter],
              maxLength: 13,
              onSubmitted: _handleSubmitted,
            ),
            const SizedBox(height: 16.0),
            Text(
              'Year: $_year',
              style: Theme.of(context).textTheme.headline6,
            ),
            ElevatedButton(
              onPressed: _handleButtonPressed,
              child: const Text('Convert to Year'),
            ),
          ],
        ),
      ),
    );
  }
}
