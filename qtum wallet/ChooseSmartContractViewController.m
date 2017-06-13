//
//  ChooseSmartContractViewController.m
//  qtum wallet
//
//  Created by Vladimir Lebedevich on 30.05.17.
//  Copyright © 2017 PixelPlex. All rights reserved.
//

#import "ChooseSmartContractViewController.h"
#import "ChoiseSmartContractCell.h"

@interface ChooseSmartContractViewController ()

@property (strong,nonatomic) NSArray<NSString*>* contractTypes;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ChooseSmartContractViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.contractTypes = @[NSLocalizedString(@"Crate Contract", @""),NSLocalizedString(@"My Contracts", @""),NSLocalizedString(@"Contacts Store", @""),NSLocalizedString(@"Watch Contract", @""), NSLocalizedString(@"Restore Contracts", @""), NSLocalizedString(@"Backup Contracts", @"")];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 46;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.row == 0) {
        [self.delegate didSelectNewContracts];
    } else if (indexPath.row == 1) {
        [self.delegate didSelectPublishedContracts];
    } else if (indexPath.row == 2) {
        [self.delegate didSelectContractStore];
    } else if (indexPath.row == 3) {
        [self.delegate didSelectWatchContracts];
    } else if (indexPath.row == 4) {
        [self.delegate didSelectRestoreContract];
    } else if (indexPath.row == 5) {
        [self.delegate didSelectBackupContract];
    }
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ChoiseSmartContractCell* cell = (ChoiseSmartContractCell*)[tableView cellForRowAtIndexPath:indexPath];
    cell.image.tintColor =
    cell.disclosure.tintColor =
    cell.smartContractType.textColor = customBlackColor();
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ChoiseSmartContractCell* cell = (ChoiseSmartContractCell*)[tableView cellForRowAtIndexPath:indexPath];
    cell.image.tintColor =
    cell.disclosure.tintColor =
    cell.smartContractType.textColor = customBlueColor();
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.contractTypes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ChoiseSmartContractCell* cell = [tableView dequeueReusableCellWithIdentifier:choiseSmartContractCellIdentifire];
    cell.smartContractType.text = self.contractTypes[indexPath.row];
    
    if (indexPath.row == 0) {
        cell.image.image =  [UIImage imageNamed:@"ic-smartContract"];
    } else if (indexPath.row == 1) {
        cell.image.image = [UIImage imageNamed:@"ic-publichedContracts"];
    } else if (indexPath.row == 2) {
        cell.image.image = [UIImage imageNamed:@"ic-contractStore"];
    } else if (indexPath.row == 3) {
        cell.image.image = [UIImage imageNamed:@"ic-token-subscribe"];
    } else if (indexPath.row == 4) {
        cell.image.image = [UIImage imageNamed:@"ic-contract_restore"];
    } else if (indexPath.row == 5) {
        cell.image.image = [UIImage imageNamed:@"ic_contr_backup"];
    }
    
    return cell;
}

- (IBAction)didPressedBackAction:(id)sender {
    
    [self.delegate didPressedQuit];
}


@end
