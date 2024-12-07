import 'package:flutter/material.dart'; // lib flutter dart
import 'dart:convert'; // lib conversao de arquivos json e xml da api
import 'package:http/http.dart' as http; // lib http para a api
import 'package:carousel_slider/carousel_slider.dart'; // lib carrossel
import 'package:proj_letterflix/Cadastro.dart';
import 'package:proj_letterflix/Detalhes.dart';
import 'package:proj_letterflix/Login.dart';
import 'package:proj_letterflix/Perfil.dart'; // lib pagina detalhes

// classes stateful
class Filmes extends StatefulWidget {
  // atributos
  // dados do usuario
  String user;
  String email;

  Filmes(this.user, this.email); // metodo construtor declarando o atributo modoEscuro a ser passado para a pagina

  @override
  State<Filmes> createState() => _FilmesState();
}

class _FilmesState extends State<Filmes> {
  // atributos
  bool _carregando = false; // usado para controlar o indicador de carregamento

  // listas
  List<Map<String, dynamic>> _filmesPop = []; // filmes populares da api
  List<Map<String, dynamic>> _pesquisa = []; // filmes pesquisados na api
  List<String> _avaliacoesPesquisa = []; // avaliacoes dos filmes pesquisados na api
  List<Map<String, dynamic>> _filmesAcao = []; // filmes de acao
  List<Map<String, dynamic>> _filmesAventura = []; // filmes de aventura
  List<Map<String, dynamic>> _filmesAnimacao = []; // filmes de animacao
  List<Map<String, dynamic>> _filmesComedia = []; // filmes de comedia
  List<Map<String, dynamic>> _filmesTerror = []; // filmes de terror
  List<Map<String, dynamic>> _filmesRomance = []; // filmes de romance
  List<Map<String, dynamic>> _filmesFiccao = []; // filmes de ficcao cientifica

  // controllers
  TextEditingController _pesquisaController = TextEditingController(); // controller do textfield de pesquisa de filmes da api

  // metodos
  // metodo sobrescrito initState que define valores quando o widget/pagina é inicializado
  @override
  void initState() {
    super.initState(); // metodo original que garante que o widget seja inicializado sem imprevistos
    _filmesPopulares(); // metodo que chama os filmes populares da api quando o widget/pagina é inicializado
    // metodos que chamam os filmes de cada genero
    _generoFilmes("28", _filmesAcao);
    _generoFilmes("12", _filmesAventura);
    _generoFilmes("16", _filmesAnimacao);
    _generoFilmes("35", _filmesComedia);
    _generoFilmes("27", _filmesTerror);
    _generoFilmes("10749", _filmesRomance);
    _generoFilmes("878", _filmesFiccao);
  }

  // metodo filmesPopulares que busca os filmes populares da api
  void _filmesPopulares() async { // async permite que o restante da pagina inicialize fora de sincronia com a api pois ela demora mais para carregar
    // API
    // atributo url que puxa o endpoint da api com os requisitos (filmes populares) e a chave de ativacao em pt-br
    String url = "https://api.themoviedb.org/3/movie/popular?api_key=6308092f684c21817487e022da14de05&language=pt-BR&page=1";
    http.Response response; // http.Response solicita uma resposta via http pela lib adicionada

    // define que a resposta armazenada em response seja a solicitacao da url da api em formato uri/json
    response = await http.get(Uri.parse(url)); // await pausa o async enquanto busca as informações necessárias

    Map<String, dynamic> retorno = json.decode(response.body); // map retorno percorre e decodifica a resposta json vinda de response (filmes populares)
    List<dynamic> filmes = retorno["results"].take(5).toList(); // list filmes coleta apenas os 5 primeiros resultados (5 filmes mais populares) de retorno em formato de list ao inves de map
    setState(() {
      // define em lista os valores de filmePop com id e imagem do filme
      _filmesPop = filmes.map<Map<String, dynamic>>((filme) {
        return {
          "id": filme["id"], // Adicionando o ID do filme ao mapa
          "poster": "https://image.tmdb.org/t/p/w500${filme["poster_path"]}" // Adicionando a URL do poster ao mapa
        };
      }).toList();
    });
  }

