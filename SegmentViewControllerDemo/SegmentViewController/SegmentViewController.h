//
//  SegmentViewController.h
//  HuaMiaoOC
//  带顶部菜单的UIViewcontroller，可以点击segment切换viewcontroller，也可以滑动。
//  Created by andy on 2017/5/17.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SegmentViewController : UIViewController


/**
 正常情况下segment的字体颜色
 */
@property (nonatomic,strong) UIColor *normalColor;


/**
 选中状态下Segment的字体颜色
 */
@property (nonatomic,strong) UIColor *selectedColor;


/**
 segment的字体大小
 */
@property (nonatomic,assign) CGFloat fontSize;


/**
 被选中时，底部的指示条颜色
 */
@property (nonatomic,strong) UIColor *indicatorColor;

/**
 指示条的背景颜色
 */
@property (nonatomic,strong) UIColor *indicatorBKColor;


/**
 segmentView的高度
 */
@property (nonatomic,assign) CGFloat segmentViewHeight;

/**
 指示条大的高度
 */
@property (nonatomic,assign) CGFloat indicatorHeight;

/**
 指示条背景高度
 */
@property (nonatomic,assign) CGFloat indicatorBKHeight;


/**
 选中segment的索引
 */
@property (nonatomic,assign) NSInteger selectedIndex;

/**
 初始化实例

 @param segmentTitles SegmentTitle说
 @param childViewControllers segmentTitle对应的UIViewController
 @return 返回实例
 */
- (instancetype)initWithSegmentTitles:(NSArray *)segmentTitles childViewControllers:(NSArray<UIViewController *> *)childViewControllers;


/**
 SegmentViewController在哪个ViewCOntroller里显示

 @param viewController SegmentViewController 将显示在该ViewCotroller里
 */
- (void)showInViewController:(UIViewController *)viewController;

@end
