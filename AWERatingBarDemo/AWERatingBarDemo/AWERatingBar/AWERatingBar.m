//
//  AWERatingBar.m
//  AWERatingBar
//
//  Created by 龚阳 on 17/3/23.
//  Copyright © 2016年 gy. All rights reserved.
//

#import "AWERatingBar.h"

#define ForegroundStarImage @"b27_icon_star_yellow"
#define BackgroundStarImage @"b27_icon_star_gray"

typedef void(^completeBlock)(CGFloat currentScore);

@interface AWERatingBar()

@property (nonatomic, strong) UIView *foregroundStarView;
@property (nonatomic, strong) UIView *backgroundStarView;

@property (nonatomic, assign) NSInteger numberOfStars;
@property (nonatomic,assign)CGFloat currentScore;   // 当前评分：0-5  默认0

@property (nonatomic,strong)completeBlock complete;

@end

@implementation AWERatingBar

- (void)setStarImageWithNormalStar:(UIImage *)normalStar selectedStar:(UIImage *)selectedStar {
    if (normalStar && selectedStar) {
        [self.foregroundStarView.subviews enumerateObjectsUsingBlock:^(__kindof UIImageView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.image = selectedStar;
        }];
        [self.backgroundStarView.subviews enumerateObjectsUsingBlock:^(__kindof UIImageView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.image = normalStar;
        }];
    }
}

- (void)displayRating:(CGFloat)rating isIndicator:(BOOL)isIndicator {
    self.isIndicator = isIndicator;
    self.currentScore = rating;
}

#pragma mark - 代理方式
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        _numberOfStars = 5;
        _rateStyle = WholeStar;
        [self createStarView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _numberOfStars = 5;
        _rateStyle = WholeStar;
        [self createStarView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame displayRating:(CGFloat)rating {
    if (self = [super initWithFrame:frame]) {
        _numberOfStars = 5;
        _rateStyle = WholeStar;
        _isIndicator = YES;
        self.currentScore = rating;
        [self createStarView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars rateStyle:(RateStyle)rateStyle anination:(BOOL)animation delegate:(id)delegate{
    if (self = [super initWithFrame:frame]) {
        _numberOfStars = numberOfStars;
        _rateStyle = rateStyle;
        _isAnimation = animation;
        _delegate = delegate;
        [self createStarView];
    }
    return self;
}

#pragma mark - block方式
- (instancetype)initWithFrame:(CGRect)frame finish:(finishBlock)finish{
    if (self = [super initWithFrame:frame]) {
        _numberOfStars = 5;
        _rateStyle = WholeStar;
        _complete = ^(CGFloat currentScore){
            finish(currentScore);
        };
        [self createStarView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars rateStyle:(RateStyle)rateStyle isAnination:(BOOL)isAnimation finish:(finishBlock)finish{
    if (self = [super initWithFrame:frame]) {
        _numberOfStars = numberOfStars;
        _rateStyle = rateStyle;
        _isAnimation = isAnimation;
        _complete = ^(CGFloat currentScore){
            finish(currentScore);
        };
        [self createStarView];
    }
    return self;
}

#pragma mark - private Method
- (void)createStarView{
    self.foregroundStarView = [self createStarViewWithImage:[UIImage imageNamed:ForegroundStarImage]];
    self.backgroundStarView = [self createStarViewWithImage:[UIImage imageNamed:BackgroundStarImage]];
    self.foregroundStarView.frame = CGRectMake(0, 0, self.bounds.size.width*_currentScore/self.numberOfStars, self.bounds.size.height);
    
    [self addSubview:self.backgroundStarView];
    [self addSubview:self.foregroundStarView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTapRateView:)];
    tapGesture.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tapGesture];
}

- (UIView *)createStarViewWithImage:(UIImage *)image {
    UIView *view = [[UIView alloc] initWithFrame:self.bounds];
    view.clipsToBounds = YES;
    view.backgroundColor = [UIColor clearColor];
    for (NSInteger i = 0; i < self.numberOfStars; i ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake(i * self.bounds.size.width / self.numberOfStars, 0, self.bounds.size.width / self.numberOfStars, self.bounds.size.height);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [view addSubview:imageView];
    }
    return view;
}

- (void)userTapRateView:(UITapGestureRecognizer *)gesture {
    if (self.isIndicator) {
        return;
    }
    CGPoint tapPoint = [gesture locationInView:self];
    CGFloat offset = tapPoint.x;
    CGFloat realStarScore = offset / (self.bounds.size.width / self.numberOfStars);
    switch (_rateStyle) {
        case WholeStar:
        {
            self.currentScore = ceilf(realStarScore);
            break;
        }
        case HalfStar:
            self.currentScore = roundf(realStarScore)>realStarScore ? ceilf(realStarScore):(ceilf(realStarScore)-0.5);
            break;
        case IncompleteStar:
            self.currentScore = realStarScore;
            break;
        default:
            break;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    __weak AWERatingBar *weakSelf = self;
    CGFloat animationTimeInterval = self.isAnimation ? 0.2 : 0;
    [UIView animateWithDuration:animationTimeInterval animations:^{
        weakSelf.foregroundStarView.frame = CGRectMake(0, 0, weakSelf.bounds.size.width * weakSelf.currentScore/self.numberOfStars, weakSelf.bounds.size.height);
    }];
}

- (void)setCurrentScore:(CGFloat)currentScore {
    if (_currentScore == currentScore) {
        return;
    }
    if (currentScore < 0) {
        _currentScore = 0;
    } else if (currentScore > _numberOfStars) {
        _currentScore = _numberOfStars;
    } else {
        _currentScore = currentScore;
    }
    
    if ([self.delegate respondsToSelector:@selector(ratingBar:ratingChanged:)]) {
        [self.delegate ratingBar:self ratingChanged:_currentScore];
    }
    
    if (self.complete) {
        _complete(_currentScore);
    }
    
    [self setNeedsLayout];
}

#pragma mark - Touches

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self touchedRating:touches];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self touchedRating:touches];
}

- (void)touchedRating:(NSSet *)touches {
    if (self.isIndicator) {
        return;
    }
    CGPoint point = [[touches anyObject] locationInView:self];
    CGFloat offset = point.x;
    CGFloat realStarScore = offset / (self.bounds.size.width / self.numberOfStars);
    switch (_rateStyle) {
        case WholeStar:
        {
            self.currentScore = ceilf(realStarScore);
            break;
        }
        case HalfStar:
            self.currentScore = roundf(realStarScore)>realStarScore ? ceilf(realStarScore):(ceilf(realStarScore)-0.5);
            break;
        case IncompleteStar:
            self.currentScore = realStarScore;
            break;
        default:
            break;
    }
}

@end
