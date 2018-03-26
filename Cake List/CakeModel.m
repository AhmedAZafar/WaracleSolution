//
//  CakeModel.m
//  Cake List
//
//  Created by Ahmed on 01/03/2018.
//  Copyright © 2018 Stewart Hart. All rights reserved.
//

#import "CakeModel.h"
#import "PrivateConstants.h"

@implementation CakeModel

- (instancetype)init{
    self = [super init];
    
    self.cakeObjectsArray = [[NSMutableArray alloc] init];
    self.imgCache = [[NSCache alloc] init];
    self.orderedCakeImageArray = [[NSMutableArray alloc] init];
    
    return self;
}

//Fuction responsible for getting cake list
- (void)getCakeObjects:(void (^)(void))callbackBlock {
    
    NSString *dataUrl = CAKE_LIST_URL;
    NSURL *url = [NSURL URLWithString:dataUrl];

    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response,NSError *error) {
        
        self.cakeObjectsArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
        [self downloadCakeImages:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                callbackBlock();
            });
        }];
    }];
    
    [downloadTask resume];
}

- (void)downloadCakeImages:(void (^)(void))callbackBlock {
    
    for (NSDictionary* dict in self.cakeObjectsArray) {
        
        if (![self.imgCache objectForKey:dict[@"title"]]) {
            
            NSURL *url = [NSURL URLWithString:dict[@"image"]];
            
            NSURLSessionDownloadTask *downloadPhotoTask = [[NSURLSession sharedSession] downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
                
                UIImage *downloadedImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
                
                [self.imgCache setObject:downloadedImage forKey:dict[@"title"]];
                [self.orderedCakeImageArray addObject:downloadedImage];
                
                if (self.orderedCakeImageArray.count == self.cakeObjectsArray.count) {
                    callbackBlock();
                }
            }];
            
            [downloadPhotoTask resume];
        }else {
            [self.orderedCakeImageArray addObject:[self.imgCache objectForKey:dict[@"title"]]];
        }
    }
    
    
}



@end
