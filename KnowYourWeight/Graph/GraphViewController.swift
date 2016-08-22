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
    let markerView = MarkerView(frame: CGRectMake(0,0,140,50))
    let mockData = [15.0,23,34,20,36,22,31,19,13,20,22,34]

    let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    
    var xAxisData : [String] = []
    var yAxisData : [Float] = []
    @IBOutlet weak var lineChartView: LineChartView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureChart()
        markerView.hidden = true
        markerView.backgroundColor = UIColor.blackColor()
        markerView.alpha = 0.9
        markerView.layer.cornerRadius = 5
        self.view.addSubview(markerView)
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func bindViewModel(completionHandler:()->Void = {}){
        viewModel.loadScaleData(){
            self.xAxisData = self.viewModel.scaleData.map({ (data: Scale) -> String in
                return "\(data.timeStamp.value)"
                
            })
            self.yAxisData = self.viewModel.scaleData.map({ (data: Scale) -> Float in
                return data.value.value
            })
            completionHandler()
        }
    }
    
    //MARK: Chart setup
    func configureChart(){
        lineChartView.delegate = self
        lineChartView.noDataText = "No data provided"
        let goal : Double = Double(viewModel.user!.goalWeight.value)
        let ll = ChartLimitLine(limit: goal, label: "Goal")
        print(lineChartView.maxVisibleValueCount)
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
        lineChartView.scaleXEnabled = true
        lineChartView.scaleYEnabled = true
        lineChartView.doubleTapToZoomEnabled = true
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
            let dataEntry = ChartDataEntry(value: Double(yData[i]), xIndex: i,data: xData[i])
            
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
        chartData.setDrawValues(true)
        chartData.highlightEnabled = true
        lineChartView.data = chartData
        lineChartView.maxVisibleValueCount = 10
        lineChartView.setVisibleXRangeMaximum(10)
        lineChartView.animate(xAxisDuration: 2.0,easingOption: .EaseInOutQuart)
    }
    
    
    //MARK: Chart view delegate
 
    
    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: ChartHighlight) {
        let marker = chartView.getMarkerPosition(entry: entry, highlight: highlight)
        markerView.timestampLabel.text = String(entry.data.value!)
        markerView.valueLabel.text = String(entry.value)
        markerView.center = CGPointMake(marker.x, marker.y-40)
        markerView.hidden = false
    }
    
}

class MarkerView: UIView{
    var view : UIView!
    
    @IBOutlet weak var timestampLabel: UILabel!
   
    @IBOutlet weak var valueLabel: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        xibSetup()
        fatalError("init(coder:) has not been implemented")
    
    }
    
   
    
    func xibSetup() {
        view = loadViewFromNib()
        
        // use bounds not frame or it'll be offset
        view.frame = bounds
        
        // Make the view stretch with containing view
        
        view.autoresizingMask = UIViewAutoresizing.FlexibleWidth.union(UIViewAutoresizing.FlexibleHeight)
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "ChartMarker", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        
        return view
    }

}
