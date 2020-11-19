import 'package:flutter/material.dart';
import 'package:rotation_champs/providers/champion_provider.dart';
import 'package:rotation_champs/models/champion_detail_model.dart';
class ChampionDetailPage extends StatelessWidget {
  final championProvider= new ChampionProvider();
  @override
  Widget build(BuildContext context) {
    final String idChamp=ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body:FutureBuilder(
        future: championProvider.getChamp(idChamp),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.hasData){
            final champion=snapshot.data;
            return CustomScrollView(
              slivers: [
                _crearAppBarChamp(champion),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      SizedBox(
                        height: 10.0,
                      ),
                      _championTitulo(context,champion),
                      SizedBox(height: 10.0,),
                      _lore(champion),
                      SizedBox(height: 10.0,),
                      _showStats(champion),
                      SizedBox(height: 10.0,),
                      _listaSkins(champion)
                    ]
                  )
                )      
              ],
            );
          }
          else{
            return Container(
            height: 400.0,
            child: Center(
              child:CircularProgressIndicator()
            ),
          ); 
          }
        },
      )
    );
  }

  Widget _crearAppBarChamp(ChampionDetailedInfo champion) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.blue[600],
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          champion.name ,
          style:TextStyle(
            color: Colors.white,
            fontSize: 16.0
          ),
        ),
        background: FadeInImage(
          image: AssetImage("assets/img/default/${champion.getDefaultImg()}"),
          placeholder: AssetImage("assets/img/loading.gif"),
          
          fit: BoxFit.cover,  
        ),
      ),
    );
  }
  Widget _lore(ChampionDetailedInfo champion) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 20.0),
      child: Text(  
        champion.lore,
        textAlign: TextAlign.justify,
        style: TextStyle(fontSize: 14.0)
      ),
    );
  }
  Widget _showStats(ChampionDetailedInfo champion){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center ,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: _getLeftColumn(champion),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center ,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:_getRightColumn(champion),
        )
      ],
    );
  }
  List<Widget> _getLeftColumn(ChampionDetailedInfo champion){
    return [
      Row(children: [
          ImageIcon(
            AssetImage("assets/img/icons/HealthScalingIcon.png") 
          ),
          SizedBox(width: 5.0,),
          Text(champion.stats["hp"].toString())
        ],
      ),
      Row(children: [
          ImageIcon(
            AssetImage("assets/img/icons/AdaptiveForceIcon.png") 
          ),
          SizedBox(width: 5.0,),
          Text(champion.stats["attackdamage"].toString())
        ],
      ),
      Row(children: [
          ImageIcon(
            AssetImage("assets/img/icons/AttackSpeedIcon.png") 
          ),
          SizedBox(width: 5.0,),
          Text(champion.stats["attackspeed"].toString())
        ],
      ),
    ];
  }
   List<Widget> _getRightColumn(ChampionDetailedInfo champion){
    return [
      Row(children: [
          ImageIcon(
            AssetImage("assets/img/icons/ArmorIcon.png") 
          ),
          SizedBox(width: 5.0,),
          Text(champion.stats["armor"].toString())
        ],
      ),
      Row(children: [
          ImageIcon(
            AssetImage("assets/img/icons/MagicResIcon.png") 
          ),
          SizedBox(width: 5.0,),
          Text(champion.stats["spellblock"].toString())
        ],
      ),
    ];
  }
   Widget _listaSkins(ChampionDetailedInfo champion) {
    return _crearSkinsPageView(champion.skins,champion.id);
  }
  Widget _crearSkinsPageView(List<Skin> skins,String id) {
    return SizedBox(
      height:300.0,
      child: PageView.builder(
        pageSnapping: false,
        itemCount: skins.length,
        controller: PageController(
          initialPage: 1,
        ),
        itemBuilder:(context,i){
          return _skinTarjeta(skins[i],id);
        }),
    );
  }
  Widget _skinTarjeta(Skin skin,String id){
    return Container(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child:FadeInImage(
              image: AssetImage('assets/img/skins/${skin.getFoto(id)}'),
              placeholder: AssetImage('assets/img/no-image.jpg'),
              height: 220.0,
              fit: BoxFit.cover,
            )
          ),
          SizedBox(height: 5.0,),
          Text(
            skin.name,
            style: TextStyle(fontSize: 16.0),
            overflow: TextOverflow.ellipsis,)  
        ],
      ),
    );
  }
   Widget _championTitulo(BuildContext context,ChampionDetailedInfo champion) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child:Row(
        children: <Widget>[
          Hero(
            tag: champion.id,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                image: AssetImage("assets/img/default/${champion.getDefaultImg()}"),
                height: 150.0,
              ),
            ),
          ),
          SizedBox(width: 20.0,),
          Flexible(
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(champion.name,style: Theme.of(context).textTheme.headline6, overflow: TextOverflow.ellipsis,),
                Text(champion.title,style: Theme.of(context).textTheme.subtitle1,overflow: TextOverflow.ellipsis),
                SizedBox(height: 5.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,  
                  children:[
                    Text("Role :"),
                    for(int i=0;i<champion.tags.length;i++)
                      Text(champion.tags[i])
                  ]
                ),
                SizedBox(height: 5.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                  Text("Difficulty :"),
                  for(int i=0;i<champion.info.difficulty;i++)
                  Container(
                      height: 5.0,
                      width: 10.0,
                      color: Colors.lightBlue,
                    ),
                  ],
                )
              ],
            ) 
          ),
        ],
      ) ,
    );
  }
}