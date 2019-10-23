//
//  liveDetaileViewController.swift
//  zxjLive
//
//  Created by zxj on 2019/10/17.
//  Copyright © 2019 zxj. All rights reserved.
//

import UIKit

private let kChatToolsViewHeight : CGFloat = 44

private let kGiftlistViewHeight : CGFloat = kScreenH * 0.5

class liveDetaileViewController: UIViewController,Emitterable{

    fileprivate lazy var chatToolsView : ChatToolsView = ChatToolsView.loadFromNib()
    fileprivate lazy var giftListView : GiftListView = GiftListView.loadFromNib()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(_:)), name: .UIKeyboardWillChangeFrame, object: nil)
    }
    
    
    @IBAction func giftBtnAction(_ sender: Any) {
     UIView.animate(withDuration: 0.25, animations: {
        
        var pageViewFrame = self.giftListView.bounds
        pageViewFrame.size.width = kScreenW
        self.giftListView.frame = pageViewFrame
        self.giftListView.frame.origin.y = kScreenH - self.giftListView.bounds.height
        self.view.addSubview(self.giftListView)
        
    })
          
          
    }
    @IBAction func chatBtnAction(_ sender: Any) {
        chatToolsView.inputTextField.becomeFirstResponder()
    }
    
    @IBAction func btnAction(_ sender: UIButton) {
    
        sender.isSelected = !sender.isSelected
        let point = CGPoint(x:sender.center.x, y: sender.center.y - sender.bounds.height*0.5)
        sender.isSelected ? startEmittering(point) : stopEmittering()
        
        
        
    }
    
   

}

// MARK:- 设置UI界面内容
extension liveDetaileViewController {
    fileprivate func setupUI() {
        //setupBlurView()
        setupBottomView()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           chatToolsView.inputTextField.resignFirstResponder()
        UIView.animate(withDuration: 0.25, animations: {
                   self.giftListView.frame.origin.y = kScreenH
               })
       }
    fileprivate func setupBlurView() {
        let blur = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        blurView.frame = view.bounds
        view.addSubview(blurView)
    }
    
    fileprivate func setupBottomView() {
        chatToolsView.frame = CGRect(x: 0, y: view.bounds.height-88, width: view.bounds.width, height: kChatToolsViewHeight)
        chatToolsView.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]
        chatToolsView.delegate = self
        view.addSubview(chatToolsView)
    }
}

// MARK:- 监听用户输入的内容
extension liveDetaileViewController : ChatToolsViewDelegate {
    func chatToolsView(toolView: ChatToolsView, message: String) {
        print(message)
    }
}

// MARK:- 监听键盘的弹出
extension liveDetaileViewController {
    @objc fileprivate func keyboardWillChangeFrame(_ note : Notification) {
        let duration = note.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
        let endFrame = (note.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let inputViewY = endFrame.origin.y - kChatToolsViewHeight
        
        UIView.animate(withDuration: duration, animations: {
            UIView.setAnimationCurve(UIViewAnimationCurve(rawValue: 7)!)
            let endY = inputViewY == (kScreenH - kChatToolsViewHeight) ? kScreenH : inputViewY
            self.chatToolsView.frame.origin.y = endY
        })
    }
}
