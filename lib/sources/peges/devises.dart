import 'package:flutter/material.dart';
import 'dart:async';



import 'package:gpsafety2/sources/blocks/provider.dart';
import 'package:gpsafety2/sources/models/dispositivosModel.dart';

import 'package:shimmer/shimmer.dart';


class Devises extends StatefulWidget {
  @override
  _DevisesState createState() => _DevisesState();
}

class _DevisesState extends State<Devises> {
  
  @override
  Widget build(BuildContext context) {
    //final bloc = Provider.of(context);

    
    final dispositivosBloc = Provider.dispositivosBloc(context);
    dispositivosBloc.cargarDispositivos(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Dispositivos') ,
        leading: Icon(Icons.adb_rounded),
      ),
      body: Center(
        child: DelayedList()  
      ),        
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearBoton(BuildContext context){


    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(
          color: Colors.black12,
          spreadRadius: 2.0,
        )],

      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50.0),
        child: Container(
          color: Color.fromRGBO(224, 136, 75, 1),
          height: 85.0,
          width: 85.0,
          child: FloatingActionButton(
            onPressed: (){ 
              Navigator.pushNamed(context, 'nuevoDisp');
            },
            child: Icon(Icons.add, color: Colors.white, size: 30.0,),
            backgroundColor: Color.fromRGBO(235, 109, 34, 1),
          ),
        ),
      ), 
    );
  }

}

class ShimmerList extends StatelessWidget{
  
  
  @override
  Widget build(BuildContext context) {
    int offset = 0;
    int time = 800;
    return SafeArea(
      child: ListView.builder(
        itemCount: 6,
        itemBuilder: (BuildContext context, int i){
          offset += 5;
          time = 800 + offset;

          //print(time);
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Shimmer.fromColors(
              child: ShimmerLayoout(),
              baseColor: Color.fromRGBO(200, 200, 200, .4),
              highlightColor: Colors.white,
              period: Duration(milliseconds: time),
            ),
          );
        }
      ),
    );
  }
}

class ShimmerLayoout extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    //double width = 280;
    //double height = 30;

    return Padding(
      padding: const EdgeInsets.fromLTRB(8,16,8,0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          color: Color.fromRGBO(200, 200, 200, .7),
        ),
        margin:  EdgeInsets.symmetric(vertical: 3.5),
        padding: EdgeInsets.symmetric(vertical: 5.0),
        alignment: Alignment.topCenter,
        height: 80.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [],
        ),
        
        
      ),
    );
  }
}


class DelayedList extends StatefulWidget{
    @override
    _DelayedListState createState() => _DelayedListState();
}

class _DelayedListState extends State<DelayedList> {
  bool isloading = true;
  @override
  Widget build(BuildContext context) {
    Timer timer = Timer(Duration(seconds: 3),(){
      setState(() {
        isloading = false;
      });
    });
    return isloading ? ShimmerList() : CrearListado(timer); 
  }
}

class CrearListado extends StatefulWidget {
  final Timer timer;
  CrearListado(this.timer);
  
  @override
  _CrearListadoState createState() => _CrearListadoState();
}

class _CrearListadoState extends State<CrearListado> {
  //final dispositivosProvider = new DispositivosProvider();
  Color color;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    color = Colors.transparent;
  }
  
  @override
  Widget build(BuildContext context) {
    final dispositivosBloc = Provider.dispositivosBloc(context);
    dispositivosBloc.cargarDispositivos(context);

    widget.timer.cancel();
    return StreamBuilder(
      stream: dispositivosBloc.dispositivosStream,
      builder: (BuildContext context, AsyncSnapshot<List<DispositivoModel>> snapshot){
        if(snapshot.hasData){
          final dispositivos = snapshot.data;
          return ListView.builder(
            itemCount: dispositivos.length,
            itemBuilder: ( context, i) => _crearDispo(dispositivos[i], context),
            
          );
        }else{
          return ShimmerList();
        }
      },
    );
    
  }

  Widget _crearDispo(DispositivoModel dispo, BuildContext context ){
    String estado = '';
    


    if(dispo.activo == true) {
      estado = 'Encendido';
    }
    else{ estado = 'Apagado';}


    return Container(
         
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8,16,8,0),
          child: 
              ListTile(
              title: Text('${dispo.nombre}'),
              subtitle: Text(estado),
              trailing: FadeInImage(
                image: NetworkImage(dispo.fotoUrl),
                placeholder: AssetImage('assets/jar-loading.gif'),
                height: 60,
                width: 60,
              ),
              tileColor: Color.fromRGBO(198, 195, 190,.2),
              onTap: (){
                Navigator.pushNamed(context, 'nuevoDisp', arguments: dispo);
              } ,
              )

                
                
                    
              
        ),
      );  
  }
}

class ActivityListTile extends StatelessWidget{

  String title;
  String subtitle;
  Widget trailingImage;
  VoidCallback onTab;
  Color color;
  Color gradient;

  ActivityListTile({this.title, this.color, this.gradient, this.onTab, this.subtitle, this.trailingImage});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: GestureDetector(
        child: Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            //es la tarjeta como tal
            Card(
              child: Container(
                //aqui se le da la redondes al widget de tarjeta
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    const Radius.circular(5.0)
                  ),
                  gradient: LinearGradient(
                    colors:[color,gradient],
                    begin: Alignment.topLeft,
                    end: Alignment.topRight
                  ),
                ),
                child: Padding(
                  //este padding es para el tañaño de la tarjeta
                  padding: const EdgeInsets.all(4.0),
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(title, style:  TextStyle(fontSize: 20),),
                    ),
                    subtitle:  Padding(
                      padding: const EdgeInsets.only(bottom:4.0),
                      child: Text( subtitle, style: TextStyle(fontSize: 12 ),),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 13.0, right: 10.0),
              child: Container( child: trailingImage,),
            )
          ],
        ),
      )
    );
  }

}
 
class CrearLista extends StatelessWidget{
    final Timer timer;
    CrearLista(this.timer);

    @override
    Widget build(BuildContext context) {
      timer.cancel();
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:  <Widget>[
        Expanded(
          child: CrearListado(timer),
        )
      ],
    );
  }
}