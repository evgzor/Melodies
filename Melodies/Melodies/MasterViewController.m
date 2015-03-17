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
#import "MBProgressHUD.h"
#import "MBProgressHUD.h"

#define REQUEST_NUMBER 20
static NSString *CellIdentifier = @"Cell";

@interface MasterViewController ()

@property NSMutableArray *dataObjects;
@property NSInteger curentPage;
@property MBProgressHUD *hud;

@end

@implementation MasterViewController


#pragma mark - View Life Cycle
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _curentPage = 0;
    _dataObjects = [@[] mutableCopy];
    
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hud.mode = MBProgressHUDModeIndeterminate;
    _hud.labelText = @"Loading";
    
    [self requestDataFromServer];
}

#pragma mark - Memory managment
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    self.dataObjects = nil;
}


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
    int lastRow= _dataObjects.count - REQUEST_NUMBER/2;
    if(indexPath.row == lastRow)
    {
        [self requestDataFromServer];

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

#pragma mark - server processing
-(void)requestDataFromServer
{
    
    
    [APINetController requestListDataFrom:_curentPage*REQUEST_NUMBER forLimit:REQUEST_NUMBER*(_curentPage + 1) withSuccess:^(NSArray *dataList) {
        [_dataObjects addObjectsFromArray:dataList];
        _curentPage++;
        dispatch_async (dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [_hud hide:YES];
        });
    } andErrorFail:^(NSError *error) {
        [_hud hide:YES];
        [[[UIAlertView alloc] initWithTitle:@"Network error" message:@"Cannot retrieve data" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles: nil] show];
        
    }]; //Method to request to server to get more data
}

@end
