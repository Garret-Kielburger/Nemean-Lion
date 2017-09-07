//
//  NemeanDatabase.swift
//  Nemean Alpha
//
//  Created by Captain on 2017-08-22.
//  Copyright © 2017 Greenr Republic Software Company. All rights reserved.
//

import Foundation
import SQLite

class NemeanDatabase {
    
    
     
    // MARK: Declarations
     
 
    
    // TABLES
    private let app_table = Table("app_data")
    private let screens_table = Table("screens")
    private let texts_table = Table("texts")
    private let images_table = Table("images")
    private let constraints_table = Table("constraints")
    
    // Columns
    private let uuid = Expression<String>("uuid")
    
    // App columns
    private let app_name = Expression<String>("app_name")
    private let navigation_id = Expression<Int64>("navigation_id")
    
    // Screens columns
    private let screen_name = Expression<String?>("screen_name")
    private let screen_order_number = Expression<Int64>("screen_order_number")
    
    // Text and Image columns
    private let id = Expression<Int64>("id")
    private let screen_uuid = Expression<String>("screen_uuid")
    private let purpose = Expression<String?>("purpose")
    private let horizontal_align = Expression<Int64>("horizontal_align")
    private let vertical_align = Expression<Int64>("vertical_align")
    // Text only
    private let content = Expression<String>("content")
    // Images only
    private let uri = Expression<String>("uri")
    
    //Constraint Columns
    private let start_id = Expression<String>("start_id")
    private let start_side = Expression<String>("start_side")
    private let end_id = Expression<String>("end_id")
    private let end_side = Expression<String>("end_side")
    private let margin = Expression<Int>("margin")
    
    // Database connection
    static let instance = NemeanDatabase()
    private let db: Connection?
    
    // Public variables
    var protocolDataObjectList = [DataObjectProtocol]()
    
    // MARK: Initialize
    
    private init() {
        
        //let doumentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        let documentDirectoryPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let dbDocumentsPath = documentDirectoryPath.appendingPathComponent("NemeanDatabase.sqlite3")
        let bundlePath = Bundle.main.path(forResource: "NemeanDatabase", ofType: "sqlite3")
        let fileManager = FileManager.default
        
        // Check if there is a db in the Documents folder
        
        do {
            let fileExists = try dbDocumentsPath.checkResourceIsReachable()
            
            print("db exists")
            
        } catch {
                // If there is no db, copy it from the Bundle
                do {
                    print("no db, so copying...")
                    try fileManager.copyItem(atPath: bundlePath!, toPath: dbDocumentsPath.path)
                } catch let error as NSError {
                    print("error occurred copying database, here are the details:\n \(error)")
                }
            }
        do {
            db = try Connection(dbDocumentsPath.path)
            print("db connection established")
            
        } catch{
            db = nil
            print("Failed to open database")
        }
    }

    

    //MARK: CRUD Operations
        /*
                Configure the Creation/Copying/Opening of the db
        */
        
        
    /*
         
        CRUD operations
        
    */
    
    // Create new stuff - Save from API calls
    // MARK: Save Functions
        
    func saveAppData(addo: AppDataDataObject) -> Int64 {
            
            // TODO: Check for app existing to update rather than insert? Make it ONLY update?
            
            do {
                let insert = app_table.insert(app_name <- addo.app_name, navigation_id <- addo.navigation_id)
            
                let id = try db!.run(insert)
                
                return id;
            } catch {
                print ("Insert Failed")
                return -1
            }
            
        }
        
    func saveScreenData(sdo: ScreenDataObject) -> Int64 {
            
            // TODO: Check for app existing to update rather than insert? Make it ONLY update?
            
            do {
                let insert = screens_table.insert(uuid <- sdo.uuid, screen_name <- sdo.name, screen_order_number <- sdo.order)
                
                let id = try db!.run(insert)
                
                return id;
            } catch {
                print ("Insert Failed")
                return -1
            }
            
    }
        
    func saveTextData(tdo: TextfieldDataObject) -> Int64 {
            
            do {
                let insert = texts_table.insert(uuid <- tdo.uuid, screen_uuid <- tdo.screen_uuid, purpose <- tdo.purpose, vertical_align <- tdo.vertical_align, horizontal_align <- tdo.vertical_align, content <- tdo.content)
                
                let id = try db!.run(insert)
                
                return id;
            } catch {
                print ("Insert Failed")
                return -1
            }
            
    }
    
