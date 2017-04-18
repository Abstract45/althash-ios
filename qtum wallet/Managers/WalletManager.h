//
//  WalletManager.h
//  qtum wallet
//
//  Created by Sharaev Vladimir on 14.12.16.
//  Copyright © 2016 Designsters. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Wallet.h"
#import "Requestable.h"
#import "Token.h"

@interface WalletManager : NSObject

@property (nonatomic, readonly) NSMutableArray *wallets;
@property (nonatomic, strong, readonly) NSString* PIN;
@property (weak,nonatomic) id <Requestable> requestManager;

- (void)createNewWalletWithName:(NSString *)name pin:(NSString *)pin withSuccessHandler:(void(^)(Wallet *newWallet))success andFailureHandler:(void(^)())failure;
- (void)importWalletWithName:(NSString *)name pin:(NSString *)pin seedWords:(NSArray *)seedWords withSuccessHandler:(void(^)(Wallet *newWallet))success andFailureHandler:(void(^)())failure;
- (void)removeWallet:(Wallet *)wallet;
- (void)removeAllWallets;
- (void)storePin:(NSString*) pin;
- (void)removePin;
- (BOOL)haveWallets;
- (Wallet *)getCurrentWallet;
- (NSArray *)getAllWallets;
- (NSArray <Token*>*)gatAllTokens;
- (void)addNewToken:(Token*) token;
- (void)clear;


- (void)startObservingForAddresses;
- (void)stopObservingForAddresses;
- (void)startObservingForTokens;


+ (instancetype)sharedInstance;
- (id)init __attribute__((unavailable("cannot use init for this class, use sharedInstance instead")));
+ (instancetype)alloc __attribute__((unavailable("alloc not available, call sharedInstance instead")));
+ (instancetype) new __attribute__((unavailable("new not available, call sharedInstance instead")));

@end
