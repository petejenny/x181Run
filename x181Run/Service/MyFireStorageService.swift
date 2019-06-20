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
    
    static let cache = NSCache<NSString, UIImage>()
    
    static let sharedInstance = MyFireStorageService()
    
    func myFireImageUpload(myImage: UIImage, myImageRef: String) {
        
        
        let filename = myImageRef  + ".jpg"
        
        // Get the local documents directory for the application
        //let imagePath = getDocumentsDirectory().appendingPathComponent(filename)
        
        // Save locally
        guard let myImageJpegData = myImage.jpegData(compressionQuality: 0.8) else {return}
        //try? myImageJpegData.write(to: imagePath)
        
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
    
    
    static func myFireImageDownload(myImageRef: String) {
        
        let filename = myImageRef  + ".jpg"
        let downloadImageRef = myImageReference.child(filename)
        let downloadTask = downloadImageRef.getData(maxSize: 1024 * 1024 * 12) { (data, error) in
            if let data = data {
                let image = UIImage(data: data)
                // download completed
                //self.downloadImage.image = image
            }
            print(error ?? "NO ERROR")
        }
        
        downloadTask.observe(.progress) { (snapshot) in
            print(snapshot.progress ?? "NO MORE PROGRESS")
            
            downloadTask.resume()
        }
    }
    
    // Used for storing files locally
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    static func downloadImage(imageId: String, completion: @escaping (_ image: UIImage?) -> ()) {
        let filename = imageId  + ".jpg"
        //let downloadImageRef =
        let downloadImageRef = myImageReference.child(filename)
        
        // Download task
        let _ = downloadImageRef.getData(maxSize: 1024 * 1024 * 12) { (data, error) in
            if let data = data {
                // We have data -> Therefore download has worked
                let downloadedImage = UIImage(data: data)
                
                if downloadedImage != nil {
                    cache.setObject(downloadedImage!, forKey: imageId as NSString)
                }
                
                completion(downloadedImage)
            }
            print(error ?? "NO ERROR")
        }
        
    }
    
        static func getImage(imageId: String, completion: @escaping (_ image: UIImage?) -> ()) {
    //        let filename = imageId + ".jpg" as NSString
            if let image = cache.object(forKey: imageId as NSString) {
                completion(image)
            } else {
                downloadImage(imageId: imageId, completion: completion)
            }
    //
        }
    
}
