//
//  CategoryTableViewCell.m
//  FarforWork
//
//  Created by Алексей on 16.05.16.
//  Copyright © 2016 Alexey. All rights reserved.
//

#import "CategoryTableViewCell.h"

@implementation CategoryTableViewCell

-(void) setInternalFields:(Category *)incomingCategory{
    self.categoryLabel.text = incomingCategory.categoryName;
    self.categoryImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",incomingCategory.categoryName]];
    self.localCategory = incomingCategory;
}

@end
