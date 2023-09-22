import 'dart:async';
import 'dart:io';

// Función para capturar información de una Motocicleta por teclado
Map<String, dynamic> capturarInformacionMoto() {
  var moto = <String, dynamic>{};
  print('Color:');
  moto['color'] = stdin.readLineSync();
  print('Matrícula:');
  moto['matricula'] = stdin.readLineSync();
  print('Combustible (litros):');
  moto['conbustible_litros'] = double.parse(stdin.readLineSync() ?? '0');
  print('Número de ruedas:');
  moto['numero_ruedas'] = int.parse(stdin.readLineSync() ?? '0');
  print('Marca:');
  moto['marca'] = stdin.readLineSync();
  print('Modelo:');
  moto['modelo'] = stdin.readLineSync();
  print('Fecha de fabricación:');
  moto['fecha_fabricacion'] = stdin.readLineSync();
  print('Velocidad punta:');
  moto['velocidad_punta'] = double.parse(stdin.readLineSync() ?? '0');
  print('Peso:');
  moto['peso'] = double.parse(stdin.readLineSync() ?? '0');
  print('Número de asientos:');
  moto['num_asientos'] = int.parse(stdin.readLineSync() ?? '0');
  print('Tipo de motor:');
  moto['tipo_motor'] = stdin.readLineSync();
  print('Transmisión:');
  moto['transmision'] = stdin.readLineSync();
  print('Velocidad máxima:');
  moto['velocidadMaxima'] = int.parse(stdin.readLineSync() ?? '0');
  return moto;
}

// Función para imprimir información de Motocicletas en un mapa
void imprimirInformacionMotocicletas(
    Map<String, Motocicleta> mapa, String titulo) {
  print(titulo);
  mapa.forEach((nombre, moto) {
    print('$nombre:');
    print(moto.toString());
  });
  print('');
}

// Funciones para realizar pruebas de métodos, getters, setters y mixins para una Motocicleta
Future<String> realizarPruebaArranque(Motocicleta moto) async {
  try {
    var mensajeArranque = await moto.arrancar();
    return mensajeArranque;
  } catch (e) {
    return 'Error al arrancar: $e';
  }
}

Future<String> realizarPruebaDetener(Motocicleta moto) async {
  try {
    var mensajeDetener = await moto.detener();
    return mensajeDetener;
  } catch (e) {
    return 'Error al detener: $e';
  }
}


void realizarPruebaFrenar(Motocicleta moto) {
  print('Frenar la Motocicleta:');
  var mensajeFrenado = moto.frenarMoto(moto.Velocidad);
  print(mensajeFrenado);
}

void realizarPruebaAcelerar(Motocicleta moto) {
  print('Acelerar la Motocicleta:');
  var mensajeAceleracion =
      moto.acelerarMoto(moto.velocidadMaxima, moto.Velocidad);
  print(mensajeAceleracion);
}

mixin Frenar {
  String frenarMoto(int velocidad) {
    if (velocidad == 0) {
      return "La velocidad de la moto está en cero";
    } else {
      return "La moto no está frenando";
    }
  }
}
mixin Acelerar {
  String acelerarMoto(int velocidadMaxima, int velocidad) {
    if (velocidad > 70) {
      velocidad *= 2;
      if (velocidad > velocidadMaxima) {
        return "Velocidad de moto excedida";
      }
    }
    return "La velocidad actual es $velocidad km/h";
  }
}

class Motocicleta with Frenar, Acelerar {
  static const MotocicletaNueva = "nueva";

  String? color;
  String? matricula;
  double? conbustible_litros;
  int? numero_ruedas;
  String? marca;
  String? modelo;
  String? fecha_fabricacion;
  double? velocidad_punta;
  double? peso;
  int? num_asientos;
  String? tipo_motor;
  String? transmision;
  bool estado = false;
  int Velocidad = 0;
  int velocidadMaxima = 0;

  Motocicleta(
    this.color,
    this.matricula,
    this.conbustible_litros,
    this.numero_ruedas,
    this.marca,
    this.modelo,
    this.fecha_fabricacion,
    this.velocidad_punta,
    this.peso,
    this.num_asientos,
    this.tipo_motor,
    this.transmision,
  );

  Motocicleta.fromMap(Map<String, dynamic> mapa)
      : color = mapa['color'],
        matricula = mapa['matricula'],
        conbustible_litros = mapa['conbustible_litros']?.toDouble(),
        numero_ruedas = mapa['numero_ruedas']?.toInt(),
        marca = mapa['marca'],
        modelo = mapa['modelo'],
        fecha_fabricacion = mapa['fecha_fabricacion'],
        velocidad_punta = mapa['velocidad_punta']?.toDouble(),
        peso = mapa['peso']?.toDouble(),
        num_asientos = mapa['num_asientos']?.toInt(),
        tipo_motor = mapa['tipo_motor'],
        velocidadMaxima = mapa['velocidadMaxima']?.toInt(),
        transmision = mapa['transmision'];

