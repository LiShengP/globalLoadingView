//
//  LXGlobalLoadingView.m
//  LingXi
//
//  Created by lsp on 2020/6/22.
//  Copyright © 2020 cmcc. All rights reserved.
//

#import "LXGlobalLoadingView.h"

@interface LXGlobalLoadingView ()

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *titleHudBgView;

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) LXGlobalLoadingType  hudType;
@property (nonatomic, copy)   NSString *title;
@property (nonatomic, strong) UILabel *tipLabel;

@property (nonatomic, assign) LXGlobalLoadingMaskType maskType;
@property (nonatomic, strong) UIView *super_view;

@end

@implementation LXGlobalLoadingView

-(instancetype)initWithType:(LXGlobalLoadingType)hudType maskType:(LXGlobalLoadingMaskType)maskType superView:(UIView *)view {
    if (self = [super init]) {
        self.super_view = view;
        self.maskType = maskType;
        self.hudType = hudType;
        self.title = nil;
        [self initialViews];
    }
    return self;
}

-(instancetype)initWithType:(LXGlobalLoadingType)hudType title:(NSString *)title maskType:(LXGlobalLoadingMaskType)maskType superView:(UIView *)view {
    if (self = [super init]) {
        self.maskType = maskType;
        self.hudType = hudType;
        self.title = title;
        self.super_view = view;
        [self initialViews];
    }
    return self;
}

- (void)initialViews {
    
    self.backgroundColor = [UIColor clearColor];
    
    [self addSubview:self.backView];
    [self.backView autoSetDimensionsToSize:CGSizeMake(72, 72)];
    [self.backView autoCenterInSuperview];

    if (self.maskType == LXGlobalLoadingMaskTypeAllow) {
        [self.backView autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [self.backView autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self withOffset:-50];
    }else {
        [self.backView autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [self.backView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    }
    
    [self addSubview:self.titleHudBgView];
    
    
    if (self.hudType == LXGlobalLoadingType_Blue) {
        self.imageView.image = [UIImage imageNamed:@"common_loading_blue_00000"];
    }else {
        self.imageView.image = [UIImage imageNamed:@"common_loading_white_00000"];
    }
    if (self.title.length > 0) {
        [self.titleHudBgView addSubview:self.imageView];
        [self.titleHudBgView addSubview:self.tipLabel];
        [self.imageView autoSetDimensionsToSize:CGSizeMake(24, 24)];
        [self.imageView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:24];
        [self.imageView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        [self.tipLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.imageView withOffset:8];
        [self.tipLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:24];
        [self.tipLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        NSDictionary *attr = @{NSFontAttributeName:[UIFont lx_fontRegularOfSize:14.0], NSForegroundColorAttributeName:[UIColor whiteColor]};
        
        CGFloat tipLabelWidth = [self.title boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 16) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine attributes:attr context:nil].size.width;
        CGFloat hudWidth = tipLabelWidth + 80;
        if (hudWidth > kDeviceWidth - 80) {
            hudWidth = kDeviceWidth - 80;
        }
        [self.titleHudBgView autoSetDimension:ALDimensionHeight toSize:40];
        [self.titleHudBgView autoSetDimension:ALDimensionWidth toSize:hudWidth];
        [self.titleHudBgView autoCenterInSuperview];
    }else {
        [self.backView addSubview:self.imageView];
        [self.imageView autoSetDimensionsToSize:CGSizeMake(36, 36)];
        [self.imageView autoCenterInSuperview];
    }
    
    NSMutableArray *images = [NSMutableArray array];
    for (int i = 1; i <= 15; i++) {
        if (self.hudType == LXGlobalLoadingType_Blue) {
            [images addObject:[UIImage imageNamed:[NSString stringWithFormat:@"common_loading_blue_0000%d", i]]];
        }else{
            [images addObject:[UIImage imageNamed:[NSString stringWithFormat:@"common_loading_white_0000%d", i]]];
        }
    }
    self.imageView.animationImages = images;
    self.imageView.animationDuration = 1.0;
}

-(void)showLoading {
    if (self.title.length > 0) {
        self.tipLabel.text = self.title;
        self.backView.hidden = YES;
        self.titleHudBgView.hidden = NO;
    }else {
        self.titleHudBgView.hidden = YES;
        self.backView.hidden = NO;
        if (self.hudType == LXGlobalLoadingType_Blue) {
            self.backView.backgroundColor = [UIColor clearColor];
        }else {
            self.backView.backgroundColor = [UIColor colorWithHex:0x292929];
        }
    }
    if (_maskType == LXGlobalLoadingMaskTypeNone) {
        self.frame = CGRectMake(0, 0, kDeviceWidth, KDeviceHeight);
    } else if (_maskType == LXGlobalLoadingMaskTypeAllow) {
        self.frame = CGRectMake(0, kLXNavigationAndStatusBarHeight, kDeviceWidth, KDeviceHeight - kLXNavigationAndStatusBarHeight);
    }
    if (self.super_view) {
        [self.super_view addSubview:self];
    }else {
        [[AppUtily keyWindow]addSubview:self];
    }
    [self.imageView startAnimating];
}

- (void)hideLoading {
    [self.imageView stopAnimating];
    [self removeFromSuperview];
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [UIView newAutoLayoutView];
        _backView.layer.cornerRadius = 6;
        _backView.backgroundColor = [UIColor colorWithHex:0x292929];
    }
    return _backView;
}
-(UIView *)titleHudBgView {
    if (!_titleHudBgView) {
        _titleHudBgView = [UIView newAutoLayoutView];
        _titleHudBgView.backgroundColor = [UIColor colorWithHex:0x292929];
        _titleHudBgView.layer.cornerRadius = 20;
    }
    return _titleHudBgView;
}

-(UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView newAutoLayoutView];
    }
    return _imageView;
}
-(UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [UILabel newAutoLayoutView];
        _tipLabel.textAlignment = NSTextAlignmentLeft;
        _tipLabel.textColor = [UIColor whiteColor];
        _tipLabel.font = [UIFont lx_fontRegularOfSize:14];
        _tipLabel.numberOfLines = 1;
        _tipLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _tipLabel;
}

@end