  // metodo pesquisarFilmes que pesquisa filmes da api a partir do valor passado pelo controller do textfield de pesquisa para o parametro busca e exibe os 10 primeiros na tela
  void _pesquisarFilmes(String busca) async {
    setState(() {
      _carregando = true; // exibe o indicador
    });

    // API
    // atributo url que puxa o endpoint da api com os requisitos (pesquisa de filmes), a chave de ativacao e o valor que foi pesquisado (busca) em pt-br
    String url = "https://api.themoviedb.org/3/search/movie?api_key=6308092f684c21817487e022da14de05&language=pt-BR&query=$busca&page=1";
    http.Response response;

    response = await http.get(Uri.parse(url));

    Map<String, dynamic> retorno = json.decode(response.body);
    List<dynamic> filmes = retorno["results"].take(10).toList(); // apenas os 10 primeiros filmes que a api traz

    // list para armazenar os detalhes de todos os filmes
    List<String> detalhesFilmes = [];

    // for para obter os detalhes de cada filme
    for (var filme in filmes) { // para cada filme entre os que aparecem na pesquisa
      String detalhes = await _detalheFilmes(filme["id"]); // coleta o id dos filmes
      detalhesFilmes.add(detalhes);
    }

    setState(() {
      // define os valores da list pesquisa como id e imagens/posteres do valor da busca (10 primeiros)
      _pesquisa = filmes.map<Map<String, dynamic>>((filme) {
        return {
          "id": filme["id"], // adicionando o id do filme ao mapa
          "poster": "https://image.tmdb.org/t/p/w500${filme["poster_path"]}" // poster
        };
      }).toList();
      _avaliacoesPesquisa = detalhesFilmes; // lista em avaliacoesPesquisa os detalhes recolhidos dos filmes vindos da pesquisa
      _carregando = false; // tira o indicador de cena
    });
  }

  // para um metodo do tipo string como detalheFilmes funcionar de modo async ele precisa de um Future delcarando que o retorno vai acontecer no futuro
  Future<String> _detalheFilmes(int idFilme) async {
    // API
    // atributo url que puxa o endpoint da api com os requisitos (id do filme pesquisado) e a chave de ativacao em pt-br
    String url = "https://api.themoviedb.org/3/movie/$idFilme?api_key=6308092f684c21817487e022da14de05&language=pt-BR";
    http.Response response;

    response = await http.get(Uri.parse(url));

    Map<String, dynamic> retorno = json.decode(response.body);

    // a API possui as avaliacoes guardadadas em vote_average, o atributo avaliacoes esta coletando as avaliacoes do id de filme anteriormente buscado
    double avaliacoes = retorno["vote_average"].toDouble();
    return avaliacoes.toStringAsFixed(1); // retorna a avaliacao como uma string e com suas casas decimais limitadas
  }

  // metodo limparPesquisa que limpa a pesquisa
  void _limparPesquisa(){
    setState(() {
      _pesquisa = []; // esvazia a list pesquisa
      _pesquisaController.clear(); // limpa o controller da pesquisa
    });
  }

  // metodo generoFilmes que busca os filmes de acordo com o genero na api
  void _generoFilmes(String idGenero, List<Map<String, dynamic>> listarFilmes) async {
    // API
    // atributo url que puxa o endpoint da api com os requisitos (id do genero) e a chave de ativacao em pt-br
    String url = "https://api.themoviedb.org/3/discover/movie?api_key=6308092f684c21817487e022da14de05&with_genres=$idGenero&language=pt-BR&page=1";
    http.Response response;

    response = await http.get(Uri.parse(url));

    Map<String, dynamic> retorno = json.decode(response.body);
    List<dynamic> genero = retorno["results"].take(5).toList(); // list genero coleta apenas os 5 primeiros resultados (5 filmes do genero) de retorno em formato de list ao inves de map
    setState(() {
      listarFilmes.addAll(genero.map<Map<String, dynamic>>((filme) {
        return {
          "id": filme["id"], // adicionando o id do filme ao mapa
          "poster": "https://image.tmdb.org/t/p/w500${filme["poster_path"]}" // poster
        };
      }).toList());
    });
  }

