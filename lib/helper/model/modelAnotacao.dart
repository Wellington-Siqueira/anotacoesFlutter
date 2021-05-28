class Anotacao {
  int id;
  String titulo;
  String descricao;
  String data;

  Anotacao(this.titulo, this.descricao, this.data);

  Anotacao.fromMap(Map mapa) {
    this.id = mapa["id"];
    this.titulo = mapa["titulo"];
    this.descricao = mapa["descricao"];
    this.data = mapa["data"];
  }

  Map converterMap() {
    Map<String, dynamic> map = {
      "titulo": this.titulo,
      "descricao": this.descricao,
      "data": this.data
    };

    if (this.id != null) {
      map["id"] = this.id;
    }
    return map;
  }
}
