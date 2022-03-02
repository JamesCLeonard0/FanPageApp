import 'dart:html';

import 'package:flutter/material.dart';

void main() {
  runApp(Home());
}

class Home extends StatelessWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp( 
     // home: Scaffold
      /*
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 108, 147, 173),
        appBar: AppBar(  centerTitle: true,
        title: const Text("The Fan Club of the Honorable and Magnificient James Leonard"),
        backgroundColor: Color.fromARGB(118, 6, 78, 42),
        ),
        body: new Container(

          child: new Padding( padding: EdgeInsets.fromLTRB(500,50,0,0,),child: new Column(
              
              children: <Widget>[
               
                Image.network('https://media-exp1.licdn.com/dms/image/C4E03AQE1tN_lBaJotQ/profile-displayphoto-shrink_800_800/0/1606741226931?e=1650499200&v=beta&t=x75iAD8PQOBv1dHUV1_BsTXhQ9A5g9wDlW6W6ZPGw7g'),
                 Text("Hello, I am Germex", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
            
                
          

              ],
              




          ),
          
          
          
          )

        ),
        
        
        
        //Padding(padding: EdgeInsets.fromLTRB(500.0,0,0,0), child: Image.network('https://media-exp1.licdn.com/dms/image/C4E03AQE1tN_lBaJotQ/profile-displayphoto-shrink_800_800/0/1606741226931?e=1650499200&v=beta&t=x75iAD8PQOBv1dHUV1_BsTXhQ9A5g9wDlW6W6ZPGw7g'),

          //child: SizedBox(height: 50, width: 50 ,child: Text('Hi Mom')),
        
        ),
        
      
    */
    );
  }
}