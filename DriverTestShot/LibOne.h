//
//  LibOne.h
//  DriverTestShot
//
//  Created by EShi on 8/26/15.
//  Copyright (c) 2015 Eren. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface LibOne : NSManagedObject
@property(nonatomic, strong) NSNumber *question_id;
@property(nonatomic, strong) NSString *question_dscp;
@property(nonatomic, strong) NSNumber *image_id;
@property(nonatomic, strong) NSString *answer_items;
@property(nonatomic, strong) NSString *right_answer;
@property(nonatomic, strong) NSNumber *question_type;
@property(nonatomic) BOOL is_marked;
@property(nonatomic, strong) NSString *remark;
@end
