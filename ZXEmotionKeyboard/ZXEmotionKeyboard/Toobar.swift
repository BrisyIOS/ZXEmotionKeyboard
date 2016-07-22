//
//  Toobar.swift
//  ZXEmotionKeyboard
//
//  Created by zhangxu on 16/7/20.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class Toobar: UIView {

    var emotionButton : UIButton?;// 表情
    var textField : UITextField?;// 输入框
    var sendButton : UIButton?;// 发送
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame);
        
        // 表情
        emotionButton = UIButton(type : .Custom);
        emotionButton?.frame = CGRectMake(RealValue(20)!, 0, RealValue(32)!, RealValue(32)!);
        emotionButton?.setImage(UIImage(named: "chat_bottom_smile_nor"), forState: UIControlState.Normal);
        emotionButton?.setImage(UIImage(named: "chat_bottom_smile_press"), forState: UIControlState.Highlighted);
        addSubview(emotionButton!);
        
        
        // 输入框
        textField = UITextField();
        textField?.frame = CGRectMake(RealValue(62)!, 0, RealValue(244)!, RealValue(32)!);
        textField?.background = UIImage(named: "chat_bottom_textfield");
        addSubview(textField!);
        
        
        // 发送
        sendButton = UIButton(type : .Custom);
        sendButton?.layer.cornerRadius = 5;
        sendButton?.layer.masksToBounds = true;
        sendButton?.setTitle("发送", forState: UIControlState.Normal);
        sendButton?.frame = CGRectMake(RealValue(326)!, 0, RealValue(58)!, RealValue(32)!);
        sendButton?.backgroundColor = UIColor.init(red: 63/255, green: 197/255, blue: 212/255, alpha: 1);
        addSubview(sendButton!);
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
