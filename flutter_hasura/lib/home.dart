import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hasura/carregar.dart';
import 'package:flutter_hasura/produto.dart';
import 'package:flutter_hasura/tela-cadastro.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Hasura'),),    




      body: StreamBuilder(
        stream: hasuraConnect.subscription(Produto().listar()),
        builder: (_, d){
          if (d.hasData) {
            print(d.data);
            return ListView.builder(
              itemCount: d.data['data']['produtos'].length,
              itemBuilder: (_, i){
                return ListTile(
                  title: Text(d.data['data']['produtos'][i]['descricao']),
                  subtitle: Text("Valor: ${d.data['data']['produtos'][i]['valor']}"),
                  trailing: IconButton(
                    icon: Icon(Icons.delete), 
                    onPressed: (){
                      showDialog(
                        context: context, 
                        child: CupertinoAlertDialog(
                          content: Text('Deseja excluir?'),
                          actions: [
                            CupertinoButton(
                              child: Text('Não'), 
                              onPressed: (){
                                Navigator.pop(context);
                              }
                            ),
                            CupertinoButton(
                              child: Text('Sim'), 
                              onPressed: () async {
                                Navigator.pop(context);
                                showDialog(
                                  context: context,
                                  child: Carregando()
                                );
                                await Produto().excluir(d.data['data']['produtos'][i]['id']);
                                Navigator.pop(context);

                              }
                            ),

                          ],
                        )
                      );
                    }
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Tela_Cadastro(editar: false, dados: d.data['data']['produtos'][i], )));

                  },
                );

              },
            );


            
          } else {
            return Center(child: CircularProgressIndicator());
          }

        },
      ),









      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Tela_Cadastro(editar: true,)));

        },
      ),




    );




  }
}