import 'package:flutter/material.dart'; // lib flutter dart
import 'package:proj_letterflix/Filmes.dart'; // lib pagina principal filmes

// funcao principal
void main() {
  // aplicativo
  runApp(MaterialApp(
    home: Filmes("User", "user@gmail.com"), // pagina principal filmes com tema escuro
    theme: ThemeData.dark(), // tema escuro
    debugShowCheckedModeBanner: false, // sem faixa de debug
  ));
}
