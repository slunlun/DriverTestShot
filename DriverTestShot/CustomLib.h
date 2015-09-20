//
//  CustomLib.h
//  DriverTestShot
//
//  Created by ShiTeng on 15/9/4.
//  Copyright (c) 2015年 Eren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DriverTestLibFour, DriverTestLibOne;

@interface CustomLib : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * isInMemory;
@property (nonatomic, retain) NSDate * startMemoryDate;
@property (nonatomic, retain) NSDate * nextMemoryDate;
@property (nonatomic, retain) NSNumber * memoryState;
@property (nonatomic, retain) NSSet *libFourQuestions;
@property (nonatomic, retain) NSSet *libOneQuestions;
@end

@interface CustomLib (CoreDataGeneratedAccessors)

- (void)addLibFourQuestionsObject:(DriverTestLibFour *)value;
- (void)removeLibFourQuestionsObject:(DriverTestLibFour *)value;
- (void)addLibFourQuestions:(NSSet *)values;
- (void)removeLibFourQuestions:(NSSet *)values;

- (void)addLibOneQuestionsObject:(DriverTestLibOne *)value;
- (void)removeLibOneQuestionsObject:(DriverTestLibOne *)value;
- (void)addLibOneQuestions:(NSSet *)values;
- (void)removeLibOneQuestions:(NSSet *)values;

@end
