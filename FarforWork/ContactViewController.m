//
//  ContactViewController.m
//  Farfor
//
//  Created by Алексей on 13.05.16.
//  Copyright © 2016 Alexey. All rights reserved.
//

#import "ContactViewController.h"
#import "SWRevealViewController.h"

@interface ContactViewController () <MKMapViewDelegate,CLLocationManagerDelegate>

@property (strong,nonatomic) MKPointAnnotation* currentAnno;
@property (strong,nonatomic) MKPointAnnotation* voronezhAnno;
@property (strong,nonatomic) MKPointAnnotation* penzaAnno;

@property (nonatomic,assign) BOOL mapIsMoving;
@property (strong,nonatomic) CLLocationManager *locationManager;

@end

@implementation ContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    [self configureMapView];
}


#pragma mark - Map View

-(void) configureMapView
{
    _locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
    
    self.mapIsMoving = NO;
    
    self.mapView.showsUserLocation = YES;

    [self addAnnotations];
    
    [self.locationManager startUpdatingLocation];
}

- (void) addAnnotations
{
    self.voronezhAnno = [[MKPointAnnotation alloc]init];
    self.voronezhAnno.coordinate = CLLocationCoordinate2DMake(51.6737, 39.2125);
    self.voronezhAnno.title = @"Farfor в Воронеже";
    
    self.penzaAnno = [[MKPointAnnotation alloc]init];
    self.penzaAnno.coordinate = CLLocationCoordinate2DMake(53.197982, 45.014983);
    self.penzaAnno.title = @"Farfor в Пензе";
    
    self.currentAnno = [[MKPointAnnotation alloc]init];
    self.currentAnno.coordinate = CLLocationCoordinate2DMake(0.0,0.0);
    self.currentAnno.title = @"Моё расположение";
    
    [self.mapView addAnnotations:@[self.voronezhAnno, self.penzaAnno]];
}

- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    self.currentAnno.coordinate = locations.lastObject.coordinate;
    if (self.mapIsMoving == NO)
    {
        [self centerMap:self.currentAnno];
    }
}

- (void) centerMap:(MKPointAnnotation *)centerPoint
{
    [self.mapView setCenterCoordinate:centerPoint.coordinate animated:YES];
}

- (void) mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    self.mapIsMoving = YES;
}

- (void) mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    self.mapIsMoving = NO;
}


@end
