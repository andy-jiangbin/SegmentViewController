//
//  SegmentView.m
//  HuaMiaoOC
//
//  Created by andy on 2017/5/17.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "SegmentView.h"
#import "SegmentCell.h"
#import "SegmentModel.h"

static const CGFloat lineSpacing = 10.0f;

@interface SegmentView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UIView *indicatorView;
@property (nonatomic,strong) UIView *indicatorBKView;

@property (nonatomic,strong) NSMutableArray *dataSource;

@end

@implementation SegmentView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray<NSString *> *)titles
{
    if (self = [super initWithFrame:frame]) {
        if (titles) {
            self.backgroundColor = [UIColor whiteColor];
           
            _normalColor = [UIColor grayColor];
            _selectedColor = [UIColor blueColor];
            
            _indicatorColor = [UIColor blueColor];
            _indicatorBKColor = [UIColor grayColor];
            
            _fontSize = 12.0f;
            
            _indicatorHeight = 2.0f;
            
            [self initData:titles];
        }
    }
    return self;
}

- (void)initData:(NSArray<NSString *> *)datas
{
     _dataSource = [NSMutableArray array];
    [datas enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SegmentModel *model = [[SegmentModel alloc] init];
        model.title = obj;
        [_dataSource addObject:model];
    }];
    
    self.selectedIndex = 0;
}

- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_collectionView];
        [_collectionView registerClass:[SegmentCell class] forCellWithReuseIdentifier:@"SegmentCellID"];
    }
    return _collectionView;
}

- (UIView *)indicatorView
{
    if (_indicatorView == nil) {
        _indicatorView = [[UIView alloc] init];
        _indicatorView.backgroundColor = _indicatorColor;
        [self.collectionView addSubview:_indicatorView];
         [self.collectionView bringSubviewToFront:_indicatorView];
    }
    return _indicatorView;
}

- (UIView *)indicatorBKView
{
    if (_indicatorBKView == nil) {
        _indicatorBKView = [[UIView alloc] init];
        _indicatorBKView.backgroundColor = _indicatorBKColor;
        [self.collectionView addSubview:_indicatorBKView];
        [self.collectionView sendSubviewToBack:_indicatorBKView];
    }
    return _indicatorBKView;
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    SegmentModel *oldModel = [self.dataSource objectAtIndex:_selectedIndex];
    oldModel.selected = NO;
    
    _selectedIndex = selectedIndex;
    
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
    
    [self moveIndicatorToIndexPath:indexpath animation:YES];
    [self.collectionView scrollToItemAtIndexPath:indexpath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
    SegmentModel *currentModel = [self.dataSource objectAtIndex:selectedIndex];
    currentModel.selected = YES;
    
    [self.collectionView reloadData];


}

- (void)setIndicatorColor:(UIColor *)indicatorColor
{
    _indicatorColor = indicatorColor;
    self.indicatorView.backgroundColor = indicatorColor;
}

- (void)setIndicatorBKColor:(UIColor *)indicatorBKColor
{
    self.indicatorBKView.backgroundColor = indicatorBKColor;
}

- (void)setFontSize:(CGFloat)fontSize
{
    _fontSize = fontSize;
    if (self.dataSource.count > 0) {
        for (SegmentModel *model in self.dataSource) {
            model.fontSize = fontSize;
        }
    }
}

- (void)calculateWidth
{
    __block CGFloat totalWidth = lineSpacing;
    [self.dataSource enumerateObjectsUsingBlock:^(SegmentModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        totalWidth = totalWidth + model.width + lineSpacing;
    }];
    
    if (totalWidth < CGRectGetWidth(self.frame)) {
        CGFloat equalWidth = (CGRectGetWidth(self.frame) - ((self.dataSource.count + 1)* 10)) / self.dataSource.count;
        for (SegmentModel *model in self.dataSource) {
            if (model.width < equalWidth) {
                model.width = equalWidth;
            }
        }
    }
}

- (void)reloadData
{
    [self calculateWidth];
    
    [self.collectionView reloadData];
}

#pragma mark -UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectedIndex == indexPath.row) {
        return;
    }
    
    [self setSelectedIndex:indexPath.row];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(segmentView:didSelectedIndex:)]) {
        [self.delegate segmentView:self didSelectedIndex:indexPath.row];
    }
}
#pragma mark -UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SegmentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SegmentCellID" forIndexPath:indexPath];
    cell.normalColor = _normalColor;
    cell.selectedColor = _selectedColor;
    
    SegmentModel *model = self.dataSource[indexPath.row];
    cell.title = model.title;
    cell.isSelected = model.selected;
    cell.fontSize = model.fontSize;
    return cell;
}

#pragma mark -UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SegmentModel *model = [self.dataSource objectAtIndex:indexPath.row];
    return CGSizeMake(model.width, CGRectGetHeight(self.frame));
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 10, 0, 10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.0f;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
}

#pragma mark -移动indicator
- (void)moveIndicatorToIndexPath:(NSIndexPath *)indexPath animation:(BOOL)animation
{
    SegmentCell *cell = (SegmentCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    if (cell) {
        CGRect indicatorBounds = self.indicatorView.bounds;
        indicatorBounds.size.width = cell.bounds.size.width;
        
        CGPoint indicatorCenter = self.indicatorView.center;
        indicatorCenter.x = cell.center.x;
        
        if (animation) {
            
            [UIView animateWithDuration:0.1 animations:^{
                
                self.indicatorView.bounds = indicatorBounds;
                self.indicatorView.center = indicatorCenter;
            }];
        } else {
            self.indicatorView.bounds = indicatorBounds;
            self.indicatorView.center = indicatorCenter;
        }
    }
}

#pragma mark - layoutsubview
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
    
    CGFloat offset = lineSpacing;
    
    for (NSInteger nIndex = 0; nIndex < self.selectedIndex; nIndex++) {
        SegmentModel *model = [self.dataSource objectAtIndex:nIndex];
        offset = offset + model.width + lineSpacing;
    }
    SegmentModel *model = [self.dataSource objectAtIndex:self.selectedIndex];
    self.indicatorView.frame = CGRectMake(offset, CGRectGetHeight(self.frame) - _indicatorHeight,model.width, _indicatorHeight);
    
    if (_indicatorBKView) {
        _indicatorBKView.frame = CGRectMake(0, CGRectGetHeight(self.frame) - self.indicatorBKHeight, CGRectGetWidth(self.frame), self.indicatorBKHeight);
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
