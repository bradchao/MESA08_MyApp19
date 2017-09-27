//
//  ViewController.swift
//  MyApp19
//
//  Created by user22 on 2017/9/27.
//  Copyright © 2017年 Brad Big Company. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let app = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var txtCname: UITextField!
    
    @IBOutlet weak var txtBirthday: UITextField!
    
    @IBOutlet weak var txtTel: UITextField!
    
    @IBAction func query(_ sender: Any) {
        if let _ = app.db {
            let sql = "select * from cust"
            var statement:OpaquePointer? = nil
            
            // 藉由 sql 產生 statement => result
            if sqlite3_prepare(app.db, sql, -1, &statement, nil) != SQLITE_OK {
                let errmesg = String(cString: sqlite3_errmsg(app.db), encoding: .utf8)
                print("prepare error:\(errmesg)")
            }
            
            // 移動指標, 直到不是一個 row
            while sqlite3_step(statement) == SQLITE_ROW {
                let id = sqlite3_column_text(statement, 0)  // UInt8
                let cname = sqlite3_column_text(statement, 1)
                let birthday = sqlite3_column_text(statement, 2)
                let tel = sqlite3_column_text(statement, 3)
                let strId = String(cString: id!)
                let strCname = String(cString: cname!)
                let strBirthday = String(cString: birthday!)
                let strTel = String(cString: tel!)
                
                print("\(strId):\(strCname):\(strBirthday):\(strTel)")
            }
            print("-------")
        }
    }
    
    @IBAction func insert(_ sender: Any) {
        if let _ = app.db {
            var statement:OpaquePointer? = nil
            
            let cname = txtCname.text!.cString(using: .utf8)
            let birthday = txtBirthday.text!.cString(using: .utf8)
            let tel = txtTel.text!.cString(using: .utf8)

            let sql = "insert into cust (cname,birthday,tel) values (?,?,?)"
            
            if sqlite3_prepare(app.db, sql, -1, &statement, nil) != SQLITE_OK {
                print("prepare error")
            }
            
            // 替換掉 ?
            sqlite3_bind_text(statement, 1, cname, -1, nil)
            sqlite3_bind_text(statement, 2, birthday, -1, nil)
            sqlite3_bind_text(statement, 3, tel, -1, nil)
            
            if sqlite3_step(statement) == SQLITE_DONE {
                print("insert ok")
            }else{
                print("insert error")
            }
        
        }
    }
    
    @IBAction func del(_ sender: Any) {
    }
    
    
    @IBAction func update(_ sender: Any) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

