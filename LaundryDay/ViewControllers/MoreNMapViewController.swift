//
//  MoreNMapViewController.swift
//  LaundryDay
//
//  Created by MBP03 on 2018. 7. 29..
//  Copyright © 2018년 MBP03. All rights reserved.
//

import UIKit

//nil이랑 (x:0, y:0) 주석처리하고 원래 코드 살리기 [MARK: - NMapPOIdataOverlayDelegate]
//NMapViewResources.swift

// set custom POI Flag Type.
// NMapPOIflagTypeReserved 보다 큰 값으로 설정.
let UserPOIflagTypeDefault: NMapPOIflagType = NMapPOIflagTypeReserved + 1
let UserPOIflagTypeInvisible: NMapPOIflagType = NMapPOIflagTypeReserved + 2

class NMapViewResources: NSObject {
    
    open static func imageWithType(_ poiFlagType: NMapPOIflagType, selected: Bool) -> UIImage? {
        switch poiFlagType {
        case NMapPOIflagTypeLocation:
            return #imageLiteral(resourceName: "pubtrans_ic_mylocation_on")
        case NMapPOIflagTypeLocationOff:
            return #imageLiteral(resourceName: "pubtrans_ic_mylocation_off")
        case NMapPOIflagTypeCompass:
            return #imageLiteral(resourceName: "ic_angle")
        case UserPOIflagTypeDefault:
            return #imageLiteral(resourceName: "pubtrans_exact_default")
        case UserPOIflagTypeInvisible:
            return #imageLiteral(resourceName: "1px_dot")
        default:
            return nil
        }
    }
    
    open static func anchorPoint(withType type: NMapPOIflagType) -> CGPoint {
        switch type {
        case NMapPOIflagTypeLocation: fallthrough
        case NMapPOIflagTypeLocationOff: fallthrough
        case NMapPOIflagTypeCompass:
            return CGPoint(x: 0.5, y: 0.5)
        case UserPOIflagTypeDefault:
            return CGPoint(x: 0.5, y: 1.0)
        case UserPOIflagTypeInvisible:
            return CGPoint(x: 0.5, y: 0.5)
        default:
            return CGPoint(x: 0.5, y: 0.5)
        }
    }
}

//본 코드 시작

class MoreNMapViewController: UIViewController,NMapViewDelegate, NMapPOIdataOverlayDelegate, NMapLocationManagerDelegate, MMapReverseGeocoderDelegate {
    
    var mapView: NMapView?
    

    
    
    //현재위치
    var changeStateButton: UIButton?
    
    enum state {
        case disabled
        case tracking
        case trackingWithHeading
    }
    
    var currentState: state = .disabled
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView = NMapView(frame: self.view.frame)
        self.navigationController?.navigationBar.isTranslucent = false
        
        if let mapView = mapView {
            // set the delegate for map view
            mapView.delegate = self
            //주소 표시하기
            mapView.reverseGeocoderDelegate = self
            
            // set the application api key for Open MapViewer Library
            mapView.setClientId("w1PKeXUIDhM6E2GqUmgR")
            mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            view.addSubview(mapView)
        }
        
        //현재위치 표시하기
        changeStateButton = createButton()
        
