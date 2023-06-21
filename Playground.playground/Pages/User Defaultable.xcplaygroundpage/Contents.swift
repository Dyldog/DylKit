import UIKit
import DylKit

//: Step 1: Create a `String`-based enum that conforms to `DefaultsKey`

enum Default: String, DefaultsKey {
    case thing = "THING"
}

//: Step 2: Define variables for your defaults values and mark them with the `UserDefaultable` property wrapper, providing the corresponding key from the enum you defined previously. The initial value you provide will be used when there is no stored value.

struct DefaultsTester {
    @UserDefaultable(key: Default.thing) var thing: String = "Hello"
}


//: Step 3: Use the variable as you would any other and it will be persisted in `UserDefaults` (by default. Provide another store to the property wrapper to use that instead).

var defaults = DefaultsTester()

defaults.thing

defaults.thing = "Byeee"

defaults.thing
