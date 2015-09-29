//
//  DriverTestQuestionsViewController.m
//  DriverTestShot
//
//  Created by EShi on 8/24/15.
//  Copyright (c) 2015 Eren. All rights reserved.
//

#import "DriverTestQuestionsViewController.h"
#import "AppDelegate.h"
#import "UIButton+SWUIButtonExt.h"
#import "DriverTestLibOne.h"
#import "DriverTestLibFour.h"
#import "DriverTestLib.h"

@interface DriverTestQuestionsViewController ()
@property(nonatomic, strong) NSMutableArray *questionsArray;
@property(nonatomic, strong) UIButton *questionsBtn;
@property(nonatomic, strong) UIButton *markBtn;
@property(nonatomic, strong) DriverTestLib *currentQuestion;
@property(nonatomic) NSInteger currentQuestionNum;
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
    _currentQuestionNum = 1;
    
    [self initTestLibData:_testType];
    [self layoutNavigationBar];
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

#pragma mark INIT
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
            _questionsArray = [NSMutableArray arrayWithArray:[context executeFetchRequest:fetchReq error:&error]];
            _currentQuestion = [_questionsArray firstObject];
            if (error) {
                assert(YES);
            }
        }
            break;
            
        default:
            break;
    }
}

-(void) layoutNavigationBar
{
    
    _questionsBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 55, 32)];
    [_questionsBtn setImage:[UIImage imageNamed:@"QuestionCount"] forState:UIControlStateNormal];
    [_questionsBtn setTitle:[NSString stringWithFormat:@"%ld/%lu", (long)_currentQuestionNum, (unsigned long)_questionsArray.count] forState:UIControlStateNormal];
    _questionsBtn.titleLabel.font = [UIFont systemFontOfSize:9];
//    _questionsBtn.titleLabel.backgroundColor = [UIColor yellowColor];
//    _questionsBtn.imageView.backgroundColor = [UIColor redColor];
//    _questionsBtn.backgroundColor = [UIColor grayColor];
    
    [_questionsBtn centerImageAndTitle:1.0];
    
    _markBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
    [_markBtn setImage:[UIImage imageNamed:@"PinNot"] forState:UIControlStateNormal];
    [_markBtn setTitle: NSLocalizedString(@"MARK_QUESTION", NULL) forState:UIControlStateNormal];
    _markBtn.titleLabel.font = [UIFont systemFontOfSize:9];
    [_markBtn addTarget:self action:@selector(markQuestion:) forControlEvents:UIControlEventTouchUpInside];
    [_markBtn centerImageAndTitle:1.0];
    
    
    UIBarButtonItem *btnQuestionNum = [[UIBarButtonItem alloc] initWithCustomView:_questionsBtn];
    UIBarButtonItem *btnMakrQuestion = [[UIBarButtonItem alloc] initWithCustomView:_markBtn];
    NSArray *barBtnItemArray = @[btnMakrQuestion, btnQuestionNum];
    self.navigationItem.rightBarButtonItems = barBtnItemArray;
}

-(void) markQuestion:(UIButton *) btnItem
{
    if (self.currentQuestion.ownCustomLib) {
        // do delete from mark
    }else
    {
        [self.markBtn setImage:[UIImage imageNamed:@"Pin"] forState:UIControlStateNormal];
        
    }
    
}
@end
