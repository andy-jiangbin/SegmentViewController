//
//  SegmentCell.m
//  HuaMiaoOC
//
//  Created by andy on 2017/5/17.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "SegmentCell.h"

@interface SegmentCell ()

@property (nonatomic,strong) UILabel *titleLabel;

@end
@implementation SegmentCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _normalColor = [UIColor grayColor];
        _selectedColor = [UIColor blueColor];
        _fontSize = 12.0f;
    }
    return self;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:_fontSize];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = _normalColor;
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (void)setFontSize:(CGFloat)fontSize
{
    _fontSize = fontSize;
    self.titleLabel.font = [UIFont systemFontOfSize:fontSize];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    self.titleLabel.text = title;
}

- (void)setSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
    self.titleLabel.textColor = isSelected ? _selectedColor:_normalColor;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.frame = self.bounds;
}
@end
