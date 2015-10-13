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

#define CARD_LEFT_RIGHT_MARGIN 10
#define CARD_TOP_MARGIN 70
#define CARD_BOTTOM_MARGIN 15
#define IMG_VIEW_LEFT_RIGHT_MARGIN 10
#define IMG_VIEW_TOP_BOTTOM_MARGIN 5

static NSString *CELL_IDENTITY_QUESTION = @"CELL_IDENTITY_QUESTION";
static NSString *CELL_IDENTITY_IMAGES = @"CELL_IDENTITY_IMAGES";
static NSString *CELL_IDENTITY_ANSWER_ITEM = @"CELL_IDENTITY_ANSWER_ITEM";

@interface DriverTestQuestionsViewController ()<SWCardSlideViewDelegate, UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong) NSMutableArray *questionsArray;
@property(nonatomic, strong) UIButton *questionsBtn;
@property(nonatomic, strong) UIButton *markBtn;
@property(nonatomic, strong) DriverTestLib *currentQuestion;
@property(nonatomic) NSInteger currentQuestionIndex;
@property(nonatomic, strong) SWCardSlideView *contentSlideView;
@property(nonatomic, strong) UITableView *questionContentTableView;
@property(nonatomic) BOOL isSelAnswer;
@property(nonatomic) CGRect cellOrgiFrame;
@property(nonatomic) CGRect cellContentViewOrgiFrame;
@property(nonatomic, strong) NSIndexPath *currentRightIndex;


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
    _currentQuestionIndex = 0;
    _isSelAnswer = NO;
    
   // _questionContentTableView = [UITableView alloc] init
    [self initTestLibData:_testType];
    [self initContentSlideView];
    [self layoutNavigationBar];
    
    // In ios7 viewcontroller will adjust the top space of scrollview controllers, in case have space to show navigationbar.
    // But now we setframe of our contenttableview in cardview and do not need navigationbar, so we disable the capacity
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    
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
-(void) initContentSlideView
{
    CGSize screenSize = self.view.bounds.size;
    CGFloat screenWidth = screenSize.width;
    CGFloat screenHeight = screenSize.height;
    _contentSlideView = [[SWCardSlideView alloc] initWithFrame:CGRectMake(CARD_LEFT_RIGHT_MARGIN, CARD_TOP_MARGIN, screenWidth - 2*CARD_LEFT_RIGHT_MARGIN, screenHeight - CARD_TOP_MARGIN - CARD_BOTTOM_MARGIN)];
    _contentSlideView.delegate = self;
    
    _questionContentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _contentSlideView.frame.size.width, _contentSlideView.frame.size.height)];
    _questionContentTableView.delegate = self;
    _questionContentTableView.dataSource = self;
    _questionContentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
   
    

    [_contentSlideView addSubview:_questionContentTableView];
    
    [self.view addSubview:_contentSlideView];
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
    [_questionsBtn setTitle:[NSString stringWithFormat:@"%ld/%lu", (long)(_currentQuestionIndex + 1), (unsigned long)_questionsArray.count] forState:UIControlStateNormal];
    _questionsBtn.titleLabel.font = [UIFont systemFontOfSize:9];
//    _questionsBtn.titleLabel.backgroundColor = [UIColor yellowColor];
//    _questionsBtn.imageView.backgroundColor = [UIColor redColor];
//    _questionsBtn.backgroundColor = [UIColor grayColor];
    
    [_questionsBtn centerImageAndTitle:1.0];
    
    _markBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
    if (self.currentQuestion.ownCustomLib) {
        
        [_markBtn setImage:[UIImage imageNamed:@"Pin"] forState:UIControlStateNormal];
        
    }else
    {
        [_markBtn setImage:[UIImage imageNamed:@"PinNot"] forState:UIControlStateNormal];
    }
    
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
        [_markBtn setImage:[UIImage imageNamed:@"PinNot"] forState:UIControlStateNormal];
        
    }else
    {
        [self.markBtn setImage:[UIImage imageNamed:@"Pin"] forState:UIControlStateNormal];
        
    }
    
}
#pragma mark SETTER/GETTER
-(void) setCurrentQuestion:(DriverTestLib *) newTest
{
    _currentQuestion = newTest;
    [self.questionContentTableView reloadData];
}

#pragma mark SWCardSlideViewDelegate
-(void) cardDidSlideOffLeft:(SWCardSlideView *) cardView
{
    self.currentQuestionIndex++;
    self.currentQuestion = self.questionsArray[self.currentQuestionIndex];
    [_questionsBtn setTitle:[NSString stringWithFormat:@"%ld/%lu", (long)(_currentQuestionIndex + 1), (unsigned long)_questionsArray.count] forState:UIControlStateNormal];
    
    [self.contentSlideView showFromRight];
}
-(void) cardDidSLideOffRight:(SWCardSlideView *) cardView
{
    self.currentQuestionIndex--;
    self.currentQuestion = self.questionsArray[self.currentQuestionIndex];
    [_questionsBtn setTitle:[NSString stringWithFormat:@"%ld/%lu", (long)(_currentQuestionIndex + 1), (unsigned long)_questionsArray.count] forState:UIControlStateNormal];
    
    [self.contentSlideView showFromLeft];
}

