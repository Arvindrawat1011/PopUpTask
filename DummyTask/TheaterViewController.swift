//
//  ViewController.swift
//  DummyTask
//
//  Created by Appinventiv Technologies on 09/10/17.
//  Copyright © 2017 Arvind Rawat. All rights reserved.
//

import UIKit

class TheaterViewController: UIViewController {
    
    
    //MARK:- VIEW IBOUTLET
    @IBOutlet var superViewTheater: UIView!
    @IBOutlet var SortByView: UIView!
    
    //MARK:- TABLEVIEW IBOUTLET
    @IBOutlet weak var shortByTableView: UITableView!
    @IBOutlet weak var theaterTableView: UITableView!
    
    var rightNavBarBtn = false
    var check:[Int] = []
    
    //MARK:- IBACTION
    @IBAction func rightNavigationButtonAction(_ sender: UIBarButtonItem) {
        
        self.rightNavBarBtn = !self.rightNavBarBtn
        sortByViewAnimation()
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let width = superViewTheater.frame.size.width
        SortByView.frame.size.width = width
        
        registeringNib()
        
        theaterTableView.delegate = self
        theaterTableView.dataSource = self
        
        shortByTableView.delegate = self
        shortByTableView.dataSource = self
    }
    
    
    func registeringNib()
    {
        let theaterNib = UINib(nibName: "ThreaterTableViewCell", bundle: nil)
        theaterTableView.register(theaterNib, forCellReuseIdentifier: "threaterTableViewCellId")
        
        let sortbyViewNib = UINib(nibName: "SortByTableViewCell", bundle: nil)
        theaterTableView.register(sortbyViewNib, forCellReuseIdentifier: "sortByTableViewCellId")
        
    }
    
    func sortByViewAnimation()
    {
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
            if self.SortByView.transform == .identity{
                self.view.addSubview(self.SortByView)
                self.theaterTableView.alpha = 0.2
                let a = self.SortByView.frame.height
                self.SortByView.transform = CGAffineTransform(translationX: 1, y: a/3)
            }
            else
            {
                self.theaterTableView.alpha = 1
                self.SortByView.transform = .identity
                self.SortByView.removeFromSuperview()
            }
        }, completion: nil)
    }
}

extension TheaterViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
            
        case self.shortByTableView:
            return 10
            
        case self.theaterTableView:
            return 20
            
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch tableView {
            
        case self.shortByTableView:
            guard let sortByViewCell = theaterTableView.dequeueReusableCell(withIdentifier: "sortByTableViewCellId") as? SortByTableViewCell else{
                
                fatalError(" Error! SortByView Cell Not Found")
            }
            if check.contains(indexPath.row) {
                sortByViewCell.checkImageOutlet.image = UIImage(named:"Tick2")
            }
            return sortByViewCell
            
        case self.theaterTableView:
            guard let theaterCell = theaterTableView.dequeueReusableCell(withIdentifier: "threaterTableViewCellId") as? ThreaterTableViewCell else{
                
                fatalError(" Error! Theater Cell Not Found")
            }
            return theaterCell
            
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == shortByTableView{
            
            guard let cell = tableView.cellForRow(at: indexPath) as? SortByTableViewCell else{
                fatalError("cell not found")
            }
            if !check.contains(indexPath.row) {
                check.append(indexPath.row)
                cell.checkImageOutlet.image = UIImage(named:"Tick2")
                
            }else{
                
                cell.checkImageOutlet.image = UIImage(named:" ")
                check.remove(at: check.index(of: indexPath.row)!)
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableView {
        case self.shortByTableView:
            return  50
            
        case self.theaterTableView:
            return 100
            
        default:
            return 1
        }
    }
}


