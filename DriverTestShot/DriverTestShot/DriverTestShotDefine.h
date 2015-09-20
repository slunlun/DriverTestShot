//
//  DriverTestShotDefine.h
//  DriverTestShot
//
//  Created by ShiTeng on 15/9/20.
//  Copyright (c) 2015年 Eren. All rights reserved.
//

#ifndef DriverTestShot_DriverTestShotDefine_h
#define DriverTestShot_DriverTestShotDefine_h

typedef NS_ENUM(NSInteger, DriverTestType) {
    // For test one
    TEST_ONE_NORMAL = 1,
    TEST_ONE_RANDOM,
    TEST_ONE_HARD,
    TEST_ONE_WRONG,
    // For test four
    TEST_FOUR_NORMAL,
};

// Core Data Table Name
#define TEST_ONE_QUESTION_TAB @"DriverTestLibOne"
#define TEST_FOUR_QUESTION_TAB @""
#endif
