//
//  ZXEmotionListViewSubCell.swift
//  ZXEmotionKeyboard
//
//  Created by zhangxu on 16/7/21.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class ZXEmotionListViewSubCell: UICollectionViewCell {
    
    var icon : UIButton?;
    var emotion : ZXEmotion? {
        
        didSet {
            
            // icon内容清空
            icon?.setImage(nil, forState: UIControlState.Normal);
            icon?.setImage(nil, forState: UIControlState.Highlighted);
            icon?.setTitle(nil, forState: UIControlState.Normal);
            
            if ((emotion?.code) != nil) {
                
                // 取消动画效果
                UIView.setAnimationsEnabled(false);
                // 设置emoji表情
                icon?.titleLabel?.font = UIFont.systemFontOfSize(32);
                icon?.setTitle(emotion?.emoji, forState: UIControlState.Normal);
                icon?.setImage(nil, forState: UIControlState.Normal);
                // 再次开启动画
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, __int64_t.init(0.1) * __int64_t.init(NSEC_PER_SEC)), dispatch_get_main_queue(), {
                    
                    UIView.setAnimationsEnabled(true);
                })
            } else {
                
                let icon = String(format: "%@/%@", emotion!.directory!, emotion!.png!);
                var image = UIImage(named: icon);
                image = image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal);
                self.icon?.setImage(image, forState: UIControlState.Normal);
                
            }
        }
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame);
        
        icon = UIButton();
        icon?.adjustsImageWhenHighlighted = false;
        icon?.frame = CGRectMake(0, 0, RealValue(50)!, RealValue(50)!);
        contentView.addSubview(icon!);
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
