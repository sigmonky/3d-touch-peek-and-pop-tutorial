//
//  DetailViewController.swift
//  PeekPop
//
//  Created by Frederik Jacques on 06/10/15.
//  Copyright © 2015 Frederik Jacques. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    // IBOutlets
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    // Properties
    var photo:Photo?
    
    // Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

        if let photo = photo {
         
            imageView.image = UIImage(named: photo.imageName)
            captionLabel.text = photo.caption
            
            title = photo.city
        }
        
    }

    override func didReceiveMemoryWarning() {

        super.didReceiveMemoryWarning()

    }
    
    override var previewActionItems: [UIPreviewActionItem] {
        let likeAction = UIPreviewAction(title: "Like", style: .default) { (action, viewController) -> Void in
            print("You liked the photo")
        }
        
        let deleteAction = UIPreviewAction(title: "Delete", style: .destructive) { (action, viewController) -> Void in
            print("You deleted the photo")
        }
        
        return [likeAction, deleteAction]
    }
    
}