    func saveImageData(ido: ImageDataObject) -> Int64 {
            
            do {
                let insert = images_table.insert(uuid <- ido.uuid, screen_uuid <- ido.screen_uuid, purpose <- ido.purpose, vertical_align <- ido.vertical_align, horizontal_align <- ido.vertical_align, uri <- ido.uri)
                
                let id = try db!.run(insert)
                
                return id;
            } catch {
                print ("Insert Failed")
                return -1
            }
            
    }
    
    func saveConstraintData (cdo: ConstraintDataObject) -> Int64 {
        
        do {
            let insert = constraints_table.insert(
            start_id <- cdo.start_id,
            start_side <- cdo.start_side,
            end_id <- cdo.end_id,
            end_side <- cdo.end_side,
            margin <- cdo.margin)
            
            let id = try db!.run(insert)
            return id;
        } catch {
            print("Insert Failed")
            return -1
        }
        
    }
    
    // MARK: Read Functions
    
    func getAllScreens() -> [ScreenDataObject] {
        var screens = [ScreenDataObject]()
        
        do {
            for screen in try db!.prepare(self.screens_table){
                screens.append(ScreenDataObject(
                uuid: screen[uuid],
                name: screen[screen_name]!,
                order: screen[screen_order_number]))
            }
        } catch {
            print("SELECT failed in getAllScreens()")
        }
        //print("Screens: \n \(screens) \n")
        return screens
    }
    
    func get_Screen_Content_By_Screen(screen_count_i: Int64) -> [ScreenDataObject] {
        let selected_screen = [ScreenDataObject]()
        // Make a protocol - needs to return results from multiple tables
        return selected_screen
    }
    
    func getScreenDataByUuid(given_screen_uuid: String) -> [DataObjectProtocol] {
        
        var current_screen: ScreenDataObject = ScreenDataObject()
        protocolDataObjectList.removeAll()
        
        // Get details from the screen table about the screen with known uuid
        
        do {
            let query = screens_table.filter(uuid == given_screen_uuid).limit(1)
            for screen in try db!.prepare(query){
                
                print("Current screen - name: \n \(screen[screen_name]) \n")
                current_screen.uuid = screen[uuid];
                current_screen.name = screen[screen_name]!;
                current_screen.order = screen[screen_order_number]
            }
        } catch {
            print("Failed to select screen from uuid")
        }
        
        // Get all the textfields on the screen
        
        do {
            let textQuery = texts_table.filter(screen_uuid == given_screen_uuid)
            for text in try db!.prepare(self.texts_table){
                //print("Text: \n \(text) \n")
                //var tdo : TextfieldDataObject = TextfieldDataObject()
                protocolDataObjectList.append(TextfieldDataObject(
                    uuid: text[uuid],
                    screen_uuid: text[screen_uuid],
                    purpose: text[purpose]!,
                    horizontal_align: text[horizontal_align],
                    vertical_align: text[vertical_align],
                    content: text[content]))
            }
        } catch {
             print("Failed to select text from screen_uuid")
        }

        //getScreenDataByUuid(given_screen_uuid: given_screen_uuid)
        
        // Get all the images on the screen
        
        do {
            let imageQuery = images_table.filter(screen_uuid == given_screen_uuid)
            for image in try db!.prepare(imageQuery){
                protocolDataObjectList.append(ImageDataObject(
                    uuid: image[uuid],
                    screen_uuid: image[screen_uuid],
                    purpose: image[purpose]!,
                    horizontal_align: image[horizontal_align],
                    vertical_align: image[vertical_align],
                    uri: image[uri]))
            }
        } catch {
            print("Failed to select image from screen_uuid")
        }
        
        // Eventually update to Comparator (ie for constraints?) - see bookmark
        protocolDataObjectList.sort{$0.vertical_align < $1.vertical_align}
        
        protocolDataObjectList.append(current_screen)
        
        //print("Current screen: \n \(current_screen) \n")
        //print("Current screen - UUID: \n \(current_screen.uuid) \n")
        //print("Current screen - name: \n \(current_screen.name) \n")
        //print("Current screen - order: \n \(current_screen.order) \n")
        //print("Protocol Data Object List: \n \(protocolDataObjectList)")
        return protocolDataObjectList
    }
    
