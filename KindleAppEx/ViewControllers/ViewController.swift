//
//  ViewController.swift
//  KindleAppEx
//
//  Created by sanket rajendra likhe on 13/03/18.
//  Copyright © 2018 sanket rajendra likhe. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    let dataManager: DataManager = DataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.setupNavigationBarStyles()
        self.setupNavBarbuttonItem()
        registerBookCellForTableView()
        navigationItem.title = "All Items"
        fetchKindleBooks()
    }

    fileprivate func registerBookCellForTableView() {
        tableView.register(BookCell.self, forCellReuseIdentifier: "cellId")
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor(white: 1, alpha: 0.3)
        tableView.separatorColor = UIColor(white: 1, alpha: 0.2)
    }
    
    fileprivate func fetchKindleBooks() {
        dataManager.fetchKindleBooks { (books, error) in
            if books != nil{
                DispatchQueue.main.async { self.tableView.reloadData() }
            }
        }
    }
    
    fileprivate func setupNavBarbuttonItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(leftMenuButtonTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "amazon_icon").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(rightMenuButtonTapped))
        
    }
    
    @objc func leftMenuButtonTapped() {
        
    }
    
    @objc func rightMenuButtonTapped() { 
        
    }
    
    fileprivate func setupNavigationBarStyles(){
        navigationController?.navigationBar.barTintColor = UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }
    
    fileprivate func initializingSegmentedControl(_ footerView: UIView) {
        let segmentedControl = UISegmentedControl(items: ["Cloud", "Device"])
        segmentedControl.tintColor = .white
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        footerView.addSubview(segmentedControl)
        segmentedControl.widthAnchor.constraint(equalToConstant: 200).isActive = true
        segmentedControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        segmentedControl.centerXAnchor.constraint(equalTo: footerView.centerXAnchor).isActive = true
        segmentedControl.centerYAnchor.constraint(equalTo: footerView.centerYAnchor).isActive = true
    }
    
    fileprivate func initializingGridButton(_ footerView: UIView) {
        let gridButton = UIButton(type: .system)
        gridButton.setImage(#imageLiteral(resourceName: "grid").withRenderingMode(.alwaysOriginal), for: .normal)
        gridButton.translatesAutoresizingMaskIntoConstraints = false
        footerView.addSubview(gridButton)
        gridButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        gridButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        gridButton.leftAnchor.constraint(equalTo: footerView.leftAnchor, constant: 8).isActive = true
        gridButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor).isActive = true
    }
    
    fileprivate func initializingSortButton(_ footerView: UIView) {
        let sortButton = UIButton()
        sortButton.setImage(#imageLiteral(resourceName: "sort").withRenderingMode(.alwaysOriginal), for: .normal)
        sortButton.translatesAutoresizingMaskIntoConstraints = false
        footerView.addSubview(sortButton)
        sortButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        sortButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        sortButton.rightAnchor.constraint(equalTo: footerView.rightAnchor, constant: -8).isActive = true
        sortButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor).isActive = true
    }
    

}

extension ViewController{
    
    // TableViewDelegate method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let booksPagerViewController = BookPagerViewController(collectionViewLayout: UICollectionViewFlowLayout())
        booksPagerViewController.title = dataManager.books[indexPath.row].title
        booksPagerViewController.pages = dataManager.getPagesForBook(book: dataManager.books[indexPath.row])
        let navigationController = UINavigationController(rootViewController: booksPagerViewController)
        present(navigationController, animated: true, completion: nil)
    }
    
    // TableViewDataSource methods
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1)
        initializingSegmentedControl(footerView)
        initializingGridButton(footerView)
        initializingSortButton(footerView)
        
        return footerView
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 86
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.books.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! BookCell
        let book = dataManager.books[indexPath.row]
        cell.titleLabel.text = book.title
        cell.authorLabel.text = book.author
        if let coverImageURL = book.coverImageUrl{
            dataManager.downloadCoverImage(url: coverImageURL, completion: { (image, error) in
                if let image = image{
                    cell.coverImageView.image = image
                }
            })
        }
        return cell
    }
}

