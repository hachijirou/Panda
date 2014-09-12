//
//  PandaSummaryTableViewController.m
//  Panda
//
//  Created by usr10049697 on 2014/07/29.
//  Copyright (c) 2014年 hachijirou. All rights reserved.
//

#import "PandaSummaryTableViewController.h"
#import "PandaUrlGroup.h"
#import "PandaDetailViewController.h"
#import "PandaUrlGroupRepository.h"

@interface PandaSummaryTableViewController ()

@property (nonatomic) NSMutableArray *items;

// 詳細編集画面から戻ったときに呼び出されるアクション
- (IBAction)backToList:(UIStoryboardSegue *)unwindSegue;

// 編集中のインデックスパス
@property (nonatomic)  NSIndexPath *editingIndexPath;

// PandaUrlGroupのリポジトリ
@property (strong, nonatomic) PandaUrlGroupRepository *urlGroupRepository;

@end

@implementation PandaSummaryTableViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
    _items = [[NSMutableArray alloc] init];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // リポジトリの初期化
    self.urlGroupRepository = [[PandaUrlGroupRepository alloc] init];
    
    // データの取得
    self.items = [self.urlGroupRepository selectAll];
    if (!self.items) {
        self.items = [[NSMutableArray alloc] init];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

// 一覧のセクション数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

// 一覧の行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.items.count;
}

// 一覧の表示
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"UrlGroupCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier forIndexPath:indexPath];
    
    PandaUrlGroup *item = self.items[indexPath.row];
    cell.textLabel.text = item.title;
    
    return cell;
}

// 行の登録
//- (IBAction)addItem:(id)sender
//{
//    PandaUrlGroup *newItem = [[PandaUrlGroup alloc] init];
//    newItem.title = [NSString stringWithFormat:@"Url Grouop %ld", (long)self.items.count];
//    
//    NSIndexPath *indexPathToInsert = [NSIndexPath indexPathForRow:0 inSection:0];
//    
//    // データソースの更新
//    [self.items insertObject:newItem atIndex:indexPathToInsert.row];
//    // テーブルビュー更新
//    [self.tableView insertRowsAtIndexPaths:@[indexPathToInsert]
//                          withRowAnimation:UITableViewRowAnimationAutomatic];
//}

// 編集時の追加ボタンの有効/無効の切り替え
- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    self.navigationItem.leftBarButtonItem.enabled = !editing;
}

// 行の削除
- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 行が削除された場合は、それをリストから取り除く
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_items removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

// ビューコントローラへのデータの受け渡し
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // 詳細編集画面のインスタンスを取得
    UINavigationController *navigationController = segue.destinationViewController;
    PandaDetailViewController *detailViewController = (PandaDetailViewController *)navigationController.viewControllers[0];
    
    // 編集
    if ([segue.identifier isEqualToString:@"EditDetailSegue"]) {
        // URLグループオブジェクト設定
        NSIndexPath *indexPath =
        [self.tableView indexPathForCell:(UITableViewCell *)sender];
        detailViewController.item = self.items[indexPath.row];
        self.editingIndexPath = indexPath;
    // 新規登録
    } else if ([segue.identifier isEqualToString:@"AddDetailSegue"]) {
        // URLグループオブジェクト初期化
        detailViewController.item = [[PandaUrlGroup alloc] init];
        self.editingIndexPath = nil;
    }
}

// 詳細編集画面から戻ったときに呼び出されるアクション
- (IBAction)backToList:(UIStoryboardSegue *)unwindSegue
{
    // URLグループの追加
    if ([[unwindSegue identifier] isEqualToString:@"SaveDetailEdit"] ) {
        PandaDetailViewController *detailViewController = unwindSegue.sourceViewController;
        if (self.editingIndexPath != nil) {
            // データソースの更新
            [self.items replaceObjectAtIndex:self.editingIndexPath.row withObject:detailViewController.item];
            // テーブルビューの更新
            [self.tableView reloadRowsAtIndexPaths:@[self.editingIndexPath]
                                  withRowAnimation:UITableViewRowAnimationFade];
        } else {
            // データの登録とビューへの反映
            NSIndexPath *indexPathToInsert = [NSIndexPath indexPathForRow:0 inSection:0];
            detailViewController.item.updateDate = [NSDate date];
            [self.items insertObject:detailViewController.item atIndex:indexPathToInsert.row];
            [self.tableView insertRowsAtIndexPaths:@[indexPathToInsert] withRowAnimation:UITableViewRowAnimationFade];
        }
        
        // データの永続化
        [self.urlGroupRepository addObject:self.items];
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
