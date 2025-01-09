
class User {
  final String id;
  final String googleId;
  final String email;
  final String? username;
  final String nombre;
  final DateTime? fechaNacimiento;
  final String? fotoPerfil;
  final DateTime fechaRegistro;
  final String estado;

  User({
    required this.id,
    required this.googleId,
    required this.email,
    this.username,
    required this.nombre,
    this.fechaNacimiento,
    this.fotoPerfil,
    required this.fechaRegistro,
    required this.estado,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      googleId: json['google_id'],
      email: json['email'],
      username: json['username'],
      nombre: json['nombre'],
      fechaNacimiento: json['fecha_nacimiento'] != null 
          ? DateTime.parse(json['fecha_nacimiento'])
          : null,
      fotoPerfil: json['foto_perfil'],
      fechaRegistro: DateTime.parse(json['fecha_registro']),
      estado: json['estado'],
    );
  }
}