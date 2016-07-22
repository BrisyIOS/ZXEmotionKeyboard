//
//  ViewController.swift
//  ZXEmotionKeyboard
//
//  Created by zhangxu on 16/7/20.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    var toolbar : Toobar?;
    var isChangingKeyboard : Bool?;
    
    // 懒加载
    lazy var keyboard : ZXEmotionKeyboard? = {
        
        let keyboard = ZXEmotionKeyboard.keyboard();
        let keyboardW = kScreenWidth;
        let keyboardH = RealValue(271)!;
        keyboard?.frame = CGRectMake(0, 0, keyboardW, keyboardH);
        
        return keyboard;
        
    }();

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        toolbar = Toobar();
        toolbar?.emotionButton?.addTarget(self, action: #selector(emotionButtonClick(_:)), forControlEvents: UIControlEvents.TouchUpInside);
        toolbar?.frame = CGRectMake(RealValue(5)!, kScreenHeight - RealValue(40)!, kScreenWidth - RealValue(20)!, RealValue(60)!);
        self.view.addSubview(toolbar!);
        
        
        // 添加通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil);
        
    }
    
    
    func emotionButtonClick(button : UIButton?) -> Void {
        
        // 正在切换键盘
        isChangingKeyboard = true;
        
        if toolbar?.textField?.inputView != nil {
            
            toolbar?.textField?.inputView = nil;
        } else {
            
            toolbar?.textField?.inputView = keyboard;
        }
        
        // 关闭键盘
        toolbar?.textField?.resignFirstResponder();
        isChangingKeyboard = false;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, __int64_t.init(Int64.init(0.1) * Int64.init(NSEC_PER_SEC))), dispatch_get_main_queue()) {
            
            // 打开键盘
            self.toolbar?.textField?.becomeFirstResponder();
        }
    }
    
    
    // 键盘将要显示的时候调用此方法
    func keyboardWillShow(notification : NSNotification?) -> Void {
        
        // 键盘弹出需要的时间
        let duration = notification?.userInfo![UIKeyboardAnimationDurationUserInfoKey]?.doubleValue;
        // 动画
        UIView.animateWithDuration(duration!) {
            
            // 取出键盘高度
            let keyboardF = notification?.userInfo![UIKeyboardFrameEndUserInfoKey]?.CGRectValue();
            let keyboardH = keyboardF?.size.height;
            self.toolbar?.transform = CGAffineTransformMakeTranslation(0, -keyboardH!);
            
        }

    }
    
    // 键盘将要隐藏的时候调用此方法
    func keyboardWillHide(notification : NSNotification?) -> Void {
        
        if isChangingKeyboard == true {
            
            return;
        }
        
        // 键盘弹出需要的时间
        let duration = notification?.userInfo![UIKeyboardAnimationDurationUserInfoKey]?.doubleValue;
        
        // 动画
        UIView.animateWithDuration(duration!) {
            
            self.toolbar?.transform = CGAffineTransformIdentity;
        }
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true);
        
    }
    
  

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

