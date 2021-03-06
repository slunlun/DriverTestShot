//
//  WrongAnswer.h
//  DriverTestShot
//
//  Created by ShiTeng on 15/9/4.
//  Copyright (c) 2015年 Eren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface WrongAnswer : NSManagedObject

@property (nonatomic, retain) NSString * questionDesc;
@property (nonatomic, retain) NSString * answerA;
@property (nonatomic, retain) NSString * answerB;
@property (nonatomic, retain) NSString * answerC;
@property (nonatomic, retain) NSString * answerD;
@property (nonatomic, retain) NSNumber * imgNum;
@property (nonatomic, retain) NSString * rightAnswer;
@property (nonatomic, retain) NSString * remark;
@property (nonatomic, retain) NSNumber * belongLib;

@end
