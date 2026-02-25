import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/model/events.dart';
import 'package:evently_app/model/my_user.dart';

class FirebaseUtils {
  static CollectionReference<Event> getEventsCollection(String uId) {
    return getUsersCollection().doc(uId)
        .collection(Event.collectionName)
        .withConverter<Event>(
          fromFirestore: (snapshot, options) =>
              Event.fromFireStore(snapshot.data()!),
          toFirestore: (event, options) => event.toFireStore(),
        );
  }

  static Future<void> addEventToFireStore(Event event , String uId) {
    var eventsCollection = getEventsCollection(uId); //collection
    DocumentReference<Event> docRef = eventsCollection.doc(); //document
    event.id = docRef.id; //auto id
    return docRef.set(event);

    /// getEventsCollection().doc().set(event);
  }

  static CollectionReference<MyUser> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
          fromFirestore: (snapshot, options) =>
              MyUser.fromFireStore(snapshot.data()!),
          toFirestore: (myUser, options) => myUser.toFireStore(),
        );
  }

  static Future<void> addUsersToFireStore(MyUser myUser) {
    return getUsersCollection().doc(myUser.id).set(myUser);
  }

  static Future<MyUser?> readUsersFromFireStore(String id) async {
     var querySnapshot = await getUsersCollection().doc(id).get();
     return querySnapshot.data();
  }
}

/// Firebase
/// developers => object
/// firebase => json 'java script object notation'
/// []  =>  json array  ,  {}  =>  json object
/// json => object
/// object => json
