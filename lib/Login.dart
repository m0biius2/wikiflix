import 'package:flutter/material.dart';
import 'package:proj_letterflix/Cadastro.dart';
import 'package:proj_letterflix/Filmes.dart';
import 'package:proj_letterflix/Perfil.dart';

class LogIn extends StatefulWidget {
  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {

  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();

  //método que apaga os dados
  void limparDados(){
    setState((){
      _controllerNome.clear(); //limpa o controller
      _controllerSenha.clear();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login",
          style: TextStyle(
              fontWeight: FontWeight.w500
          ),
        ),
        backgroundColor: Colors.red.shade800, //cor navbar
      ),
      // menu de navegacao lateral
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Column(
              children: [
                // dados do user
                Container(
                  padding: EdgeInsets.fromLTRB(20, 40, 20, 40),
                  decoration: BoxDecoration(color: Colors.red.shade800),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "User",
                              style:  TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "user@gmail.com",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                // paginas do app
                // navigator pagina perfil
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 30, 0, 0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Perfil("User", "user@gmail.com")
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.account_circle_outlined,
                          color: Colors.red.shade800,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            "Perfil",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // navigator pagina filmes
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 25, 0, 0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Filmes("User", "user@gmail.com")
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.movie_creation_outlined,
                          color: Colors.red.shade800,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            "Filmes",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // botoes login/cadastro
                // login
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 430, 30, 0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.red.shade800)),
                    onPressed: () {

                    },
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Login",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                // cadastro
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.red.shade800)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Cadastro()
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Cadastre-se",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: TextField(
                controller: _controllerNome,
                maxLength: 50, // tamanho máximo do campo
                keyboardType: TextInputType.text, // estilo teclado
                decoration: InputDecoration(
                  labelText: "Digite seu nome completo",
                  labelStyle: TextStyle(
                    color: Colors.red.shade800, //nome da escrita que aparece
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.red.shade800
                      )),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.red.shade800
                      )),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: TextField(
                controller: _controllerSenha,
                obscureText: true, //deixa o texto obscuro
                maxLength: 8, // tamanho máximo do campo
                keyboardType: TextInputType.text, // estilo teclado
                decoration: InputDecoration(
                  labelText: "Digite sua senha",
                  labelStyle: TextStyle(
                    color: Colors.red.shade800, //nome da escrita que aparece
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.red.shade800
                      )),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.red.shade800
                      )),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                    child: GestureDetector(
                      child: ElevatedButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Filmes("User", "user@gmail.com")));
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.red.shade800)),
                        child: Text(
                          "Enviar",
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ), //botão enviar
                      ),
                    )
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.red.shade800)),
                    onPressed: limparDados, //chama a função apagar dados
                    child: Text(
                      "Limpar",
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ), //botão limpar
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
