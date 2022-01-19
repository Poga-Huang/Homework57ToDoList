//
//  EditTableViewController.swift
//  Homework57ToDoList
//
//  Created by 黃柏嘉 on 2022/1/19.
//

import UIKit

class EditTableViewController: UITableViewController {
    
    var task:Task?
    
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var executionDateLabel: UILabel!
    @IBOutlet weak var selectDatePicker: UIDatePicker!
    
    var showDatePicker = false{
        didSet{
            tableView.performBatchUpdates(nil)
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectDatePicker.date = Date()
        executionDateLabel.text = convertDateFormat(date: selectDatePicker.date)
        inputTextField.becomeFirstResponder()
        updateContentUI()
    }
    //讀入更新資料
    func updateContentUI(){
        if let task = task {
            inputTextField.text = task.taskName
            executionDateLabel.text = task.executionDate
            self.navigationItem.title = "修改"
        }else{
            self.navigationItem.title = "新增"
        }
    }
    //轉換時間格式
    func convertDateFormat(date:Date)->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
       return dateFormatter.string(from: date)
    }
    
    //完成
    @IBAction func done(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "backToList", sender: nil)
    }
    //DatePicker
    @IBAction func selectDate(_ sender: UIDatePicker) {
        executionDateLabel.text = convertDateFormat(date: sender.date)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let taskName = inputTextField.text ?? ""
        let executionDate = executionDateLabel.text ?? ""
        let isComplete = false
        
        task = Task(taskName: taskName, executionDate: executionDate,complete: isComplete)
    }
    
    //限制有輸入才能回傳
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if inputTextField.text?.isEmpty == false && executionDateLabel.text?.isEmpty == false{
            return true
        }else{
            let alert = UIAlertController(title: "錯誤", message:"請勿留白", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                alert.dismiss(animated: true, completion: nil)
            }))
            present(alert, animated: true, completion: nil)
            return false
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 2  && showDatePicker == false{
            return 0
        }else if indexPath.row == 2 && showDatePicker == true{
            return UITableView.automaticDimension
        }else{
            return 50
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1{
            showDatePicker = !showDatePicker
        }
    }
}
