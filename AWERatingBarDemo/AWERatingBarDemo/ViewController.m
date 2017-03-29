//
//  ViewController.m
//  AWERatingBarDemo
//
//  Created by 龚阳 on 2017/3/29.
//  Copyright © 2017年 龚阳. All rights reserved.
//

#import "ViewController.h"
#import "AWERatingBar.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    AWERatingBar *ratingBar = [[AWERatingBar alloc] initWithFrame:CGRectMake(8, 72, 150, 30) numberOfStars:5 rateStyle:WholeStar isAnination:YES finish:^(CGFloat currentScore) {
        NSLog(@"current score: %lf", currentScore);
    }];
    [self.view addSubview:ratingBar];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
