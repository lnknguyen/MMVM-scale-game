//
//  GraphViewController.swift
//  KnowYourWeight
//
//  Created by Nguyen Luong on 5/3/16.
//  Copyright © 2016 Nguyen Luong. All rights reserved.
//

import UIKit
import Charts

class GraphViewController: UIViewController, ChartViewDelegate {

    var viewModel = GraphViewModel()
    
    let mockData = [15.0,23,34,20,36,22,31,19,13,20,22,34]

    let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    
    var xAxisData : [String] = []
    var yAxisData : [Float] = []
    @IBOutlet weak var lineChartView: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureChart()
        bindViewModel(){
            self.setupChartData(self.xAxisData, yData: self.yAxisData)
        }
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        bindViewModel(){
            self.setupChartData(self.xAxisData, yData: self.yAxisData)
        }
    }

    func bindViewModel(completionHandler:()->Void = {}){
        viewModel.loadScaleData(){
            self.xAxisData = self.viewModel.scaleData.map({ (data: Scale) -> String in
                return "\(data.id)"
                
            })
            self.yAxisData = self.viewModel.scaleData.map({ (data: Scale) -> Float in
                return data.value.value
            })
            completionHandler()
        }
    }
    
    //MARK: Chart setup
    func configureChart(){
        lineChartView.noDataText = "No data provided"
        let goal : Double = Double(viewModel.user!.goalWeight.value)
        let ll = ChartLimitLine(limit: goal, label: "Goal")
        ll.valueFont = UIFont(name: "American Typewriter", size: 13)!
        
        //x--axis
        lineChartView.xAxis.labelPosition = .Bottom
        lineChartView.xAxis.drawGridLinesEnabled = false
        lineChartView.xAxis.drawLabelsEnabled = false
        lineChartView.legend.enabled = false
        
        //y-axis
        lineChartView.rightAxis.enabled = false
        lineChartView.leftAxis.addLimitLine(ll)
        lineChartView.leftAxis.axisMinValue = 0
        lineChartView.leftAxis.axisMaxValue = 200
        lineChartView.leftAxis.axisLineColor = UIColor.redColor()
        lineChartView.leftAxis.labelFont = UIFont(name: "American Typewriter", size: 16)!
        
        //gesture
        lineChartView.dragEnabled = true
        lineChartView.pinchZoomEnabled = true
        lineChartView.setScaleEnabled(true)
        
        //lineChartView.backgroundColor = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 1)
        let tmp: UIImage =  Utility.imageWithImage(UIImage(named: "blurred-background-1")!,scaledToSize: self.view.bounds.size)
        lineChartView.backgroundColor = UIColor.init(patternImage:tmp)
        lineChartView.delegate = self
        lineChartView.descriptionText = ""
    
        
    }
    
    func setupChartData(xData: [String], yData: [Float]){
        var dataEntries : [ChartDataEntry] = []
        
        for i in 0..<yData.count{
            let dataEntry = ChartDataEntry(value: Double(yData[i]), xIndex: i)
            
            dataEntries.append(dataEntry)
        }
        let chartDataSet = LineChartDataSet(yVals: dataEntries, label: "ID")
        
        chartDataSet.setColor(UIColor.brownColor())
        chartDataSet.circleRadius = 6.0
        chartDataSet.setCircleColor(UIColor.brownColor())
        chartDataSet.lineWidth = 5.0
        chartDataSet.drawValuesEnabled = false
        //chartDataSet.circleHoleColor = UIColor.brownColor()
        //chartDataSet.colors = ChartColorTemplates.liberty()
        
        let chartData = LineChartData(xVals: xAxisData, dataSets: [chartDataSet])
        lineChartView.data = chartData
        lineChartView.animate(xAxisDuration: 2.0,easingOption: .EaseInOutQuart)
    }
    
    
    //MARK: Chart view delegate
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //TODO: Implement delegate
    


}
