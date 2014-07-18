//
//  CustomProgressView.h
//  ProgressDemo
//
//  Created by maolin on 14-7-17.
//  Copyright (c) 2014年 maolin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomProgressView : UIView
@property (nonatomic) CGFloat progress; //0.0 ~ 1.0
@property (nonatomic, retain) UIImage *trackImage;
@property (nonatomic, retain) UIImage *progressImage;
@property(nonatomic, retain) UIColor *progressTintColor;
@property(nonatomic, retain) UIColor *trackTintColor;
@end
