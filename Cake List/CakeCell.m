//
//  CakeCell.m
//  Cake List
//
//  Created by Stewart Hart on 19/05/2015.
//  Copyright (c) 2015 Stewart Hart. All rights reserved.
//

#import "CakeCell.h"
#import "CakeModel.h"

@implementation CakeCell

- (void)prepareCellFrom:(NSDictionary*)dict andImage:(UIImage *)img{
    
    CGSize finalImageSize = CGSizeMake(self.cakeImageView.bounds.size.width, self.cakeImageView.bounds.size.height);
    
    self.titleLabel.text = dict[@"title"];
    self.descriptionLabel.text = dict[@"desc"];
    self.cakeImageView.image = [self imageWithImage:img scaledToSize:finalImageSize];

}

//Convenience method to ensure that images will be as per the size of ImageView in the Cell
- (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize {
    
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
