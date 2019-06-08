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
    
    func createRun() {
        
        
        let runEntry: [String: Any] = ["runName": "harold",
                                       "runDate": "18-Mar-2007",
                                       "runText": "Bay To Breakers"]
        //let userReference = Firestore.firestore().collection("users")
        reference(to: .runs).addDocument(data: runEntry)
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
        reference(to: .runs).addSnapshotListener{(snapshot, _) in
            
            // Confirm that we have a snapshot
            guard let snapshot = snapshot else {return}
            
            do {
                // Create new empty objects arrar
                var objects = [T]()
                
                // Iterate through documents in snapshot
                for document in snapshot.documents {
                    // create object from decoded document
                    let object = try document.decode(as: objectType.self)
                    
                    // Append object into objects array
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
    
    func fetchFireRunFeed() -> [Run] {
        
        var myRuns = [Run]() {
            didSet {
                print("Hello 1111")
            }
        }
        
                        MyFireDbService.sharedInstance.myRead(from: .runs, returning: Run.self) {(runs) in
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
    
    func readRuns() {
        
        reference(to: .runs).addSnapshotListener { (snapshot, _) in
            
            guard let snapshot = snapshot else {return}
            print("AAAAAAAAAAAAAAAAAAAAA")
            for document in snapshot.documents {
                print("Document=",document.data())
            }
            print("ZZZZZZZZZZZZZZZZZZZ")
        }
    }
    
    func runUpdate() {
        
        reference(to: .runs).document("aDeXNsNXlbsEb4Uh9yaX").setData(["age": 75, "name": "Wally"])
        
    }
    
    //    func myUpdate<T: Encodable & IdentifiableFirestoreDocId>(for encodableObject: T, in collectionReference: MyFireCollectionRef) {
    //        do {
    //
    //            let json = try encodableObject.toJson(excluding: ["id"])
    //            guard let id = encodableObject.id else {
    //                throw MyError.encodingError
    //            }
    //            reference(to: collectionReference).document(id).setData(json)
    //
    //        } catch {
    //            print(error)
    //        }
    //    }
    
    func runDelete() {
        
        let runReference = Firestore.firestore().collection("runs")
        runReference.document("aDeXNsNXlbsEb4Uh9yaX").delete()
        
    }
    
    //    func myDelete<T: IdentifiableFirestoreDocId>(_ identifiableObject: T, in collectionReference: MyFireCollectionRef) {
    //        do {
    //            guard let id = identifiableObject.id else {throw MyError.encodingError}
    //
    //            reference(to: collectionReference).document(id).delete()
    //        } catch {
    //            print(error)
    //        }
    //    }
}
