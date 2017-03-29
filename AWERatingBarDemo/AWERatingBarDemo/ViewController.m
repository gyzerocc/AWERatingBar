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

@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    __weak typeof(self) weakself = self;
    AWERatingBar *ratingBar = [[AWERatingBar alloc] initWithFrame:CGRectMake(8, 72, 150, 30) numberOfStars:5 rateStyle:WholeStar isAnination:YES finish:^(CGFloat currentScore) {
        weakself.label1.text = [NSString stringWithFormat:@"No.1 star score: %lf", currentScore];
    }];
    [self.view addSubview:ratingBar];
    
    AWERatingBar *ratingBar1 = [[AWERatingBar alloc] initWithFrame:CGRectMake(8, 112, 150, 30) numberOfStars:5 rateStyle:HalfStar isAnination:YES finish:^(CGFloat currentScore) {
        weakself.label2.text = [NSString stringWithFormat:@"No.2 star score: %lf", currentScore];
    }];
    [self.view addSubview:ratingBar1];
    
    AWERatingBar *ratingBar2 = [[AWERatingBar alloc] initWithFrame:CGRectMake(8, 152, 150, 30) numberOfStars:5 rateStyle:IncompleteStar isAnination:YES finish:^(CGFloat currentScore) {
        weakself.label3.text = [NSString stringWithFormat:@"No.3 star score: %lf", currentScore];
    }];
    [self.view addSubview:ratingBar2];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
