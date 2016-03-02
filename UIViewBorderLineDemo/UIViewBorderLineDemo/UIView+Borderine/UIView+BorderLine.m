//
//  UIView+BorderLine.m
//  UIViewBorderLineDemo
//
//  Created by 王四的mac air on 16/3/2.
//  Copyright © 2016年 王四的mac air. All rights reserved.
//

#import "UIView+BorderLine.h"

#import <objc/runtime.h>

static CGFloat const kDefaultBottomLineWidth = 0.5f;

static char const kBorderStyleKey = '\0';
static char const kBorderLineLayerKey = '\0';

@interface UIView()

@property (nonatomic, strong) CAShapeLayer *borderLineLayer;

@end

@implementation UIView (BorderLine)

+ (void)load
{
    method_exchangeImplementations(class_getInstanceMethod(self, @selector(layoutSubviews)), class_getInstanceMethod(self, @selector(sp_layoutSubviews)));
}

- (void)sp_layoutSubviews
{
    [self sp_layoutSubviews];
    if (self.borderLineLayer) {
        self.borderLineLayer.frame = self.bounds;
        [self resetBorderPath:self.borderLineStyle];
    }
}

#pragma mark - Setter / Getter

#pragma mark borderLineLayer

- (void)setBorderLineLayer:(CAShapeLayer *)borderLineLayer
{
    objc_setAssociatedObject(self, &kBorderLineLayerKey, borderLineLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CAShapeLayer *)borderLineLayer
{
    return objc_getAssociatedObject(self, &kBorderLineLayerKey);;
}

#pragma mark borderLineColor

- (void)setBorderLineColor:(CGColorRef)borderLineColor
{
    [self borderLayerInstance].strokeColor = borderLineColor;
}

- (CGColorRef)borderLineColor
{
    return self.borderLineLayer.strokeColor;
}

#pragma mark borderLineStyle

- (void)setBorderLineStyle:(BorderLineStyle)borderLineStyle
{
    if (self.borderLineStyle == borderLineStyle) {
        return;
    }
    NSNumber *number = [NSNumber numberWithInteger:borderLineStyle];
    objc_setAssociatedObject(self, &kBorderStyleKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self resetBorderPath:borderLineStyle];
}

- (BorderLineStyle)borderLineStyle
{
    NSNumber *number = objc_getAssociatedObject(self, &kBorderStyleKey);
    if (!number) {
        return BorderLineStyleNone;
    } else {
        return [number integerValue];
    }
}

#pragma mark borderLineWidth

- (void)setBorderLineWidth:(CGFloat)borderLineWidth
{
    [self borderLayerInstance].lineWidth = borderLineWidth;
}

- (CGFloat)borderLineWidth
{
    return self.borderLineLayer.lineWidth;
}

#pragma mark - Helper

- (CAShapeLayer *)borderLayerInstance
{
    CAShapeLayer *layer = self.borderLineLayer;
    if (layer == nil) {
        layer = [[CAShapeLayer alloc] init];
        layer.lineWidth = kDefaultBottomLineWidth;
        self.borderLineLayer = layer;
        [self.layer addSublayer:layer];
    }
    return layer;
}

- (void)resetBorderPath:(BorderLineStyle)style
{
    CGMutablePathRef path = CGPathCreateMutable();
    // Top
    if (style & BorderLineStyleTop) {
        CGPathMoveToPoint(path, NULL, 0, 0);
        CGPathAddLineToPoint(path, NULL, self.bounds.size.width, 0);
    }
    // Right
    if (style & BorderLineStyleRight) {
        CGPathMoveToPoint(path, NULL, self.bounds.size.width, 0);
        CGPathAddLineToPoint(path, NULL, self.bounds.size.width, self.bounds.size.height);
    }
    // Bottom
    if (style & BorderLineStyleBottom) {
        CGPathMoveToPoint(path, NULL, self.bounds.size.width, self.bounds.size.height);
        CGPathAddLineToPoint(path, NULL, 0, self.bounds.size.height);
    }
    // Left
    if (style & BorderLineStyleLeft) {
        CGPathMoveToPoint(path, NULL, 0, self.bounds.size.height);
        CGPathAddLineToPoint(path, NULL, 0, 0);
    }
    
    //    CGPathCloseSubpath(path);
    
    [self borderLayerInstance].path = path;
}

@end
