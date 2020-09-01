import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qchatapp/widgets/card_top_heading.dart';
import 'package:qchatapp/widgets/count_widget.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height*0.20,
                color: Colors.green,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                       Container(
                         padding: EdgeInsets.only(left: 15),
                         child: Text("My Profile",
                           style: TextStyle(
                             color: Colors.white,
                             fontFamily: 'sf_pro_bold',
                             fontSize: 40
                           ),
                         ),
                       ),


                       Container(
                         padding: EdgeInsets.only(right: 15),
                         child: Icon(
                           Icons.mode_edit,
                           size: 30,
                           color: Colors.white,
                         ),
                       ),



                    ],
                  ),
                ),
              ),

              SafeArea(
                child: Column(
                  children: [

                    SizedBox(height: MediaQuery.of(context).size.height*0.10),

                    Card(
                      elevation: 2,
                      child: Container(
                        padding: EdgeInsets.all(10),

                        child: Column(
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: AssetImage(
                                    'assets/images/profile_dummy.jpg'
                                  ),
                                  maxRadius: 30,
                                ),

                                SizedBox(width: 10,),

                                Text("Annoymous",
                                style: TextStyle(
                                    fontFamily: 'sf_pro_bold',
                                    fontSize: 30,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 10,),

                            Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),

                            ),

                            SizedBox(height: 16,),

                            Divider(height: 0.5,color: Colors.black,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                 InkWell(
                                   onTap: (){},
                                   child: CountWidget(
                                     count: "532",
                                     title: "Public Post",
                                   ),
                                 ),

                                InkWell(
                                  onTap: (){},
                                  child: CountWidget(
                                    count: "840",
                                    title: "Followers",
                                  ),
                                ),

                                InkWell(
                                  onTap: (){},
                                  child: CountWidget(
                                    count: "20000",
                                    title: "Following",
                                  ),
                                ),
                              ]
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 15,),

                    Card(
                      elevation: 2,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            CardTopHeading(
                              leftText: "Friends",
                              rightText: "See all",
                            ),

                            SizedBox(height: 10,),

                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(6, (index) {
                                    return Container(
                                      padding: index!=0 ? EdgeInsets.only(left: 5) : EdgeInsets.all(0),
                                      child: CircleAvatar(
                                        backgroundImage: AssetImage(
                                            'assets/images/profile_dummy.jpg'
                                        ),
                                        maxRadius: 28,
                                      ),
                                    );
                                  }
                                )
                              ),
                            ),




                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 15,),

                    Card(
                      elevation: 2,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            CardTopHeading(
                              leftText: "Photos",
                              rightText: "See all",
                            ),



                            Row(

                              children: [

                                Container(
                                  height: 200,
                                  child: Image(
                                    image: AssetImage(
                                      'assets/images/profile_dummy.jpg',
                                    ),
                                  ),
                                ),

                                SizedBox(width: 10,),


                                Container(
                                  height: 202,
                                  width: 220,
                                  child: GridView.count(
                                    crossAxisCount: 2,
                                    mainAxisSpacing:10,
                                    crossAxisSpacing: 10,
                                    children:List.generate(4, (index){
                                     return  Container(
                                       height: 50,
                                        child: Image(
                                          height: 50,
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                            'assets/images/profile_dummy.jpg',
                                          ),
                                        ),
                                      );
                                    })
                                  ),
                                )

                              ],
                            )

                          ],
                        ),
                      ),
                    )

                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        backgroundColor: Colors.lightBlue,
        child: Icon(
          Icons.add
        ),
      ),

    );
  }
}


