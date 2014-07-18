//
//  MainViewController.m
//  ProgressDemo
//
//  Created by maolin on 14-7-15.
//  Copyright (c) 2014年 maolin. All rights reserved.
//

#import "MainViewController.h"
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>
#import "CustomProgressView.h"
#import "CTFlightProgressView.h"

@interface MainViewController ()

@end

@implementation MainViewController{
    dispatch_once_t once;
    CustomProgressView * progressView;
    CTFlightProgressView * flightProgressView;
    UIButton * btn;
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    dispatch_once(&once, ^{
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"MainCell"];
    });
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.backgroundColor = [UIColor orangeColor];
    progressView = [[CustomProgressView alloc] initWithFrame:CGRectMake(120,20,160,8)];
//    CGAffineTransform transform =CGAffineTransformMakeScale(1.0f,14.0f);
//    progressView.transform = transform;
//    UIImage* trackImage = [[UIImage imageNamed:@"mainTitle"]resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeStretch];
    progressView.progressImage = [UIImage imageNamed:@"mainTitle"];
//    [progressView setTrackImage:trackImage];

//    progressView.trackImage = [UIImage imageNamed:@"mainTitle.png"];
    progressView.progress = 0.5f;
    [cell.contentView addSubview:progressView];
    // Configure the cell...
    btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"click" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(40.0f, 80.0f, 200.0f, 40.0f);
    [cell.contentView addSubview:btn];
    
    flightProgressView = [[CTFlightProgressView alloc]initWithFrame:CGRectMake(40.0f, 140.0f, 200.0f, 60.0f)];
    UIImage * img = [UIImage imageNamed:@"mainTitle"];
    flightProgressView.trackImage = img;
//    flightProgressView.radius = 20.0f;
    flightProgressView.trackTintColor = [UIColor blueColor];
    flightProgressView.progressImage = [UIImage imageNamed:@"navBar"];
    [flightProgressView setProgress:0.5f];
    [cell.contentView addSubview:flightProgressView];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 548.f;
}

-(void)add{
    if (progressView) {
        progressView.progress += 0.05;
    }
}

@end