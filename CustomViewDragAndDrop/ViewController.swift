/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Demonstrates how to enable drag and drop for a UIImageView instance.
*/

import UIKit

class ViewController: UIViewController {
    // MARK: - Properties
    
  @IBOutlet weak var dragView: UIView! {
    didSet {
      dragView.layer.borderColor = UIColor.yellow.cgColor
      dragView.layer.borderWidth = 0.0
    }
  }
  @IBOutlet weak var dragBView: UIView!
  @IBOutlet weak var dragBLabel: UILabel!
  @IBOutlet weak var dragLabel: UILabel!
  
  @IBOutlet weak var dropView: UIView! {
    didSet {
      dropView.layer.borderColor = UIColor.yellow.cgColor
      dropView.layer.borderWidth = 0.0
    }
    
  }
  @IBOutlet weak var dropLabel: UILabel!
  // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.layer.borderColor = UIColor.red.cgColor
        

        // Enable dragging from the image view (see ViewController+Drag.swift).
        let dragInteraction = UIDragInteraction(delegate: self)
      
        dragView.addInteraction(dragInteraction)
      
        let dragInteractionB = UIDragInteraction(delegate: self)
      
        dragBView.addInteraction(dragInteractionB)
        
        // Enable dropping onto the image view (see ViewController+Drop.swift).
        let dropInteraction = UIDropInteraction(delegate: self)
  
        dropView.addInteraction(dropInteraction)
    }
}
