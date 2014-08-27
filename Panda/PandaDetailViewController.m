//
//  PandaDetailViewController.m
//  Panda
//
//  Created by usr10049697 on 2014/08/12.
//  Copyright (c) 2014年 hachijirou. All rights reserved.
//

#import "PandaConst.h"
#import "PandaDetailViewController.h"
#import "PandaUrl.h"

@interface PandaDetailViewController ()<UITableViewDelegate, UITableViewDataSource>

// ビュー全体を覆うスクロールビュー
@property (weak, nonatomic) IBOutlet PandaScrollView *contentScrollView;
// タイトル
@property (weak, nonatomic) IBOutlet UITextField *titleTextFIeld;
// メモ
@property (weak, nonatomic) IBOutlet UITextView *memoTextView;
// 更新日時
@property (weak, nonatomic) IBOutlet UILabel *updateDateLabel;
// URLリストを表示するためのテーブルビュー
@property (weak, nonatomic) IBOutlet UITableView *urlListTableView;

// 現在編集中のテキストフィールドを保持する
@property (strong, nonatomic) UITextField *memoryEditingTextField;
// 画面をスクロールすべきか判定するフラグ
@property BOOL canScroll;

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
    
    // 制御系の変数の初期化
    self.canScroll = NO;
    
    // textFieldのDelegate通知を受け取る
    self.titleTextFIeld.delegate = self;
    self.memoTextView.delegate = self;
    
    // tableViewのDelegate通知を受け取る
    self.urlListTableView.delegate = self;
    self.urlListTableView.dataSource = self;
    
    
    // タイトルのテキストビューに枠線を設定
    
    // メモのテキストビューに枠線を設定
    self.memoTextView.layer.borderWidth = 1;
    self.memoTextView.layer.borderColor = [[UIColor blackColor] CGColor];
    
    // URLリストの読み込み
    [self.urlListTableView registerNib:[UINib nibWithNibName:@"PandaUrlListCustomCell" bundle:nil] forCellReuseIdentifier:@"PandaUrlListCustomCell"];
    
    NSIndexPath *indexPathToInsert = [NSIndexPath indexPathForRow:0 inSection:0];
    PandaUrl *urlInfo = [[PandaUrl alloc] init];
    [self.item.urlGroupList insertObject:urlInfo atIndex:indexPathToInsert.row];
    [self.urlListTableView insertRowsAtIndexPaths:@[indexPathToInsert] withRowAnimation:UITableViewRowAnimationFade];
    
//    if (self.urlList.count == 0) {
//        NSIndexPath *indexPathToDefault = [NSIndexPath indexPathForRow:0 inSection:0];
//        PandaUrl *urlInfo = [[PandaUrl alloc] init];
//        [self.urlList insertObject:urlInfo atIndex:indexPathToDefault.row];
//        [self.urlListTableView insertRowsAtIndexPaths:@[indexPathToDefault] withRowAnimation:UITableViewRowAnimationFade];
//    }
    
    // キーボードが表示されたときのNotificationをうけとる
    [self registerForKeyboardNotifications];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// UITextFiledの編集開始時に呼ばれる処理
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.memoryEditingTextField = textField;
    if (textField.tag >= PandaDetailContentsTitlePrefix && textField.tag <= PandaDetailScrollTermination) {
        self.canScroll = YES;
    } else {
        self.canScroll = NO;
    }
}

// UITextFieldのReturn時に呼ばれる処理
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // キーボードを閉じる
    [textField resignFirstResponder];
    self.memoryEditingTextField = nil;
    return YES;
}

// ビューがtouchされたときに呼ばれる処理
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // キーボードを閉じる
    [self.titleTextFIeld resignFirstResponder];
    [self.memoTextView resignFirstResponder];
    [self.memoryEditingTextField resignFirstResponder];
    self.memoryEditingTextField = nil;
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

// URLリストテーブルビューの行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.item.urlGroupList.count;;
}

// URLリストテーブルビューの行数
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"PandaUrlListCustomCell";
    // 再利用できるセルがあれば再利用する
    PandaUrlListCustomCell *cell = (PandaUrlListCustomCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier forIndexPath:indexPath];
    
    // textFieldのDelegate通知を受け取る
    cell.urlTitleTextField.delegate = self;
    cell.urlTextField.delegate = self;
    
    // タイトルのテキストフィールドに枠線を追加
    cell.urlTitleTextField.layer.borderWidth = 1;
    cell.urlTextField.layer.borderWidth = 1;
    
    // 識別のためにタグを設定
    cell.urlTitleTextField.tag = PandaDetailContentsTitlePrefix + indexPath.row;
    cell.urlTextField.tag = PandaDetailContentsUrlPrefix + indexPath.row;
    
    return cell;
}

// キーボードが表示されたときの通知を受け取る
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

// キーボードが表示されたときにコールバックされる
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    if (self.canScroll) {
        CGPoint scrollPoint = CGPointMake(0.0,150.0);
        [self.contentScrollView setContentOffset:scrollPoint animated:YES];
    }
}

// キーボードが隠れたときにコールバックされる
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    if (self.canScroll) {
        [self.contentScrollView setContentOffset:CGPointZero animated:YES];
        self.canScroll = NO;
    }
}

@end

@implementation PandaUrlListCustomCell

@end

@implementation PandaScrollView

// タッチイベントをビューコントローラに送り出す
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!self.dragging) {
        [self.nextResponder touchesBegan:touches withEvent:event];
    }
    [super touchesBegan:touches withEvent:event];
}

@end
