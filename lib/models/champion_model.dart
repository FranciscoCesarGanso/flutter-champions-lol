class Champions{
  List<Champion> items= new List();
  Champions();
  Champions.fromJsonMap(Map<String,dynamic> jsonMap){
    if(jsonMap==null) return;
    jsonMap.forEach((key, value) { 
      final champ=Champion.fromJsonMap(value);
      items.add(champ);
    });
  }
}

class Champion {
  String id;
  String key;
  String name;
  String title;
  String lore;
  List<String> tags;
  

  Champion({
    this.id,
    this.key,
    this.name,
    this.title,
   
    this.tags,
    //this.info,
  });
  Champion.fromJsonMap(Map<String,dynamic> json){
    this.id=json['id'];
    this.key=json['key'];
    this.name=json['name'];
    this.title=json['title'];
    this.tags=json['tags'].cast<String>();
  }
  String getDefaultImg(){
   return "${this.id}_0.jpg";
  }
}





 