#pragma mark About Table View
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = 1;
    if ([_currentQuestion.imgNum integerValue] > 0) {
        rows++;
    }
    
    
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
    NSString *rightAnswer = nil;
    
    UIColor *lightGray = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.0];
    tableView.backgroundColor = lightGray;
    
    if(indexPath.row == 0)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTITY_QUESTION];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTITY_QUESTION];
            self.cellOrgiFrame = cell.frame;
            self.cellContentViewOrgiFrame = cell.contentView.frame;
        }else
        {
            cell.frame = self.cellOrgiFrame;
        }
        
       
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.text = self.currentQuestion.questionDesc;
        cell.textLabel.lineBreakMode = NSLineBreakByCharWrapping;
        
        CGSize textSize = [cell.textLabel sizeThatFits:CGSizeMake(cell.frame.size.width, MAXFLOAT)];
        
        cell.textLabel.textColor = [UIColor blackColor];
        cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, textSize.height + 24);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }else if(indexPath.row == 1)
    {
        if ([_currentQuestion.imgNum integerValue] > 0) {
            NSInteger imgNums = [_currentQuestion.imgNum integerValue];
            // 获取对应图片
            cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTITY_IMAGES];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTITY_IMAGES];
            }else
            {
                // 因为是复用的cell，所以要恢复cell的默认size，才可以正确计算cell的大小
                cell.frame = self.cellOrgiFrame;
                cell.contentView.frame = self.cellContentViewOrgiFrame;
            }
            
            for (UIView *subView in cell.contentView.subviews) {
                [subView removeFromSuperview];
            }
            cell.frame = CGRectMake(cell.contentView.frame.origin.x, cell.contentView.frame.origin.y, tableView.frame.size.width, cell.contentView.frame.size.height);
            
            UIView *imgContentView = [[UIView alloc] init];
            CGSize imageSize;
            imageSize.height = cell.frame.size.height * 2;
            imageSize.width = cell.frame.size.width - IMG_VIEW_LEFT_RIGHT_MARGIN*2;
            
            imgContentView.frame = CGRectMake(0, 0, cell.frame.size.width, IMG_VIEW_TOP_BOTTOM_MARGIN * (imgNums + 1) + imageSize.height * imgNums);
            cell.frame = imgContentView.frame;
            
            
            for (int i = 0; i < [self.currentQuestion.imgNum intValue]; i++) {
                UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@%d", self.currentQuestion.imgPerfix, i]]];
                imageView.frame = CGRectMake(IMG_VIEW_LEFT_RIGHT_MARGIN, imageSize.height * i + IMG_VIEW_TOP_BOTTOM_MARGIN * (i + 1), imageSize.width, imageSize.height);
                [imgContentView addSubview:imageView];
            }
            
            [cell.contentView addSubview:imgContentView];
            imgContentView.backgroundColor = [UIColor redColor];
            cell.backgroundColor = [UIColor yellowColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
            
        }else
        {
            // 没有图片，则这是第一个答案选项A
            cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTITY_ANSWER_ITEM];
            if (cell == nil) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTITY_ANSWER_ITEM];
            }else
            {
                cell.frame = self.cellOrgiFrame;
            }
            cell.textLabel.numberOfLines = 0;
            cell.textLabel.text = self.currentQuestion.answerA;
            cell.backgroundColor = lightGray;
            cell.textLabel.lineBreakMode = NSLineBreakByCharWrapping;
            
            CGSize textSize = [cell.textLabel sizeThatFits:CGSizeMake(cell.frame.size.width, MAXFLOAT)];
            
            cell.textLabel.textColor = [UIColor blackColor];
            cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, textSize.height + 24);
            
        }
    
    }else {
        
        cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTITY_ANSWER_ITEM];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTITY_ANSWER_ITEM];
        }else
        {
            cell.frame = self.cellOrgiFrame;
        }
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.lineBreakMode = NSLineBreakByCharWrapping;
        
       
        
        if(indexPath.row == 2){
            
            // no images, answer itemB
            if([_currentQuestion.imgNum intValue] == 0)
            {
                cell.textLabel.text = self.currentQuestion.answerB;
            }else // have image, answer itemA
            {
                cell.textLabel.text = self.currentQuestion.answerA;
                cell.backgroundColor = lightGray;
            }

        }else if(indexPath.row == 3){
            // no images, answer itemC
            if([_currentQuestion.imgNum intValue] == 0)
            {
                cell.textLabel.text = self.currentQuestion.answerC;
                cell.backgroundColor = lightGray;
                
            }else // have image, answer itemB
            {
                cell.textLabel.text = self.currentQuestion.answerB;
            }
            
        }
        else if(indexPath.row == 4){
            // no images, answer itemD
            if([_currentQuestion.imgNum intValue] == 0)
            {
                cell.textLabel.text = self.currentQuestion.answerD;
                
                
            }else // have image, answer itemC
            {
                cell.textLabel.text = self.currentQuestion.answerC;
                cell.backgroundColor = lightGray;
            }
            
        }else if(indexPath.row == 5){
            
            if([_currentQuestion.imgNum intValue] > 0) // have image, answer itemD
            {
                cell.textLabel.text = self.currentQuestion.answerD;
                
            }
        }
        
        CGSize textSize = [cell.textLabel sizeThatFits:CGSizeMake(cell.frame.size.width, MAXFLOAT)];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, textSize.height + 24);
    }
    
    // record right answer
    if ([cell.textLabel.text isEqualToString:self.currentQuestion.rightAnswer]) {
        self.currentRightIndex = indexPath;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *nowAnswerCell = [tableView cellForRowAtIndexPath:indexPath];
    UITableViewCell *rightAnswerCell = [tableView cellForRowAtIndexPath:self.currentRightIndex];
    
    if ([nowAnswerCell isEqual:rightAnswerCell]) {
        nowAnswerCell.textLabel.textColor = [UIColor greenColor];
    }else
    {
        nowAnswerCell.textLabel.textColor = [UIColor redColor];
        rightAnswerCell.textLabel.textColor = [UIColor greenColor];
        
        // TBD store to wrong answer
    }
    
}



@end
