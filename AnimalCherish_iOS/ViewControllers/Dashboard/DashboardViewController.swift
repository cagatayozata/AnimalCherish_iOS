//
//  DashboardViewController.swift
//  AnimalCherish_iOS
//
//  Created by Cagatay Ozata on 26.02.2020.
//  Copyright © 2020 CTIS_Team1. All rights reserved.
//

import UIKit
import Charts
import Foundation

class DashboardViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, XMLParserDelegate {
    
    // MARK: IBOutlet
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var middleMenu: UIStackView!
    @IBOutlet weak var yeniliklerButton: UIButton!
    @IBOutlet weak var recentNewsButton: UIButton!
    @IBOutlet weak var summaryButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Variables
    let rolesTitles = ["Barınak Görevlisi", "Veteriner Hekim", "Normal Kullanıcı", "Administrator"]
    let rolesValues = [1, 1, 1, 12]
    
    var activeSegment = 0 // 0 -> Özet, 1 -> Son Haberler, 3 -> Yenilikler
    
    var summaryData: [String] = ["15", "52", "13", "18"]
    var summaryDataTitles: [String] = ["Sistemdeki kayıtlı veteriner sayısı", "Sistemdeki kayıtlı hayvan sayısı","Sistemdeki kayıtlı barınak sayısı","Sistemdeki kayıtlı kullanıcı sayısı"]
    var summaryDataIcons: [String] = ["veticon", "animalicon", "sheltericon", "usericon"]
    
    var myFeed : NSArray = []
    var feedImgs: [AnyObject] = []
    var url: URL!
    
    // MARK: viewDidLoad
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // create pie chart with data
        createPieChart(dataPoints: rolesTitles, values: rolesValues.map{ Double($0) })
        
