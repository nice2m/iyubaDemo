//
//  HomeIndexCell.m
//  iyubaDemo
//
//  Created by nice2meet on 2018/2/28.
//  Copyright © 2018年 nice2meet-demo. All rights reserved.
//

#import "HomeIndexCell.h"

@interface HomeIndexCell()
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

- (void)configModel:(NSDictionary *)dict{
    self.leftImgView.image = [UIImage imageNamed:@""];
    self.titleLabel.text = @"";
    self.readDetailDesLabel.text = [NSString stringWithFormat:@"%@ | 阅读：%ld",@"",(long)0];
}

@end
