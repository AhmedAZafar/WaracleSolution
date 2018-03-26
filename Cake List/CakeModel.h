//
//  CakeModel.h
//  Cake List
//
//  Created by Ahmed on 01/03/2018.
//  Copyright © 2018 Stewart Hart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CakeModel : NSObject

@property (strong, nonatomic) NSCache *imgCache;
@property (strong, nonatomic) NSMutableArray *cakeObjectsArray; //Array of dictionaries that contains all the cake info
@property (strong, nonatomic) NSMutableArray *orderedCakeImageArray;

- (void)getCakeObjects:(void (^)(void))callbackBlock;
- (void)downloadCakeImages:(void (^)(void))callbackBlock;

@end
