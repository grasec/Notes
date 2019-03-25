//
//  ViewController.swift
//  Notes
//
//  Created by hackeru on 25/03/2019.
//  Copyright © 2019 lol. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate {
    
    var notes:[MyNote] = []
    var tableView: UITableView!
    var addBtn: UIButton!
    let destinationPath = NSTemporaryDirectory() + "MyNotes.txt"

    override func viewDidLoad() {
        super.viewDidLoad()
        //table view
        load()
        tableView = UITableView(frame: CGRect(x: 5, y: 20, width: view.frame.width - 10, height: view.frame.height - 50), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        //button
        addBtn = UIButton(type: .system)
        addBtn.frame = CGRect(x: 5, y: view.frame.height - 30, width: view.frame.width-10, height: 30)
        addBtn.setTitle("ADD", for: .normal)
        view.addSubview(addBtn)
        addBtn.addTarget(self, action: #selector(handleAdd(sender:)), for: .touchUpInside)
        //long pres reco
        let longPressGesture:UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress(longPressGesture:)))
        longPressGesture.minimumPressDuration = 1.0
        longPressGesture.delegate = self
        self.tableView.addGestureRecognizer(longPressGesture)
        // load on startup
        print(destinationPath)
    }
    
//    func testFunc(){
//        print("*******")
//        var notes:[MyNote] = []
//        do{
//            let nsNotes = try NSArray(contentsOfFile: destinationPath) as! [MyNote]
//            if let nsNotes = NSArray(contentsOfFile: destinationPath){
//                print("im here!")
//                notes = nsNotes as! [MyNote]
//            }
//            for s in nsNotes{
//                print(s.description)
//            }
//        }catch{
//
//        }
//    }
    
    func save(){
        do{
            print("in save")
            //saving array to file:
            
            let notesAsNS = notes as NSArray
            for s in notesAsNS{
                print((s as! MyNote).description)
            }
            notesAsNS.write(toFile: destinationPath, atomically: true)
        }
    }
    
    func load(){
        print("in load")
        //reading array from file:
        do{
            if let nsNotes = NSArray(contentsOfFile: destinationPath){
                self.notes = nsNotes as! [MyNote]
                self.tableView.reloadData()
            }
        }
    }

    @objc func longPress(longPressGesture: UILongPressGestureRecognizer) {
        if longPressGesture.state == UIGestureRecognizer.State.began {
            let touchPoint = longPressGesture.location(in: self.tableView)
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                print("in long")
                self.notes.remove(at: indexPath.row)
                self.tableView.reloadData()
                self.save()
            }
        }
    }
    
    @objc func handleAdd(sender: UIButton){
        
        let alertController = UIAlertController(title: "Add new note", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField: UITextField) in
            textField.placeholder = "enter note"
        }
        
        let action = UIAlertAction(title: "Ok", style: .default) { (action: UIAlertAction) in
            print("action Ok was clicked...")
            let textField = alertController.textFields![0]

            print("your note is \(textField.text!)")
            self.notes.append(MyNote(desc: textField.text!))
            self.tableView.reloadData()
//          self.save()
//            self.save2File()
//            self.readFromFile()
        }
        
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "identifier")
        if cell == nil{
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "identifier")
        }
        
        let myObject:MyNote = notes[indexPath.row]
        cell!.textLabel!.text = myObject.desc
        return cell!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    
//    func save2File(){
//        do{
//            let arr:NSArray = notes as NSArray
//            try arr.write(toFile: destinationPath, atomically: true)
//        }catch{
//            print("error: \(error)")
//        }
//    }
//    func readFromFile(){
//        do{
//        let arr = NSArray(contentsOfFile: destinationPath) as! [MyNote]
//        for s in arr{
//            print(s)
//        }
//        }catch{
//            print("error: \(error)")
//        }
//    }
}

