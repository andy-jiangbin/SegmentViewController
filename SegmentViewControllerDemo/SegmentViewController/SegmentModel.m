//
//  SegmentModel.m
//  HuaMiaoOC
//
//  Created by andy on 2017/5/17.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "SegmentModel.h"

@implementation SegmentModel

- (instancetype)init
{
    if (self = [super init]) {
        _title = @"";
        _width = 0;
        _selected = NO;
        _fontSize = 12.0f;
    }
    return self;
}

- (CGFloat)width
{
    if (_width <= 0) {
        _width = [self.title boundingRectWithSize:CGSizeMake(0, 30) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:self.fontSize]} context:nil].size.width;
    }
    return _width;
}
@end
