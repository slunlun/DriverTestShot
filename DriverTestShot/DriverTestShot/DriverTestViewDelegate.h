//
//  Header.h
//  DriverTestShot
//
//  Created by EShi on 8/24/15.
//  Copyright (c) 2015 Eren. All rights reserved.
//

#ifndef DriverTestShot_Header_h
#define DriverTestShot_Header_h

#import <UIKit/UIKit.h>
@protocol DriverTestViewProtocal<NSObject>
@required
-(void) DriverTestView:(UIViewController *) driverTestView shouldShowViewController:(UIViewController *) viewController;
@end

#endif
