//
//  SwiftHeader.swift
//  ZXEmotionKeyboard
//
//  Created by zhangxu on 16/7/21.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import Foundation
import UIKit

// 屏幕宽度
let kScreenWidth = UIScreen.mainScreen().bounds.size.width;
// 屏幕高度
let kScreenHeight = UIScreen.mainScreen().bounds.size.height;


// 常量
let ZXEmotionToolbarDefaultEmotionNotification = "ZXEmotionToolbarDefaultEmotionNotification";
let ZXEmotionToolbarEmojiEmotionNotification = "ZXEmotionToolbarEmojiEmotionNotification";

// 真实值换算
func RealValue(value : CGFloat?) -> CGFloat? {
    
    let realValue = value! / 414 * kScreenWidth;
    
    return realValue;
}


// RGB 
func RGB(red : CGFloat? , green : CGFloat? , blue : CGFloat?) -> UIColor? {
    
    let color = UIColor.init(red: red!/255, green: green!/255, blue: blue!/255, alpha: 1);
    return color;
}