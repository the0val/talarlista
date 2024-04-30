import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'model.dart';
import 'speaker.dart';

class IdForm extends StatelessWidget {
  IdForm({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FocusNode _textFocus = FocusNode();
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SpeakersQueue speakers = Provider.of<SpeakersQueue>(context, listen: false);

    void add() {
      if (_textController.text != '') {
        // Get text and add to model
        speakers.queue(Speaker(_textController.text));
      }
      _resetTextfield();
    }

    void remove() {
      speakers.dequeue();
      _resetTextfield();
    }

    return Shortcuts(
      shortcuts: <ShortcutActivator, Intent>{
        const SingleActivator(LogicalKeyboardKey.enter):
            VoidCallbackIntent(() => add()),
      },
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 200,
                child: TextFormField(
                    controller: _textController,
                    autofocus: true,
                    focusNode: _textFocus,
                    decoration: const InputDecoration(hintText: 'OmbudsNr')),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: ElevatedButton(
                    onPressed: add, child: const Text('Lägg till')),
              ),
              ElevatedButton(onPressed: remove, child: const Text('Ta bort')),
            ],
          ),
        ),
      ),
    );
  }

  void _resetTextfield() {
    _formKey.currentState?.reset();
    _textFocus.requestFocus();
  }
}
