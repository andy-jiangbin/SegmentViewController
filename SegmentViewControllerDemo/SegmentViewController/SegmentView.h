//
//  SegmentView.h
//  HuaMiaoOC
//SegmentView，顶部菜单
//  Created by andy on 2017/5/17.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SegmentView;
@protocol SegmentViewDelegate <NSObject>

- (void)segmentView:(SegmentView *)segmentView didSelectedIndex:(NSInteger)index;

@end

@interface SegmentView : UIView

@property (nonatomic,strong) UIColor *normalColor;
@property (nonatomic,strong) UIColor *selectedColor;

@property (nonatomic,assign) CGFloat fontSize;

@property (nonatomic,strong) UIColor *indicatorColor;
@property (nonatomic,strong) UIColor *indicatorBKColor;

@property (nonatomic,assign) CGFloat indicatorHeight;
@property (nonatomic,assign) CGFloat indicatorBKHeight;

@property (nonatomic,assign) NSInteger selectedIndex;

@property (nonatomic,weak) id<SegmentViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray<NSString *> *)titles;

- (void)reloadData;

@end
