//
//  NSObject+WCKVOBlock.h
//  WCBlockKit
//
//  Created by zhao weicheng on 2018/4/17.
//  Copyright © 2018年 weichengz. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface NSObject (WCKVOBlock)
// EN:  method "wc_addObserver.." will produce  observers for your keypaths，and they will be delloced after the object observered delloced, but they will not remove theirs  observers. so, as usual,theirs observers(add by method "wc_addObserver..") need to be removed by yourself through methods such as ”wc_removeObserver...“ .
// zh-CN:  调用“wc_addObserver..” 添加keyPath监听将自动生成他们的观察者对象，并会随着被观察者的销毁而自动销毁，但是并不会为你自动注销他们的键值观察，和以往一样，需要你调用如“wc_removeObserver...”方法移除注销对应的(wc_addObserver..所添加的)键值观察。

/**@!brief add an object keypath observer.
 * @param keyPath the object keyPath by observered.
 * @param block , will call this block when value changed.
 * @blockNext's ofObj, the object by observered.
 * @blockNext's oldValue, value before changed.
 * @blockNext's newValue, value after changed.
 */
- (void)wc_addObserverForKeyPath:(NSString*)keyPath
                  valueBlockNext:(void(^)(NSString *keypath,id ofObj, id oldValue,id newValue))block;
/**@!brief  add object keyPath observer more than one.
 * @param keyPaths    e.g:@[@"keyPath0",@"keyPath1"]
 */
- (void)wc_addObserverForKeyPaths:(NSArray<NSString*>*)keyPaths
                  valueBlockNext:(void(^)(NSString *keypath,id ofObj, id oldValue,id newValue))block;
/**@!brief add an object keyPath observer.
 * @param keyPath  the object keyPath  by observered.
 * @param block ,call back.
 * @blockNext ofObj ,the object by observered.
 * @blockNext change , values after changed.
 */
- (void)wc_addObserverForKeyPath:(NSString*)keyPath
                         options:(NSKeyValueObservingOptions)options
                 changeBlockNext:(void(^)(NSString *keypath,id ofObj, NSDictionary<NSKeyValueChangeKey,id> *change))block;
/**@!brief add object keyPath observer more than one.
 * @param keyPaths ,a keyPath array  e.g,@[@"keyPath0",@"keyPath1"].
 */
- (void)wc_addObserverForKeyPaths:(NSArray<NSString*>*)keyPaths
                         options:(NSKeyValueObservingOptions)options
                 changeBlockNext:(void(^)(NSString *keypath,id ofObj, NSDictionary<NSKeyValueChangeKey,id> *change))block;
/**@!brief remove an object keyPath observer.
 * @param keyPath , the object keyPath  by observered.
 * tip : you can call the method to remove your object keyPath observer.
 */
- (void)wc_removeObserverForKeyPath:(NSString*)keyPath;
/**@!brief remove object  keyPath observers
 * @param keyPaths , a keyPath array  e.g:@[@"keyPath0",@"keyPath1"].
 * tip :you can call the method to remove your object keyPath observer .
 */
- (void)wc_removeObserverForKeyPaths:(NSArray<NSString*>*)keyPaths;
/**@!brief remove all  object keyPath observers.
 * tip :you can call the method to remove all your  object keyPath observers .
 */
- (void)wc_removeAllKeyValueObservers;
@end
