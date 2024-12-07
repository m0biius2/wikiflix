import 'package:flutter/material.dart';
import 'package:proj_letterflix/Filmes.dart';
import 'package:proj_letterflix/Login.dart';
import 'package:proj_letterflix/Perfil.dart';

class Cadastro extends StatefulWidget {
  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {

  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerNomeUsuario = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerNumero = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();

  //método que apaga os dados
  void limparDados(){
    setState((){
      _controllerNome.clear(); //limpa o controller
      _controllerNomeUsuario.clear();
      _controllerEmail.clear();
      _controllerNumero.clear();
      _acao = false;
      _aventura = false;
      _comedia = false;
      _drama = false;
      _fantasia = false;
      _musical = false;
      _romance = false;
      _terror = false;
      _controllerSenha.clear();
    });
  }

  void _navegacao(){}

  //atributos para o checkbox
  bool _acao = false;
  bool _aventura = false;
  bool _comedia = false;
  bool _drama = false;
  bool _fantasia = false;
  bool _musical = false;
  bool _romance = false;
  bool _terror = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cadastro",
          style: TextStyle(
              fontWeight: FontWeight.w500
          ),
        ),
        backgroundColor: Colors.red.shade800, // cor navbar
      ),
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
                            builder: (context) => Filmes(_controllerNomeUsuario.text, _controllerEmail.text)
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LogIn()
                        ),
                      );
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
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: TextField(
                controller: _controllerNomeUsuario,
                maxLength: 50, // tamanho máximo do campo
                keyboardType: TextInputType.text, // estilo teclado
                decoration: InputDecoration(
                  labelText: "Insira um nome de usuário",
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
              padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: TextField(
                controller: _controllerEmail,
                maxLength: 50, // tamanho máximo do campo
                keyboardType: TextInputType.emailAddress, // estilo teclado
                decoration: InputDecoration(
                  labelText: "Insira seu email",
                  labelStyle: TextStyle(
                    color: Colors.red.shade800,
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
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: TextField(
                controller: _controllerNumero,
                maxLength: 10, // tamanho máximo do campo
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Insira seu número",
                  labelStyle: TextStyle(
                    color: Colors.red.shade800,
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
              padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
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

            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "Escolha seus gêneros de filmes preferidos:",
                style: TextStyle(
                  color: Colors.red.shade800,
                  fontSize: 18, //define o tamanho da imagem
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CheckboxListTile(
                    title: Text("Ação"), //titulo
                    activeColor: Colors.pink, //a cor quando ele estiver ativo
                    value: _acao,
                    onChanged: (bool? valor){
                      setState((){
                        _acao = valor!;
                      });
                    }
                ),
                CheckboxListTile(
                    title: Text("Aventura"), //titulo
                    activeColor: Colors.pink, //a cor quando ele estiver ativo
                    value: _aventura,
                    onChanged: (bool? valor){
                      setState((){
                        _aventura = valor!;
                      });
                    }
                ),
                CheckboxListTile(
                    title: Text("Comédia"), //titulo
                    activeColor: Colors.pink, //a cor quando ele estiver ativo
                    value: _comedia,
                    onChanged: (bool? valor){
                      setState((){
                        _comedia = valor!;
                      });
                    }
                ),
                CheckboxListTile(
                    title: Text("Drama"), //titulo
                    activeColor: Colors.pink, //a cor quando ele estiver ativo
                    value: _drama,
                    onChanged: (bool? valor){
                      setState((){
                        _drama = valor!;
                      });
                    }
                ),
                CheckboxListTile(
                    title: Text("Fantasia"), //titulo
                    activeColor: Colors.pink, //a cor quando ele estiver ativo
                    value: _fantasia,
                    onChanged: (bool? valor){
                      setState((){
                        _fantasia = valor!;
                      });
                    }
                ),
                CheckboxListTile(
                    title: Text("Musical"), //titulo
                    activeColor: Colors.pink, //a cor quando ele estiver ativo
                    value: _musical,
                    onChanged: (bool? valor){
                      setState((){
                        _musical = valor!;
                      });
                    }
                ),
                CheckboxListTile(
                    title: Text("Romance"), //titulo
                    activeColor: Colors.pink, //a cor quando ele estiver ativo
                    value: _romance,
                    onChanged: (bool? valor){
                      setState((){
                        _romance = valor!;
                      });
                    }
                ),
                CheckboxListTile(
                    title: Text("Terror"), //titulo
                    activeColor: Colors.pink, //a cor quando ele estiver ativo
                    value: _terror,
                    onChanged: (bool? valor){
                      setState((){
                        _terror = valor!;
                      });
                    }
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                    child: GestureDetector(
                      child: ElevatedButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Filmes(_controllerNomeUsuario.text, _controllerEmail.text)));
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