        // style edits
        style()
        
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 180
        tableView.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.1)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        loadData()
    }
    
    func loadData() {
        url = URL(string: "https://www.tshf.org.tr/rss/latest-posts")!
        loadRss(url);
    }
    
    func loadRss(_ data: URL) {
        
        // XmlParserManager instance/object/variable.
        let myParser : XmlParserManager = XmlParserManager().initWithURL(data) as! XmlParserManager
        
        // Put feed in array.
        feedImgs = myParser.img as [AnyObject]
        myFeed = myParser.feeds
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openPage" {
            let indexPath: IndexPath = self.tableView.indexPathForSelectedRow!
            let selectedFURL: String = (myFeed[indexPath.row] as AnyObject).object(forKey: "link") as! String
            
            // Instance of our feedpageviewcontrolelr.
            let fivc: FeedItemWebViewController = segue.destination as! FeedItemWebViewController
            fivc.selectedFeedURL = selectedFURL as String
        }
    }
    
    // MARK: - Table view data source.
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // MARK: Table view show selected segment
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if activeSegment == 0 {
            
            // özet
            return summaryData.count
            
        } else if activeSegment == 1 {
            
            // son haberler
            if myFeed.count > 7 {
                return 7
            }
            
            return myFeed.count
            
        } else {
            
            // yenilikler
            return summaryData.count
            
        }
    }
    
    // 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if activeSegment == 0 {
            
            // özet
            let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
            
            cell.backgroundColor = UIColor(white: 1, alpha: 0)
            let cellImageLayer: CALayer?  = cell.imageView?.layer
            
            cellImageLayer!.cornerRadius = 0
            cellImageLayer!.masksToBounds = false
            
            cell.imageView?.image = UIImage(named: summaryDataIcons[indexPath.row])
            cell.textLabel?.text = self.summaryData[indexPath.row]
            cell.detailTextLabel?.text = self.summaryDataTitles[indexPath.row]
            
            return cell
            
        } else if activeSegment == 1 {
            
            // son haberler
            let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
            cell.textLabel?.backgroundColor = UIColor.clear
            cell.detailTextLabel?.backgroundColor = UIColor.clear
            cell.textLabel?.numberOfLines = 1
            
            if indexPath.row % 2 == 0 {
                cell.backgroundColor = UIColor(white: 1, alpha: 0)
            } else {
                cell.backgroundColor = UIColor(white: 0.5, alpha: 0.1)
            }
            
            // Load feed iamge.
            let url = NSURL(string:feedImgs[indexPath.row] as! String)
            let data = NSData(contentsOf:url! as URL)
            var image = UIImage(data:data! as Data)
            
            image = resizeImage(image: image!, toTheSize: CGSize(width: 70, height: 70))
            
            let cellImageLayer: CALayer?  = cell.imageView?.layer
            
            cellImageLayer!.cornerRadius = 15
            cellImageLayer!.masksToBounds = true
            
            cell.imageView?.image = image
            
            let str = (myFeed.object(at: indexPath.row) as AnyObject).object(forKey: "title") as? String
            let nsString = str as! NSString
            if nsString.length >= 30
            {
                cell.textLabel?.text = nsString.substring(with: NSRange(location: 0, length: nsString.length > 30 ? 30 : nsString.length)) + "..."
            }
            

            cell.textLabel?.numberOfLines = 1
            cell.textLabel?.lineBreakMode = .byWordWrapping
            cell.detailTextLabel?.text = (myFeed.object(at: indexPath.row) as AnyObject).object(forKey: "pubDate") as? String

            
            return cell
            
        } else {
            
            // yenilikler
            let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
            
            cell.imageView?.image = UIImage(systemName: "person")
            cell.textLabel?.text = self.summaryData[indexPath.row]
            cell.detailTextLabel?.text = self.summaryData[indexPath.row]
            
            return cell
            
        }
    
    }
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 255) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 255) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    // MARK: Resize Image of Recent News
    func resizeImage(image:UIImage, toTheSize size:CGSize)->UIImage{
        
        let scale = CGFloat(max(size.width/image.size.width,
                                size.height/image.size.height))
        let width:CGFloat  = image.size.width * scale
        let height:CGFloat = image.size.height * scale;
        
        let rr:CGRect = CGRect(x: 0, y: 0, width: width, height: height)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0);
        image.draw(in: rr)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        return newImage!
    }
    
    // MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        
        // show pie chart with animation
        self.pieChartView.animate(xAxisDuration: 0.0, yAxisDuration: 1.0)
        
    }
    
    // MARK: Show Summary Page
    @IBAction func pressedSummary(_ sender: Any) {
        
        summaryButton.setTitleColor(UIColor(#colorLiteral(red: 0.0006258591893, green: 0.4516738057, blue: 0.96962744, alpha: 1)), for: .normal)
        recentNewsButton.setTitleColor(UIColor(#colorLiteral(red: 0.7922700644, green: 0.7923850417, blue: 0.7922448516, alpha: 1)), for: .normal)
        yeniliklerButton.setTitleColor(UIColor(#colorLiteral(red: 0.7922700644, green: 0.7923850417, blue: 0.7922448516, alpha: 1)), for: .normal)
        activeSegment = 0
        tableView.reloadData()
        
    }
    
    // MARK: Show Recent News Page
    @IBAction func pressedRecentNews(_ sender: Any) {
        
        summaryButton.setTitleColor(UIColor(#colorLiteral(red: 0.7922700644, green: 0.7923850417, blue: 0.7922448516, alpha: 1)), for: .normal)
        recentNewsButton.setTitleColor(UIColor(#colorLiteral(red: 0.0006258591893, green: 0.4516738057, blue: 0.96962744, alpha: 1)), for: .normal)
        yeniliklerButton.setTitleColor(UIColor(#colorLiteral(red: 0.7922700644, green: 0.7923850417, blue: 0.7922448516, alpha: 1)), for: .normal)
        activeSegment = 1
        tableView.reloadData()
        
    }
    
    // MARK: Show Yenilikler Page
    @IBAction func pressedYenilikler(_ sender: Any) {
        
        summaryButton.setTitleColor(UIColor(#colorLiteral(red: 0.7922700644, green: 0.7923850417, blue: 0.7922448516, alpha: 1)), for: .normal)
        recentNewsButton.setTitleColor(UIColor(#colorLiteral(red: 0.7922700644, green: 0.7923850417, blue: 0.7922448516, alpha: 1)), for: .normal)
        yeniliklerButton.setTitleColor(UIColor(#colorLiteral(red: 0.0006258591893, green: 0.4516738057, blue: 0.96962744, alpha: 1)), for: .normal)
        activeSegment = 2
        tableView.reloadData()
        
    }
    
    // MARK: Create Pie Chart
    func createPieChart(dataPoints: [String], values: [Double]) {
        
        // 1. Set ChartDataEntry
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i], data: dataPoints[i] as AnyObject)
            dataEntries.append(dataEntry)
        }
        
        let pieChartData = PieChartData()
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: "")
        
        pieChartDataSet.colors = ChartColorTemplates.vordiplom()
        pieChartData.addDataSet(pieChartDataSet)
        
        let centerText: NSMutableAttributedString = NSMutableAttributedString(string: "Kim Ne Görev Yapıyor?")
        centerText.addAttributes([NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Light", size: 13.0)!], range: NSMakeRange(0, centerText.length))
        
        self.pieChartView.data = pieChartData
        self.pieChartView.chartDescription?.text = "Copyright AnimalCherish"
        self.pieChartView.centerAttributedText = centerText
        self.pieChartView.drawEntryLabelsEnabled = false
        self.pieChartView.notifyDataSetChanged()
        //self.pieChartView.drawHoleEnabled = false
        
    }
    
    // MARK: Download Chart To Gallery
    @IBAction func downloadChartToGallery(_ sender: Any) {
        
        //Create the UIImage
        UIGraphicsBeginImageContext(pieChartView.frame.size)
        pieChartView.layer.render(in: UIGraphicsGetCurrentContext()!)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //Save it to the camera roll
        if let temp = image {
            UIImageWriteToSavedPhotosAlbum(temp, nil, nil, nil)
            Alert.showAlert(message: "Grafik fotoğraflarınıza kaydedildi!", vc: self)
        }
        
    }
    
    // MARK: style
    func style() {
        
        // Middle menu style
        let thickness: CGFloat = 2.0
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x:0, y: middleMenu.frame.size.height - thickness, width: middleMenu.frame.size.width, height:thickness)
        bottomBorder.backgroundColor = #colorLiteral(red: 0.0006258591893, green: 0.4516738057, blue: 0.96962744, alpha: 1)
        middleMenu.layer.addSublayer(bottomBorder)
        
    }
    
    // MARK: goBackToFirst
    @IBAction func goBackToFirst(_ sender: UIStoryboardSegue) {
    }
    
}
