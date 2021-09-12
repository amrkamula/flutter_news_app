import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_news/network_handler.dart';
import 'package:flutter_app_news/second_screen.dart';
import 'package:intl/intl.dart';
import 'model.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String? _country;
  List<String>? _categories;
  int _chosenIndexCat =0;
  bool _countryFlag = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _country='us';
    _categories=['general','business','sports','entertainment','health','science','technology'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          SizedBox(width: 10.0,),
          IconButton(onPressed: (){
            setState(() {
              _countryFlag = !_countryFlag;
            });
          }, icon: Icon(Icons.place_outlined,color: Colors.indigo,))
        ],
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('News Today',style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.bold,fontSize: 20.0),),
            Text('${DateFormat.yMMMd().format(DateTime.now())}',style: TextStyle(color: Colors.grey,fontSize: 14.0),),
          ],
        ),

      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: _countryFlag,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.indigo,width: 2.0),
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white
                ),
                height: 40.0,
                width: double.infinity,
                child: Row(
                  children:[
                    Expanded(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: DropdownButton(
                          underline: Container(
                            color: Colors.white,
                          ),
                          elevation: 16,
                          icon: Icon(Icons.arrow_circle_down,color: Colors.indigo,),
                          iconSize: 24.0,
                          style: TextStyle(color: Colors.indigo,fontSize: 18.0),
                          value: _country,
                          onChanged: (String? value){
                            setState(() {
                              _country = value;
                              _countryFlag = !_countryFlag;
                            });
                          },
                          items: [
                            DropdownMenuItem(
                              child: Text('United States  '),
                              value: 'us',
                            ),
                            DropdownMenuItem(
                              child: Text('Egypt  '),
                              value: 'eg',
                            ),
                            DropdownMenuItem(
                              child: Text('Lithuania  '),
                              value: 'lt',
                            ),
                            DropdownMenuItem(
                              child: Text('United Arab Emirates  '),
                              value: 'ae',
                            ),
                            DropdownMenuItem(
                              child: Text('Belgium  '),
                              value: 'be',
                            ),
                            DropdownMenuItem(
                              child: Text('New Zealand  '),
                              value: 'nz',
                            ),
                            DropdownMenuItem(
                              child: Text('Russia  '),
                              value: 'ru',
                            ),
                            DropdownMenuItem(
                              child: Text('Sweden  '),
                              value: 'se',
                            ),
                          ],
                        ),
                      ),
                    ),),
                    IconButton(onPressed: (){
                      setState(() {
                        _countryFlag = !_countryFlag;
                      });
                    }, icon: Icon(Icons.clear,color: Colors.grey[700],))
                  ]
                ),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height*0.18,
            child: ListView.builder(
                itemCount: _categories!.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context,index){
              return GestureDetector(
                onTap: (){
                  setState(() {
                    _chosenIndexCat = index;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        foregroundImage: Image.asset('images/${_categories![index]}.jpg').image,
                        radius: 30.0,
                      ),
                      SizedBox(height: 7.0,),
                      Container(
                          decoration: BoxDecoration(
                            color: (_chosenIndexCat == index)?Colors.indigo:Colors.white,
                            borderRadius: BorderRadius.circular(12.0)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 2.0),
                            child: Text('${_categories![index]}',
                              style: TextStyle(color: (_chosenIndexCat == index)?Colors.white:Colors.grey,fontSize: 16.0),),
                          ))
                    ],
                  ),
                ),
              );
            }),
          ),
          Padding(padding: const EdgeInsets.symmetric(vertical: 12.0,horizontal: 8.0),child: Text("Latest News",style: const TextStyle(color: Colors.indigo,fontWeight: FontWeight.bold,fontSize: 20.0),),),
          Expanded(
            child: FutureBuilder(
              future: NetworkHandler(country: _country,category: _categories![_chosenIndexCat]).getNews(),
              builder: (context,AsyncSnapshot<Map> snapshot){
                if(snapshot.hasData){
                  List articles = snapshot.data!['articles'];
                  List adjust = articles.reversed.toList();
                  adjust.add({});
                  articles = adjust.reversed.toList();
                  return ListView.builder(
                      itemCount: articles.length+1,
                      itemBuilder: (context,index){
                        Article article;
                        if(index==0){
                          article = Article(
                              source: { '':''},
                              content: '',
                              author: '',
                              title: '',
                              description: '',
                              urlToArticle: '',
                              urlToImage: '',
                              publishedAt: '');
                        }
                        else{
                          article = Article.fromJson(articles[index]);
                        }
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: (){
                          if(index ==0){

                          }
                          else {
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) {
                                  return SecondScreen(
                                      url: article.urlToArticle!);
                                }));
                          }
                        },
                        child: Card(
                          elevation: 8.0,
                          child: (index == 0)?
                          Container(
                            height: MediaQuery.of(context).size.height*0.3,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Stack(
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.height*0.3,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  clipBehavior: Clip.hardEdge,
                                  child: Image.asset('images/default.jpg',fit: BoxFit.fill,),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(child: Container()),
                                    Padding(padding: const EdgeInsets.all(12.0),
                                      child: Text('We give you all news before you Blink',
                                        overflow: TextOverflow.fade,
                                        maxLines: 2,
                                        style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold),), ),
                                  ],
                                ),
                              ],
                            ),
                          )
                              :
                          Row(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height*0.1,
                                width: 100.0,
                                child: Image.network('${article.urlToImage}',fit: BoxFit.fill,),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text('${article.title}',
                                    overflow: TextOverflow.fade,
                                    maxLines: 2,
                                    style: TextStyle(color: Colors.blue[700],fontSize: 18.0),),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ) ;
                  });
                }
                else{
                  return Center(child: CircularProgressIndicator(color: Colors.indigo,strokeWidth: 2.0,),);
                }
              },
            ),
          ),
        ],
      ),
    );
  }


}
