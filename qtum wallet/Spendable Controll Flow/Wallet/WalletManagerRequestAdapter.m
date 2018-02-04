//
//  WalletManagerRequestAdapter.m
//  qtum wallet
//
//  Created by Vladimir Lebedevich on 20.04.17.
//  Copyright © 2017 QTUM. All rights reserved.
//

#import "WalletManagerRequestAdapter.h"
#import "BTCTransactionOutput+Address.h"
#import "NSNumber+Comparison.h"

@implementation WalletManagerRequestAdapter

- (void)getBalanceForAddreses:(NSArray *) keyAddreses
		   withSuccessHandler:(void (^)(QTUMBigNumber *balance)) success
			andFailureHandler:(void (^)(NSError *error, NSString *message)) failure {

	__weak __typeof (self) weakSelf = self;
	[SLocator.requestManager getUnspentOutputsForAdreses:keyAddreses isAdaptive:YES successHandler:^(id responseObject) {
		success ([weakSelf calculateBalance:responseObject]);
	}                                  andFailureHandler:^(NSError *error, NSString *message) {
		failure (error, message);
	}];
}

#pragma mark - Outputs

- (void)getunspentOutputs:(NSArray *) keyAddreses withSuccessHandler:(void (^)(NSArray *responseObject)) success andFailureHandler:(void (^)(NSError *error, NSString *message)) failure {

	[SLocator.requestManager getUnspentOutputsForAdreses:keyAddreses isAdaptive:YES successHandler:^(id responseObject) {
		success ([self createArray:responseObject]);
	}                                  andFailureHandler:^(NSError *error, NSString *message) {
		failure (error, message);
	}];
}


#pragma mark - Adapters Methods

- (NSArray <BTCTransactionOutput *> *)createArray:(NSArray *) responseObject {

	NSMutableArray *outputs = [NSMutableArray array];

	for (NSDictionary *item in responseObject) {
		BTCTransactionOutput *txout = [[BTCTransactionOutput alloc] init];

		txout.value = [self convertValueToAmount:item[@"amount"]];
		txout.script = [[BTCScript alloc] initWithData:BTCDataFromHex (item[@"txout_scriptPubKey"])];
		txout.index = [item[@"vout"] intValue];
		txout.confirmations = [item[@"confirmations"] unsignedIntegerValue];
		txout.transactionHash = (BTCDataFromHex ([NSString invertHex:item[@"tx_hash"]]));
		txout.blockHeight = [item[@"confirmations"] integerValue];
		txout.runTimeAddress = item[@"address"];

		//filter only valid outputs
		if (([item[@"confirmations"] unsignedIntegerValue] > 500 && [item[@"is_stake"] unsignedIntegerValue] > 0) || [item[@"is_stake"] unsignedIntegerValue] == 0) {
			[outputs addObject:txout];
		}
	}

	return outputs;
}

- (BTCAmount)convertValueToAmount:(NSString *) stringValue {

	if ([stringValue isKindOfClass:[NSString class]] && stringValue.length > 0) {

		NSDecimalNumber *amount = [NSDecimalNumber decimalNumberWithString:stringValue];

		if (amount) {
			return [[amount decimalNumberByMultiplyingBy:[[NSDecimalNumber alloc] initWithDouble:BTCCoin]] integerValue];
		}
	}

	return [stringValue doubleValue] * BTCCoin;
}

- (QTUMBigNumber *)calculateBalance:(NSArray *) responseObject {

	QTUMBigNumber *balance = [QTUMBigNumber decimalWithInteger:0];

	for (NSDictionary *dictionary in responseObject) {

		NSNumber *amount = dictionary[@"amount"];
		if ([amount isKindOfClass:[NSNumber class]]) {
			balance = [balance add:[QTUMBigNumber decimalWithString:amount.stringValue]];
		}
	}

	return balance;
}

@end
