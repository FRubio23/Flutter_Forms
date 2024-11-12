import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class WizardForm extends StatefulWidget {
  const WizardForm({super.key});

  @override
  State<WizardForm> createState() => _WizardFormState();
}

class _WizardFormState extends State<WizardForm> {
  // Clave global para el FormBuilder (para validación y gestión del estado)
  final _formKey = GlobalKey<FormBuilderState>();
  final PageController _pageController = PageController(); // Controlador de las páginas del wizard

  // Función para ir al siguiente paso del formulario
  void _goToNextPage() {
    if (_pageController.page == 0) {
      // Si estamos en el paso 1, pasamos al paso 2
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300), // Duración de la animación
        curve: Curves.ease, // Curva de la animación
      );
    } else if (_pageController.page == 1) {
      // Si estamos en el paso 2, pasamos al paso 3
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  // Función para volver al paso anterior
  void _goBack() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300), // Duración de la animación
      curve: Curves.ease, // Curva de la animación
    );
  }

  // Función para ir al paso específico al hacer clic en los avatares
  void _goToStep(int step) {
    _pageController.jumpToPage(step - 1); // -1 porque PageView comienza desde 0
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Indicadores de los pasos (Horizontal)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildStepIndicator(1, 'Personal'),
                _buildStepIndicator(2, 'Contact'),
                _buildStepIndicator(3, 'Upload'),
              ],
            ),
          ),
          // PageView para navegar entre los pasos (Cada página será un paso)
          Expanded(
            child: PageView(
              controller: _pageController, // Controlador de la vista
              onPageChanged: (index) {
                setState(() {}); // Redibujamos cuando se cambia la página
              },
              children: [
                // Paso Personal
                _buildPersonalStep(),
                // Paso Contact
                _buildContactStep(),
                // Paso Upload
                _buildUploadStep(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget para el indicador de cada paso (números y etiquetas)
  // Ahora los indicadores son interactivos y permiten navegar a los pasos
  Widget _buildStepIndicator(int step, String label) {
    // Obtiene la página actual
    int currentPage = (_pageController.hasClients)
        ? _pageController.page!.toInt() + 1
        : 1;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => _goToStep(step),  // Al hacer clic en el avatar, va al paso correspondiente
            child: CircleAvatar(
              radius: 20,
              backgroundColor: currentPage >= step ? Colors.blue : Colors.grey,
              child: Text(
                '$step', // Número del paso
                style: TextStyle(
                  color: currentPage >= step ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          // Etiqueta del paso
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  // Paso Personal: aquí se muestra el contenido del primer paso
  Widget _buildPersonalStep() {
    return SingleChildScrollView( // Hacemos el paso desplazable si el contenido es muy largo
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          const Text('Personal', style: TextStyle(fontSize: 24)), // Título del paso
          const SizedBox(height: 10),
          const Text('Pulsa Contact o pulsa el botón de continuar'),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Botón para continuar al siguiente paso
              ElevatedButton(
                onPressed: _goToNextPage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Color de fondo del botón
                  foregroundColor: Colors.white, // Color del texto del botón
                ),
                child: const Text('Continue'),
              ),
              const SizedBox(width: 20),
              // Botón para cancelar (volvemos a la pantalla anterior)
              OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.blue), // Bordes de color azul
                ),
                child: const Text('Cancel', style: TextStyle(color: Colors.blue)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Paso Contacto: aquí se muestra el contenido del segundo paso
  Widget _buildContactStep() {
    return SingleChildScrollView( // Hacemos el paso desplazable si el contenido es muy largo
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          const Text('Contact', style: TextStyle(fontSize: 24)), // Título del paso
          const SizedBox(height: 10),
          const Text('Pulsa Upload o pulsa el botón de continuar'),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Botón para continuar al siguiente paso
              ElevatedButton(
                onPressed: _goToNextPage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Color de fondo
                  foregroundColor: Colors.white, // Color del texto
                ),
                child: const Text('Continue'),
              ),
              const SizedBox(width: 20),
              // Botón para volver al paso anterior
              OutlinedButton(
                onPressed: _goBack,
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.blue), // Bordes del botón
                ),
                child: const Text('Cancel', style: TextStyle(color: Colors.blue)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Paso Subir: este paso contiene un formulario
  Widget _buildUploadStep() {
    return SingleChildScrollView( // Hacemos el paso desplazable si el contenido es muy largo
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            // Formulario con campos de texto
            FormBuilder(
              key: _formKey, // Asignamos la clave global para el formulario
              child: Column(
                children: <Widget>[
                  // Campo de texto para el correo electrónico
                  FormBuilderTextField(
                    name: 'email',
                    decoration: const InputDecoration(
                      icon: Icon(Icons.email),
                      hintText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(), // Validación de que es obligatorio
                    ]),
                  ),
                  const SizedBox(height: 10),
                  // Campo de texto para la dirección
                  FormBuilderTextField(
                    name: 'address',
                    decoration: const InputDecoration(
                      icon: Icon(Icons.home),
                      hintText: 'Address',
                      border: OutlineInputBorder(),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                  const SizedBox(height: 10),
                  // Campo de texto para el número móvil
                  FormBuilderTextField(
                    name: 'mobile',
                    decoration: const InputDecoration(
                      icon: Icon(Icons.phone),
                      hintText: 'Movile Nº',
                      border: OutlineInputBorder(),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Botón para continuar si el formulario es válido
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.saveAndValidate() ?? false) {
                            final formData = _formKey.currentState!.value;
                            // Mostrar los datos en un Snackbar
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Datos: $formData'),
                              ),
                            );
                          } else {
                            // Si el formulario no es válido, mostrar un mensaje de error
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Por favor, rellena todos los campos.'),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue, // Color del botón
                          foregroundColor: Colors.white, // Color del texto
                        ),
                        child: const Text('Continue'),
                      ),
                      const SizedBox(width: 20),
                      // Botón para cancelar y volver al paso anterior
                      OutlinedButton(
                        onPressed: _goBack,
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.blue),
                        ),
                        child: const Text('Cancel', style: TextStyle(color: Colors.blue)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}