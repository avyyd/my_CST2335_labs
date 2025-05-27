import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Categories',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const CategoriesPage(title: 'Categories Home Page'),
    );
  }
}


class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key, required String title});

  Widget buildStackCenter(String imagePath, String label) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(imagePath),
          radius: 50,
        ),
        Text(
          label,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget buildStackBottom(String imagePath, String label) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CircleAvatar(backgroundImage: AssetImage(imagePath),
          radius: 50,
        ),
        Container(
          color: Colors.black54,
          padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          child: Text(
            label,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Browse Categories",
        style: TextStyle(fontSize: 50,
          color: Colors.black87,
          fontWeight: FontWeight.bold,),),),),
      body: Center(
        child: Column( mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(
          "Not Sure about exactly which recipe you are looking for? Do a search, or dive into our most popular categories.",
          style: TextStyle(fontSize: 18, color: Colors.black87,),
        ),Text(
          "BY MEAT",style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87),
        ),Row(  mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [Stack(alignment: AlignmentDirectional.center,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('images/beef.jpg'), radius: 70,),
              Text("Beef",style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),),
            ]
       ),
        Stack(alignment: AlignmentDirectional.center,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('images/chicken.jpg'), radius: 70,),
              Text("Chicken", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),),
            ]
        ),
          Stack(alignment: AlignmentDirectional.center,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('images/prok.jpg'), radius: 70,),
                Text("Pork", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),),
              ]
          ),
          Stack(alignment: AlignmentDirectional.center,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('images/seafood.jpg'), radius: 70,),
                Text("Seafood",style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),),
              ]
          ),
      ],
        ),Text(
          "BY COURSE",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
          Row(  mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [Stack(alignment: AlignmentDirectional.bottomCenter,
                children: [
                  CircleAvatar(

                    backgroundImage: AssetImage('images/maindishes.jpg'), radius: 70,),
                  Text("Main Dishes",style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black54),),
                ]
            ),
              Stack(alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('images/salad.jpg'), radius: 70,),
                    Text("Salad Recipes", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black54),),
                  ]
              ),
              Stack(alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('images/maindishes.jpg'), radius: 70,),
                    Text("Side Dishes", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black54),),
                  ]
              ),
              Stack(alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('images/crockpot.jpg'), radius: 70,),
                    Text("CrockPot",style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black54),),
                  ]
              ),
            ],
          ),Text(
            "BY DESSERT",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          Row(  mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [Stack(alignment: AlignmentDirectional.bottomCenter,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('images/icecream.jpg'), radius: 70,),
                  Text("Ice Cream",style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black54),),
                ]
            ),
              Stack(alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('images/brownie.jpg'), radius: 70,),
                    Text("Brownies", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black54),),
                  ]
              ),
              Stack(alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('images/pies.jpg'), radius: 70,),
                    Text("Pies", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black54),),
                  ]
              ),
              Stack(alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('images/cookies.jpg'), radius: 70,),
                    Text("Cookies",style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black54),),
                  ]
              ),
            ],
          ),

        ],
        )

      ),
    );
  }


}