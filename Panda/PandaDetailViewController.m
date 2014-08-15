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
// URL
@property (weak, nonatomic) IBOutlet UITableView *UrlTableView;

@end

@implementation PandaDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // textFieldのDelegate通知を受け取る
    self.titleTextFIeld.delegate = self;
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
