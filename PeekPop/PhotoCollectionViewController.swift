//
//  PhotoCollectionViewController.swift
//  PeekPop
//
//  Created by Frederik Jacques on 06/10/15.
//  Copyright © 2015 Frederik Jacques. All rights reserved.
//

import UIKit

private let reuseIdentifier = "photoCell"

class PhotoCollectionViewController: UICollectionViewController, UIViewControllerPreviewingDelegate {
    
    // Properties
    lazy var photos:[Photo] = {
        
        return [
            Photo(caption: "Lovely piece of art in Bordeaux", imageName: "bordeaux", city: "Bordeaux"),
            Photo(caption: "Cosy lake beach in France", imageName: "lake", city: "Bordeaux"),
            Photo(caption: "Harbour in France", imageName: "harbour", city: "Rouffiac"),
            Photo(caption: "Buda beach in Kortrijk", imageName: "buda", city: "Kortrijk")
        ]
        
    }()
    
    // Lifecycle methods    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if( traitCollection.forceTouchCapability == .available){
            
            registerForPreviewing(with: self, sourceView: view)
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if( segue.identifier == "sgPhotoDetail" ){
            let cell = sender as! UICollectionViewCell
            let photo = photos[(collectionView?.indexPath(for: cell)?.row)!]
            
            let vc = segue.destination as! DetailViewController
            vc.photo = photo
            
        }
        
    }

    // MARK: UICollectionViewDataSource methods
    override func numberOfSections(in collectionView: UICollectionView) -> Int {

        return 1
        
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return photos.count
        
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! PhotoCollectionViewCell
    
        // Configure the cell
        let photo = photos[indexPath.row]
        
        if let image = UIImage(named: photo.imageName) {
            
            cell.imageView.image = image
            
        }else {
            
            cell.imageView.image = UIImage(named: "image-not-found")
            
        }

        return cell
    }
    
    // MARK: Trait collection delegate methods
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
    }
    
    // MARK: UIViewControllerPreviewingDelegate methods
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        guard let indexPath = collectionView?.indexPathForItem(at: location) else { return nil }
        
        guard let cell = collectionView?.cellForItem(at: indexPath) else { return nil }
        
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return nil }
        
        let photo = photos[indexPath.row]
        detailVC.photo = photo
        
        detailVC.preferredContentSize = CGSize(width: 0.0, height: 300)
        
        previewingContext.sourceRect = cell.frame
        
        return detailVC
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        
        show(viewControllerToCommit, sender: self)
        
    }
    
}
