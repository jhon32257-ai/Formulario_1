import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final _txtIdentificacion = TextEditingController();
  final _txtNombre = TextEditingController();
  final _txtCelular = TextEditingController();
  final _txtEmail = TextEditingController();
  final _soloLetras = RegExp(r'^[A-Za-zÁÉÍÓÚáéíóúÑñ ]+$');
  final _emailRegex = RegExp(
    r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$',
  );
  String? _generoSeleccionado;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registro Empleados"),
        backgroundColor: Colors.amberAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _txtIdentificacion,
                  decoration: InputDecoration(
                    labelText: 'Identificación',
                    hintText: "Solo números",
                    prefixIcon: Icon(Icons.badge),
                    border: OutlineInputBorder(),
                    counterText: '',
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "La indentificaón es obligatoria";
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _txtNombre,
                  decoration: InputDecoration(
                    labelText: "Nombre completo",
                    hintText: "Nombre(s) y Aplellido(s)",
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                  textCapitalization: TextCapitalization.words,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(_soloLetras),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "El nombre es obligatorio";
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  initialValue: _generoSeleccionado,
                  decoration: const InputDecoration(
                    labelText: 'Género',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.wc),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'Masculino',
                      child: Text('Masculino'),
                    ),
                    DropdownMenuItem(
                      value: 'Femenino',
                      child: Text('Femenino'),
                    ),
                  ],
                  onChanged: (value) =>
                      setState(() => _generoSeleccionado = value),
                  validator: (value) =>
                      value == null ? 'Selecciona un género' : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _txtCelular,
                  decoration: InputDecoration(
                    labelText: "Solo números",
                    hintText: "Son 10 digitos",
                    prefixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "El número de celular es obligatorio";
                    }
                    if (value.length < 10) {
                      return "El número de celular debe tener 10 digitos";
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _txtEmail,
                  decoration: InputDecoration(
                    labelText: "Email",
                    hintText: "alguien@gmail.com",
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  inputFormatters: [LengthLimitingTextInputFormatter(50)],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "El número de celular es obligatorio";
                    }
                    if (!_emailRegex.hasMatch(value)) {
                      return 'Formato de correo no válido';
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                  icon: Icon(Icons.save),
                  onPressed: () {
                    final esValido = _formKey.currentState!.validate();
                    if (!esValido)
                      return; // Hay errores: los mensajes se muestran debajo de los campos
                    _txtIdentificacion.clear();
                    _txtNombre.clear();
                    _txtCelular.clear();
                    _txtEmail.clear();
                  },
                  label: Text("Guardar"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
