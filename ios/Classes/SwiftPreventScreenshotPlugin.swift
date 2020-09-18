import Flutter
import UIKit

public class SwiftPreventScreenshotPlugin: NSObject, FlutterPlugin, FlutterStreamHandler {
      private var eventSink: FlutterEventSink?
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    let methodChannel = FlutterMethodChannel(name: "prevent_screenshot", binaryMessenger: registrar.messenger())
    let eventChannel = FlutterEventChannel(name: "prevent_screenshot.events", binaryMessenger: registrar.messenger())
   
    let instance = SwiftPreventScreenshotPlugin()
    
    registrar.addMethodCallDelegate(instance, channel: methodChannel)
    eventChannel.setStreamHandler(instance)
  
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
    
    // Handle stream emitting (Swift => Flutter)
    private func emitValues(value: Bool) {
        // If no eventSink to emit events to, do nothing (wait)
        if (eventSink == nil) {
            return
        }
        // Emit values count event to Flutter
        eventSink!(value)
    }

    // Event Channel: On Stream Listen
    public func onListen(withArguments arguments: Any?,
      eventSink: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = eventSink
//        NotificationCenter.default.addObserver(self, selector: #selector(screenCaptureChanged), name: UIApplication.capturedDidChangeNotification, object: nil)
        NotificationCenter.default.addObserver(forName: UIApplication.userDidTakeScreenshotNotification, object: nil, queue: OperationQueue.main) { notification in
               print("Screenshot taken!")
            if #available(iOS 11.0, *) {
                self.emitValues(value: UIScreen.main.isCaptured)
            } else {
               print("Platform version not supported")
            }
//            self.emitValues(values: "")
           }
        if #available(iOS 11.0, *) {
            NotificationCenter.default.addObserver(forName:  UIScreen.capturedDidChangeNotification, object: nil, queue: OperationQueue.main) { notification in
                print("Screen recording ")
                self.emitValues(value: UIScreen.main.isCaptured)
            }
        } else {
           print("Platform version not supported")
        }
        return nil
    }
    
 
    // Event Channel: On Stream Cancelled
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        NotificationCenter.default.removeObserver(self)
        eventSink = nil
        //self.emitValues(values: audioData)
        return nil
    }
}
