//
//  MasterViewController.m
//  Cake List
//
//  Created by Stewart Hart on 19/05/2015.
//  Copyright (c) 2015 Stewart Hart. All rights reserved.
//

#import "MasterViewController.h"
#import "CakeCell.h"
#import "CakeModel.h"

@interface MasterViewController ()

//Model conatining all data
@property (strong, nonatomic) CakeModel* cakeModel;

@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated{
    
    //Can be done via storyboard (IB) but I like doing it via code
    self.cakeTable.delegate = self;
    self.cakeTable.dataSource = self;
    
    //Show view containing activity indicator and hide view containing table
    self.loadingView.alpha = 1.0;
    self.tableView.alpha = 0.0;
    [self.activityIndicator startAnimating];
}

- (void)viewDidAppear:(BOOL)animated {
    
    //Making the request to get cake data
    self.cakeModel = [[CakeModel alloc] init];
    [self.cakeModel getCakeObjects:^{
        self.tableView.alpha = 1.0;
        self.loadingView.alpha = 0.0;
        [self.activityIndicator stopAnimating];
        [self.cakeTable reloadData];
    }];
}

#pragma mark - Table View
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cakeModel.cakeObjectsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CakeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CakeCell"];
    
    if (cell == nil) {
        
        NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"CakeCell" owner:self options:nil];
        cell = [nib firstObject];
    }
    
    [cell prepareCellFrom:[self.cakeModel.cakeObjectsArray objectAtIndex:indexPath.row] andImage:[self.cakeModel.orderedCakeImageArray objectAtIndex:indexPath.row]];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
