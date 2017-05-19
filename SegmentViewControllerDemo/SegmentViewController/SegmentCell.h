//
//  SegmentCell.h
//  HuaMiaoOC
//
//  Created by andy on 2017/5/17.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SegmentCell : UICollectionViewCell

@property (nonatomic,strong) NSString *title;

@property (nonatomic,strong) UIColor *normalColor;
@property (nonatomic,strong) UIColor *selectedColor;

@property (nonatomic,assign) CGFloat fontSize;

@property (nonatomic,assign,setter=setSelected:) BOOL isSelected;

@end
