//
//  ViewController.m
//  SegmentViewControllerDemo
//
//  Created by andy on 2017/5/19.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "ViewController.h"
#import "SegmentViewController.h"
#import "ContentViewController.h"


@interface ViewController ()
@property (nonatomic,strong) UICollectionView *collectView;

@property (nonatomic,strong) NSArray *menuTitles;
@property (nonatomic,strong) NSMutableArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"新界面";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout =  UIRectEdgeNone;
    _dataSource = [NSMutableArray array];
    _menuTitles = @[@"物理物理物理",@"语文语文",@"数学学",@"语文学学学",@"化物理学",@"自物理然",@"科学"];
    for (NSInteger index = 0; index < _menuTitles.count; index++) {
        ContentViewController *vc = [[ContentViewController alloc] init];
        vc.titlestr = _menuTitles[index];
        [_dataSource addObject:vc];
    }
    SegmentViewController *vc = [[SegmentViewController alloc] initWithSegmentTitles:_menuTitles childViewControllers:_dataSource];
    vc.normalColor = [UIColor redColor];
    vc.selectedColor = [UIColor blueColor];
    vc.selectedIndex = 3;
    vc.indicatorBKColor = [UIColor redColor];
    vc.indicatorBKHeight = 2.0f;
    [vc showInViewController:self];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
