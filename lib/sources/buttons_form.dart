import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class ButtonsForm extends StatefulWidget {
  const ButtonsForm({super.key});

  @override
  State<ButtonsForm> createState() {
    return _ButtonsFormState();
  }
}

class _ButtonsFormState extends State<ButtonsForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  var speedOptions = ['Option 1', 'Option 2', 'Option 3', 'Option 4'];

  void _onChanged(dynamic val) => debugPrint(val.toString());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          FormBuilder(
            key: _formKey,
            onChanged: () {
              _formKey.currentState!.save();
              debugPrint(_formKey.currentState!.value.toString());
            },
            autovalidateMode: AutovalidateMode.disabled,
            skipDisabled: true,
            child: Column(
              children: <Widget>[

                // Filter Chips (Checkboxes)
                FormBuilderFilterChip<String>(
                  name: 'chips',
                  options: ['Flutter', 'Android', 'Chrome OS']
                      .map((lang) => FormBuilderChipOption(
                    value: lang,
                    child: lang == 'Flutter'
                        ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/flutter_logo.png', // Ruta de tu imagen en assets
                          width: 24, // Ancho de la imagen
                          height: 24, // Alto de la imagen
                        ),
                        SizedBox(width: 4), // Espacio entre la imagen y el texto
                        Text(
                          lang,
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    )
                        : Text(
                      lang,
                      style: TextStyle(color: Colors.white),
                    ),
                  ))
                      .toList(),
                  decoration: InputDecoration(
                    labelText: 'Choice Chips',
                    border: OutlineInputBorder(),
                  ),
                  validator: FormBuilderValidators.required(),
                  selectedColor: Colors.blue, // Color de fondo cuando el chip está seleccionado
                  backgroundColor: Colors.blue[300], // Color de fondo cuando el chip no está seleccionado
                  checkmarkColor: Colors.white, // Color del checkmark cuando el chip está seleccionado
                  spacing: 12.0,
                  runSpacing: 12.0,
                  alignment: WrapAlignment.center,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                const SizedBox(height: 15),

                FormBuilderSwitch(
                  title: const Text('This is a Switch'),
                  name: 'switch',
                  initialValue: true,
                  decoration: InputDecoration(
                    labelText: 'Switch',
                    hintStyle: const TextStyle(
                      color: Colors.grey, // Color opcional para el hintText
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0), // Bordes redondeados
                      borderSide: const BorderSide(color: Colors.grey), // Color del borde
                    ),
                  ),
                  onChanged: _onChanged,
                ),
                const SizedBox(height: 15),

                FormBuilderTextField(
                  name: 'textfield',
                  decoration: InputDecoration(
                    labelText: 'Text Field', // Placeholder dentro del campo
                    labelStyle: TextStyle(
                      color: Colors.black, // Color del placeholder dentro del campo
                    ),
                    filled: true, // Habilita el fondo para el campo de texto
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)), // Bordes redondeados
                      borderSide: BorderSide(
                        color: Colors.black, // Sin borde al estar habilitado
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)), // Bordes redondeados
                      borderSide: BorderSide(
                        color: Colors.blue, // Sin borde al estar enfocado
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
                const SizedBox(height: 15),

                FormBuilderDropdown<String>(
                  name: 'options',
                  decoration: InputDecoration(
                    labelText: 'Dropdrow Field',
                    hintStyle: const TextStyle(
                      color: Colors.grey, // Color opcional para el hintText
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(color: Colors.grey)
                    ),
                  ),
                  items: speedOptions
                      .map((speed) => DropdownMenuItem(
                    alignment: AlignmentDirectional.centerStart,
                    value: speed,
                    child: Text(speed),
                  ))
                      .toList(),
                  borderRadius: BorderRadius.circular(8),
                  onChanged: _onChanged,
                ),
                const SizedBox(height: 15),

                FormBuilderRadioGroup<String>(
                  decoration: InputDecoration(
                    labelText: 'Radio Group Model',
                    hintStyle: const TextStyle(
                      color: Colors.grey, // Color opcional para el hintText
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(color: Colors.grey)
                    ),
                  ),
                  initialValue: null,
                  name: 'Radiogroup',
                  onChanged: _onChanged,
                  validator: FormBuilderValidators.compose(
                      [FormBuilderValidators.required()]),
                  options: ['Option 1', 'Option 2', 'Option 3', 'Option 4']
                      .map((km) => FormBuilderFieldOption(
                    value: km,
                    child: Text(km),
                  ))
                      .toList(growable: false),
                  controlAffinity: ControlAffinity.leading,
                  orientation: OptionsOrientation.vertical,
                ),
                const SizedBox(height: 15),

                // Submit Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FloatingActionButton(
                      onPressed: () {
                        if (_formKey.currentState?.saveAndValidate() ?? false) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return SimpleDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15), // Bordes redondeados del diálogo
                                ),
                                contentPadding: const EdgeInsets.all(16.0), // Padding dentro del diálogo
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(height: 8),
                                      Text(
                                        _formKey.currentState?.value.toString() ?? '',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      SizedBox(height: 16),
                                    ],
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          debugPrint(_formKey.currentState?.value.toString());
                          debugPrint('Validation failed');
                        }
                      },
                      backgroundColor: Colors.lightBlue[100], // Color de fondo del botón flotante
                      child: Icon(Icons.upload, color: Colors.black), // Icono de carga
                    ),
                    const SizedBox(width: 20), // Espacio opcional
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
