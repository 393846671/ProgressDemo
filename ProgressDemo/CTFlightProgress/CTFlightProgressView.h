//
//  CTFlightProgressView.h
//  ProgressDemo
//
//  Created by maolin on 14-7-16.
//  Copyright (c) 2014年 maolin. All rights reserved.
//

#import <UIKit/UIKit.h>

/*进度条图片填充模式(默认拉伸)*/
typedef NS_ENUM(NSInteger,ProgressImageResizingMode) {
    /*平铺模式(如果进度条图片宽度大于视图宽度,则截取到视图宽度;如果进度条图片宽度小于视图宽度,则图片重复显示)*/
    ProgressImageResizingModeTile,
    
    /*拉伸模式(进度条图片宽度会拉伸或收缩到和视图的宽度一致为止,整个进度条是一张图片,按照进度加载，最后显示的是一张完整图)*/
    ProgressImageResizingModeStretch,
};

/*背景图片填充模式(默认拉伸)*/
typedef NS_ENUM(NSInteger,TrackImageResizingMode) {
    /*平铺模式(如果图片宽度大于视图宽度,则截取到视图宽度;如果图片宽度小于视图宽度,则图片重复显示)*/
    TrackImageResizingModeTile,
    
    /*拉伸模式(图片宽度会拉伸或收缩到和视图的宽度一致为止,整个背景是一张图片)*/
    TrackImageResizingModeStretch,
};

@interface CTFlightProgressView : UIView
@property(nonatomic) float progress;                        // 进度0.0 .. 1.0, 默认 0.0.
@property(nonatomic, retain) UIColor* progressTintColor;    //进度条颜色,设置了进度条图片后,该项失效
@property(nonatomic, retain) UIColor* trackTintColor;       //进度条背景色,设置了背景图片后,该项失效
@property(nonatomic, retain) UIImage* progressImage;        //进度条图片
@property(nonatomic, retain) UIImage* trackImage;           //背景色图片
@property(nonatomic) float radius;  //圆角半径(默认0,不需要圆角)

- (void)setProgress:(float)progress animated:(BOOL)animated;

@end
