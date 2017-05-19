//
//  SegmentViewController.m
//  HuaMiaoOC
//
//  Created by andy on 2017/5/17.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "SegmentViewController.h"
#import "SegmentView.h"

@interface SegmentViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource,SegmentViewDelegate>

@property (nonatomic,strong) SegmentView *segmentView;
@property (nonatomic,strong) UIPageViewController *pageViewController;

@property (nonatomic,strong) NSArray *segmentTitles;
@property (nonatomic,strong) NSMutableArray *childViewControllers;

@property (nonatomic,assign) NSInteger currentIndex;

@end

@implementation SegmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIViewController *viewController = [self.childViewControllers firstObject];
    [self.pageViewController setViewControllers:@[viewController] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (instancetype)initWithSegmentTitles:(NSArray *)segmentTitles childViewControllers:(NSArray<UIViewController *> *)childViewControllers
{
    if (self = [super init]) {
        _segmentViewHeight = 30.0f;
        _segmentTitles = [NSArray arrayWithArray:segmentTitles];
        _childViewControllers = [NSMutableArray arrayWithArray:childViewControllers];
    }
    return self;
}

- (void)showInViewController:(UIViewController *)viewController
{
    [viewController addChildViewController:self];
    [viewController.view addSubview:self.view];
    [self.segmentView reloadData];
}

- (SegmentView *)segmentView
{
    if (_segmentView == nil) {
        _segmentView = [[SegmentView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), self.segmentViewHeight) titles:self.segmentTitles];
        _segmentView.delegate = self;
        [self.view addSubview:_segmentView];
    }
    return _segmentView;
}

- (UIPageViewController *)pageViewController
{
    if (_pageViewController == nil) {
        NSDictionary *option = [NSDictionary dictionaryWithObject:@(0) forKey:UIPageViewControllerOptionInterPageSpacingKey];
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:option];
        _pageViewController.delegate = self;
        _pageViewController.dataSource = self;
        
        [self addChildViewController:_pageViewController];
        [self.view addSubview:_pageViewController.view];
    }
    return _pageViewController;
}

- (void)setNormalColor:(UIColor *)normalColor
{
    _normalColor = normalColor;
    self.segmentView.normalColor = normalColor;
}

- (void)setSelectedColor:(UIColor *)selectedColor
{
    _selectedColor = selectedColor;
    self.segmentView.selectedColor = selectedColor;
}

- (void)setFontSize:(CGFloat)fontSize
{
    _fontSize = fontSize;
    
    self.segmentView.fontSize = fontSize;
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    self.segmentView.selectedIndex = selectedIndex;
    self.currentIndex = self.selectedIndex;
}

- (void)setIndicatorHeight:(CGFloat)indicatorHeight
{
    _indicatorHeight = indicatorHeight;
    self.segmentView.indicatorHeight = indicatorHeight;
    
    [self.view setNeedsLayout];
}

- (void)setIndicatorBKHeight:(CGFloat)indicatorBKHeight
{
    _indicatorBKHeight = indicatorBKHeight;
    self.segmentView.indicatorBKHeight = indicatorBKHeight;
}

- (void)setIndicatorColor:(UIColor *)indicatorColor
{
    _indicatorColor = indicatorColor;
    self.segmentView.indicatorColor = indicatorColor;
}

- (void)setIndicatorBKColor:(UIColor *)indicatorBKColor
{
    _indicatorBKColor = indicatorBKColor;
    self.segmentView.indicatorBKColor = indicatorBKColor;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.segmentView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), self.segmentViewHeight);
    self.pageViewController.view.frame = CGRectMake(0, self.segmentViewHeight, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - self.segmentViewHeight);
  
    UIViewController *viewController = [self.childViewControllers objectAtIndex:self.selectedIndex];
    [self.pageViewController setViewControllers:@[viewController] direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];

}

#pragma mark -UIPageViewControllerDelegate
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers
{
    UIViewController *nextVC = [pendingViewControllers firstObject];
    
    self.currentIndex = [self.childViewControllers indexOfObject:nextVC];
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed
{
    if (completed) {
        
        self.segmentView.selectedIndex = self.currentIndex ;
    }
}

#pragma mark -UIPageViewControllerDataSource
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger index = [self.childViewControllers indexOfObject:viewController];
    
    if (index == 0 || (index == NSNotFound)) {
        
        return nil;
    }
    
    index--;
    
    return [self.childViewControllers objectAtIndex:index];

}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger index = [self.childViewControllers indexOfObject:viewController];
    
    if (index == self.childViewControllers.count - 1 || (index == NSNotFound)) {
        
        return nil;
    }
    
    index++;
    
    return [self.childViewControllers objectAtIndex:index];
}

#pragma mark -SegmentViewDelegate
- (void)segmentView:(SegmentView *)segmentView didSelectedIndex:(NSInteger)index
{
    UIViewController *viewController = [self.childViewControllers objectAtIndex:index];
    
    if (index > self.currentIndex) {
        
        [self.pageViewController setViewControllers:@[viewController] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
            
        }];
    } else {
        
        [self.pageViewController setViewControllers:@[viewController] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:^(BOOL finished) {
            
        }];
    }
    
    self.currentIndex = index;

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
