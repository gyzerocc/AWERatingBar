//
//  AWERatingBar.h
//  AWERatingBar
//
//  Created by 龚阳 on 17/3/23.
//  Copyright © 2017年 gy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AWERatingBar;

typedef void(^finishBlock)(CGFloat currentScore);

typedef NS_ENUM(NSInteger, RateStyle)
{
    WholeStar = 0, //只能整星评论
    HalfStar = 1,  //允许半星评论
    IncompleteStar = 2  //允许不完整星评论
};

@protocol RatingBarDelegate <NSObject>

-(void)ratingBar:(AWERatingBar *)ratingBar ratingChanged:(CGFloat)rating;

@end

@interface AWERatingBar : UIView

@property (nonatomic,assign)BOOL isAnimation;       //是否动画显示，默认NO
@property (nonatomic,assign)BOOL isIndicator;       //是否允许修改Rating 默认NO 可以修改
@property (nonatomic,assign)RateStyle rateStyle;    //评分样式    默认是WholeStar
@property (nonatomic, weak) id<RatingBarDelegate>delegate;


- (void)displayRating:(CGFloat)rating isIndicator:(BOOL)isIndicator;
- (instancetype)initWithCoder:(NSCoder *)aDecoder;


- (instancetype)initWithFrame:(CGRect)frame;
- (instancetype)initWithFrame:(CGRect)frame displayRating:(CGFloat)rating;
- (instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars rateStyle:(RateStyle)rateStyle anination:(BOOL)animation delegate:(id)delegate;


- (instancetype)initWithFrame:(CGRect)frame finish:(finishBlock)finish;
- (instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars rateStyle:(RateStyle)rateStyle isAnination:(BOOL)isAnimation finish:(finishBlock)finish;

@end
