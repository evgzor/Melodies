//
//  MasterViewController.m
//  Melodies
//
//  Created by Evgeny Zorin on 17/03/15.
//  Copyright (c) 2015 Evgeny Zorin. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "APINetController.h"
#import "Melodies.h"
#import "MelodyTableViewCell.h"

static NSString *CellIdentifier = @"Cell";

@interface MasterViewController ()

@property NSMutableArray *dataObjects;
@property NSInteger curentPage;

@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _curentPage = 0;
     //[self.tableView registerClass:[MelodyTableViewCell class] forCellReuseIdentifier:CellIdentifier];
    
    [APINetController requestListDataFrom:0 forLimit:20 withSuccess:^(NSArray *dataList) {
        self.dataObjects = [dataList mutableCopy];
        dispatch_async (dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });

    } andErrorFail:^(NSError *error) {
        
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*- (void)insertNewObject:(id)sender {
    if (!self.objects) {
        self.objects = [[NSMutableArray alloc] init];
    }
    [self.objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}*/

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Melodies *object = self.dataObjects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataObjects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MelodyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    cell.coverPhoto.image = nil;
    [cell setNeedsDisplay];
    
    Melodies *object = self.dataObjects[indexPath.row];
    cell.coverPhoto.imageURL = [NSURL URLWithString:object.picUrl];
    cell.melodyArtist.text = [NSString stringWithFormat:@"Artist : %@",object.artist];
    cell.melodyTitle.text = [NSString stringWithFormat:@"Title : %@",object.title];

    
    return cell;
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    int lastRow= _dataObjects.count -1;
    if(indexPath.row == lastRow)
    {
            [APINetController requestListDataFrom:_curentPage*20 forLimit:20*(_curentPage+1) withSuccess:^(NSArray *dataList) {
                [_dataObjects addObjectsFromArray:dataList];
                dispatch_async (dispatch_get_main_queue(), ^{
                    _curentPage++;
                    [self.tableView reloadData];
                });
                
                
            } andErrorFail:^(NSError *error) {
                
            }]; //Method to request to server to get more data
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.dataObjects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

@end
