//
//  UIView+BorderLine.h
//  UIViewBorderLineDemo
//
//  Created by 王四的mac air on 16/3/2.
//  Copyright © 2016年 王四的mac air. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSInteger, BorderLineStyle) {
    BorderLineStyleNone =   0,
    BorderLineStyleTop =    1 << 0,
    BorderLineStyleBottom = 1 << 1,
    BorderLineStyleLeft =   1 << 2,
    BorderLineStyleRight =  1 << 3
};


@interface UIView (BorderLine)

@property (nonatomic, assign) CGColorRef borderLineColor;
@property (nonatomic, assign) BorderLineStyle borderLineStyle;
@property (nonatomic, assign) CGFloat borderLineWidth;

@end
