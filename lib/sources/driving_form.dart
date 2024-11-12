import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
//import 'package:intl/intl.dart';

class DrivingForm extends StatefulWidget {
  const DrivingForm({super.key});

  @override
  State<DrivingForm> createState() {
    return _DrivingFormState();
  }
}

class _DrivingFormState extends State<DrivingForm> {
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  String value = "";
  final _formKey = GlobalKey<FormBuilderState>();


  void _onChanged(dynamic val) => debugPrint(val.toString());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          FormBuilder(
            key: _formKey,
            // enabled: false,
            onChanged: () {
              _formKey.currentState!.save();
              debugPrint(_formKey.currentState!.value.toString());
            },
            autovalidateMode: AutovalidateMode.disabled,
            skipDisabled: true,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 15),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Please provide the speed of vehicle past 1 hour?',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Please provide the speed of vehicle past 1 hour?',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),

                FormBuilderRadioGroup<String>(
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(
                      fontSize: 18, // Ajusta el tamaño de la fuente según lo necesites
                      fontWeight: FontWeight.bold, // Puedes hacer la fuente en negrita si lo deseas
                    ),
                  ),
                  initialValue: null,
                  name: 'speed',
                  onChanged: _onChanged,
                  validator: FormBuilderValidators.compose(
                      [FormBuilderValidators.required()]),
                  options: ['above 40km/h', 'below 40km/h', '0km/h']
                      .map((lang) => FormBuilderFieldOption(
                            value: lang,
                            child: Text(lang),
                          ))
                      .toList(growable: false),
                  controlAffinity: ControlAffinity.leading,
                ),

                const SizedBox(height: 10), // Espacio entre partes del form

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Enter remarks',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10), // Espacio entre partes del form

                FormBuilderTextField(
                  name: 'remark',
                  decoration: InputDecoration(
                    hintText: 'Enter your remarks', // Placeholder dentro del campo
                    hintStyle: TextStyle(
                      color: Colors.black, // Color del placeholder dentro del campo
                    ),
                    filled: true, // Habilita el fondo para el campo de texto
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)), // Bordes redondeados
                      borderSide: BorderSide(
                        color: Colors.transparent, // Sin borde al estar habilitado
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)), // Bordes redondeados
                      borderSide: BorderSide(
                        color: Colors.transparent, // Sin borde al estar enfocado
                      ),
                    ),
                  ),
                  style: TextStyle(
                    color: Colors.black, // Color del texto dentro del campo
                  ),
                  onChanged: _onChanged,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                ),

                const SizedBox(height: 10),
                const Divider(),
                const SizedBox(height: 10),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Please provide the high speed of vehicle?',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Please select one option given below',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 5),

                FormBuilderDropdown<String>(
                  decoration: InputDecoration(
                    hintText: 'Select options',
                    contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0), // Bordes redondeados
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0), // Bordes redondeados
                      borderSide: BorderSide(color: Colors.blue), // Puedes cambiar el color del borde enfocado
                    ),
                  ),
                  name: 'highspeed',
                  initialValue: null,
                  onChanged: _onChanged,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                  items: ['High', 'Medium', 'Low']
                      .map((speed) => DropdownMenuItem(
                    alignment: AlignmentDirectional.center,
                    value: speed,
                    child: Text(speed),
                  ))
                      .toList(),
                ),
                const SizedBox(height: 15),
                const Divider(),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Please provide the speed of vehicle past 1 hour?',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Please select one or more option given below',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 5),
                FormBuilderCheckboxGroup<String>(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(
                      fontSize: 18, // Ajusta el tamaño de la fuente según lo necesites
                      fontWeight: FontWeight.bold, // Puedes hacer la fuente en negrita si lo deseas
                    ),
                  ),
                  name: 'selectSpeed',
                  options: const [
                    FormBuilderFieldOption(value: '20km/h'),
                    FormBuilderFieldOption(value: '30km/h'),
                    FormBuilderFieldOption(value: '40km/h'),
                    FormBuilderFieldOption(value: '50km/h'),
                  ],
                  onChanged: _onChanged,
                  separator: const VerticalDivider(
                    width: 10,
                    thickness: 5,
                    color: Colors.red,
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.minLength(1),
                    FormBuilderValidators.maxLength(4),
                  ]),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end, // Alinea los elementos a la derecha
            children: <Widget>[
              FloatingActionButton(
                onPressed: () {
                  if (_formKey.currentState?.saveAndValidate() ?? false) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15), // Bordes redondeados
                          ),
                          title: Column(
                            children: [
                              Icon(Icons.check_circle, color: Colors.black), // Icono de éxito
                              SizedBox(width: 8), // Espacio entre icono y título
                              Text('Submission Completed'),
                            ],
                          ),
                          content: Text(
                            _formKey.currentState?.value.toString() ?? '',
                            style: TextStyle(fontSize: 16),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('Close'),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    debugPrint(_formKey.currentState?.value.toString());
                    debugPrint('validation failed');
                  }
                },
                backgroundColor: Colors.lightBlue[100], // Aquí cambiamos el color de fondo
                child: Icon(Icons.upload, color: Colors.black), // Icono de descarga
              ),
              const SizedBox(width: 20), // Espacio opcional
            ],
          ),
        ],
      ),
    );
  }
}
