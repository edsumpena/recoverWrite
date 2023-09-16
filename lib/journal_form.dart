import 'dart:collection';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'bouncing.dart';

class AddEntry extends StatefulWidget {
  const AddEntry({Key? key}) : super(key: key);

  @override
  State<AddEntry> createState() => AddEntryMain();
}

class AddEntryBloc extends FormBloc<String, String> {
  final completeRegiment = SelectFieldBloc(
      name: 'Completed the regiment?',
      items: ['Yes', 'No'],
      validators: [FieldBlocValidators.required]);

  final timeSpent = SelectFieldBloc(
      name: 'Time spent today on regiment',
      items: ['1-2 hours', '3-4 hours', '5-6 hours', '7-8 hours', '8+ hours'],
      validators: [FieldBlocValidators.required]);

  final emotion = MultiSelectFieldBloc(
      name: 'Which emotion(s) describe your feelings?',
      items: ['Happy', 'Sad', 'Optimistic', 'Angry', 'Frustrated'],
      validators: [FieldBlocValidators.required]);

  final completeDescription = TextFieldBloc(
      name: 'Describe completed exercises.', validators: []);

  final noCompleteDescription = TextFieldBloc(
      name: 'Describe uncompleted exercises.',
      validators: []);

  final journal = TextFieldBloc(
      name:
          'Feelings about regiment? Challenges?',
      validators: []);

  AddEntryBloc() {
    addFieldBlocs(
      fieldBlocs: [
        completeRegiment,
        timeSpent,
        emotion,
        completeDescription,
        noCompleteDescription,
        journal,
      ],
    );
  }

  @override
  Future<void> close() {
    completeRegiment.close();
    timeSpent.close();
    emotion.close();
    completeDescription.close();
    noCompleteDescription.close();
    journal.close();
    return super.close();
  }

  @override
  void onSubmitting() async {
    if (kDebugMode) {
      print("Field Values:");
      print(completeRegiment.value);
      print(timeSpent.value);
      print(emotion.value);
      print(completeDescription.value);
      print(noCompleteDescription.value);
      print(journal.value);
    }

    HashMap<String, List<String>> log = HashMap<String, List<String>>();

    log["completeRegiment"] = [completeRegiment.value!];
    log["timeSpent"] = [timeSpent.value!];
    log["emotion"] = emotion.value;
    log["completeDescription"] = [completeDescription.value];
    log["noCompleteDescription"] = [noCompleteDescription.value];
    log["journal"] = [journal.value];

    final dataDir = await getApplicationDocumentsDirectory();
    final dir = Directory('${dataDir.path}/Events');

    await dir.create(recursive: true).then((value) async {
      if (dir.existsSync()) {
        final file = File('${dataDir.path}/Events/${DateTime.now().millisecondsSinceEpoch}.json');
        await file.writeAsString(log.toString());
      }
    });

    emitSuccess();
  }
}

