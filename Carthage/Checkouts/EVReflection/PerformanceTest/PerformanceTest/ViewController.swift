//
//  ViewController.swift
//  EVReflectionTestApp
//
//  Created by Edwin Vermeer on 4/9/16.
//  Copyright © 2016 evict. All rights reserved.
//

import UIKit
import EVReflection

class ViewController: UIViewController {
    
    // MARK: - General test setup and functions
    
    @IBOutlet weak var initialMemoryUsage: UILabel!
    @IBOutlet weak var testDuration: UILabel!
    @IBOutlet weak var curenMemoryUsage: UILabel!
    @IBOutlet weak var changedMemoryUsage: UILabel!
    
    var usage: UInt = 0
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        usage = report_memory()
        curenMemoryUsage.text = "\(NSNumber(value: Int32(usage)).description(withLocale: NSLocale.current))"
        initialMemoryUsage.text = "\(NSNumber(value: Int32(usage)).description(withLocale: NSLocale.current))"
    }
    
    override func didReceiveMemoryWarning() {
        print("WARNING: didReceiveMemoryWarning")
        super.didReceiveMemoryWarning()
    }
    
    func report_memory() -> UInt {
        var info = mach_task_basic_info()
        var count = mach_msg_type_number_t(MemoryLayout<mach_task_basic_info>.size)/4
        
        let kerr: kern_return_t = withUnsafeMutablePointer(to: &info) {
            $0.withMemoryRebound(to: integer_t.self, capacity: 1) {
                task_info(mach_task_self_,
                          task_flavor_t(MACH_TASK_BASIC_INFO),
                          $0,
                          &count)
            }
        }
        
        if kerr == KERN_SUCCESS {
            print("Memory in use (in bytes): \(info.resident_size)")
            return UInt(info.resident_size)
        } else {
            print("Error with task_info(): " +
                (String(cString: mach_error_string(kerr), encoding: String.Encoding.ascii) ?? "unknown error"))
            return 0
        }
    }
    
    
    
    func doTest(test : ()-> ()) {
        let startTime = NSDate()
        let usageAtBegin = usage
    
        test()

        let endTime = NSDate()

        usage = report_memory()
        curenMemoryUsage.text = "\(NSNumber(value: Int32(usage)).description(withLocale: NSLocale.current))"

        let change: Int32 = (Int32(usage) - Int32(usageAtBegin))
        changedMemoryUsage.text = "\(NSNumber(value: change).description(withLocale: NSLocale.current))"

        testDuration.text = "\(endTime.timeIntervalSince(startTime as Date))"
    }
    
    // MARK: - Executing the tests
    
    @IBAction func test1(sender: AnyObject) {
        doTest {
            let a = TestObject1()
            for i in 1...1000 {
                a.listObject2?.append(TestObject2(id: i))
            }
            let b = a.toJsonString()
            let c = TestObject1(json: b)
            assert(c.listObject2?.count ?? 0 == 1000)
        }
    }

    @IBAction func test2(sender: AnyObject) {
        doTest {
            let test = ArrayDeserializationPerformanceTest()
            test.performanceTest1()
        }
    }

    @IBAction func test3(sender: AnyObject) {
        doTest {
            let a = TestObject1()
            a.listObject2?.append(TestObject2(id: 1))
            let b = a.toJsonString()
            let c = TestObject1(json: b)
            assert(c.listObject2?.count ?? 0 == 1)
        }
    }


}


// MARK: - Objects used in the tests


class TestObject1: EVObject {
    var name: String? = "Object1 Name"
    var listObject2: [TestObject2]? = []
}

class TestObject2: EVObject {
    var name: String? = "Object2 Name"

    init(id: Int) {
        super.init()
        name = "Object2 Name \(id)"
    }
    //workaround
    @available(*, deprecated: 0.0.1, message: "init isn't supported, use init(id:) instead")
    required init() {
        super.init()
    }
}
