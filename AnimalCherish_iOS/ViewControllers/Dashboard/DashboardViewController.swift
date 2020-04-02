//
//  DashboardViewController.swift
//  AnimalCherish_iOS
//
//  Created by Cagatay Ozata on 26.02.2020.
//  Copyright © 2020 CTIS_Team1. All rights reserved.
//

import UIKit
import Charts

class DashboardViewController: UIViewController {
    
    // MARK: IBOutlet
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var middleMenu: UIStackView!
    @IBOutlet weak var yeniliklerButton: UIButton!
    @IBOutlet weak var recentNewsButton: UIButton!
    @IBOutlet weak var summaryButton: UIButton!
    
    // MARK: Variables
    let rolesTitles = ["Barınak Görevlisi", "Veteriner Hekim", "Normal Kullanıcı", "Administrator"]
    let rolesValues = [1, 1, 1, 12]
    
    // MARK: viewDidLoad
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // create pie chart with data
        createPieChart(dataPoints: rolesTitles, values: rolesValues.map{ Double($0) })
        
        // style edits
        style()
        
    }
    
    // MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        
        // show pie chart with animation
        self.pieChartView.animate(xAxisDuration: 0.0, yAxisDuration: 1.0)
        
    }
    
    @IBAction func pressedSummary(_ sender: Any) {
        
        summaryButton.setTitleColor(UIColor(#colorLiteral(red: 0.0006258591893, green: 0.4516738057, blue: 0.96962744, alpha: 1)), for: .normal)
        recentNewsButton.setTitleColor(UIColor(#colorLiteral(red: 0.7922700644, green: 0.7923850417, blue: 0.7922448516, alpha: 1)), for: .normal)
        yeniliklerButton.setTitleColor(UIColor(#colorLiteral(red: 0.7922700644, green: 0.7923850417, blue: 0.7922448516, alpha: 1)), for: .normal)
        
    }
    
    @IBAction func pressedRecentNews(_ sender: Any) {
        
        summaryButton.setTitleColor(UIColor(#colorLiteral(red: 0.7922700644, green: 0.7923850417, blue: 0.7922448516, alpha: 1)), for: .normal)
        recentNewsButton.setTitleColor(UIColor(#colorLiteral(red: 0.0006258591893, green: 0.4516738057, blue: 0.96962744, alpha: 1)), for: .normal)
        yeniliklerButton.setTitleColor(UIColor(#colorLiteral(red: 0.7922700644, green: 0.7923850417, blue: 0.7922448516, alpha: 1)), for: .normal)
        
    }
    
    @IBAction func pressedYenilikler(_ sender: Any) {
        
        summaryButton.setTitleColor(UIColor(#colorLiteral(red: 0.7922700644, green: 0.7923850417, blue: 0.7922448516, alpha: 1)), for: .normal)
        recentNewsButton.setTitleColor(UIColor(#colorLiteral(red: 0.7922700644, green: 0.7923850417, blue: 0.7922448516, alpha: 1)), for: .normal)
        yeniliklerButton.setTitleColor(UIColor(#colorLiteral(red: 0.0006258591893, green: 0.4516738057, blue: 0.96962744, alpha: 1)), for: .normal)
        
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
