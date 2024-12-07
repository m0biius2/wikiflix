import 'package:flutter/material.dart';
import 'package:proj_letterflix/Cadastro.dart';
import 'package:proj_letterflix/Detalhes.dart';
import 'package:proj_letterflix/Filmes.dart';
import 'package:proj_letterflix/Login.dart';
import 'dart:convert'; // lib conversao de arquivos json e xml da api
import 'package:http/http.dart' as http; // lib http para a api

class Perfil extends StatefulWidget {
  // Atributos
  String nome;
  String email;

  // Método construtor declarando o atributo a ser passado
  Perfil(this.nome, this.email);

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  // Atributos
  Color red = Colors.red.shade800; // Cor tema do app
  bool _editar = false; // Visibilidade dos itens de edição
  double _tamanhoContainer = 250; // Tamanho do container vermelho
  String _posterGenteGrande = "";
  String _nomeGenteGrande = "";
  String _posterStarWars = "";
  String _nomeStarWars = "";
  String _posterBarbie = "";
  String _nomeBarbie = "";
  // icones de favorito
  var _iconFavGenteGrande = Icon(Icons.favorite_rounded);
  var _iconFavStarWars = Icon(Icons.favorite_rounded);
  var _iconFavBarbie = Icon(Icons.favorite_rounded);
  // visibilidade dos filmes
  bool _visiGenteGrande = true;
  bool _visiStarWars = true;
  bool _visiBarbie = true;

  TextEditingController _nomeController = TextEditingController(); // Controller do TextField de alterar o nome

  // metodos
  // metodo sobrescrito initState que define valores quando o widget/pagina é inicializado
  @override
  void initState() {
    super.initState(); // metodo original que garante que o widget seja inicializado sem imprevistos
    // inicia os metodos para pedir as informacoes da api
    _genteGrande();
    _starWars();
    _barbie();
  }

  // metodo filme que busca os dados do filme de acordo com o id na api
  void _genteGrande() async { // async permite que o restante da pagina inicialize fora de sincronia com a api pois ela demora mais para carregar
    // API
    // atributo url que puxa o endpoint da api o id do filme e a chave de ativacao em pt-br
    String url = "https://api.themoviedb.org/3/movie/38365?api_key=6308092f684c21817487e022da14de05&language=pt-BR";
    http.Response response; // http.Response solicita uma resposta via http pela lib adicionada

    // define que a resposta armazenada em response seja a solicitacao da url da api em formato uri/json
    response = await http.get(Uri.parse(url)); // await pausa o async enquanto busca as informações necessárias

    Map<String, dynamic> retorno = json.decode(response.body); // map retorno percorre e decodifica a resposta json vinda de response (dados do filme)
    setState(() {
      _posterGenteGrande = "https://image.tmdb.org/t/p/w500${retorno["poster_path"]}";
      _nomeGenteGrande = retorno["title"];
    });
  }

  // metodo filme que busca os dados do filme de acordo com o id na api
  void _starWars() async { // async permite que o restante da pagina inicialize fora de sincronia com a api pois ela demora mais para carregar
    // API
    // atributo url que puxa o endpoint da api o id do filme e a chave de ativacao em pt-br
    String url = "https://api.themoviedb.org/3/movie/11?api_key=6308092f684c21817487e022da14de05&language=pt-BR";
    http.Response response; // http.Response solicita uma resposta via http pela lib adicionada

    // define que a resposta armazenada em response seja a solicitacao da url da api em formato uri/json
    response = await http.get(Uri.parse(url)); // await pausa o async enquanto busca as informações necessárias

    Map<String, dynamic> retorno = json.decode(response.body); // map retorno percorre e decodifica a resposta json vinda de response (dados do filme)
    setState(() {
      _posterStarWars = "https://image.tmdb.org/t/p/w500${retorno["poster_path"]}";
      _nomeStarWars = retorno["title"];
    });
  }

  // metodo filme que busca os dados do filme de acordo com o id na api
  void _barbie() async { // async permite que o restante da pagina inicialize fora de sincronia com a api pois ela demora mais para carregar
    // API
    // atributo url que puxa o endpoint da api o id do filme e a chave de ativacao em pt-br
    String url = "https://api.themoviedb.org/3/movie/346698?api_key=6308092f684c21817487e022da14de05&language=pt-BR";
    http.Response response; // http.Response solicita uma resposta via http pela lib adicionada

    // define que a resposta armazenada em response seja a solicitacao da url da api em formato uri/json
    response = await http.get(Uri.parse(url)); // await pausa o async enquanto busca as informações necessárias

    Map<String, dynamic> retorno = json.decode(response.body); // map retorno percorre e decodifica a resposta json vinda de response (dados do filme)
    setState(() {
      _posterBarbie = "https://image.tmdb.org/t/p/w500${retorno["poster_path"]}";
      _nomeBarbie = retorno["title"];
    });
  }

