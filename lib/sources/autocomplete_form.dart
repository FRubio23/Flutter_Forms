import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/src/intl/date_format.dart';

class AutocompleteForm extends StatefulWidget {
  const AutocompleteForm({super.key});

  @override
  State<AutocompleteForm> createState() {
    return _AutocompleteFormState();
  }
}

class _AutocompleteFormState extends State<AutocompleteForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  DateTime? selectedDate;

  // Ejemplo de lista de sugerencias para TypeAhead
  static const List<String> _allCountries = [
    'Argentina', 'Australia', 'Austria', 'Belgium', 'Brazil', 'Canada', 'Chile',
    'China', 'Colombia', 'Denmark', 'Egypt', 'Finland', 'France', 'Germany',
    'India', 'Indonesia', 'Italy', 'Japan', 'Kenya', 'Malaysia', 'Mexico',
    'Netherlands', 'New Zealand', 'Norway', 'Pakistan', 'Peru', 'Philippines',
    'Poland', 'Portugal', 'Russia', 'Saudi Arabia', 'Singapore', 'South Africa',
    'Spain', 'Sweden', 'Thailand', 'Turkey', 'United States', 'Vietnam'
  ];

  String stringAutocomplete = '';

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
                const SizedBox(height: 15),

                // TypeAheadField
                Autocomplete<String>(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text.isEmpty) {
                      return const Iterable<String>.empty();
                    }
                    return _allCountries.where((String option) {
                      return option.toLowerCase().contains(
                          textEditingValue.text.toLowerCase());
                    });
                  },
                  fieldViewBuilder: (BuildContext context,
                      TextEditingController textEditingController,
                      FocusNode focusNode,
                      VoidCallback onFieldSubmitted) {
                    return FormBuilderTextField(
                      name: 'autocomplete',
                      controller: textEditingController,
                      focusNode: focusNode,
                      decoration: InputDecoration(
                        labelText: 'Autocomplete',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 15),

                // Date Picker
                FormBuilderDateTimePicker(
                  name: 'date',
                  decoration: InputDecoration(
                    labelText: 'Select Date',
                    border: OutlineInputBorder(),
                  ),
                  validator: FormBuilderValidators.required(),
                  inputType: InputType.date,
                ),
                const SizedBox(height: 15),

                // Time Picker
                FormBuilderDateTimePicker(
                  name: 'time',
                  decoration: InputDecoration(
                    labelText: 'Select Time',
                    border: OutlineInputBorder(),
                  ),
                  validator: FormBuilderValidators.required(),
                  inputType: InputType.time,
                ),
                const SizedBox(height: 15),

                FormBuilderDateRangePicker(
                  name: 'date_range',  // Nombre del campo para el rango de fechas
                  decoration: InputDecoration(
                    labelText: 'Select Date Range',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.close),
                  ),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  format: DateFormat('yyyy-MM-dd'), // Formato de la fecha
                ),

                const SizedBox(height: 15),

                // Filter Chips (Checkboxes)
                FormBuilderFilterChip<String>(
                  name: 'chips',
                  options: ['HTML', 'CSS', 'React', 'Dart', 'TypeScript', 'Angular']
                      .map((lang) => FormBuilderChipOption(
                    value: lang,
                    child: Text(
                      lang,
                      style: TextStyle(color: Colors.white),
                    ),
                  ))
                      .toList(),
                  decoration: InputDecoration(
                    labelText: 'Input Chips(Filter Chips)',
                    border: OutlineInputBorder(),
                  ),
                  validator: FormBuilderValidators.required(),
                  selectedColor: Colors.blue, // Color de fondo cuando el chip está seleccionado
                  backgroundColor: Colors.blue[300], // Color de fondo cuando el chip no está seleccionado
                  checkmarkColor: Colors.white, // Color del checkmark cuando el chip está seleccionado
                  spacing: (12.0),
                  runSpacing: (12.0),
                  alignment: WrapAlignment.center,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(15)
                  ),
                ),
                const SizedBox(height: 15),

                // Submit Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FloatingActionButton(
                      onPressed: () {
                        if (_formKey.currentState?.saveAndValidate() ?? false) {
                          showModalBottomSheet(
                            context: context,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(15), // Bordes redondeados en la parte superior
                              ),
                            ),
                            builder: (context) {
                              return Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.check_circle, color: Colors.black, size: 40), // Icono de éxito
                                    SizedBox(height: 8), // Espacio entre icono y título
                                    Text(
                                      'Submission Completed',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      _formKey.currentState?.value.toString() ?? '',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    SizedBox(height: 16),
                                    TextButton(
                                      onPressed: () => Navigator.of(context).pop(),
                                      child: const Text('Close'),
                                    ),
                                  ],
                                ),
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
