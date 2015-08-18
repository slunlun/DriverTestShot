//
//  UserInfoTableViewCell.m
//  DriverTestShot
//
//  Created by EShi on 8/18/15.
//  Copyright (c) 2015 Eren. All rights reserved.
//

#import "UserInfoTableViewCell.h"

@implementation UserInfoTableViewCell
+(instancetype) initWithTableView:(UITableView *)tableView userInfoCellWithUserName:(NSString *) userName userHeadImage:(UIImage *) headImage
{
    static NSString *userCellIdentify = @"userCellIdentify";
    UserInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:userCellIdentify];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:nil options:nil]lastObject];
    }
    
    cell.headImage.image = headImage;
    return cell;
    
}

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
