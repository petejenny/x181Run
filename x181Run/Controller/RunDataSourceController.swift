//
//  RunDataSourceController.swift
//  x181Run
//
//  Created by Peter Forward on 5/30/19.
//  Copyright © 2019 Peter Forward. All rights reserved.
//

import LBTAComponents

class RunDatasourceController: DatasourceController {
    
    let errorMessageLabel: UILabel = {
        let label = UILabel()
        label.text = "Apologies something went wrong.  Please try again later."
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        return label
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //collectionView?.backgroundColor = .red
        
        view.addSubview(errorMessageLabel)
        errorMessageLabel.fillSuperview()
        
        setupNavigationBarItems()
        
        print("----------------Read runs from Firebase")
        MyFireDbService.sharedInstance.myRead(from: .runs, returning: Run.self) {(runs) in
            print("---------------set the datasource to the runs that have been read in")
            self.datasource = MyFireRunDataSource(runs: runs)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        // Don't leave a gap between the cells
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // First section
        if indexPath.section == 0 {
            // Section 0 returns user struct
            // BioText size estimation
            guard let run = self.datasource?.item(indexPath) as? Run else { return .zero}
            let estimatedHeight = estimatedHeightForTest(run.runText)
            return CGSize(width: view.frame.width, height: estimatedHeight + 66)
            
        } else if indexPath.section == 1 {
            // Section 1 returns a tweet struct
            // Tweet size estimation
            //            guard let tweet = datasource?.item(indexPath) as? Tweet else {return .zero}
            //            let estimatedHeight = estimatedHeightForTest(tweet.message)
            //            return CGSize(width: view.frame.width, height: estimatedHeight + 74)
            
            return CGSize(width: view.frame.width, height: 200)
        }
        return CGSize(width: view.frame.width, height: 150)
    }
    
    private func estimatedHeightForTest(_ text: String) -> CGFloat {
        let approximatedWidthOfBioTextView = view.frame.width - 12 - 50 - 12 - 2  // Tweak as necessary
        let size = CGSize(width: approximatedWidthOfBioTextView, height: 1000)
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)]
        let estimatedFrame = NSString(string: text).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        
        return estimatedFrame.height
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        
        collectionView.collectionViewLayout.invalidateLayout()
    }
}