    func getAllConstraints() -> [ConstraintDataObject] {
        
        var constraints = [ConstraintDataObject]()
        
        do {
            for constraint in try db!.prepare(self.constraints_table){
                constraints.append(ConstraintDataObject(
                    screen_uuid: constraint[screen_uuid],
                    start_id: constraint[start_id],
                    start_side: constraint[start_side],
                    end_id: constraint[end_id],
                    end_side: constraint[end_side],
                    margin: constraint[margin]))
            }
        } catch {
            print("SELECT failed in getAllConstraints")
        }
            return constraints
    }

    // MARK: Delete Functions
    
    func delete_Screen(screen_id:Int64)->Bool {
    
        do {
            let delete_screen = screens_table.filter(id == screen_id)
            try db!.run(delete_screen.delete())
            return true
            
        } catch{
            print("Deleting single screen failed")
        }
        
        return false
    }

    func delete_Text(text_id:Int64)->Bool{
        do {
            let delete_text = texts_table.filter(id == text_id)
            try db!.run(delete_text.delete())
            return true
        } catch {
            print("Deleting single text failed")
        }
        return false
    }
    
    func delete_Image(image_id:Int64)->Bool{
        do{
            let delete_image = images_table.filter(id == image_id)
            try db!.run(delete_image.delete())
            return true
        } catch {
            print("Deleting single image failed")
        }
        return false
    }
    
    func delete_All_Screens()->Bool {
        
        do {
            try db!.run(screens_table.delete())
            return true
        } catch {
            print("Deleting all screens failed")
            return false
        }
    }

    func delete_All_Texts()->Bool {
        do {
            try db!.run(texts_table.delete())
            return true
        } catch {
            print("Deleting all texts failed")
            return false
        }
    }
    
    func delete_All_Images()->Bool {
        do {
            try db!.run(images_table.delete())
            return true
        } catch {
            print("Deleting all images failed")
            return false
        }
    }
    
    func delete_All_Constraints()->Bool {
        do {
            try db!.run(constraints_table.delete())
            return true
        } catch {
            print("Deleting all constraints failed")
            return false
        }
    }
    
    //MARK: Update Functions
    
    func update_Screen(screen_id:Int64, screenUpdate:ScreenDataObject)->Bool{
        let screen = screens_table.filter(id == screen_id)
        
        do{
            let update = screen.update([
                uuid <- screenUpdate.uuid,
                screen_name <- screenUpdate.name,
                screen_order_number <- screenUpdate.order
                ])
            if try db!.run(update) > 0 {
                return true
            }
            
        } catch{
            print("Error updating single screen")
        }
        return false
    }
    
    func update_Text(text_id: Int64, textUpdate:TextfieldDataObject)->Bool{
        let text = texts_table.filter(id == text_id)
        
        do{
            let update = text.update([
                screen_uuid <- textUpdate.screen_uuid,
                purpose <- textUpdate.purpose,
                horizontal_align <- textUpdate.horizontal_align,
                vertical_align <- textUpdate.vertical_align,
                content <- textUpdate.content
                ])
            if try db!.run(update) > 0 {
                return true
            }
            
        } catch{
            print ("Error updating individual text")
        }
        return false
    }
    
    func update_Image(image_id: Int64, imageUpdate: ImageDataObject)->Bool {
        let image = images_table.filter(id == image_id)
        do{
            let update = image.update([
                screen_uuid <- imageUpdate.screen_uuid,
                purpose <- imageUpdate.purpose,
                horizontal_align <- imageUpdate.horizontal_align,
                vertical_align <- imageUpdate.vertical_align,
                uri <- imageUpdate.uri
                ])
            if try db!.run(update) > 0 {
                return true
            }
        } catch{
            print("Error updating individual image")
        }
        return false
    }
    
    func update_Constraint(constraint_id: Int64, constraintUpdate: ConstraintDataObject)->Bool {
        let constraint = constraints_table.filter(id == constraint_id)
        do{
            let update = constraint.update([
                start_id <- constraintUpdate.start_id,
                start_side <- constraintUpdate.start_side,
                end_id <- constraintUpdate.end_id,
                end_side <- constraintUpdate.end_side,
                margin <- constraintUpdate.margin
                ])
            if try db!.run(update) > 0 {
                return true
            }
        } catch{
            print("Error updating individual constraint")
        }
        return false
    }

    
    }
