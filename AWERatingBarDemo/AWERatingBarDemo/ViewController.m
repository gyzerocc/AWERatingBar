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
{
    AWERatingBar *ratingBar3;
}

@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;

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
    
    ratingBar3 = [[AWERatingBar alloc] initWithFrame:CGRectMake(8, 192, 150, 30) numberOfStars:5 rateStyle:IncompleteStar isAnination:YES finish:^(CGFloat currentScore) {
        weakself.label4.text = [NSString stringWithFormat:@"No.4 star score: %lf", currentScore];
    }];
    [self.view addSubview:ratingBar3];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeImage:(UIButton *)sender {
    if (!sender.isSelected) {
        [ratingBar3 setStarImageWithNormalStar:[UIImage imageNamed:@"star_normal"] selectedStar:[UIImage imageNamed:@"star_selected"]];
    } else {
        [ratingBar3 setStarImageWithNormalStar:[UIImage imageNamed:@"b27_icon_star_gray"] selectedStar:[UIImage imageNamed:@"b27_icon_star_yellow"]];
    }
    sender.selected = !sender.isSelected;
}

@end
