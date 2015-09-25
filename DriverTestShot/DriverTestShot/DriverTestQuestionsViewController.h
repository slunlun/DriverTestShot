//
//  DriverTestQuestionsViewController.h
//  DriverTestShot
//
//  Created by EShi on 8/24/15.
//  Copyright (c) 2015 Eren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DriverTestShotDefine.h"

@interface DriverTestQuestionsViewController : UIViewController
@property(nonatomic) NSInteger testType;

-(instancetype) initWithTestType:(DriverTestType)type;
@end