  // metodo que navega para a pagina de detalhes passando o id do filme
  _pagDetalhes(int id){
    setState(() {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Detalhes(id)
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // aplicativo
    return Scaffold(
      // appbar
      appBar: AppBar(
        title: Text(
          "Wikiflix",
          style: TextStyle(
              fontWeight: FontWeight.w500
          ),
        ),
        backgroundColor: Colors.red.shade800,
        foregroundColor: Colors.white,
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
                              widget.user,
                              style:  TextStyle(
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
                // paginas do app
                // navigator pagina perfil
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 30, 0, 0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Perfil(widget.user, widget.email)
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
                    onTap: () {},
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
      // corpo do app
      body: Container(
          padding: EdgeInsets.only(top: 30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // 5 filmes mais populares
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: Text(
                        "| Populares da semana",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                    padding: EdgeInsets.only(top: 10)
                ),
                // carrossel de filmes populares
                _filmesPop.isEmpty // confere se os filmes carregaram
                    ? Center(child: CircularProgressIndicator(color: Colors.red.shade800,)) // caso a api nao tenha carregado, exibe um icone de carregamento
                    : CarouselSlider( // caso a api tenha carregado, exibe o carrossel
                  options: CarouselOptions(
                    height: 400.0,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    viewportFraction: 0.6,
                  ),
                  items: _filmesPop.map((filme) { // define que os itens do carrossel sao as imagens de filmesPop (5 filmes mais populares)
                    return Container(
                      child: Center(
                        child: GestureDetector(
                          onTap: (){
                            print("ID: ${filme["id"]}");
                            _pagDetalhes(filme["id"]);
                          },
                          child: Image.network(filme["poster"], fit: BoxFit.cover, width: 1000),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                // pesquisa de filmes
                // pesquisa de filmes por nome
                Padding(
                  padding: EdgeInsets.all(20),
                  child: TextField(
                    controller: _pesquisaController,
                    decoration: InputDecoration(
                      labelText: "Pesquisar filmes",
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
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.search,
                          color: Colors.red.shade800,
                        ),
                        onPressed: () {
                          _pesquisarFilmes(_pesquisaController.text); // passa o valor da busca para o controller
                          FocusScope.of(context).requestFocus(new FocusNode());
                        },
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    maxLines: null,
                  ),
                ),
                // botao de limpar pesquisa
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.red.shade800)),
                    onPressed: _limparPesquisa,
                    child: Text(
                      "Limpar",
                      style: TextStyle(color: Colors.white),
                    )
                ),
                Padding(padding: EdgeInsets.only(top: 17)),
                _pesquisa.isEmpty // confere se a pesquisa é nula
                    ? _pesquisaController.text.isEmpty // se sim, confere se o controller é nulo
                    ? Container() // se sim, mantem um container vazio
                    : _carregando // se nao, puxa o atributo carregando
                    ? Center(child: CircularProgressIndicator(color: Colors.red.shade800,)) // indicador de carregamento enquanto carregando for true
                // se carregando for false, o controller nao for nulo mas a pesquisa for nula, significa que a API nao possui os dados daquela pesquisa
                    : Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Text("Não foi possível encontrar resultados, verifique se há erros na digitação e tente novamente."),
                    )
                  ],
                )
                    : GridView.builder( // se nao for nulo, retorna os resultados
                  shrinkWrap: true, // ajusta o tamanho da lista para a tela
                  physics: NeverScrollableScrollPhysics(), // evita que o conteudo seja rolado, apenas a tela
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount( // define o tamanho da grid
                    crossAxisCount: 2, // itens por linha
                    childAspectRatio: 0.7, // ajuste dos itens
                  ),
                  itemCount: _pesquisa.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: GridTile(
                        child: GestureDetector(
                          onTap: () {
                            print("ID: ${_pesquisa[index]["id"]}");
                            _pagDetalhes(_pesquisa[index]["id"]);
                          },
                          child: Image.network(
                            _pesquisa[index]["poster"], // Acesso ao poster correto
                            fit: BoxFit.cover,
                          ),
                        ),
                        footer: GridTileBar(
                            backgroundColor: Colors.black45,
                            title: Row(
                              children: [
                                Icon(Icons.star_rounded),
                                Text(
                                  "${_avaliacoesPesquisa[index]}", // avaliacoes de acordo com a pesquisa
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white
                                  ),
                                ),
                              ],
                            )
                        ),
                      ),
                    );
                  },
                ),
                // filmes por genero
                // acao - id 28
                Padding(padding: EdgeInsets.only(top: 30)),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: Text(
                        "| Ação",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    )
                  ],
                ),
                _carrossel(_filmesAcao),
                // aventura - id 12
                Padding(padding: EdgeInsets.only(top: 30)),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: Text(
                        "| Aventura",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    )
                  ],
                ),
                _carrossel(_filmesAventura),
                // animacao - id 16
                Padding(padding: EdgeInsets.only(top: 30)),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: Text(
                        "| Animação",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    )
                  ],
                ),
                _carrossel(_filmesAnimacao),
                // comedia - id 35
                Padding(padding: EdgeInsets.only(top: 30)),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: Text(
                        "| Comédia",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    )
                  ],
                ),
                _carrossel(_filmesComedia),
                // terror - id 27
                Padding(padding: EdgeInsets.only(top: 30)),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: Text(
                        "| Terror",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    )
                  ],
                ),
                _carrossel(_filmesTerror),
                // romance - id 10749
                Padding(padding: EdgeInsets.only(top: 30)),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: Text(
                        "| Romance",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    )
                  ],
                ),
                _carrossel(_filmesRomance),
                // ficcao cientifica - id 878
                Padding(padding: EdgeInsets.only(top: 30)),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: Text(
                        "| Ficção Científica",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    )
                  ],
                ),
                _carrossel(_filmesFiccao),
                Padding(
                    padding: EdgeInsets.only(bottom: 30)
                )
              ],
            ),
          )
      ),
    );
  }

  // widget carrossel facilita no código pois vai ser usado varias vezes
  Widget _carrossel(List<Map<String, dynamic>> filmes) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(padding: EdgeInsets.only(top: 30)),
        Container(
          height: 220, // Altura ajustável conforme desejado
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: filmes.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  width: 160, // Largura ajustável conforme desejado
                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      // Ação ao tocar na imagem
                      print("ID: ${filmes[index]["id"]}");
                      _pagDetalhes(filmes[index]["id"]);
                    },
                    child: Container(
                      width: 160, // Largura ajustável conforme desejado
                      margin: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Image.network(
                        filmes[index]["poster"],
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
              );
            },
          ),
        ),
      ],
    );
  }
}
