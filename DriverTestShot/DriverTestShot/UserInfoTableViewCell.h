//
//  UserInfoTableViewCell.h
//  DriverTestShot
//
//  Created by EShi on 8/18/15.
//  Copyright (c) 2015 Eren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInfoTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headImage;

+(instancetype) initWithTableView:(UITableView *)tableView userInfoCellWithUserName:(NSString *) userName userHeadImage:(UIImage *) headImage;
@end
