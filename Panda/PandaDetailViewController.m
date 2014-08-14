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
    
    // タイトルのテキストビューに枠線を設定
    
    // メモのテキストビューに枠線を設定
    _memoTextView.layer.borderWidth = 1;
    _memoTextView.layer.borderColor = [[UIColor blackColor] CGColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
