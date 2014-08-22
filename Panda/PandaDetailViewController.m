//
//  PandaDetailViewController.m
//  Panda
//
//  Created by usr10049697 on 2014/08/12.
//  Copyright (c) 2014年 hachijirou. All rights reserved.
//

#import "PandaDetailViewController.h"

@interface PandaDetailViewController ()

// タイトル
@property (weak, nonatomic) IBOutlet UITextField *titleTextFIeld;
// メモ
@property (weak, nonatomic) IBOutlet UITextView *memoTextView;
// 更新日時
@property (weak, nonatomic) IBOutlet UILabel *updateDateLabel;
// URLリスト
@property (weak, nonatomic) IBOutlet UIScrollView *urlListScrollView;

// タイトルの編集完了
- (IBAction)titleEditingDidEnd:(id)sender;
- (IBAction)titleEditingChanged:(id)sender;

@end

@implementation PandaDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 初期化
    self.titleTextFIeld.text = self.item.title;
    self.memoTextView.text = self.item.note;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    self.updateDateLabel.text =
    [formatter stringFromDate:self.item.updateDate];
    
    // URLリストの初期化
    // サブビューのクリア
//    for (UIView *view in [self.view subviews]) {
//        [view removeFromSuperview];
//    }
//    if () {
//        
//    }
//    //
//    CGRect urlListScrollViewRect = self.urlListScrollView.frame;
//    self.urlListScrollView.contentSize =
//    CGSizeMake(urlListScrollViewRect.size.width, urlListScrollViewRect.size.height);
    
    
//    self.urlListScrollView.contentSize = CGSizeMake(1000, 1000);
    UITextField *urlTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, 200, 30)];
    urlTextField.borderStyle = UITextBorderStyleLine;
    UITextField *urlTextField2 = [[UITextField alloc] initWithFrame:CGRectMake(10, 45, 200, 30)];
    urlTextField2.borderStyle = UITextBorderStyleLine;
    
    [self.urlListScrollView addSubview:urlTextField];
    [self.urlListScrollView addSubview:urlTextField2];
    
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(urlTextField, urlTextField2);
    NSString *format = @"V:[urlTextField]-100-[urlTextField2]";
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:format
                                                                   options:0
                                                                   metrics:nil
                                                                     views:viewsDictionary];
    [self.urlListScrollView addConstraints:constraints];
    
    // textFieldのDelegate通知を受け取る
    self.titleTextFIeld.delegate = self;
    self.memoTextView.delegate = self;
    
    
    // タイトルのテキストビューに枠線を設定
    
    // メモのテキストビューに枠線を設定
    self.memoTextView.layer.borderWidth = 1;
    self.memoTextView.layer.borderColor = [[UIColor blackColor] CGColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// UITextFieldのReturn時に呼ばれる処理
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // キーボードを閉じる
    [textField resignFirstResponder];
    return YES;
}

// ビューがtouchされたときに呼ばれる処理
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // キーボードを閉じる
    [self.titleTextFIeld resignFirstResponder];
    [self.memoTextView resignFirstResponder];
}

// 編集完了の判定を行う
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    // タイトル
    if ([identifier isEqualToString:@"SaveDetailEdit"]) {
        if (self.item.title == nil ||
            self.item.title.length == 0) {
            UIAlertView *alert =
            [[UIAlertView alloc] initWithTitle:@"Warning"
                                       message:@"Title must not be empty."
                                      delegate:nil
                             cancelButtonTitle:@"OK"
                             otherButtonTitles:nil,
             nil];
            [alert show];
            return NO;
        }
    }
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

// タイトルの編集完了
- (IBAction)titleEditingDidEnd:(id)sender
{
    self.item.title = self.titleTextFIeld.text;
}
- (IBAction)titleEditingChanged:(id)sender
{
    self.item.title = self.titleTextFIeld.text;
}
// メモの編集完了
- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    self.item.note = self.memoTextView.text;
    return YES;
}
@end
