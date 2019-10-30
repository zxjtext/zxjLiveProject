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

private let kChatContentViewHeight : CGFloat = 200

class liveDetaileViewController: UIViewController,Emitterable{

    fileprivate lazy var chatToolsView : ChatToolsView = ChatToolsView.loadFromNib()
    fileprivate lazy var giftListView : GiftListView = GiftListView.loadFromNib()
    fileprivate lazy var chatContentView : ChatContentView = ChatContentView.loadFromNib()
    fileprivate lazy var socket : HYSocket = HYSocket(addr: "172.16.100.58", port: 7878)
    fileprivate var heartBeatTimer : Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(_:)), name: .UIKeyboardWillChangeFrame, object: nil)
        // 3.连接聊天服务器
        if socket.connectServer() {
            print("连接成功")
            socket.startReadMsg()
            addHeartBeatTimer()
            socket.sendJoinRoom()
            socket.delegate = self
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
           super.viewDidDisappear(animated)
           socket.sendLeaveRoom()
       }
       
       deinit {
           heartBeatTimer?.invalidate()
           heartBeatTimer = nil
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
        
        // 0.设置Chat内容的View
        chatContentView.frame = CGRect(x: 0, y: view.bounds.height - 44 - kChatContentViewHeight, width: view.bounds.width, height: kChatContentViewHeight)
        chatContentView.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        view.addSubview(chatContentView)
        
        //
        chatToolsView.frame = CGRect(x: 0, y: view.bounds.height-88, width: view.bounds.width, height: kChatToolsViewHeight)
        chatToolsView.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]
        chatToolsView.delegate = self
        view.addSubview(chatToolsView)
        
        // 2.设置giftListView
        giftListView.frame = CGRect(x: 0, y: view.bounds.height, width: view.bounds.width, height: kGiftlistViewHeight)
        giftListView.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]
        view.addSubview(giftListView)
        giftListView.delegate = self
        
    }
}

// MARK:- 监听用户输入的内容
extension liveDetaileViewController : ChatToolsViewDelegate , GiftListViewDelegate {
    func chatToolsView(toolView: ChatToolsView, message: String) {
        socket.sendTextMsg(message: message)
    }
    func giftListView(giftView: GiftListView, giftModel: GiftModel) {
        socket.sendGiftMsg(giftName: giftModel.subject, giftURL: giftModel.img2, giftCount: 1)
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
            let contentEndY = inputViewY == (kScreenH - kChatToolsViewHeight) ? (kScreenH - kChatContentViewHeight - 44) : endY - kChatContentViewHeight
            self.chatContentView.frame.origin.y = contentEndY
        })
    }
}



// MARK:- 给服务器发送即时消息
extension liveDetaileViewController {
    
    fileprivate func addHeartBeatTimer() {
        heartBeatTimer = Timer(fireAt: Date(), interval: 9, target: self, selector: #selector(sendHeartBeat), userInfo: nil, repeats: true)
        RunLoop.main.add(heartBeatTimer!, forMode: .commonModes)
    }
    
    @objc fileprivate func sendHeartBeat() {
        socket.sendHeartBeat()
    }
}

// MARK:- 接受聊天服务器返回的消息
extension liveDetaileViewController : HYSocketDelegate {
    func socket(_ socket: HYSocket, joinRoom user: UserInfo) {
        chatContentView.insertMsg(AttrStringGenerator.generateJoinLeaveRoom(user.name, true))
    }
    
    func socket(_ socket: HYSocket, leaveRoom user: UserInfo) {
        chatContentView.insertMsg(AttrStringGenerator.generateJoinLeaveRoom(user.name, false))
    }
    
    func socket(_ socket: HYSocket, chatMsg: ChatMessage) {
        // 1.通过富文本生成器, 生产需要的富文本
        let chatMsgMAttr = AttrStringGenerator.generateTextMessage(chatMsg.user.name, chatMsg.text)
        
        // 2.将文本的属性字符串插入到内容View中
        chatContentView.insertMsg(chatMsgMAttr)
    }
    
    func socket(_ socket: HYSocket, giftMsg: GiftMessage) {
        // 1.通过富文本生成器, 生产需要的富文本
        let giftMsgAttr = AttrStringGenerator.generateGiftMessage(giftMsg.giftname, giftMsg.giftUrl, giftMsg.user.name)
        
        // 2.将文本的属性字符串插入到内容View中
        chatContentView.insertMsg(giftMsgAttr)
    }
}
