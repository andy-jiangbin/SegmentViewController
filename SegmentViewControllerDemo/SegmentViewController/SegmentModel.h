//
//  SegmentModel.h
//  HuaMiaoOC
//
//  Created by andy on 2017/5/17.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SegmentModel : NSObject

@property (nonatomic,copy) NSString *title;
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) BOOL selected;
@property (nonatomic,assign) CGFloat fontSize;

@end
