//
//  Task.swift
//  Homework57ToDoList
//
//  Created by 黃柏嘉 on 2022/1/19.
//

import Foundation

struct Task:Codable{
    var taskName:String
    var executionDate:String
    var complete:Bool
    
    //生成文件目錄路徑
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    //儲存
    static func save(_ tasks:[Self]){
        guard let data = try? JSONEncoder().encode(tasks) else{return}
        let url = documentsDirectory.appendingPathComponent("tasks")
        try? data.write(to: url)
    }
    //讀檔
    static func load()->[Self]?{
        let url = documentsDirectory.appendingPathComponent("tasks")
        guard let data = try? Data(contentsOf: url) else{return nil}
        return try? JSONDecoder().decode([Self].self, from: data)
    }
}
