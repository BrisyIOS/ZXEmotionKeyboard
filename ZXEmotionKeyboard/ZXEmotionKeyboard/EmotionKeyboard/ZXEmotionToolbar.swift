//
//  ZXEmotionToolbar.swift
//  ZXEmotionKeyboard
//
//  Created by zhangxu on 16/7/21.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class ZXEmotionToolbar: UIView {

    
    var defaultEmotion : UIButton?;// 默认
    var emojiButton : UIButton?;// 全部
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame);
        
        
        // 默认
        defaultEmotion = UIButton(type : .Custom);
        defaultEmotion?.setTitle("默认", forState: UIControlState.Normal);
        defaultEmotion?.backgroundColor = UIColor.purpleColor();
        defaultEmotion?.frame = CGRectMake(0, 0, kScreenWidth/2, 50);
        addSubview(defaultEmotion!);
        
        // 全部
        emojiButton = UIButton(type : .Custom);
        emojiButton?.setTitle("Emoji", forState: UIControlState.Normal);
        emojiButton?.backgroundColor = UIColor.greenColor();
        emojiButton?.frame = CGRectMake(kScreenWidth/2, 0, kScreenWidth/2, 50);
        addSubview(emojiButton!);
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
