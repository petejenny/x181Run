//
//  MyFireDbService.swift
//  x181Run
//
//  Created by Peter Forward on 6/5/19.
//  Copyright © 2019 Peter Forward. All rights reserved.
//

import Foundation
import Firebase

struct MyFireDbService {
    
    static let sharedInstance = MyFireDbService()
    
    //let runReference = Database.database().reference().child("runs")
    
    private func myDbReference(to myCollectionReference: MyFireCollectionRef) -> CollectionReference {
        
        //
        var collectionPath: String
        if myCollectionReference == .runEvents {
            collectionPath = "/users/" + (Auth.auth().currentUser?.uid)! + "/events"
        } else {
            collectionPath = myCollectionReference.rawValue
        }
        
        let myDataRef = Firestore.firestore().collection(collectionPath)
        
        //var myDataRef = Firestore.firestore().collection(collectionReference.rawValue)
        //return Firestore.firestore().collection(myCollectionReference.rawValue)
//        if myCollectionReference == .runEvents {
//            myDataRef.order(by: "eventDate").limit(to: 2)
//        }
        
        return myDataRef
    
    }
    
    func readRunNumber() {
        myDbReference(to: .SequenceNumbers).addSnapshotListener { (snapshot, _) in
            
            guard let snapshot = snapshot else {return}
            print("#11111111111111111")
            for document in snapshot.documents {
                print("Document=",document.data())
            }
            print("#222222222222222222")
        }
    }
    
    func createRunNumber() {
        print("createRunNumber()")
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .short
        let dateString = formatter.string(from: currentDateTime)
        
        let runNumber: [String: Any] = ["runNumber": 777,
                                        "setDate": dateString,
                                        "setUser": "Peter"]
        //let userReference = Firestore.firestore().collection("users")
        myDbReference(to: .SequenceNumbers).addDocument(data: runNumber)
    }
    
    func myCreate<T: Encodable>(for encodableObject: T, in collectionReference: MyFireCollectionRef) {
        
        do {
            // Exclude the id from the json to ensure we don't update and existing database record
            var json = try encodableObject.toJson(excluding: ["id"])
            // Include the userId
            json["UserId"] = Auth.auth().currentUser?.uid
            myDbReference(to: collectionReference).addDocument(data: json)
            
        } catch {
            print(error)
        }
    }
    
    func myRead<T: Decodable>(from collectionReference: MyFireCollectionRef, returning objectType: T.Type, completion: @escaping ([T]) -> Void) {
        print("------------Create reference to firebase location")
        
        //let myDataRef = Firestore.firestore().collection(collectionReference.rawValue)
       
        //let myDataRef = Firestore.firestore().collection("/users/l9eaNKDhnTTnOuYqJvhBMALzzPG3/events")
        
        //var myDataRef = Firestore.firestore().collection(collectionReference.rawValue)
        //return Firestore.firestore().collection(myCollectionReference.rawValue)
//        if collectionReference == .runEvents {
//            myDataRef.order(by: "eventDate").limit(to: 2)
//        }
        let test = myDbReference(to: collectionReference)
        
        let query = test.order(by: UserDefaults.standard.getSortOrder()! )
        
        //myDbReference(to: collectionReference).addSnapshotListener{(snapshot, _) in
        query.addSnapshotListener{(snapshot, _) in
            
            //myDataRef.addSnapshotListener{(snapshot, _) in
            
            // Confirm that we have a snapshot
            guard let snapshot = snapshot else {return}
            print("------------We have a snapshot")
            do {
                // Create new empty objects arrar
                print("------------Create objects from snapshot")
                var objects = [T]()
                
                // Iterate through documents in snapshot
                print("------------Iterate through the documents")
                for document in snapshot.documents {
                    // create object from decoded document
                    print(">>------------create the object")
                    print(document.documentID)
                    print(document.data())
                    
                    // get the document ID
                    let documentID = document.documentID
                    
                    let object = try document.decode(as: objectType.self)
                    
                    if collectionReference == .runEvents {
                        var myRun = object as! Run
                        myRun.id = documentID
                    }
                    
                    // Append object into objects array
                    print(">>------------Append the object")
                    print(object)
                    objects.append(object)
                }
                
                // All documents have been decoded into the objects array
                // In the completion pass in the objects array
                completion(objects)
            } catch {
                print(error)
            }
        }
    }
    
    func myUpdate<T: Encodable & IdentifiableFirestoreDocId>(for encodableObject: T, in collectionReference: MyFireCollectionRef) {
        do {
            //print("++++++Encodable Object++++++")
            //print(encodableObject)
            //print("enode object as json")
            
            var json = try encodableObject.toJson(excluding: ["id"])
            
            if collectionReference == .runEvents {
                json["UserId"] = Auth.auth().currentUser?.uid
                print(json)
            }

            //print("ensure encodable object contains ID")
            guard let id = encodableObject.id else { throw MyError.encodingError}
            //print("do the update")
            myDbReference(to: collectionReference).document(id).setData(json)
        } catch {
            print(error)
        }
    }
    
    func myDelete<T: IdentifiableFirestoreDocId>(_ identifiableObject: T, in collectionReference: MyFireCollectionRef) {
        do {
            guard let id = identifiableObject.id else {throw MyError.encodingError}
            
            myDbReference(to: collectionReference).document(id).delete()
        } catch {
            print(error)
        }
    }
    
    //==============================================
    // Functions used for testing during development
    //==============================================
   
    func oldCreateRun() {
        let runEntry: [String: Any] = ["eventTitle": "harold",
                                       "eventDate": "18-Mar-2007",
                                       "eventLocation": "Bay To Breakers"]
        
        myDbReference(to: .runEvents).addDocument(data: runEntry)
    }
    func oldFetchFireRunFeed() -> [Run] {
        
        var myRuns = [Run]() {
            didSet {
                print("Hello 1111")
            }
        }

        MyFireDbService.sharedInstance.myRead(from: .runEvents, returning: Run.self) {(runs) in
            print("Successfully fetched firbase objects count=",runs.count)
            print("1~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
            print(runs)
            print("2~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
            for run in runs {
                print("------")
                print(run)
            }
            print("2~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
            //self.myFireRuns = runs
            //self.myFireRuns = runs
            myRuns = runs
        }

        return myRuns
    }

    func oldReadRuns() {

        myDbReference(to: .runEvents).addSnapshotListener { (snapshot, _) in

            guard let snapshot = snapshot else {return}
            print("AAAAAAAAAAAAAAAAAAAAA")
            for document in snapshot.documents {
                print("Document=",document.data())
            }
            print("ZZZZZZZZZZZZZZZZZZZ")
        }
    }

    func oldRunUpdate() {

        myDbReference(to: .runEvents).document("aDeXNsNXlbsEb4Uh9yaX").setData(["age": 75, "name": "Wally"])
    }
    
    func oldRunDelete() {
        let runReference = Firestore.firestore().collection("runs")
        runReference.document("aDeXNsNXlbsEb4Uh9yaX").delete()
    }
}
