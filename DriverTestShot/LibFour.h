//
//  LibFour.h
//  DriverTestShot
//
//  Created by EShi on 8/27/15.
//  Copyright (c) 2015 Eren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface LibFour : NSManagedObject

@property (nonatomic, retain) NSNumber * question_id;
@property (nonatomic, retain) NSString * question_dscp;
@property (nonatomic, retain) NSNumber * img_id;
@property (nonatomic, retain) NSString * answer_items;
@property (nonatomic, retain) NSString * right_answer;
@property (nonatomic, retain) NSNumber * question_type;
@property (nonatomic, retain) NSNumber * is_marked;
@property (nonatomic, retain) NSString * remark;

@end
