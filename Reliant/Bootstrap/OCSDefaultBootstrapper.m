//
//  OCSNSObjectCategoryUsingBootstrapper.m
//  Reliant
//
//  Created by Michael Seghers on 01/06/16.
//
//

#import "OCSDefaultBootstrapper.h"
#import "OCSBootstrapper.h"
#import "NSObject+OCSReliantInjection.h"
#import "NSObject+OCSReliantContextBinding.h"

@implementation OCSDefaultBootstrapper

- (id<OCSObjectContext>)bootstrapObjectContextWithConfigurationFromClass:(Class)configuration bindOnObject:(NSObject *)object {
    [object ocsBootstrapAndBindObjectContextWithConfiguratorFromClass:configuration];
    return object.ocsObjectContext;
}

- (id<OCSObjectContext>)bootstrapObjectContextWithConfigurationFromClass:(Class)configuration bindAndInjectObject:(NSObject *)object {
    id<OCSObjectContext> context = [self bootstrapObjectContextWithConfigurationFromClass:configuration bindOnObject:object];
    [object ocsInject];
    return context;
}

@end
