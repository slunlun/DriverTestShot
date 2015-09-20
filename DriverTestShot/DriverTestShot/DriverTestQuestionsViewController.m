//
//  DriverTestQuestionsViewController.m
//  DriverTestShot
//
//  Created by EShi on 8/24/15.
//  Copyright (c) 2015 Eren. All rights reserved.
//

#import "DriverTestQuestionsViewController.h"
#import "AppDelegate.h"

@interface DriverTestQuestionsViewController ()
@property(nonatomic, strong) NSMutableArray *questionsArray;
@end

@implementation DriverTestQuestionsViewController
-(instancetype) initWithTestType:(DriverTestType)type
{
    self = [super init];
    if (self) {
        _testType = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = [UIColor brownColor];
    
    [self initTestLibData:_testType];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    
//   
//}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void) initTestLibData:(DriverTestType) testType
{
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.managedObjectContext;

    switch (testType) {
        case TEST_ONE_NORMAL:
        {
            NSFetchRequest *fetchReq = [[NSFetchRequest alloc] init];
            NSEntityDescription *entity = [NSEntityDescription entityForName:TEST_ONE_QUESTION_TAB inManagedObjectContext:context];
            fetchReq.entity = entity;
            NSError *error = [[NSError alloc] init];
            NSArray *ar = [context executeFetchRequest:fetchReq error:nil];
            _questionsArray = [NSMutableArray arrayWithArray:[context executeFetchRequest:fetchReq error:&error]];
            if (error) {
                assert(YES);
            }
        }
            break;
            
        default:
            break;
    }
}
@end
