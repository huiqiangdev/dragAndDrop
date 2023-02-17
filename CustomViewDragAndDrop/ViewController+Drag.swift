/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Implements the delegate methods for providing data for a drag interaction.
*/

import UIKit

extension ViewController: UIDragInteractionDelegate {
    // MARK: - UIDragInteractionDelegate
    
   
    func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
      print(#function)
        let string = "我是拖拽对象的数据"
        let provider = NSItemProvider(object: string as NSString)
        let item = UIDragItem(itemProvider: provider)
      

        return [item]
    }
//    func dragInteraction(_ interaction: UIDragInteraction, itemsForAddingTo session: UIDragSession, withTouchAt point: CGPoint) -> [UIDragItem] {
//      print(#function)
//      let itemProvider = NSItemProvider(object: "拖拽过程中额外的数据" as NSString)
//      let dragItem = UIDragItem(itemProvider: itemProvider)
//      return [dragItem]
//    }
  
    func dragInteraction(_ interaction: UIDragInteraction, sessionForAddingItems sessions: [UIDragSession], withTouchAt point: CGPoint) -> UIDragSession? {
      print(#function)
      guard let newSession = sessions.first else {
        return nil
      }
      // Set the desired behavior for the new session
      newSession.localContext = "New session"
    
      return newSession
    }
  // Animation
//    func dragInteraction(_ interaction: UIDragInteraction, willAnimateLiftWith animator: UIDragAnimating, session: UIDragSession) {
//      // 获取拖动视图
//      guard let view = interaction.view else { return }
//
//      // 计算拖动距离
//      let translation = CGPoint(x: 0, y: 100)
//
//      // 设置动画属性
//      animator.addAnimations {
//        view.transform = CGAffineTransform(translationX: translation.x, y: translation.y)
//        view.transform = CGAffineTransform(rotationAngle: Double.pi)
//      }
//
//      // 完成动画后将视图恢复到原始位置
//      animator.addCompletion { position in
//        if position == .end {
//          UIView.animate(withDuration: 1) {
//            view.transform = .identity
//          }
//        }
//      }
//
//    }
//    func dragInteraction(_ interaction: UIDragInteraction, item: UIDragItem, willAnimateCancelWith animator: UIDragAnimating) {
//      // 获取拖动视图
//      guard let view = interaction.view else { return }
//      let translation = CGPoint(x: -10, y: 10)
//      animator.addAnimations {
//        view.transform = CGAffineTransform(translationX: translation.x, y: translation.y)
//        view.transform = CGAffineTransform(rotationAngle: Double.pi)
//      }
//      animator.addCompletion { position in
//
//        if position == .end {
//          UIView.animate(withDuration: 0.6) {
//              view.transform = .identity
//            }
//        }
//      }
//    }
    func dragInteraction(_ interaction: UIDragInteraction, sessionWillBegin session: UIDragSession) {
      dragBLabel.text = "开始移动了"
    }
    func dragInteraction(_ interaction: UIDragInteraction, session: UIDragSession, willAdd items: [UIDragItem], for addingInteraction: UIDragInteraction) {
      dragBLabel.text = "开始添加另外一个Item"
    }
    func dragInteraction(_ interaction: UIDragInteraction, sessionDidMove session: UIDragSession) {
      dragBLabel.text = "移动到其他位置"
    }
    func dragInteraction(_ interaction: UIDragInteraction, session: UIDragSession, willEndWith operation: UIDropOperation) {
      let maps:[UInt:String] = [0:"取消",1:"禁止",2:"拷贝",3:"移动"]
      dragBLabel.text = "\(maps[operation.rawValue]!)的行为将要结束了"
    }
    func dragInteraction(_ interaction: UIDragInteraction, session: UIDragSession, didEndWith operation: UIDropOperation) {
      let maps:[UInt:String] = [0:"取消",1:"禁止",2:"拷贝",3:"移动"]
      dragBLabel.text = "\(maps[operation.rawValue]!)的行为结束了"
    }
    func dragInteraction(_ interaction: UIDragInteraction, sessionDidTransferItems session: UIDragSession) {
      dragBLabel.text = "已经将Item移交给接收者了"
    }
//    func dragInteraction(_ interaction: UIDragInteraction, previewForLifting item: UIDragItem, session: UIDragSession) -> UITargetedDragPreview? {
//      let imageView = UIImageView(image: UIImage(named: "butterfly"))
//      imageView.frame = CGRect(x: 50, y: 50, width: 50, height: 50)
//      let dragView = interaction.view!
//      let dragPoint = session.location(in: dragView)
//      let target = UIDragPreviewTarget(container: dragView, center: dragPoint)
//      return UITargetedDragPreview(view: imageView, parameters:UIDragPreviewParameters(),
//                                   target:target)
//    }
//    func dragInteraction(_ interaction: UIDragInteraction, previewForCancelling item: UIDragItem, withDefault defaultPreview: UITargetedDragPreview) -> UITargetedDragPreview? {
//      let imageView = UIImageView(image: UIImage(named: "dog"))
//
//      return UITargetedDragPreview(view: imageView, parameters:defaultPreview.parameters,
//                                   target:defaultPreview.target)
//    }
    func dragInteraction(_ interaction: UIDragInteraction, prefersFullSizePreviewsFor session: UIDragSession) -> Bool {
      return true
    }
//  private func dragInteraction(_ interaction: UIDragInteraction, viewForLifting item: UIDragItem, session: UIDragSession) -> UIView? {
//      let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
//      view.layer.cornerRadius = 50
//      view.layer.masksToBounds = true
//      view.backgroundColor = .purple
//      return view
//    }

  
}
