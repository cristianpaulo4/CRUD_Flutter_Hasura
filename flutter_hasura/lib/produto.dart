import 'package:hasura_connect/hasura_connect.dart';

HasuraConnect hasuraConnect =
    HasuraConnect('https://testehasura2020.herokuapp.com/v1/graphql');

class Produto {
  int id;
  String descricao;
  double valor;

  cadastrar(Produto pro) async {
    String query = """
      mutation MyMutation {
        insert_produtos(objects: {
          descricao: "${pro.descricao}", 
          valor: "${pro.valor}"
        
        }) {
          affected_rows
        }
      }
    """;
    var res = await hasuraConnect.mutation(query);
    return true;

  }




  listar() {
    String query = """subscription MySubscription {
      produtos {
        id
        descricao
        valor
      }
    }
    """;
    return query;
  }


  excluir(int id) async {
    String query = """
      mutation MyMutation {
        delete_produtos(where: {id: {_eq: $id }}) {
          affected_rows
        }
      }
    """;
    var res = await hasuraConnect.mutation(query);
    return true;
  }


  editar(Produto pro, int id) async {
    String query = """
      mutation MyMutation {
        update_produtos(where: {id: {_eq: $id }}, _set: {
          descricao: "${pro.descricao}", 
          valor: "${pro.valor}"
        }) {
          affected_rows
        }
      }
    """;
    var res = await hasuraConnect.mutation(query);
    return true;
    
  }



}
