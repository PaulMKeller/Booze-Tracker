//
//  SettingsViewController.swift
//  Booze Tracker
//
//  Created by Paul Keller on 30/11/2015.
//  Copyright © 2015 Planet K Games. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var pickerData: [String] = [String]()
    @IBOutlet var pickerView: UIPickerView!
    var sessionPriceList: PriceList = PriceList(useZero: false)
    
    @IBOutlet var beer: UITextField!
    @IBOutlet var redWine: UITextField!
    @IBOutlet var whiteWine: UITextField!
    @IBOutlet var spirit: UITextField!
    @IBOutlet var shots: UITextField!
    @IBOutlet var cocktail: UITextField!
    @IBOutlet var bubbles: UITextField!
    @IBOutlet var softDrink: UITextField!
    @IBOutlet var coffeeTea: UITextField!
    @IBOutlet var barSnacks: UITextField!
    @IBOutlet var liteBites: UITextField!
    @IBOutlet var bigFood: UITextField!
    @IBOutlet var currencySymbol: UITextField!
    @IBOutlet var currency: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //CreateCurrencyArray()
        pickerData = ["$", "£", "€", "¥", "inr", "Other"]
        SetupPickerData()
        
        FormLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // The number of columns of data
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return  pickerData[row]
    }
    
    
    func SetupPickerData(){
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
    }
    
    func FormLoad(){
        beer.text = String(sessionPriceList.beer)
        redWine.text = String(sessionPriceList.redWine)
        whiteWine.text = String(sessionPriceList.whiteWine)
        spirit.text = String(sessionPriceList.spirit)
        shots.text = String(sessionPriceList.shots)
        cocktail.text = String(sessionPriceList.cocktail)
        bubbles.text = String(sessionPriceList.bubbles)
        softDrink.text = String(sessionPriceList.softDrink)
        coffeeTea.text = String(sessionPriceList.coffeeTea)
        barSnacks.text = String(sessionPriceList.barSnacks)
        liteBites.text = String(sessionPriceList.liteBites)
        bigFood.text = String(sessionPriceList.mainMeal)
        currency.text = sessionPriceList.currency
    }
    
    func CreateCurrencyArray(){
        pickerData = [
            "Albania Lek (ALL): Lek",
            "Afghanistan Afghani (AFN): ؋",
            "Argentina Peso (ARS): $",
            "Aruba Guilder (AWG): ƒ",
            "Australia Dollar (AUD): $",
            "Azerbaijan New Manat (AZN): ман",
            "Bahamas Dollar (BSD): $",
            "Barbados Dollar (BBD): $",
            "Belarus Ruble (BYR): p.",
            "Belize Dollar (BZD): BZ$",
            "Bermuda Dollar (BMD): $",
            "Bolivia Boliviano (BOB): $b",
            "Bosnia and Herzegovina Convertible Marka (BAM): KM",
            "Botswana Pula (BWP): P",
            "Bulgaria Lev (BGN): лв",
            "Brazil Real (BRL): R$",
            "Brunei Darussalam Dollar (BND): $",
            "Cambodia Riel (KHR): ៛",
            "Canada Dollar (CAD): $",
            "Cayman Islands Dollar (KYD): $",
            "Chile Peso (CLP): $",
            "China Yuan Renminbi (CNY): ¥",
            "Colombia Peso (COP): $",
            "Costa Rica Colon (CRC): ₡",
            "Croatia Kuna (HRK): kn",
            "Cuba Peso (CUP): ₱",
            "Czech Republic Koruna (CZK): Kč",
            "Denmark Krone (DKK): kr",
            "Dominican Republic Peso (DOP): RD$",
            "East Caribbean Dollar (XCD): $",
            "Egypt Pound (EGP): £",
            "El Salvador Colon (SVC): $",
            "Euro Member Countries (EUR): €",
            "Falkland Islands (Malvinas) Pound (FKP): £",
            "Fiji Dollar (FJD): $",
            "Ghana Cedi (GHS): ¢",
            "Gibraltar Pound (GIP): £",
            "Guatemala Quetzal (GTQ): Q",
            "Guernsey Pound (GGP): £",
            "Guyana Dollar (GYD): $",
            "Honduras Lempira (HNL): L",
            "Hong Kong Dollar (HKD): $",
            "Hungary Forint (HUF): Ft",
            "Iceland Krona (ISK): kr",
            "India Rupee (INR): inr",
            "Indonesia Rupiah (IDR): Rp",
            "Iran Rial (IRR): ﷼",
            "Isle of Man Pound (IMP): £",
            "Israel Shekel (ILS): ₪",
            "Jamaica Dollar (JMD): J$",
            "Japan Yen (JPY): ¥",
            "Jersey Pound (JEP): £",
            "Kazakhstan Tenge (KZT): лв",
            "Korea (North) Won (KPW): ₩",
            "Korea (South) Won (KRW): ₩",
            "Kyrgyzstan Som (KGS): лв",
            "Laos Kip (LAK): ₭",
            "Lebanon Pound (LBP): £",
            "Liberia Dollar (LRD): $",
            "Macedonia Denar (MKD): ден",
            "Malaysia Ringgit (MYR): RM",
            "Mauritius Rupee (MUR): ₨",
            "Mexico Peso (MXN): $",
            "Mongolia Tughrik (MNT): ₮",
            "Mozambique Metical (MZN): MT",
            "Namibia Dollar (NAD): $",
            "Nepal Rupee (NPR): ₨",
            "Netherlands Antilles Guilder (ANG): ƒ",
            "New Zealand Dollar (NZD): $",
            "Nicaragua Cordoba (NIO): C$",
            "Nigeria Naira (NGN): ₦",
            "Korea (North) Won (KPW): ₩",
            "Norway Krone (NOK): kr",
            "Oman Rial (OMR): ﷼",
            "Pakistan Rupee (PKR): ₨",
            "Panama Balboa (PAB): B/.",
            "Paraguay Guarani (PYG): Gs",
            "Peru Nuevo Sol (PEN): S/.",
            "Philippines Peso (PHP): ₱",
            "Poland Zloty (PLN): zł",
            "Qatar Riyal (QAR): ﷼",
            "Romania New Leu (RON): lei",
            "Russia Ruble (RUB): руб",
            "Saint Helena Pound (SHP): £",
            "Saudi Arabia Riyal (SAR): ﷼",
            "Serbia Dinar (RSD): Дин.",
            "Seychelles Rupee (SCR): ₨",
            "Singapore Dollar (SGD): $",
            "Solomon Islands Dollar (SBD): $",
            "Somalia Shilling (SOS): S",
            "South Africa Rand (ZAR): R",
            "Korea (South) Won (KRW): ₩",
            "Sri Lanka Rupee (LKR): ₨",
            "Sweden Krona (SEK): kr",
            "Switzerland Franc (CHF): CHF",
            "Suriname Dollar (SRD): $",
            "Syria Pound (SYP): £",
            "Taiwan New Dollar (TWD): NT$",
            "Thailand Baht (THB): ฿",
            "Trinidad and Tobago Dollar (TTD): TT$",
            "Turkey Lira (TRY): try",
            "Tuvalu Dollar (TVD): $",
            "Ukraine Hryvnia (UAH): ₴",
            "United Kingdom Pound (GBP): £",
            "United States Dollar (USD): $",
            "Uruguay Peso (UYU): $U",
            "Uzbekistan Som (UZS): лв",
            "Venezuela Bolivar (VEF): Bs",
            "Viet Nam Dong (VND): ₫",
            "Yemen Rial (YER): ﷼",
            "Zimbabwe Dollar (ZWD): Z$"
        ]
    }
    
}
