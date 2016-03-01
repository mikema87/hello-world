//
//  ListViewController.m
//  hello
//
//  Created by Fahad Muntaz on 2/29/16.
//  Copyright © 2016 Michael Ma. All rights reserved.
//

#import "ListViewController.h"
#import "ListTableViewCell.h"


@interface ListViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray<NSString *> *list;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"My To-do List";
    
    self.list = [NSMutableArray new];
    
    UIBarButtonItem *addBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItemTapped)];
    self.navigationItem.rightBarButtonItem = addBarButtonItem;
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.list.count;
}

#pragma mark - <UITableViewDelegate>

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[ListTableViewCell identifier] forIndexPath:indexPath];
    
    cell.textLabel.text = [self.list objectAtIndex:indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0f;
}

#pragma mark - Actions

- (void)addItemTapped {
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
    __weak __typeof(self) weakSelf = self;

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Add item" message:@"Add your to do item" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:nil];
    
    UIAlertAction *addAction = [UIAlertAction actionWithTitle:@"Add" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *field = [alertController.textFields firstObject];
        if (field != nil) {
            [weakSelf addItem:field.text];
        }
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf dismissViewControllerAnimated:YES completion:^{
            weakSelf.navigationItem.rightBarButtonItem.enabled = YES;
        }];
    }];
    
    [alertController addAction:addAction];
    [alertController addAction:cancel];
    

    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (void)addItem:(NSString * _Nonnull)item {
    __weak __typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.navigationItem.rightBarButtonItem.enabled = YES;
        [weakSelf.list addObject:item];
        [weakSelf.tableView reloadData];
    });
}

@end
