//
//  MyFireStorageService.swift
//  x181Run
//
//  Created by Peter Forward on 6/18/19.
//  Copyright © 2019 Peter Forward. All rights reserved.
//

import Firebase
//import FirebaseStorage

struct MyFireStorageService {
    
    static let sharedInstance = MyFireStorageService()
  
    var myImageReference: StorageReference {
        return Storage.storage().reference().child("/users/" + (Auth.auth().currentUser?.uid)! + "/events")
    }
    
    func myFireImageUpload(myImage: UIImage, myImageRef: String) {
        //guard let image = uploadImage.image else {return}
        guard let myImageJpegData = myImage.jpegData(compressionQuality: 0.8) else {return}
        
        let filename = myImageRef  + ".jpg"
        let uploadImageRef = myImageReference.child(filename)
        
        let uploadTask = uploadImageRef.putData(myImageJpegData, metadata: nil) {(metadata, error) in
            print("UPLOAD TASK FINISHED")
            print(metadata ?? "NO METADATA")
            print(error ?? "NO ERROR")
        }
        
        uploadTask.observe(.progress) { (snapshot) in
            print(snapshot.progress ?? "NO MORE PROGRESS")
        }
        
        uploadTask.resume()
    }
    
    func myFireImageDownload(myImageRef: String) {
        
        let filename = myImageRef  + ".jpg"
        let downloadImageRef = myImageReference.child(filename)
        let downloadTask = downloadImageRef.getData(maxSize: 1024 * 1024 * 12) { (data, error) in
            if let data = data {
                let image = UIImage(data: data)
                //self.downloadImage.image = image
            }
            print(error ?? "NO ERROR")
        }
        
        downloadTask.observe(.progress) { (snapshot) in
            print(snapshot.progress ?? "NO MORE PROGRESS")
            
            downloadTask.resume()
        }
    }
    
}
