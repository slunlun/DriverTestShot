//
//  ImgLibOne.h
//  DriverTestShot
//
//  Created by EShi on 8/27/15.
//  Copyright (c) 2015 Eren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ImgLibOne : NSManagedObject

@property (nonatomic, retain) NSNumber * img_id;
@property (nonatomic, retain) NSData * img_content;
@property (nonatomic, retain) NSString * img_dscp;
@property (nonatomic, retain) NSString * remark;
@property (nonatomic, retain) NSNumber * belonged_QID;

@end
