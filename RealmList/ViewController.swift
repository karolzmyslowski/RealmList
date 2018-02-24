//
//  ViewController.swift
//  RealmList
//
//  Created by Karol Zmyslowski on 19.02.2018.
//  Copyright © 2018 Karol Zmyslowski. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var lines: Results<Line>!
    var notificationToken: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        let realm = RealmService.shared.realm
        lines = realm.objects(Line.self)
        
        notificationToken = realm.observe({ (notification, realm) in
            self.tableView.reloadData()
        })
        
        RealmService.shared.observeRealmErrors(in: self) { (error) in
            print(error ?? "no error")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        notificationToken?.invalidate()
        RealmService.shared.stopObservingErrors(in: self)
    }
    
    
    @IBAction func onAddTapped() {
        AlertService.addAlert(in: self) { (line, score, email) in
            let newLine = Line(line: line, score: score, email: email)
            RealmService.shared.create(newLine)
        }
    }
    
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LineCell") as? LineCell else {
            return UITableViewCell() }
        let line = lines[indexPath.row]
        cell.configure(with: line)
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedLine = lines[indexPath.row]
        AlertService.updateAlert(in: self, line: selectedLine) { (line, score, email) in
            let dict: [String: Any?] = ["line": line,
                                        "score": score,
                                        "email": email]
            RealmService.shared.update(selectedLine, with: dict)
            
            
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {return }
        let editingLine = lines[indexPath.row]
        RealmService.shared.delete(editingLine)
    }
}