  bool? get getEstado => estado;

  set setEstado(bool value) {
    estado = value;
  }

  String? get getMarca => marca;

  set setMarca(String? value) {
    marca = value;
  }

  String? get getMatricula => matricula;

  set setMatricula(String? value) {
    matricula = value;
  }

  Future<String> arrancar() async {
    if (estado == false) {
      await Future.delayed(Duration(seconds: 1));
      return "La moto arranca";
    } else {
      throw Exception("algo salio mal");
    }
  }

  Future<String> detener() async {
    if (estado == false) {
      return "La moto se encuentra apagada";
    } else {
      await Future.delayed(Duration(milliseconds: 500));
      this.setEstado = false;
      return "moto apagada";
    }
  }

  @override
  String toString() {
    return 'Motocicleta:\n'
        'Color: $color\n'
        'Matrícula: $matricula\n'
        'Combustible (litros): $conbustible_litros\n'
        'Número de ruedas: $numero_ruedas\n'
        'Marca: $marca\n'
        'Modelo: $modelo\n'
        'Fecha de fabricación: $fecha_fabricacion\n'
        'Velocidad punta: $velocidad_punta\n'
        'Peso: $peso\n'
        'Número de asientos: $num_asientos\n'
        'Tipo de motor: $tipo_motor\n'
        'Transmisión: $transmision\n'
        'Estado: ${estado ? 'Encendida' : 'Apagada'}';
  }
}

void main() async {
  // Crear tres mapas para almacenar las motocicletas
  var mapaMotos1 = <String, Motocicleta>{};
  var mapaMotos2 = <String, Motocicleta>{};
  var mapaMotos3 = <String, Motocicleta>{};

  // Capturar información de cada motocicleta por teclado
  print('Ingrese información de la primera motocicleta:');
  var moto1 = capturarInformacionMoto();
  print('Ingrese información de la segunda motocicleta:');
  var moto2 = capturarInformacionMoto();
  print('Ingrese información de la tercera motocicleta:');
  var moto3 = capturarInformacionMoto();

  // Crear una instancia para cada motocicleta
  var motocicleta1 = Motocicleta.fromMap(moto1);
  var motocicleta2 = Motocicleta.fromMap(moto2);
  var motocicleta3 = Motocicleta.fromMap(moto3);

  // Agregar las motocicletas a los mapas
  mapaMotos1['Moto1'] = motocicleta1;
  mapaMotos2['Moto2'] = motocicleta2;
  mapaMotos3['Moto3'] = motocicleta3;

  // Realizar pruebas de métodos, getters, setters y mixins para cada motocicleta
  int opcion;

  do {
    print('Seleccione una prueba:');
    print('1. Arrancar la Motocicleta');
    print('2. Detener la Motocicleta');
    print('3. Frenar la Motocicleta');
    print('4. Acelerar la Motocicleta');
    print('0. para salir');
    opcion = int.parse(stdin.readLineSync() ?? '0');

    switch (opcion) {
      case 1:
        print(await realizarPruebaArranque(motocicleta1));
        print(await realizarPruebaArranque(motocicleta2));
        print(await realizarPruebaArranque(motocicleta3));

        break;
      case 2:
        print(await realizarPruebaDetener(motocicleta1));
        print(await realizarPruebaDetener(motocicleta2));
        print(await realizarPruebaDetener(motocicleta3));

        break;
      case 3:
        realizarPruebaFrenar(motocicleta1);
        realizarPruebaFrenar(motocicleta2);
        realizarPruebaFrenar(motocicleta3);
        break;
      case 4:
        realizarPruebaAcelerar(motocicleta1);
        realizarPruebaAcelerar(motocicleta2);
        realizarPruebaAcelerar(motocicleta3);
        break;
      case 0:
        print('Saliendo del programa.');
        break;
      default:
        print('Opción no válida');
    }
  } while (opcion != 0);
  // Imprimir información de las motocicletas en los mapas
  imprimirInformacionMotocicletas(mapaMotos1, 'Mapa de Moto1:');
  imprimirInformacionMotocicletas(mapaMotos2, 'Mapa de Moto2:');
  imprimirInformacionMotocicletas(mapaMotos3, 'Mapa de Moto3:');
}
