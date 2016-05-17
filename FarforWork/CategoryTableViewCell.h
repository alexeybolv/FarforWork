//
//  CategoryTableViewCell.h
//  FarforWork
//
//  Created by Алексей on 16.05.16.
//  Copyright © 2016 Alexey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Category.h"

@interface CategoryTableViewCell : UITableViewCell

@property (strong,nonatomic) Category *localCategory;

@property (weak, nonatomic) IBOutlet UIImageView *categoryImageView;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;

-(void) setInternalFields:(Category *)incomingCategory;

@end

