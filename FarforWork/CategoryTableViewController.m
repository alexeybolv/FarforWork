//
//  CategoryTableViewController.m
//  Farfor
//
//  Created by Алексей on 13.05.16.
//  Copyright © 2016 Alexey. All rights reserved.
//

#import "CategoryTableViewController.h"
#import "CategoryTableViewCell.h"
#import "OfferTableViewController.h"
#import "SWRevealViewController.h"
#import "Offer.h"
#import "Category.h"
#import "Reachability.h"
#import "Offer.h"
#import "OfferParser.h"
#import "Category.h"
#import "CategoryParser.h"

@interface CategoryTableViewController ()

@property (strong, nonatomic) IBOutlet UITableView *categoryTableView;
@property (strong,nonatomic) NSMutableArray *offerArray;
@property (strong,nonatomic) NSMutableArray *categoryArray;
@property (strong,nonatomic) UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic) Reachability *internetReachability;


@end

@implementation CategoryTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 70;

    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
//    // setting up Reachability
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
//    
//    self.internetReachability = [Reachability reachabilityForInternetConnection];
//    [self.internetReachability startNotifier];
//    [self checkReachability:self.internetReachability];
    
    [self parseInfo];
}

#pragma mark - Parse Info

- (void)parseInfo
{
    CategoryParser *sharedCategoryParser = [CategoryParser sharedCategoryParser];
    OfferParser *sharedOfferParser = [OfferParser sharedOfferParser];
    if (!sharedCategoryParser.wasParsed)
    {
        dispatch_async(dispatch_get_global_queue(0,0), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                self.activityIndicatorView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
                [self configureActivityIndicatorView:self.activityIndicatorView withCenter:self.categoryTableView.center];
                [self.view addSubview: self.activityIndicatorView];
                [self.activityIndicatorView startAnimating];
            });
            [sharedCategoryParser parseXMLFile];
            [sharedOfferParser parseXMLFile];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.categoryArray = sharedCategoryParser.categoryArray;
                self.offerArray = sharedOfferParser.offerArray;
                [self.tableView reloadData];
                [self.activityIndicatorView stopAnimating];
            });
        });
    }
    else
    {
        self.categoryArray = sharedCategoryParser.categoryArray;
        self.offerArray = sharedOfferParser.offerArray;
    }
}

//#pragma mark - Reachability
//
//- (void) reachabilityChanged:(NSNotification *)note
//{
//    Reachability* curReach = [note object];
//    [self checkReachability:curReach];
//}
//
//-(void) checkReachability:(Reachability *)reachability{
//    NetworkStatus netStatus = [reachability currentReachabilityStatus];
//    if (netStatus == NotReachable)
//    {
//        [self.activityIndicatorView stopAnimating];
//        UIAlertController *internetConnectionController = [UIAlertController alertControllerWithTitle:@"Problem" message:@"Please, switch on the Internet to parse new offers" preferredStyle:UIAlertControllerStyleAlert];
//        [self presentViewController:internetConnectionController animated:YES completion:nil];
//        
//        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];
//        
//        UIAlertAction *settingsAction = [UIAlertAction actionWithTitle:@"Settings" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
//        }];
//        
//        [internetConnectionController addAction:settingsAction];
//        [internetConnectionController addAction:cancelAction];
//    }
//}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.categoryArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CategoryTableViewCell *cell = (CategoryTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"CategoryCellIdentifier"];
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(CategoryTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    Category *category = [self.categoryArray objectAtIndex:indexPath.row];
    [cell setInternalFields:category];
}



#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    OfferTableViewController *child = (OfferTableViewController*)[segue destinationViewController];
    CategoryTableViewCell *source = (CategoryTableViewCell*)sender;
    [child receiveCategory:source.localCategory andOfferArray:self.offerArray];
}

#pragma mark - Configure ActivityIndicatorView

-(void) configureActivityIndicatorView:(UIActivityIndicatorView *)activityIndicatorView withCenter:(CGPoint)center{
    activityIndicatorView.layer.cornerRadius = 05;
    activityIndicatorView.opaque = NO;
    activityIndicatorView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.6f];
    activityIndicatorView.center = center;
    activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [activityIndicatorView setColor:[UIColor colorWithRed:0.6 green:0.8 blue:1.0 alpha:1.0]];
}

@end
