//
//  ToDoListTableViewController.swift
//  Homework57ToDoList
//
//  Created by 黃柏嘉 on 2022/1/19.
//

import UIKit

class ToDoListTableViewController: UITableViewController {
    
    let colors = [UIColor.systemYellow,UIColor.systemOrange,UIColor.systemRed,UIColor.systemGreen,UIColor.systemBlue]
    
    var tasks = [Task](){
        didSet{
            Task.save(tasks)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let loadTasks = Task.load(){
            tasks = loadTasks
        }
        
    }

    @IBAction func unwindToToDoListTableViewController(_ unwindSegue: UIStoryboardSegue) {
        if let sourceViewController = unwindSegue.source as? EditTableViewController,let task = sourceViewController.task{
            if let indexPath = tableView.indexPathForSelectedRow{
                tasks[indexPath.row] = task
                tableView.reloadRows(at: [indexPath], with: .fade)
            }else{
                tasks.insert(task, at: 0)
                tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
                tableView.reloadData()
            }
        }
        
        
        
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskTableViewCell
        cell.taskNameLabel.text = tasks[indexPath.row].taskName
        cell.executionDateLabel.text = tasks[indexPath.row].executionDate
        cell.changeButtonImage(task: tasks[indexPath.row])
        cell.cardView.backgroundColor = colors[indexPath.row%5]
        
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    //完成
    @IBAction func complete(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: tableView)
        if let indexPath = tableView.indexPathForRow(at: point){
            tasks[indexPath.row].complete = !tasks[indexPath.row].complete
            tableView.reloadData()
        }
    }
    
    
    //如果有點選現有內容就傳值
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? EditTableViewController,let row = tableView.indexPathForSelectedRow?.row{
                controller.task = tasks[row]
        }
        
    }
    
    //客製化swipeButton
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let newDeleteButton = UIContextualAction(style: .destructive, title: "不幹了") {(action, view, completionHandler) in
            self.tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
            tableView.reloadData()
            completionHandler(true)
        }
        let configuration = UISwipeActionsConfiguration(actions: [newDeleteButton])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    
}
