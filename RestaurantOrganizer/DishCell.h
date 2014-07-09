//
//  DishCell.h
//  RestaurantOrganizer
//
//  Created by Carole Touma on 7/9/14.
//  Copyright (c) 2014 ___rpinsker___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DishCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *dishNameLabel;

@end
