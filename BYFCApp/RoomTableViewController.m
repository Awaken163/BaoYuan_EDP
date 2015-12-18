//
//  RoomTableViewController.m
//  BYFCApp
//
//  Created by PengLee on 15/3/2.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "RoomTableViewController.h"
#import "PL_Header.h"
@interface RoomTableViewController ()


@end

@implementation RoomTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.separatorColor = [UIColor whiteColor];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.scrollEnabled = YES;
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
   
   
    
    
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell2 forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell2 respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell2 setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell2 respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell2 setLayoutMargins:UIEdgeInsetsZero];
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 38;
}
- (NSMutableArray * )loadWithData:(NSArray *)resultArray1
{
    self.resultArray  =[NSMutableArray arrayWithArray:resultArray1];
     [self.tableView reloadData];
    
    return self.resultArray;
   
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.resultArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * idertifer = @"tableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idertifer ];

    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idertifer];
        //[cell.textLabel setFrame:CGRectOffset(cell.textLabel.frame, 2, 0)];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.highlighted  = YES;
    }
    cell.backgroundColor = PL_CUSTOM_COLOR(48, 48, 48, 1);
    cell.textLabel.text = _resultArray[indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont systemFontOfSize:PL_ROOM_DETAIL_FONT_SIGN_SIZE];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell * cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.highlighted = YES;
//   NSLog(@"--%@  -- %d",cell.textLabel.text,indexPath.row);
    if ([self.delegate  respondsToSelector:@selector(didSelectPopOverRowIndex: cellTitleText:)])
    {
        [self.delegate didSelectPopOverRowIndex:indexPath cellTitleText:cell.textLabel.text];
        
    }
//    NSLog(@"index -%d",indexPath.row);
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end