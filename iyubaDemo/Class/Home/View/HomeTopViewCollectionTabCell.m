//
//  HomeTopViewCollectionTabCell.m
//  iyubaDemo
//
//  Created by HuanLeiMac on 2018/2/28.
//  Copyright © 2018年 nice2meet-demo. All rights reserved.
//

#import "HomeTopViewCollectionTabCell.h"
#import "HomeTopViewCollectionTabCellModel.h"


@interface HomeTopViewCollectionTabCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end


@implementation HomeTopViewCollectionTabCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configModel:(HomeTopViewCollectionTabCellModel *)model{
    self.titleLabel.text = model.title;
    
    UIColor * color = [UIColor colorWithHexString:@"#5C5C5C"];
    if (model.isSelected) {
        color = [UIColor colorWithHexString:@"#86A5C9"];
    }
    self.titleLabel.textColor = color;
}

@end
