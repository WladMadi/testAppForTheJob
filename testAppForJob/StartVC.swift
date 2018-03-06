//
//  StartVC.swift
//  testAppForJob
//
//  Created by mac on 06.03.2018.
//  Copyright © 2018 madINC. All rights reserved.
//

import UIKit

class StartVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let manager: DataManager = DataManager()
    var time: Int = 15
    var timer: Timer?
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        manager.getData()
        tableView.dataSource = self
        tableView.delegate = self
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,
                                     selector: #selector(self.onTimer), userInfo: nil, repeats: true)
        
        delay(delay: 2) {
            self.tableView.reloadData()
        }
        
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       return namesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "valutCell", for: indexPath)
        
        let nameCellLabel: UILabel = cell.contentView.viewWithTag(1) as! UILabel
        nameCellLabel.text! = namesArray[indexPath.row]
        
        let amountCellLabel: UILabel = cell.contentView.viewWithTag(3) as! UILabel
        amountCellLabel.text! = String(format: "%.2f", amountsArray[indexPath.row])
        
        let volumesCellLabel: UILabel = cell.contentView.viewWithTag(2) as! UILabel
        volumesCellLabel.text! = String(Int(volumesArray[indexPath.row]))
        
        return cell
    }
    
    
    func delay(delay: Double, closure: @escaping () -> ()){
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + delay) {
            closure()
        }
        
    }
    
    
    @objc func onTimer() {
        time = time - 1
        if(time <= 0) {
            manager.getData()
            delay(delay: 2){
                self.tableView.reloadData()
                print("RELOAD_DATA")
            }
            time = 15
        }
    }
    
    
    @IBAction func refreshAction(_ sender: Any) {
        manager.getData()
        delay(delay: 2){
            self.tableView.reloadData()
            print("MANUAL_RELOAD_DATA")
        }
        
    }
    

}
