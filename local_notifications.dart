   
//This method is called or triggete after an upload button has completed a task with firebase.
 
//New V1 FCM by Google
static Future<void> sendNotificationToCurrentPhone(
       String deviceToken, String school, String myName, String imageUrl) async {
     
     //this is no longer an option to use, I have to use the access token instead which I dont quiet understand how to implement
     String serverToken = "AAAAVp93T1I:...";
  
   try{
     await http.post(
       Uri.parse('https://fcm.googleapis.com/v1/projects/revival-academy/messages:send'),
       
       headers: <String, String>{
         'Content-Type': 'application/json',
         'Authorization': 'Bearer $serverToken', 
       },
       body: jsonEncode(
         {
           "message": {
             "token": deviceToken,
             "notification": {
               'title': myName,
               'body': "Please don't forget to fetch your child at $school",
               'image': imageUrl,
               'show_when': true,
              'icon': '@mipmap/ic_launcher',
               'sticky': true,
             },
     
             "data": {"story_id": "11"},
             "android": {
               "notification": {
                "click_action": "FLUTTER_NOTIFICATION_CLICK",
                 "body": "Noted"
               }
             },
           },
        },
       ),
     );
   }catch(e){
	print("Failed to send the notification: " $e);
   }
   }
  


  //This is the old FCM Lagecy method I am using which I want to change to the above code snippet  
  //this works perfectly but is depreciated
 static Future<void> sendNotificationToChat(String deviceToken, String school,
      String myName, String messageFromUser) async {
    try {
      String serverToken ="AAAAVp93T1I:APA91bHu8CVkBRif0-Nz6pllM7RBo1k.......";
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverToken',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'title': "From $myName",
              'body': messageFromUser,
              // 'image': imageUrl,
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done',
            },
            'to': deviceToken,
          },
        ),
      );
    } catch (e) {
      Fluttertoast.showToast(
          backgroundColor: Colors.green,
          msg: "Failed: ${e.toString()}",
          textColor: Colors.white);
    }
  }

 