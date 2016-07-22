//
//  ZXEmotion.swift
//  ZXEmotionKeyboard
//
//  Created by zhangxu on 16/7/21.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class ZXEmotion: NSObject {
    
    // 繁体汉字
    var cht : String?;
    // 简体汉字
    var chs : String?;
    // 静态图名
    var png : String?;
    // emoji 编码
    var code : String? {
        
        didSet {
            
            if code == nil {
                
                return;
            }
            
            self.emoji = NSString.emojiWithStringCode(code!);
           
        }
    };
    // 表情的存放目录和文件
    var directory : String?;
    // emoji表情的字符
    var emoji : String?;
    
    
    override init() {
        
        super.init();
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        self.cht = aDecoder.decodeObjectForKey("cht") as? String;
        self.chs = aDecoder.decodeObjectForKey("chs") as? String;
        self.png = aDecoder.decodeObjectForKey("png") as? String;
        self.code = aDecoder.decodeObjectForKey("code") as? String;
        self.directory = aDecoder.decodeObjectForKey("directory") as? String;
        
    }
    
    
    func encodeWithCoder(aCoder: NSCoder) {
        
        aCoder.encodeObject(cht, forKey: "cht");
        aCoder.encodeObject(chs, forKey: "chs");
        aCoder.encodeObject(png, forKey: "png");
        aCoder.encodeObject(code, forKey: "code");
        aCoder.encodeObject(directory, forKey: "directory");
    }
    
    func isEqual(otherEmotion : ZXEmotion?) -> Bool? {
        
        if (self.code != nil) {
            // emoji表情
            return self.code == otherEmotion?.code;
            
        } else {
            // 图片表情
            return self.png == otherEmotion?.png && self.chs == otherEmotion?.chs && self.cht == otherEmotion?.cht;
        }
        
    }
    
    // 防崩溃
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
        
    }
}
