//
//  DriverTestLib.h
//  DriverTestShot
//
//  Created by EShi on 9/29/15.
//  Copyright © 2015 Eren. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@class CustomLib;
@interface DriverTestLib : NSManagedObject
@property (nonatomic, retain) NSString * questionDesc;
@property (nonatomic, retain) NSString * answerA;
@property (nonatomic, retain) NSString * answerB;
@property (nonatomic, retain) NSString * answerC;
@property (nonatomic, retain) NSString * answerD;
@property (nonatomic, retain) NSString * rightAnswer;
@property (nonatomic, retain) NSString * remark;
@property (nonatomic, retain) NSNumber * imgNum;
@property (nonatomic, retain) CustomLib *ownCustomLib;
@end
