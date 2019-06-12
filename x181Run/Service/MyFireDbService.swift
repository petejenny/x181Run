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
    
    private func reference(to myCollectionReference: MyFireCollectionRef) -> CollectionReference {
        return Firestore.firestore().collection(myCollectionReference.rawValue)
    }
    
    func readRunNumber() {
        reference(to: .SequenceNumbers).addSnapshotListener { (snapshot, _) in
            
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
        reference(to: .SequenceNumbers).addDocument(data: runNumber)
    }
    
    func myCreate<T: Encodable>(for encodableObject: T, in collectionReference: MyFireCollectionRef) {
        
        do {
            // Exclude the id from the json to ensure we don't update and existing database record
            let json = try encodableObject.toJson(excluding: ["id"])
            reference(to: collectionReference).addDocument(data: json)
            
        } catch {
            print(error)
        }
    }
    
    func myRead<T: Decodable>(from collectionReference: MyFireCollectionRef, returning objectType: T.Type, completion: @escaping ([T]) -> Void) {
        print("------------Create reference to firebase location")
        reference(to: .runEvents).addSnapshotListener{(snapshot, _) in
            
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
            print("++++++Encodable Object++++++")
            print(encodableObject)
            print("enode object as json")
            let json = try encodableObject.toJson(excluding: ["id"])
            print("+++++json ++++++")
            print(json)
            print("ensure encodable object contains ID")
            guard let id = encodableObject.id else { throw MyError.encodingError}
            print("do the update")
            reference(to: collectionReference).document(id).setData(json)
        } catch {
            print(error)
        }
    }
    
    func myDelete<T: IdentifiableFirestoreDocId>(_ identifiableObject: T, in collectionReference: MyFireCollectionRef) {
        do {
            guard let id = identifiableObject.id else {throw MyError.encodingError}
            
            reference(to: collectionReference).document(id).delete()
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
        
        reference(to: .runEvents).addDocument(data: runEntry)
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
        
        reference(to: .runEvents).addSnapshotListener { (snapshot, _) in
            
            guard let snapshot = snapshot else {return}
            print("AAAAAAAAAAAAAAAAAAAAA")
            for document in snapshot.documents {
                print("Document=",document.data())
            }
            print("ZZZZZZZZZZZZZZZZZZZ")
        }
    }
    
    func oldRunUpdate() {
        
        reference(to: .runEvents).document("aDeXNsNXlbsEb4Uh9yaX").setData(["age": 75, "name": "Wally"])
    }
    
    func oldRunDelete() {
        let runReference = Firestore.firestore().collection("runs")
        runReference.document("aDeXNsNXlbsEb4Uh9yaX").delete()
    }
}