class AddEntryMain extends State<AddEntry> {
  bool sendProvider = false;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Theme(
      data: Theme.of(context).copyWith(
        primaryColor: Colors.indigo,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      child: BlocProvider(
        create: (context) => AddEntryBloc(),
        child: Builder(builder: (context) {
          final addEntryBloc = context.read<AddEntryBloc>();

          return GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                      elevation: 0.0,
                      backgroundColor: Colors.white,
                        leading: IconButton(
                          icon: Platform.isAndroid
                              ? const Icon(Icons.arrow_back, color: Colors.indigo)
                              : const Icon(Icons.arrow_back_ios, color: Colors.indigo),
                          onPressed:  () => Navigator.of(context).pop(),
                        )
                  ),
                  body: Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.035),
                      child: FormBlocListener<AddEntryBloc, String, String>(
                        onSubmitting: (context, state) {},
                        onSubmissionFailed: (context, state) {},
                        onSuccess: (context, state) {
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                        onFailure: (context, state) {},
                        child: SingleChildScrollView(
                            physics: const ClampingScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                              SizedBox(
                                height: height * 0.02,
                              ),
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  minWidth: width * 0.525,
                                  maxWidth: width * 0.525,
                                  minHeight: height * 0.08,
                                  maxHeight: height * 0.08,
                                ),
                                child: Text(
                                  'Add Entry',
                                  style: TextStyle(
                                      color: Colors.indigo,
                                      fontWeight: FontWeight.w900,
                                      fontSize: width * 0.1),
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(height: height * 0.01),
                              RadioButtonGroupFieldBlocBuilder<String>(
                                selectFieldBloc: addEntryBloc.completeRegiment,
                                decoration: InputDecoration(
                                  labelText: addEntryBloc.completeRegiment.name,
                                  prefixIcon: const SizedBox(),
                                ),
                                itemBuilder: (context, item) => FieldItem(
                                  child: Text(item),
                                ),
                                canTapItemTile: true,
                              ),
                              RadioButtonGroupFieldBlocBuilder<String>(
                                selectFieldBloc: addEntryBloc.timeSpent,
                                decoration: InputDecoration(
                                  labelText: addEntryBloc.timeSpent.name,
                                  prefixIcon: const SizedBox(),
                                ),
                                itemBuilder: (context, item) => FieldItem(
                                  child: Text(item),
                                ),
                                canTapItemTile: true,
                              ),
                              CheckboxGroupFieldBlocBuilder<String>(
                                multiSelectFieldBloc: addEntryBloc.emotion,
                                decoration: InputDecoration(
                                  labelText: addEntryBloc.emotion.name,
                                  prefixIcon: const SizedBox(),
                                ),
                                itemBuilder: (context, item) => FieldItem(
                                  child: Text(item),
                                ),
                                canTapItemTile: true,
                              ),
                              TextFieldBlocBuilder(
                                textFieldBloc: addEntryBloc.completeDescription,
                                keyboardType: TextInputType.text,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                decoration: InputDecoration(
                                  labelText:
                                      addEntryBloc.completeDescription.name,
                                  prefixIcon: const Icon(Icons.check_box_outlined),
                                ),
                                minLines: 1,
                                maxLines: 5,
                              ),
                              TextFieldBlocBuilder(
                                textFieldBloc: addEntryBloc.noCompleteDescription,
                                keyboardType: TextInputType.text,
                                textCapitalization:
                                TextCapitalization.sentences,
                                decoration: InputDecoration(
                                  labelText:
                                  addEntryBloc.noCompleteDescription.name,
                                  prefixIcon: const Icon(Icons.check_box_outline_blank),
                                ),
                                minLines: 1,
                                maxLines: 5,
                              ),
                              TextFieldBlocBuilder(
                                textFieldBloc: addEntryBloc.journal,
                                keyboardType: TextInputType.text,
                                textCapitalization:
                                TextCapitalization.sentences,
                                decoration: InputDecoration(
                                  labelText:
                                  addEntryBloc.journal.name,
                                  prefixIcon: const Icon(Icons.person),
                                ),
                                minLines: 1,
                                maxLines: 5,
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              CheckboxListTile(
                                title: const Text(
                                  "Share with Provider?",
                                ),
                                value: sendProvider,
                                onChanged: (bool? value) {
                                  setState(() {
                                    sendProvider = value!;
                                  });
                                },
                                  controlAffinity: ListTileControlAffinity.platform,
                                activeColor: Colors.indigo,
                              ), //Check
                              SizedBox(
                                height: height * 0.01,
                              ),
                              Bouncing(
                                onPress: () {},
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  child: SizedBox(
                                    width: 329,
                                    height: 56,
                                    child: ElevatedButton(
                                      onPressed: addEntryBloc.submit,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.indigo,
                                      ),
                                      child: const Text(
                                        'Submit',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height * 0.03,
                              ),
                            ])),
                      ))));
        }),
      ),
    );
  }
}
