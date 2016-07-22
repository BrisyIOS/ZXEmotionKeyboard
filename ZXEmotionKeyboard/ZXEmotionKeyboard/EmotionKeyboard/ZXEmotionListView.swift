//
//  ZXEmotionListView.swift
//  ZXEmotionKeyboard
//
//  Created by zhangxu on 16/7/21.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class ZXEmotionListView: UIView , UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    
    // 常量
    let emotionListViewCellIdentifier = "emotionListViewCellIdentifier";

    var collectionView : UICollectionView?;
    var pageControl : UIPageControl?;
    var page : NSInteger?;
    var emotionArray : NSMutableArray?;
    var emotionListArray : NSMutableArray?;
    
    // 移除通知
    deinit {
        
        NSNotificationCenter.defaultCenter().removeObserver(self);
    }
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame);
        
        let layout = UICollectionViewFlowLayout();
        layout.itemSize = CGSizeMake(kScreenWidth, RealValue(271 - 100)!);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal;
        collectionView = UICollectionView.init(frame: CGRectMake(0, 10, kScreenWidth, RealValue(271 - 90)!), collectionViewLayout: layout);
        collectionView?.pagingEnabled = true;
        collectionView?.backgroundColor = RGB(210, green: 213, blue: 219);
        collectionView?.dataSource = self;
        collectionView?.delegate = self;
        addSubview(collectionView!);
        
        
        // 注册cell
        collectionView?.registerClass(ZXEmotionListViewCell.self, forCellWithReuseIdentifier: emotionListViewCellIdentifier);
        
        
        // 添加pageControl
        pageControl = UIPageControl();
        pageControl?.currentPage = 0;
        pageControl?.numberOfPages = 5;
        pageControl?.center = CGPointMake(self.center.x, RealValue(271 - 65)!)
        pageControl?.bounds = CGRectMake(0, 0, 100, 30);
        pageControl?.currentPageIndicatorTintColor = UIColor.grayColor();
        pageControl?.pageIndicatorTintColor = UIColor.whiteColor();
        addSubview(pageControl!);
        
        
        // 添加通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(defaultEmotionButton(_:)), name: ZXEmotionToolbarDefaultEmotionNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(emojiEmotionNotification(_:)), name: ZXEmotionToolbarEmojiEmotionNotification, object: nil);

        
        // 默认情况下
        emotionArray = ZXEmotionManager.defaultEmotions();
        
        emotionListArray = separArray(emotionArray!);
        
    }
    
    // 将大数组分割成小数组
    func separArray(array : NSArray?) -> NSMutableArray? {
        
        let emotionListArray = NSMutableArray();
        var subArray = NSMutableArray();
        for emotion in array! {
            
            let emotion = emotion as? ZXEmotion;
            if subArray.count < 20 {
                
                subArray.addObject(emotion!);
                
            } else {
                
                emotionListArray.addObject(subArray);
                subArray = NSMutableArray();
            }
        }
    
        emotionListArray.addObject(subArray);
       
        
        return emotionListArray;
        
    }
    
    // 实现默认表情通知方法
    func defaultEmotionButton(notification : NSNotification?) -> Void {
        
        let defaultEmotion = notification?.userInfo!["ZXEmotionToolbarDefaultEmotionNotification"] as? NSMutableArray;
        emotionArray = defaultEmotion;
        emotionListArray = separArray(defaultEmotion);
        pageControl?.numberOfPages = (defaultEmotion?.count)! / 21 + 1;
        collectionView?.reloadData();
        
    }
    
    
    // 实现emoji表情通知方法
    func emojiEmotionNotification(notification : NSNotification?) -> Void {
        
        let emojiEmotion = notification?.userInfo!["ZXEmotionToolbarEmojiEmotionNotification"] as? NSMutableArray;
        emotionArray = emojiEmotion;
        emotionListArray = separArray(emojiEmotion);
        pageControl?.numberOfPages = (emojiEmotion?.count)! / 21 + 1;
        collectionView?.reloadData();
  
    }
    
    
    // 返回多少cell
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return (emotionArray?.count)! / 21 + 1;
    }
    
    // 返回cell
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        // 更新页码
        pageControl?.currentPage = indexPath.row;
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(emotionListViewCellIdentifier, forIndexPath: indexPath) as? ZXEmotionListViewCell;
        cell?.emotionListSubArray = emotionListArray![indexPath.row] as? NSMutableArray;
        cell?.collectionView?.reloadData();
        return cell!;
        
    }
    
    
    // 滚动结束调用此方法
    func scrollViewDidZoom(scrollView: UIScrollView) {
        
        if scrollView.contentOffset.x < 0 {
            
            page = 0;
        } else if scrollView.contentOffset.x > CGFloat((pageControl?.numberOfPages)!) * kScreenWidth {
            
            page = pageControl?.numberOfPages;
        } else {
            
            page = NSInteger.init(scrollView.contentOffset.x / kScreenWidth);
        }
        pageControl?.currentPage = page!;
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
