//
//  DriverTestLibraryViewController.h
//  DriverTestShot
//
//  Created by EShi on 8/24/15.
//  Copyright (c) 2015 Eren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DriverTestViewDelegate.h"
#import "DriverTestShotDefine.h"
@interface DriverTestLibraryClassOneViewController : UIViewController
@property(nonatomic, weak) id<DriverTestViewProtocal> delegate;
@end
