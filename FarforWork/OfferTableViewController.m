//
//  OfferTableViewController.m
//  FarforWork
//
//  Created by Алексей on 16.05.16.
//  Copyright © 2016 Alexey. All rights reserved.
//

#import "OfferTableViewController.h"
#import "OfferTableViewCell.h"
#import "OfferDetailViewController.h"

@interface OfferTableViewController ()


@property (strong, nonatomic) IBOutlet UITableView *offerTableView;
@property (strong,nonatomic) Category *localCategory;
@property (strong,nonatomic) NSMutableArray *offerArray;
@property (strong,nonatomic) NSMutableArray *sortedOfferArray;
@property (strong,nonatomic) Offer *localOffer;

@end

@implementation OfferTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.localCategory.categoryName;
    [self sortOfferArray];
}

-(void)viewWillAppear:(BOOL)animated{
    self.offerTableView.rowHeight = 150;
}

-(void)viewDidAppear:(BOOL)animated
{
    NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
    if (indexPath) {
        [self.tableView deselectRowAtIndexPath:indexPath animated:animated];
    }
}

-(void) receiveCategory:(Category *)category andOfferArray:(NSMutableArray *)offerArray
{
    self.localCategory = category;
    self.offerArray = offerArray;
}

#pragma mark - Sorting offerArray

-(void)sortOfferArray{
    self.sortedOfferArray = [[NSMutableArray alloc]init];
    for (Offer *item in self.offerArray)
    {
        if([item.offerCategoryID isEqualToString:self.localCategory.categoryID])
        {
            [self.sortedOfferArray addObject:item];
        }
    }
}

#pragma mark - Loading images

- (void)loadThumbnailsforOffer:(Offer *)offer withIndexPath:(NSIndexPath *)indexPath {
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSData * data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:offer.offerPicture]];
        if ( data == nil )
            return;
        offer.offerPictureData = data;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.offerTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
        });
    });
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sortedOfferArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OfferTableViewCell *cell = (OfferTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"OfferCellIdentifier"];
    Offer *offer = [self.sortedOfferArray objectAtIndex:indexPath.row];
    if (!offer.offerPictureData)
    {
        [self loadThumbnailsforOffer:offer withIndexPath:indexPath];
    }
    [cell setInternalFields:offer];
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    OfferDetailViewController *child = (OfferDetailViewController*)[segue destinationViewController];
    OfferTableViewCell *source = (OfferTableViewCell*)sender;
    [child receiveOffer:source.localOffer];
}


@end
