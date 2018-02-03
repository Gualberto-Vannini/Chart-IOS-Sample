//
//  ViewController.swift
//  GITHUB EXAMPLE
//
//  Created by Gualberto on 03/02/18.
//

import UIKit
import Foundation

import Charts

class ViewController: UIViewController, ChartViewDelegate {
    
    var intArrayAnno: [Int]!
    var convertionDataDouble:[Double] = [0.0]
    
    @IBOutlet weak var lineChartView: LineChartView!
    
    //Creazione variabile mesi
    var months: [String]!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let intMileageYear  = [200.0, 591.0, 817.0, 143.0, 458.0, 78.0, 120.0, 330.0, 58.0, 62.0, 41.0, 316.0]
        
        convertionDataDouble = intMileageYear.map { Double($0)}
        print(convertionDataDouble, "convetionDataDouble print line 28")
        
        //print(intArrayAnno, "array consumi dentro anno per chart?")
        //print(dataFormattataArrayAnno, "trasportdataFormattataArrayAnno?")
        
        //First xAxis
        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]

        let mileage = convertionDataDouble
        
        //Marker's creation
        let marker:BalloonMarker = BalloonMarker(color: UIColor.lightGray,
                                                 font: UIFont(name: "Helvetica", size: 15)!,
                                                 textColor: UIColor.white,
                                                 insets: UIEdgeInsets(top: 8, left: 8, bottom: 20, right: 8))
        marker.chartView = lineChartView
        marker.minimumSize = CGSize(width: 80, height: 40)
        lineChartView.marker = marker

        //Set Chart
        setChart(dataPoints: months, values: mileage)
        
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        //New variable for xAxis
        let declareNewXAxis:lineChartFormatter = lineChartFormatter()
        let xaxis:XAxis = XAxis()
        
        var dataEntries: [ChartDataEntry] = []
        
        //Cycle for xAxis ed yAxis data
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
            
            //new xAxis
            declareNewXAxis.stringForValue(Double(i), axis: xaxis)
            
        }
        //creation of new xAxis
        xaxis.valueFormatter = declareNewXAxis
        
        //Avoid clicking
        lineChartView.doubleTapToZoomEnabled = false
        
        //graph declarations
        let lineChartDataSet = LineChartDataSet(values: dataEntries, label: "Kilometers")
        let linechartData = LineChartData(dataSet: lineChartDataSet)
        lineChartView.data = linechartData
        //Animations element creation
        lineChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        
        //X axis at bottom
        lineChartView.xAxis.labelPosition = XAxis.LabelPosition.bottom
        
        //Y axis only left
        let yaxis = lineChartView.getAxis(YAxis.AxisDependency.right)
        yaxis.drawLabelsEnabled = false
        
        //No description label
        lineChartView.chartDescription?.text = ""
        
        //Radius circle
        lineChartDataSet.circleRadius = 4
        lineChartDataSet.circleHoleRadius = 3
        lineChartDataSet.circleHoleColor = UIColor.white
        lineChartDataSet.circleColors = [NSUIColor.red]
        
        // Gradient Fill
        let gradientColors = [UIColor.red.cgColor, UIColor.clear.cgColor] as CFArray // Colors of the gradient
        let colorLocations:[CGFloat] = [0.5, 0.0] // Positioning of the gradient
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations) // Gradient Object
        lineChartDataSet.fill = Fill.fillWithLinearGradient(gradient!, angle: 90.0) // Set the Gradient
        lineChartDataSet.drawFilledEnabled = true // Draw the Gradient
        //Gradient in function of the value
        lineChartDataSet.cubicIntensity = 0.09
        
        // Set grid background color
        lineChartView.gridBackgroundColor = UIColor.orange
        // It is required to enable 'drawGridBackgroundColor' to see effect of gridBackground color
       lineChartView.drawGridBackgroundEnabled = false
        
        
        //Color line
        lineChartDataSet.colors = [NSUIColor.red]
        //Thickness line
        lineChartDataSet.lineWidth = 0.3
   
        //no value above the points
        lineChartDataSet.drawValuesEnabled = false
        
        //yAxix will start to zero of xAxis
        lineChartView.rightAxis.axisMinimum = 0.0
        lineChartView.leftAxis.axisMinimum = 0.0
        
        //Avoid Y grid
        lineChartView.xAxis.labelCount = 11
        
        //Set Legend
        let legend = lineChartView.legend
        lineChartView.legend.verticalAlignment = .top
        //No legend
        legend.enabled = false;
        
        //nuovi valori all'asse X
        lineChartView.xAxis.valueFormatter = xaxis.valueFormatter
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //new obj to move xAxis
    @objc(lineChartFormatter)
    public class lineChartFormatter: NSObject, IAxisValueFormatter{
        
        //creation new xAxis to put in bottom
        var months: [String]! = ["Gen", "Feb", "Mar", "Apr", "Mag", "Giu", "Lug", "Ago", "Set", "Ott", "Nov", "Dic"]
        
        
        public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
            
            return months[Int(value)]
        }
    }
    
 
    
}







