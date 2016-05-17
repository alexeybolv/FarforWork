//
//  SideBarTableViewController.m
//  Farfor
//
//  Created by Алексей on 13.05.16.
//  Copyright © 2016 Alexey. All rights reserved.
//

#import "SideBarTableViewController.h"
#import "SWRevealViewController.h"

@interface SideBarTableViewController ()

@end

@implementation SideBarTableViewController
{
    NSArray *menuItems;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    menuItems = @[@"Farfor",@"Catalog",@"Contacts"];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return menuItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = [menuItems objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    return cell;
}

@end
