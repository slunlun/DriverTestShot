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
    cell.headImage.layer.cornerRadius = cell.headImage.frame.size.width / 2;
    cell.headImage.clipsToBounds = YES;
    cell.headImage.layer.borderWidth = 2;
    cell.headImage.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    cell.userNameLabel.text = userName;
    return cell;
    
}

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
        
    //draw the bottom seperator line
    CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
    CGContextStrokeRect(context, CGRectMake(30, rect.size.height, rect.size.width - 60, 1));
    
}

@end