        if let button = changeStateButton {
            view.addSubview(button)
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        if view.frame.size.width != size.width {
            if let mapView = mapView, mapView.isAutoRotateEnabled {
                mapView.setAutoRotateEnabled(false, animate: false)
                
                coordinator.animate(alongsideTransition: {(context: UIViewControllerTransitionCoordinatorContext) -> Void in
                    if let mapView = self.mapView {
                        mapView.setAutoRotateEnabled(true, animate: false)
                    }
                }, completion: nil)
                
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        mapView?.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        mapView?.viewWillAppear()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        mapView?.viewDidDisappear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        mapView?.viewDidAppear()
        
        //주소 표시하기
        requestAddressByCoordination(NGeoPoint(longitude: 126.978371, latitude: 37.5666091))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        mapView?.viewWillDisappear()
        
        stopLocationUpdating()
    }

    
    
    
    
    
    // MARK: - NMapViewDelegate Methods
    
    open func onMapView(_ mapView: NMapView!, initHandler error: NMapError!) {
        if (error == nil) { // success
            // set map center and level
            mapView.setMapCenter(NGeoPoint(longitude:126.978371, latitude:37.5666091), atLevel:11)
            // set for retina display
            mapView.setMapEnlarged(true, mapHD: true)
            // set map mode : vector/satelite/hybrid
            mapView.mapViewMode = .vector
        } else { // fail
            print("onMapView:initHandler: \(error.description)")
        }
    }
    
    open func onMapView(_ mapView: NMapView!, touchesEnded touches: Set<AnyHashable>!, with event: UIEvent!) {
        
        if let touch = event.allTouches?.first {
            // Get the specific point that was touched
            let scrPoint = touch.location(in: mapView)
            
            print("scrPoint: \(scrPoint)")
            print("to: \(mapView.fromPoint(scrPoint))")
            requestAddressByCoordination(mapView.fromPoint(scrPoint))
        }
    }
    
  

    
    // MARK: - NMapPOIdataOverlayDelegate
    
    open func onMapOverlay(_ poiDataOverlay: NMapPOIdataOverlay!, imageForOverlayItem poiItem: NMapPOIitem!, selected: Bool) -> UIImage! {
        return NMapViewResources.imageWithType(poiItem.poiFlagType, selected: selected); //;붙임 갑자기(주소)
    }
    
    open func onMapOverlay(_ poiDataOverlay: NMapPOIdataOverlay!, anchorPointWithType poiFlagType: NMapPOIflagType) -> CGPoint {
        return NMapViewResources.anchorPoint(withType: poiFlagType)
    }
    
    open func onMapOverlay(_ poiDataOverlay: NMapPOIdataOverlay!, calloutOffsetWithType poiFlagType: NMapPOIflagType) -> CGPoint {
        return CGPoint.zero
    }
    
    open func onMapOverlay(_ poiDataOverlay: NMapPOIdataOverlay!, imageForCalloutOverlayItem poiItem: NMapPOIitem!, constraintSize: CGSize, selected: Bool, imageForCalloutRightAccessory: UIImage!, calloutPosition: UnsafeMutablePointer<CGPoint>!, calloutHit calloutHitRect: UnsafeMutablePointer<CGRect>!) -> UIImage! {
        return nil
    }
    
    
    // MARK: - MMapReverseGeocoderDelegate Methods
    
    open func location(_ location: NGeoPoint, didFind placemark: NMapPlacemark!) {
        let address = placemark.address
        
        self.title = address
        
        let alert = UIAlertController(title: "ReverseGeocoder", message: address, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    open func location(_ location: NGeoPoint, didFailWithError error: NMapError!) {
        print("location:(\(location.longitude), \(location.latitude)) didFailWithError: \(error.description)")
    }
    
    // MARK: -
    
    func requestAddressByCoordination(_ point: NGeoPoint) {
        mapView?.findPlacemark(atLocation: point)
        setMarker(point)
    }
    
    let UserFlagType: NMapPOIflagType = NMapPOIflagTypeReserved + 1
    
    func setMarker(_ point: NGeoPoint) {
        
        clearOverlay()
        
        if let mapOverlayManager = mapView?.mapOverlayManager {
            
            // create POI data overlay
            if let poiDataOverlay = mapOverlayManager.newPOIdataOverlay() {
                
                poiDataOverlay.initPOIdata(1)
                
                poiDataOverlay.addPOIitem(atLocation: point, title: "마커 1", type: UserFlagType, iconIndex: 0, with: nil)
                
                poiDataOverlay.endPOIdata()
            }
        }
    }
    
    func clearOverlay() {
        if let mapOverlayManager = mapView?.mapOverlayManager {
            mapOverlayManager.clearOverlay()
        }
    }
    
    
    
    // MARK: - NMapLocationManagerDelegate Methods
    
    open func locationManager(_ locationManager: NMapLocationManager!, didUpdateTo location: CLLocation!) {
        
        let coordinate = location.coordinate
        
        let myLocation = NGeoPoint(longitude: coordinate.longitude, latitude: coordinate.latitude)
        let locationAccuracy = Float(location.horizontalAccuracy)
        
        mapView?.mapOverlayManager.setMyLocation(myLocation, locationAccuracy: locationAccuracy)
        mapView?.setMapCenter(myLocation)
    }
    
    open func locationManager(_ locationManager: NMapLocationManager!, didFailWithError errorType: NMapLocationManagerErrorType) {
        
        var message: String = ""
        
        switch errorType {
        case .unknown: fallthrough
        case .canceled: fallthrough
        case .timeout:
            message = "일시적으로 내위치를 확인 할 수 없습니다."
        case .denied:
            message = "위치 정보를 확인 할 수 없습니다.\n사용자의 위치 정보를 확인하도록 허용하시려면 위치서비스를 켜십시오."
        case .unavailableArea:
            message = "현재 위치는 지도내에 표시할 수 없습니다."
        case .heading:
            message = "나침반 정보를 확인 할 수 없습니다."
        }
        
        if (!message.isEmpty) {
            let alert = UIAlertController(title:"NMapViewer", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:"OK", style:.default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        
        if let mapView = mapView, mapView.isAutoRotateEnabled {
            mapView.setAutoRotateEnabled(false, animate: true)
        }
    }
    
    func locationManager(_ locationManager: NMapLocationManager!, didUpdate heading: CLHeading!) {
        let headingValue = heading.trueHeading < 0.0 ? heading.magneticHeading : heading.trueHeading
        setCompassHeadingValue(headingValue)
    }
    
    func onMapViewIsGPSTracking(_ mapView: NMapView!) -> Bool {
        return NMapLocationManager.getSharedInstance().isTrackingEnabled()
    }
    
    func findCurrentLocation() {
        enableLocationUpdate()
    }
    
    func setCompassHeadingValue(_ headingValue: Double) {
        
        if let mapView = mapView, mapView.isAutoRotateEnabled {
            mapView.setRotateAngle(Float(headingValue), animate: true)
        }
    }
    
    func stopLocationUpdating() {
        
        disableHeading()
        disableLocationUpdate()
    }
    
    
    //일단 아이콘 붙여둠
    open static func imageWithType(_ poiFlagType: NMapPOIflagType, selected: Bool) -> UIImage? {
        switch poiFlagType {
        case NMapPOIflagTypeLocation:
            return #imageLiteral(resourceName: "pubtrans_ic_mylocation_on")
        case NMapPOIflagTypeLocationOff:
            return #imageLiteral(resourceName: "pubtrans_ic_mylocation_off")
        case NMapPOIflagTypeCompass:
            return #imageLiteral(resourceName: "ic_angle")
        //case UserPOIflagTypeDefault:
            //return #imageLiteral(resourceName: "pubtrans_exact_default")
        //case UserPOIflagTypeInvisible:
            //return #imageLiteral(resourceName: "1px_dot")
        default:
            return nil
        }
    }
    
    
    
    // MARK: - My Location
    
    func enableLocationUpdate() {
        
        if let lm = NMapLocationManager.getSharedInstance() {
            
            if lm.locationServiceEnabled() == false {
                locationManager(lm, didFailWithError: .denied)
                return
            }
            
            if lm.isUpdateLocationStarted() == false {
                // set delegate
                lm.setDelegate(self)
                // start updating location
                lm.startContinuousLocationInfo()
            }
        }
    }
    
    func disableLocationUpdate() {
        
        if let lm = NMapLocationManager.getSharedInstance() {
            
            if lm.isUpdateLocationStarted() {
                // start updating location
                lm.stopUpdateLocationInfo()
                // set delegate
                lm.setDelegate(nil)
            }
        }
        
        mapView?.mapOverlayManager.clearMyLocationOverlay()
    }
    
    
    // MARK: - Compass
    
    func enableHeading() -> Bool {
        
        if let lm = NMapLocationManager.getSharedInstance() {
            
            let isAvailableCompass = lm.headingAvailable()
            
            if isAvailableCompass {
                
                mapView?.setAutoRotateEnabled(true, animate: true)
                
                lm.startUpdatingHeading()
            } else {
                return false
            }
        }
        
        return true;
    }
    
    func disableHeading() {
        if let lm = NMapLocationManager.getSharedInstance() {
            
            let isAvailableCompass = lm.headingAvailable()
            
            if isAvailableCompass {
                lm.stopUpdatingHeading()
            }
        }
        
        mapView?.setAutoRotateEnabled(false, animate: true)
    }
    
    // MARK: - Button Control
    
    func createButton() -> UIButton? {
        
        let button = UIButton(type: .custom)
        
        button.frame = CGRect(x: 15, y: 30, width: 36, height: 36)
        button.setImage(#imageLiteral(resourceName: "v4_btn_navi_location_normal"), for: .normal)
        
        button.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
        
        //button.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
        
        return button
    }
    
    @objc func buttonClicked(_ sender: UIButton!) {
        
        if let lm = NMapLocationManager.getSharedInstance() {
            
            switch currentState {
            case .disabled:
                enableLocationUpdate()
                updateState(.tracking)
            case .tracking:
                let isAvailableCompass = lm.headingAvailable()
                
                if isAvailableCompass {
                    enableLocationUpdate()
                    if enableHeading() {
                        updateState(.trackingWithHeading)
                    }
                } else {
                    stopLocationUpdating()
                    updateState(.disabled)
                }
            case .trackingWithHeading:
                stopLocationUpdating()
                updateState(.disabled)
            }
        }
    }
    
    func updateState(_ newState: state) {
        
        currentState = newState
        
        switch currentState {
        case .disabled:
            changeStateButton?.setImage(#imageLiteral(resourceName: "v4_btn_navi_location_normal"), for: .normal)
        case .tracking:
            changeStateButton?.setImage(#imageLiteral(resourceName: "v4_btn_navi_location_selected"), for: .normal)
        case .trackingWithHeading:
            changeStateButton?.setImage(#imageLiteral(resourceName: "v4_btn_navi_location_my"), for: .normal)
        }
    }
    
}

   
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

