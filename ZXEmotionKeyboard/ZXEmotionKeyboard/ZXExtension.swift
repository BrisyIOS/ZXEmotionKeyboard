//
//  ZXExtension.swift
//  ZXEmotionKeyboard
//
//  Created by zhangxu on 16/7/21.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import Foundation


// 字符串的延展，主要是扩充一些与表情有关的接口
extension NSString {
    
    class func EmojiCodeToSymbol(c : Int64?) -> Int64? {
        
        
        return ((((0x808080F0 | (c! & 0x3F000) >> 4) | (c! & 0xFC0) << 10) | (c! & 0x1C0000) << 18) | (c! & 0x3F) << 24);
        
    }
    
    class func emojiWithIntCode(code : Int64?) -> String? {
        
        var symbol = EmojiCodeToSymbol(code!);
        var string = NSString.init(bytes: &symbol, length: sizeof(NSInteger), encoding: NSUTF8StringEncoding);
        if string == nil {
            
            string = NSString(format: "%C" , code!);
        }
        
        return string as? String;
    }
    
    class func emojiWithStringCode(stringCode : String?) -> String? {
        
        let stringCode = stringCode?.cStringUsingEncoding(NSUTF8StringEncoding);
        let code = strtoll(stringCode!, nil , 16);
        
        return emojiWithIntCode(code);
    }
    
    // 判断是否是 emoji表情
    func isEmoji() -> Bool? {
        
        var returnValue : Bool = false;
        let hs = characterAtIndex(0);
        if 0xd800 <= hs && hs <= 0xdbff {
            
            if self.length > 1 {
                
                let ls = characterAtIndex(1);
                let mc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00);
                let uc = UInt32.init(mc) + UInt32.init(0x10000)
                if 0x1d000 <= uc && uc <= 0x1f77f {
                    
                    returnValue = true;
                    
                }
                
            }
            
        } else if self.length > 1 {
            
            let ls = characterAtIndex(1);
            if (ls == 0x20e3) {
                
                returnValue = true;
            }
            
        } else {
            
            if 0x2100 <= hs && hs <= 0x27ff {
                
                returnValue = true;
                
            } else if 0x2B05 <= hs && hs <= 0x2b07 {
                
                returnValue = true;
                
            } else if 0x2934 <= hs && hs <= 0x2935 {
                
                returnValue = true;
                
            } else if 0x3297 <= hs && hs <= 0x3299 {
                
                returnValue = true;
                
            } else if hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50 {
                
                returnValue = true;
                
            }
        }
        
        
        return returnValue;
        
    }
    
}
