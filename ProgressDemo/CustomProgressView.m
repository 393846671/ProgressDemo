//
//  CustomProgressView.m
//  ProgressDemo
//
//  Created by maolin on 14-7-17.
//  Copyright (c) 2014年 maolin. All rights reserved.
//

#import "CustomProgressView.h"

@implementation CustomProgressView{
    CGFloat SYSTEM_VERSION;
}


- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        self.progressTintColor = nil;
        self.trackTintColor = nil;
        _progress = 0.0f;
        SYSTEM_VERSION = [[[UIDevice currentDevice] systemVersion] floatValue];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    CGFloat radius = height / 2.0f;
    
    CGFloat fillPercent = _progress < 0.0 || _progress > 1.0 ? 0.0 : _progress;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    CGMutablePathRef tarckPathRef = CGPathCreateMutable();
    CGPathAddArc(tarckPathRef, nil, radius, radius, radius, -M_PI_2, -(M_PI_2-M_PI), 1);
    CGPathAddLineToPoint(tarckPathRef, nil, width, height);
    CGPathAddArc(tarckPathRef, nil, width-radius, radius, radius, M_PI_2, -M_PI_2, 1);
    CGPathAddLineToPoint(tarckPathRef, nil, radius, 0);
    CGPathCloseSubpath(tarckPathRef);
    
    CGMutablePathRef progressPathRef = NULL;
    CGFloat fillWidth = width * fillPercent;
    if (fillWidth > 0.0f) {
        progressPathRef = CGPathCreateMutable();
        CGPathAddArc(progressPathRef, nil, radius, radius, radius, -M_PI_2, -(M_PI_2-M_PI), 1);
        CGPathAddLineToPoint(progressPathRef, nil, fillWidth, height);
        CGPathAddArc(progressPathRef, nil, fillWidth-radius, radius, radius, M_PI_2, -M_PI_2, 1);
        CGPathAddLineToPoint(progressPathRef, nil, radius, 0);
        CGPathCloseSubpath(progressPathRef);
    }
    
    CGContextAddPath(context, tarckPathRef);
    [self.trackTintColor setFill];
    CGContextDrawPath(context, kCGPathFill);
    CGPathRelease(tarckPathRef);
    
    if (progressPathRef) {
        CGContextAddPath(context, progressPathRef);
        [self.progressTintColor setFill];
//        CGContextDrawPath(context, kCGPathFill);
        CGContextFillPath(context);
        CGPathRelease(progressPathRef);
    }
    
    CGContextRestoreGState(context);
}


- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    [self setNeedsDisplay];
}


- (void)setTrackImage:(UIImage *)trackImage {
    if(_trackImage != trackImage) {
        if(_trackImage) {
            _trackImage = nil;
        }
        
        _trackImage = trackImage;
        CGFloat leftRightCaps = 3.0;
        UIEdgeInsets capInsets = UIEdgeInsetsMake(0, leftRightCaps, 0, leftRightCaps);
        UIImage *nmImage = _trackImage;
        if (SYSTEM_VERSION >= 6) {
            UIImageResizingMode resizingMode = UIImageResizingModeStretch;
            nmImage = [_trackImage resizableImageWithCapInsets:capInsets
                                                  resizingMode:resizingMode];
            
        } else if (SYSTEM_VERSION >= 5) {
            CGFloat topBottom = 2;
            capInsets.top = topBottom;
            capInsets.bottom = topBottom;
            nmImage = [_trackImage resizableImageWithCapInsets:capInsets];
        }
        nmImage = [self scaleToSize:nmImage size:CGSizeMake(self.frame.size.width, self.frame.size.height)];
        self.trackTintColor = [UIColor colorWithPatternImage:nmImage];
        [self setNeedsDisplay];
    }
}


- (void)setProgressImage:(UIImage *)progressImage {
    if(_progressImage != progressImage) {
        if(_progressImage) {
            _progressImage = nil;
        }
        _progressImage = progressImage;
        CGFloat leftRightCaps = 6.0;
        UIEdgeInsets capInsets = UIEdgeInsetsMake(0, leftRightCaps, 0, leftRightCaps);
        UIImage *onImage = _progressImage;
        if (SYSTEM_VERSION >= 6) {
            UIImageResizingMode resizingMode = UIImageResizingModeStretch;
            onImage = [_progressImage resizableImageWithCapInsets:capInsets
                                                     resizingMode:resizingMode];
            
        } else if (SYSTEM_VERSION >= 5) {
            CGFloat topBottom = 2;
            capInsets.top = topBottom;
            capInsets.bottom = topBottom;
            onImage = [_progressImage resizableImageWithCapInsets:capInsets];
        }
        onImage = [self scaleToSize:onImage size:CGSizeMake(onImage.size.width, self.frame.size.height)];
        self.progressTintColor = [UIColor colorWithPatternImage:onImage];
        [self setNeedsDisplay];
    }
}


- (void)setTrackTintColor:(UIColor *)trackTintColor {
    if(_trackTintColor != trackTintColor) {
        if(_trackTintColor) {
            _trackTintColor = nil;
        }
        _trackTintColor = trackTintColor;
        if (!trackTintColor) {
            _trackTintColor = [UIColor lightGrayColor];
        }
        [self setNeedsDisplay];
    }
}


- (void)setProgressTintColor:(UIColor *)progressTintColor {
    if(_progressTintColor != progressTintColor) {
        if(_progressTintColor) {
            _progressTintColor = nil;
        }
        _progressTintColor = progressTintColor;
        if (!_progressTintColor) {
            _progressTintColor = [UIColor orangeColor];
        }
        [self setNeedsDisplay];
    }
}


- (void)dealloc {
    self.trackImage = nil;
    self.progressImage = nil;
    self.trackTintColor = nil;
    self.progressTintColor = nil;
}


#pragma mark -
#pragma mark Utils
//用来放缩图片的方法，当然，如果你的图片大小刚好，就没有必要了
- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}
@end
