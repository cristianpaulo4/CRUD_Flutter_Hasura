import 'package:flutter/material.dart';
import 'package:flutter_hasura/produto.dart';

class Tela_Cadastro extends StatefulWidget {
  final editar;
  final dados;
  const Tela_Cadastro({Key key, this.editar, this.dados}) : super(key: key);
  
  @override
  _Tela_CadastroState createState() => _Tela_CadastroState();
}

class _Tela_CadastroState extends State<Tela_Cadastro> {
  GlobalKey<FormState> _globalKey = GlobalKey();
  TextEditingController _descricao = TextEditingController();
  TextEditingController _valor = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.dados!=null) {
      _descricao.text = widget.dados['descricao'];
      _valor.text = widget.dados['valor'].toString();
      
    }
  }
  



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro'),),


      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            children: [
              Form(
                key: _globalKey,
                child: Column(
                  children: [

                    TextFormField(
                      controller: _descricao,                    
                      validator: (x){
                        if (x.isEmpty) {
                          return 'Digite a descrição';
                        }
                      },
                    ),


                    TextFormField(
                      controller: _valor,
                      validator: (x){
                        if (x.isEmpty) {
                          return 'Digite o valor';
                        }
                      },


                    ), 

                    SizedBox(height: 50,),


                    Visibility(
                      visible: widget.editar,
                      child: RaisedButton.icon(
                      onPressed: (){
                        if (_globalKey.currentState.validate()) {
                          setState((){
                            Produto pro = Produto();
                            pro.descricao = _descricao.text;
                            pro.valor = double.parse(_valor.text);
                            pro.cadastrar(pro);
                            _descricao.text ='';
                            _valor.text ='';
                            
                          });
                          
                        }
                      }, 
                      icon: Icon(Icons.save), 
                      label: Text('Salvar')
                    ),
                    replacement: RaisedButton.icon(
                      onPressed: () async {
                        if (_globalKey.currentState.validate()) {
                          Produto pro = Produto();
                          pro.descricao = _descricao.text;
                          pro.valor = double.parse(_valor.text);
                          await pro.editar(pro, widget.dados['id']);
                          Navigator.pop(context);

                          
                        }
                      }, 
                      icon: Icon(Icons.save), 
                      label: Text('Editar')
                    ),
                    )



                  ],
                ),

              )




            ],
          ),
        ),
      ),






    );
  }
}