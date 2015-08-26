//
//  ImgLib.h
//  DriverTestShot
//
//  Created by EShi on 8/26/15.
//  Copyright (c) 2015 Eren. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface ImgLib : NSManagedObject
@property(nonatomic, strong) NSNumber *img_id;
@property(nonatomic, strong) NSData *img_content;
@property(nonatomic, strong) NSString *img_dscp;
@property(nonatomic, strong) NSString *remark;
@end
