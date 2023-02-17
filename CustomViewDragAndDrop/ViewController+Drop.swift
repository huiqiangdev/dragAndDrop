/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Implements the delegate methods for consuming data for a drop interaction.
*/

import UIKit
import Foundation
import MobileCoreServices
import CoreServices
extension ViewController: UIDropInteractionDelegate {
    // MARK: - UIDropInteractionDelegate
    
    /**
         Ensure that the drop session contains a drag item with a data representation
         that the view can consume.
    */
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.hasItemsConforming(toTypeIdentifiers: [kUTTypeText as String]) && session.items.count == 1
    }
    
    // Update UI, as needed, when touch point of drag session enters view.
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidEnter session: UIDropSession) {
        self.dropLabel.text = "有东西拖过来了"
        let dropLocation = session.location(in: view)
        updateLayers(forDropLocation: dropLocation)
    }
    
    /**
         Required delegate method: return a drop proposal, indicating how the
         view is to handle the dropped items.
    */
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        let dropLocation = session.location(in: view)
        updateLayers(forDropLocation: dropLocation)

        let operation: UIDropOperation

        if dropView.frame.contains(dropLocation) {
          
          operation = .copy
        } else {
            // Do not allow dropping outside of the drop view.
            operation = .cancel
        }

      
      return UIDropProposal(operation: operation)
    }
    
    /**
         This delegate method is the only opportunity for accessing and loading
         the data representations offered in the drag item.
    */
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
      
        session.progressIndicatorStyle = .none
      
      
        _ = session.loadObjects(ofClass: String.self) { stringItems in
          DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)){
            
            self.dropLabel.text = stringItems.first
            
          }
           
        }

        // Perform additional UI updates as needed.
        let dropLocation = session.location(in: view)
        updateLayers(forDropLocation: dropLocation)
        // 创建并执行一个简单的动画
        let animation = UIViewPropertyAnimator(duration: 1, curve: .easeInOut) {
          // 将视图颜色更改为绿色
          self.dropView.backgroundColor = UIColor.purple
        }
        animation.startAnimation()
        animation.addCompletion { position in
          // 将视图颜色更改原来的颜色
          self.dropView.backgroundColor = UIColor.systemPink
        }
    }
    
    // Update UI, as needed, when touch point of drag session leaves view.
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidExit session: UIDropSession) {
        let dropLocation = session.location(in: view)
        updateLayers(forDropLocation: dropLocation)
      self.dropLabel.text = "拖拽的东西离开了"
    }
    
    // Update UI and model, as needed, when drop session ends.
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidEnd session: UIDropSession) {
        let dropLocation = session.location(in: view)
        updateLayers(forDropLocation: dropLocation)
      self.dropLabel.text = "拖拽结束了"
    }
  
    func dropInteraction(_ interaction: UIDropInteraction, item: UIDragItem, willAnimateDropWith animator: UIDragAnimating) {
        // 获取交互视图
        guard let view = interaction.view else { return }
        // 设置动画属性
        // 旋转它
        animator.addAnimations {
          view.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 4)
        }
        animator.addCompletion { _ in
          view.transform = CGAffineTransformIdentity
        }
  
    }
    func dropInteraction(_ interaction: UIDropInteraction, previewForDropping item: UIDragItem, withDefault defaultPreview: UITargetedDragPreview) -> UITargetedDragPreview? {
      let size = CGSize(width: 100, height: 100)
      let previewView = UIView(frame: CGRect(origin: CGPoint.zero, size: size))
      previewView.backgroundColor = UIColor.blue
      let preview = UITargetedDragPreview(view: previewView, parameters: defaultPreview.parameters,target: defaultPreview.target)
      
      return preview
    }
  
    func dropInteraction(_ interaction: UIDropInteraction, concludeDrop session: UIDropSession) {
      dragBLabel.text = "动画结束了"
    }

    // MARK: - Helpers

    func updateLayers(forDropLocation dropLocation: CGPoint) {
        if dropView.frame.contains(dropLocation) {
            dragView.layer.borderWidth = 0.0
            dropView.layer.borderWidth = 6.0
        } else if dragView.frame.contains(dropLocation) {
            dragView.layer.borderWidth = 5.0
          dropView.layer.borderWidth = 0.0
        } else {
            dragView.layer.borderWidth = 0.0
            dropView.layer.borderWidth = 0.0
        }
    }
}