  @override
  Widget build(BuildContext context) {
    // Aplicativo
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Perfil",
          style: TextStyle(
              fontWeight: FontWeight.w500
          ),
        ),
        backgroundColor: Colors.red.shade800,
        foregroundColor: Colors.white,
      ),
      // Menu de navegação lateral
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Column(
              children: [
                // Dados do usuário
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
                              widget.nome,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              widget.email,
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
                // Páginas do app
                // Navigator página perfil
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 30, 0, 0),
                  child: GestureDetector(
                    onTap: () {

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
                // Navigator página filmes
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 25, 0, 0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Filmes(widget.nome, widget.email)
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
                // Botões login/cadastro
                // Login
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
                // Cadastro
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
        child: Container(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: _tamanhoContainer,
                decoration: BoxDecoration(
                    color: red,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(24),
                        bottomLeft: Radius.circular(24)
                    )
                ),
                padding: EdgeInsets.only(top: 40,),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.nome,
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(top: 15),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.email,
                          style: TextStyle(
                              fontSize: 20,
                              fontStyle: FontStyle.italic
                          ),
                        ),
                      ],
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 30)
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(
                                      Colors.red.shade800)),
                              onPressed: () {
                                setState(() {
                                  _editar = true;
                                  _tamanhoContainer = 400;
                                });
                              },
                              child: Icon(
                                Icons.create,
                                color: Colors.white,
                              )
                          ),
                        ),
                      ],
                    ),
                    Visibility(
                        visible: _editar,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: "Alterar nome de usuário",
                                  labelStyle: TextStyle(
                                    color: Colors.white, // Cor da escrita que aparece
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white
                                      )),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white
                                      )),
                                ),
                                keyboardType: TextInputType.text,
                                controller: _nomeController,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(
                                          Colors.red.shade800)),
                                  onPressed: () {
                                    setState(() {
                                      _editar = false;
                                      _tamanhoContainer = 250;
                                      widget.nome = _nomeController.text;
                                    });
                                  },
                                  child: Text(
                                    "Enviar",
                                    style: TextStyle(color: Colors.white),
                                  )
                              ),
                            ),
                          ],
                        )
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 50, left: 40, right: 60),
                    child: Text(
                      "Favoritos",
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 40, left: 60),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.red.shade800)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Filmes(widget.nome, widget.email)
                            ),
                          );
                        },
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        )
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: _visiGenteGrande,
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 65, left: 30),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Detalhes(38365)
                              ),
                            );
                          },
                          child: Image.network(_posterGenteGrande,
                            width: 100,
                            height: 100,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(padding: EdgeInsets.only(top: 25, right: 20),
                            child: GestureDetector(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Detalhes(38365)
                                  ),
                                );
                              },
                              child: Text(
                                _nomeGenteGrande,
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: GestureDetector(
                              onTap: (){
                                setState(() {
                                  _visiGenteGrande = false;
                                });
                              },
                              child: _iconFavGenteGrande,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
              ),
              Visibility(
                visible: _visiStarWars,
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 70, left: 30),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Detalhes(11)
                              ),
                            );
                          },
                          child: Image.network(_posterStarWars,
                            width: 100,
                            height: 100,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(padding: EdgeInsets.only(top: 25, right: 20),
                            child: GestureDetector(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Detalhes(11)
                                  ),
                                );
                              },
                              child: Text(
                                _nomeStarWars,
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: GestureDetector(
                              onTap: (){
                                _visiStarWars = false;
                              },
                              child: _iconFavStarWars,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
              ),
              Visibility(
                visible: _visiBarbie,
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 70, left: 30),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Detalhes(346698)
                              ),
                            );
                          },
                          child: Image.network(_posterBarbie,
                            width: 100,
                            height: 100,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(padding: EdgeInsets.only(top: 25, right: 20),
                            child: GestureDetector(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Detalhes(346698)
                                  ),
                                );
                              },
                              child: Text(
                                _nomeBarbie,
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: GestureDetector(
                              onTap: (){
                                _visiBarbie = false;
                              },
                              child: _iconFavBarbie,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
              ),
              Padding(padding: EdgeInsets.only(top: 30))
            ],
          ),
        ),
      ),
    );
  }
}
