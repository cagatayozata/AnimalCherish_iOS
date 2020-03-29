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
    
    // MARK: Variables
    let rolesTitles = ["Barınak Görevlisi", "Veteriner Hekim", "Normal Kullanıcı", "Administrator"]
    let rolesValues = [1, 1, 1, 12]
    
    // MARK: viewDidLoad
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // create pie chart with data
        createPieChart(dataPoints: rolesTitles, values: rolesValues.map{ Double($0) })

    }

    // MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        
        // show pie chart with animation
        self.pieChartView.animate(xAxisDuration: 0.0, yAxisDuration: 1.0)
        
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
            showAlert(for: "Grafik fotoğraflarınıza kaydedildi!")
        }
        
    }
    
    // MARK: Alert
    func showAlert(for alert: String) {
        let alertController = UIAlertController(title: nil, message: alert, preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
}
