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
#import "SWCardSlideView.h"

#define CARD_MARGIN 10
static NSString *CELL_IDENTITY_QUESTION = @"CELL_IDENTITY_QUESTION";
static NSString *CELL_IDENTITY_IMAGES = @"CELL_IDENTITY_IMAGES";
static NSString *CELL_IDENTITY_ANSWER_ITEM = @"CELL_IDENTITY_ANSWER_ITEM";

@interface DriverTestQuestionsViewController ()<SWCardSlideViewDelegate, UITableViewDataSource, UITabBarDelegate>
@property(nonatomic, strong) NSMutableArray *questionsArray;
@property(nonatomic, strong) UIButton *questionsBtn;
@property(nonatomic, strong) UIButton *markBtn;
@property(nonatomic, strong) DriverTestLib *currentQuestion;
@property(nonatomic) NSInteger currentQuestionNum;
@property(nonatomic, strong) SWCardSlideView *contentSlideView;
@property(nonatomic, strong) UITableView *questionContentTableView;
@property(nonatomic) BOOL isSelAnswer;
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
    _isSelAnswer = NO;
    
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
-(void) initContentSlideViewWithQuestion:(DriverTestLib *) question
{
    
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

#pragma mark SWCardSlideViewDelegate
-(void) cardDidSlideOffLeft:(SWCardSlideView *) cardView
{
}
-(void) cardDidSLideOffRight:(SWCardSlideView *) cardView
{
}

#pragma mark About Table View
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = 1;
    rows += [_currentQuestion.imgNum integerValue];
    
    // 判断题
    if ([_currentQuestion.answerC isEqualToString:@""]) {
        rows += 2;
    }else // 4选题
    {
        rows += 4;
    }
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    
    
    if(indexPath.row == 0)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTITY_QUESTION];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTITY_QUESTION];
        }
        
        cell.frame = CGRectMake(cell.contentView.frame.origin.x, cell.contentView.frame.origin.y, tableView.frame.size.width, cell.contentView.frame.size.height);
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.text = self.currentQuestion.questionDesc;
        cell.textLabel.lineBreakMode = NSLineBreakByCharWrapping;
        
        CGSize textSize = [cell.textLabel sizeThatFits:CGSizeMake(cell.frame.size.width, MAXFLOAT)];
        
        cell.textLabel.textColor = [UIColor blackColor];
        cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, textSize.height + 24);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
    }else if(indexPath.row == 1)
    {
        if ([_currentQuestion.imgNum integerValue] != 0) {
            // 获取对应图片
            cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTITY_IMAGES];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTITY_IMAGES];
            }
            
            for (UIView *subView in cell.contentView.subviews) {
                [subView removeFromSuperview];
            }
            cell.frame = CGRectMake(cell.contentView.frame.origin.x, cell.contentView.frame.origin.y, tableView.frame.size.width, cell.contentView.frame.size.height);
            UIView *imgContentView = [[UIView alloc] initWithFrame:cell.contentView.frame];
            CGSize imageSize;
            imageSize.height = cell.frame.size.height * 2;
            imageSize.width = cell.frame.size.width - 20;
            
            imgContentView.frame = CGRectMake(0, 0, cell.frame.size.width, 5 * 3 + imageSize.height * 2);
            cell.frame = imgContentView.frame;
            
            
            for (int i = 0; i < [self.currentQuestion.imgNum intValue]; i++) {
                UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@%d", self.currentQuestion.imgPerfix, i]]];
                imageView.frame = CGRectMake(10, imageSize.height * i + 5 * (i + 1), imageSize.width, imageSize.height);
                [imgContentView addSubview:imageView];
            }
            
            [cell.contentView addSubview:imgContentView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
            
        }else
        {
            // 没有图片，则这是第一个答案选项A
            cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTITY_ANSWER_ITEM];
            if (cell == nil) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTITY_ANSWER_ITEM];
            }
            cell.textLabel.numberOfLines = 0;
            cell.textLabel.text = self.currentQuestion.answerA;
            cell.textLabel.lineBreakMode = NSLineBreakByCharWrapping;
            
            CGSize textSize = [cell.textLabel sizeThatFits:CGSizeMake(cell.frame.size.width, MAXFLOAT)];
            
            cell.textLabel.textColor = [UIColor blackColor];
            cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, textSize.height + 24);
            
        }
    
    }else if(indexPath.row == 2){
        
    }else if(indexPath.row == 3){
        
    }
    else if(indexPath.row == 4){
        
    }else if(indexPath.row == 5){
        
    }
            
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}


@end
