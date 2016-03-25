//
//  CSStorageInterface.swift
//  CoreStore
//
//  Created by John Rommel Estropia on 2016/03/18.
//  Copyright © 2016 John Rommel Estropia. All rights reserved.
//

import UIKit

/**
 The `CSStorageInterface` serves as the Objective-C bridging type for `StorageInterface`.
 */
@objc
public protocol CSStorageInterface {
    
    /**
     The string identifier for the `NSPersistentStore`'s `type` property. This is the same string CoreStore will use to create the `NSPersistentStore` from the `NSPersistentStoreCoordinator`'s `addPersistentStoreWithType(...)` method.
     */
    @objc
    static var storeType: String { get }
    
    /**
     The configuration name in the model file
     */
    @objc
    var configuration: String? { get }
    
    /**
     The options dictionary for the `NSPersistentStore`
     */
    @objc
    var storeOptions: [String: AnyObject]? { get }
}


// MARK: - CSLocalStorageOptions

/**
 The `CSLocalStorageOptions` provides settings that tells the `CSDataStack` how to setup the persistent store for `CSLocalStorage` implementers.
 */
@objc
public final class CSLocalStorageOptions: NSObject {
    
    /**
     Tells the `DataStack` that the store should not be migrated or recreated, and should simply fail on model mismatch
     */
    @objc
    public static let none = 0
    
    /**
     Tells the `DataStack` to delete and recreate the store on model mismatch, otherwise exceptions will be thrown on failure instead
     */
    @objc
    public static let recreateStoreOnModelMismatch = 1
    
    /**
     Tells the `DataStack` to prevent progressive migrations for the store
     */
    @objc
    public static let preventProgressiveMigration = 2
    
    /**
     Tells the `DataStack` to allow lightweight migration for the store when added synchronously
     */
    @objc
    public static let allowSynchronousLightweightMigration = 4
    
    
    // MARK: Private
    
    private override init() {
        
        fatalError()
    }
}


// MARK: - CSLocalStorage

/**
 The `CSLocalStorage` serves as the Objective-C bridging type for `LocalStorage`.
 */
@objc
public protocol CSLocalStorage: CSStorageInterface {
    
    /**
     The `NSURL` that points to the store file
     */
    @objc
    var fileURL: NSURL { get }
    
    /**
     The `NSBundle`s from which to search mapping models for migrations
     */
    @objc
    var mappingModelBundles: [NSBundle] { get }
    
    /**
     Options that tell the `CSDataStack` how to setup the persistent store
     */
    @objc
    var localStorageOptions: Int { get }
    
    /**
     Called by the `CSDataStack` to perform actual deletion of the store file from disk. Do not call directly! The `sourceModel` argument is a hint for the existing store's model version. Implementers can use the `sourceModel` to perform necessary store operations. (SQLite stores for example, can convert WAL journaling mode to DELETE before deleting)
     */
    @objc
    func eraseStorageAndWait(soureModel soureModel: NSManagedObjectModel) throws
}
