//
//  NewsCellView.m
//  TestOC
//
//  Created by wangjianjun on 17/7/4.
//  Copyright © 2017年 wangjianjun. All rights reserved.
//

#import "NewsCellView.h"
#import "Story.h"
#import "AFHTTPRequestOperationManager.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Masonry.h"
#import "MASConstraintMaker.h"

const int cellHeight = 300;

@implementation NewsCellView


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.cellImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.cellImageView];
        
        UIImageView * imageView = self.cellImageView;
        [self.cellImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView).offset(0);
            make.left.equalTo(self.contentView).offset(16);
            make.top.equalTo(self.contentView).offset(16);
            make.bottom.equalTo(self.contentView).offset(-16);
            make.width.equalTo(imageView.mas_height);
        }];
        
        
        
        self.cellLabel = [[UILabel alloc] init];
        self.cellLabel.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview: self.cellLabel];
        
        [self.cellLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.cellImageView).offset(16);
            make.right.equalTo(self.contentView).offset(-16);
            make.top.equalTo(self.contentView).offset(16);
            make.bottom.equalTo(self.contentView).offset(-16);
        }];
    
    }
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 300;
}

- (void)setData:(Story *)story{
    self.story = story;
    self.cellLabel.text = story.title;

    [self.cellImageView sd_setImageWithURL:[NSURL URLWithString:[story.images objectAtIndex:0]]
                      placeholderImage:[UIImage imageNamed:@"pic_mv.png"]];
}

@end