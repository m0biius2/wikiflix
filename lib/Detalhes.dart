import 'package:flutter/material.dart'; // lib flutter dart
import 'dart:convert'; // lib conversao de arquivos json e xml da api
import 'package:http/http.dart' as http; // lib http para a api
import 'package:intl/intl.dart';
import 'dart:core';

import 'package:proj_letterflix/Filmes.dart';

// classes stateful
class Detalhes extends StatefulWidget {
  // atributos
  // atributo vindo do filme que for clicado
  int id;

  // metodo construtor declarando os atributos a serem passados
  Detalhes(this.id);

  @override
  State<Detalhes> createState() => _DetalhesState();
}

class _DetalhesState extends State<Detalhes> {
  // atributos
  // atributos do filme vindo da api pelo id
  String _poster = "";
  String _nome = "";
  List<String> _generos = [];
  String _sinopse = "";
  String _lancamento = "";
  String _avaliacoes = "";
  var _iconStatus = Icons.check_rounded;
  var _iconFav = Icons.favorite_border_rounded;
  String _status = "Lançado";
  List<Map<String, dynamic>> _streaming = [];
  double _valor = 0;

  // metodos
  // metodo sobrescrito initState que define valores quando o widget/pagina é inicializado
  @override
  void initState() {
    super.initState(); // metodo original que garante que o widget seja inicializado sem imprevistos
    _filme(widget.id.toString()); // passa o id para coletar seus dados no metodo _filme
    _buscarStreaming(widget.id.toString());
  }

  void _estaDisponivel(String disponivel){
    if(disponivel == "released"){
      _sinopse = "Lançado";
      _iconStatus = Icons.check_rounded;
    } else if (disponivel == "unreleased") {
      _sinopse = "Não Lançado";
      _iconStatus = Icons.close_rounded;
    }
  }

  String _formatarData(String data) {
    // Analisar a data
    DateTime dataFormatada = DateTime.parse(data);

    // Formatar a data no formato desejado
    String _dataFormatadaString = DateFormat('dd/MM/yyyy').format(dataFormatada);

    return _dataFormatadaString;
  }


  // metodo filme que busca os dados do filme de acordo com a String na api
  void _filme(String idFilme) async { // async permite que o restante da pagina inicialize fora de sincronia com a api pois ela demora mais para carregar
    // API
    // atributo url que puxa o endpoint da api o id do filme e a chave de ativacao em pt-br
    String url = "https://api.themoviedb.org/3/movie/$idFilme?api_key=6308092f684c21817487e022da14de05&language=pt-BR";
    http.Response response; // http.Response solicita uma resposta via http pela lib adicionada

    // define que a resposta armazenada em response seja a solicitacao da url da api em formato uri/json
    response = await http.get(Uri.parse(url)); // await pausa o async enquanto busca as informações necessárias

    Map<String, dynamic> retorno = json.decode(response.body); // map retorno percorre e decodifica a resposta json vinda de response (dados do filme)
    setState(() {
      _poster = "https://image.tmdb.org/t/p/w500${retorno["poster_path"]}";
      _nome = retorno["title"];
      _generos = List<String>.from(
          retorno["genres"].map((genre) => genre["name"]).toList());
      _sinopse = retorno["overview"];
      _lancamento = _formatarData(retorno["release_date"]);
      _avaliacoes = retorno["vote_average"].toStringAsFixed(1);
      _estaDisponivel(retorno["status"]);
    });
  }

  void _buscarStreaming(String idFilme) async {
    String url = "https://api.themoviedb.org/3/movie/$idFilme/watch/providers?api_key=6308092f684c21817487e022da14de05";
    http.Response response;

    response = await http.get(Uri.parse(url));

    Map<String, dynamic> data = json.decode(response.body);
    if (data.containsKey("results")) {
      setState(() {
        _streaming = List<Map<String, dynamic>>.from(data["results"]["BR"]["flatrate"].map((item) => {
          "provider_id": item["provider_id"],
          "provider_name": item["provider_name"]
        }).toList());
      });
    }
  }

  _alterarIcon(){
    if(_iconFav == Icons.favorite_border_rounded) {
      setState(() {
        _iconFav = Icons.favorite_rounded;
      });
    } else {
      setState(() {
        _iconFav = Icons.favorite_border_rounded;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // aplicativo
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(
                context,
                MaterialPageRoute(
                    builder: (context) => Filmes("User", "user@gmail.com")
                )
            );
          },
          child: Icon(
              Icons.arrow_back
          ),
        ),
        title: Text(
          _nome,
          style: TextStyle(
              fontWeight: FontWeight.w500
          ),
        ),
        backgroundColor: Colors.red.shade800,
        foregroundColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(80, 0, 80, 20),
                child: Image.network(_poster),
              ),
              Center(
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.red.shade800)),
                    onPressed: _alterarIcon,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Favoritar",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Icon(
                            _iconFav,
                            color: Colors.white,
                          ),
                        )
                      ],
                    )
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 20, 10, 0),
                    child: Text(
                      "| ${_nome}",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(30, 10, 0, 0),
                child: Text(
                  _lancamento,
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(30, 5, 0, 0),
                child: Text(
                  _generos.join(", "),
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
                child: Text(
                  _sinopse,
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade400
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Text(
                          _status,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Icon(
                              _iconStatus
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.star_rounded),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text(
                            _avaliacoes,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(30, 50, 0, 0),
                child: Text(
                  "| Onde assistir?",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500
                  ),
                ),
              ),
              if (_streaming.isNotEmpty) // Verifica se há serviços de streaming disponíveis
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 10, 0, 0),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _streaming.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Icon(Icons.play_arrow),
                            title: Text(
                              _streaming[index]["provider_name"],
                              style: TextStyle(
                                  color: Colors.grey
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                )
              else // Se não houver serviços de streaming disponíveis, exibe o texto "Nenhum streaming disponível"
                Padding(
                    padding: EdgeInsets.fromLTRB(30, 10, 0, 0),
                    child: ListTile(
                      leading: Icon(Icons.play_arrow),
                      title: Text(
                        "Nenhum serviço de strem disponível",
                        style: TextStyle(
                            color: Colors.grey
                        ),
                      ),
                    )
                ),
              Padding(
                  padding: EdgeInsets.fromLTRB(30, 50, 0, 30),
                child: Text(
                  "| Avalie o filme!",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    valueIndicatorTextStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  child: Slider(
                    value: _valor,
                    min: 0,
                    max: 10,
                    divisions: 10,
                    label: _valor.toString(),
                    activeColor: Colors.red.shade800,
                    onChanged: (double? novoValor) {
                      setState(() {
                        _valor = novoValor!;
                      });
                    },
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 30)
              )
            ],
          ),
        ),
      ),
    );
  }
}
