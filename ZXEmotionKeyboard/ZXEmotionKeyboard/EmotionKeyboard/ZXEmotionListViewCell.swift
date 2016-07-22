//
//  ZXEmotionListViewCell.swift
//  ZXEmotionKeyboard
//
//  Created by zhangxu on 16/7/21.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class ZXEmotionListViewCell: UICollectionViewCell , UICollectionViewDelegateFlowLayout , UICollectionViewDataSource , UICollectionViewDelegate {
    
    // 常量
    let emotionListViewSubCellIdentifier = "emotionListViewSubCellIdentifier";
    
    var collectionView : UICollectionView?;
    var emotionListSubArray : NSMutableArray?;
    
    override init(frame: CGRect) {
        
        super.init(frame: frame);
        
        let layout = UICollectionViewFlowLayout();
        layout.itemSize = CGSizeMake(RealValue(50)!, RealValue(50)!);
        layout.minimumInteritemSpacing = RealValue(10)!;
        layout.minimumLineSpacing = RealValue(10)!;
        collectionView = UICollectionView.init(frame: CGRectMake(0, 0, kScreenWidth, RealValue(271 - 100)!), collectionViewLayout: layout);
        collectionView?.backgroundColor = RGB(210, green: 213, blue: 219);
        collectionView?.dataSource = self;
        collectionView?.delegate = self;
        collectionView?.scrollEnabled = false;
        contentView.addSubview(collectionView!);
        
        
        // 注册cell
        collectionView?.registerClass(ZXEmotionListViewSubCell.self, forCellWithReuseIdentifier: emotionListViewSubCellIdentifier);
        
        
    }
    
    
    
    // 返回多少cell
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (emotionListSubArray?.count)! == 20 {
            
            return 21;
            
        } else {
            
            return (emotionListSubArray?.count)! + 1;
        }
        
    }
    
    // 返回cell
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(emotionListViewSubCellIdentifier, forIndexPath: indexPath) as? ZXEmotionListViewSubCell;
        if emotionListSubArray?.count < 20 {
            
            if indexPath.row == (emotionListSubArray?.count)! {
                
                // 清空icon内容
                cell?.icon?.setTitle(nil, forState: UIControlState.Normal);
                cell?.icon?.setImage(UIImage(named: "compose_emotion_delete@2x"), forState: UIControlState.Normal);
                cell?.icon?.setImage(UIImage(named: "compose_emotion_delete_highlighted@2x"), forState: UIControlState.Highlighted);
                return cell!;
            }
            
        }
        if indexPath.row == 20 {
            // 清空icon内容
            cell?.icon?.setTitle(nil, forState: UIControlState.Normal);
            cell?.icon?.setImage(UIImage(named: "compose_emotion_delete@2x"), forState: UIControlState.Normal);
            cell?.icon?.setImage(UIImage(named: "compose_emotion_delete_highlighted@2x"), forState: UIControlState.Highlighted);
           
            
        } else {
            
            cell?.emotion = emotionListSubArray![indexPath.row] as? ZXEmotion;
            
        }
 
        return cell!;
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
