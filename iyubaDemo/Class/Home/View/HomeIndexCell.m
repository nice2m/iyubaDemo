//
//  HomeIndexCell.m
//  iyubaDemo
//
//  Created by nice2meet on 2018/2/28.
//  Copyright © 2018年 nice2meet-demo. All rights reserved.
//

#import "HomeIndexCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface HomeIndexCell()
@property (weak, nonatomic) IBOutlet UILabel *topImaginaryLineLabel;
@property (weak, nonatomic) IBOutlet UIImageView *leftImgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *readDetailDesLabel;

@end

@implementation HomeIndexCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configModel:(BBCTitleModel *)model{
    NSURL * imgURL = [NSURL URLWithString:model.Pic];
    [self.leftImgView sd_setImageWithURL:imgURL placeholderImage:[UIImage imageNamed:@"homeScrollPagePlaceHolder"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        [UIView animateWithDuration:0.2 animations:^{
            self.leftImgView.alpha = 1.0;
        }];
    }];
    self.titleLabel.text = model.Title;
    NSString * detailDate = [model.CreatTime componentsSeparatedByString:@" "].firstObject;
    self.readDetailDesLabel.text = [NSString stringWithFormat:@"%@ | 阅读：%@",detailDate,model.ReadCount];
}

- (void)showTopImaginary{
    self.topImaginaryLineLabel.hidden = FALSE;
}

@end
