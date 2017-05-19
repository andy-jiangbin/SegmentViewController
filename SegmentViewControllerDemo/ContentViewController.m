//
//  ContentViewController.m
//  SegmentViewControllerDemo
//
//  Created by andy on 2017/5/19.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "ContentViewController.h"

@interface ContentViewController ()
@property (nonatomic,strong) UILabel *label;

@end

@implementation ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setTitlestr:(NSString *)titlestr
{
    _titlestr = titlestr;
    self.label.text = titlestr;
}

- (UILabel *)label
{
    if (_label == nil) {
        _label = [[UILabel alloc]initWithFrame:CGRectMake(100, 100, 200, 40)];
        _label.backgroundColor = [UIColor yellowColor];
        _label.textColor = [UIColor redColor];
        [self.view addSubview:_label];
    }
    return _label;
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
