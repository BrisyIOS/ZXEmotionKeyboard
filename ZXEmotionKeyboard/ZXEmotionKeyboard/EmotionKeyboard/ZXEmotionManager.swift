//
//  ZXEmotionManager.swift
//  ZXEmotionKeyboard
//
//  Created by zhangxu on 16/7/21.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class ZXEmotionManager: NSObject {
    
    static var _defaultEmotions : NSMutableArray?;
    static var _emojiEmotions : NSMutableArray?;
    
    
    //  默认表情
    class func defaultEmotions() -> NSMutableArray? {
        
        if _defaultEmotions == nil {
            
            let plist = NSBundle.mainBundle().pathForResource("EmotionResource.bundle/default/info.plist", ofType: nil);
            // 根据文件路径将plist文件转化成模型数组
            
            _defaultEmotions = objectArrayWithFile(plist!);
            
            for emotion in _defaultEmotions! {
                
                let emotion = emotion as? ZXEmotion;
                
                emotion?.directory = NSBundle.mainBundle().pathForResource("EmotionResource.bundle/default", ofType: nil);
                
            }
            
        }
        
        return _defaultEmotions;
        
    }
    
    
    // emoji表情
    class func emojiEmotions() -> NSMutableArray? {
        
        if _emojiEmotions == nil {
            
            let plist = NSBundle.mainBundle().pathForResource("EmotionResource.bundle/emoji/info.plist", ofType: nil);
            _emojiEmotions = objectArrayWithFile(plist!);
            
            for emotion in _emojiEmotions! {
                
                let emotion = emotion as? ZXEmotion;
                emotion?.directory = NSBundle.mainBundle().pathForResource("EmotionResource.bundle/emoji", ofType: nil);
                
            }
        }
        
        return _emojiEmotions;
    }
    
    
    class func objectArrayWithFile(file : String?) -> NSMutableArray? {
        
        let array = NSArray.init(contentsOfFile: file!);
        let emotionArray = NSMutableArray();
        for dic in array! {
            
            let dic = dic as? NSDictionary;
            let model = ZXEmotion();
            model.setValuesForKeysWithDictionary(dic as! [String : AnyObject]);
            emotionArray.addObject(model);
        }
        
        return emotionArray;
    }

}
