//
//  ContactViewController.h
//  Farfor
//
//  Created by Алексей on 13.05.16.
//  Copyright © 2016 Alexey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapKit/Mapkit.h"

@interface ContactViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end
