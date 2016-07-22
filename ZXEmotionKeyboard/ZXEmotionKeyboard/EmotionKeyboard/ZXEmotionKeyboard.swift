//
//  ZXEmotionKeyboard.swift
//  ZXEmotionKeyboard
//
//  Created by zhangxu on 16/7/21.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class ZXEmotionKeyboard: UIView {
    
    
    
    var emotionListView : ZXEmotionListView?;
    var emotionToolbar : ZXEmotionToolbar?;


    // 单粒
    class func keyboard() -> ZXEmotionKeyboard? {
        
        let keyboard = ZXEmotionKeyboard();
        return keyboard;
    }
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame);
        
        
        // 表情
        emotionListView = ZXEmotionListView();
        addSubview(emotionListView!);
        
        
        // 工具条
        emotionToolbar = ZXEmotionToolbar();
        emotionToolbar?.defaultEmotion?.addTarget(self, action: #selector(defaultEmotionClick(_:)), forControlEvents: UIControlEvents.TouchUpInside);
        emotionToolbar?.emojiButton?.addTarget(self, action: #selector(emotionButtonClick(_:)), forControlEvents: UIControlEvents.TouchUpInside);
        addSubview(emotionToolbar!);
        
      
    }
    
    // 监听默认表情按钮
    func defaultEmotionClick(button : UIButton?) -> Void {
        
        let defaultEmotion = ZXEmotionManager.defaultEmotions();
        
        NSNotificationCenter.defaultCenter().postNotificationName(ZXEmotionToolbarDefaultEmotionNotification, object: nil, userInfo: [ZXEmotionToolbarDefaultEmotionNotification : defaultEmotion!]);
        
    }
    
    // 监听emoji表情按钮
    func emotionButtonClick(button : UIButton?) -> Void {
        
        let emojiEmotion = ZXEmotionManager.emojiEmotions();
        NSNotificationCenter.defaultCenter().postNotificationName(ZXEmotionToolbarEmojiEmotionNotification, object: nil, userInfo: [ZXEmotionToolbarEmojiEmotionNotification : emojiEmotion!])
    }
    
    
    // 设置子控件的frame
    override func layoutSubviews() {
        
        super.layoutSubviews();
        
        // 表情
        let emotionListViewX = CGFloat(0);
        let emotionListViewY = CGFloat(0);
        let emotionListViewW = kScreenWidth;
        let emotionListViewH = RealValue(271 - 50)!;
        emotionListView?.frame = CGRectMake(emotionListViewX, emotionListViewY, emotionListViewW, emotionListViewH);
        
        
        // 工具条
        let emotionToolbarX = CGFloat(0);
        let emotionToolbarY = emotionListViewH;
        let emotionToolbarW = emotionListViewW;
        let emotionToolbarH = RealValue(50)!;
        emotionToolbar?.frame = CGRectMake(emotionToolbarX, emotionToolbarY, emotionToolbarW, emotionToolbarH);
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
