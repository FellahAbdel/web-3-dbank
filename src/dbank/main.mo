import Debug "mo:base/Debug";
import Time "mo:base/Time";
import Float "mo:base/Float"


actor DBank {
    stable var startTime : Int = Time.now();
    // Debug.print(debug_show(startTime));
    stable var currentValue : Float = 3000;
    // currentValue := 3500;

    // Debug.print(debug_show(currentValue));

    public func topUp(amount: Float){
        currentValue += amount;
        // Debug.print(debug_show(currentValue));
    };

    public func withdraw(amount: Float){
        var temp : Float = currentValue - amount;
        if(temp >= 0){
            currentValue -= amount;
            Debug.print(debug_show(currentValue));
        }else {
            Debug.print("Amount too high, cannot withdraw");
        }
    };

    public query func checkBalance():async Float {
        return currentValue;
    };
    public func compound(){
        let currentTime : Int = Time.now();
        let timeElapsedNS : Int = currentTime - startTime;
        let timeElapsedS : Int = timeElapsedNS / 1000000000;
        currentValue := currentValue* ( 1.01 ** Float.fromInt(timeElapsedS));
        startTime := currentTime;
        // Debug.print(debug_show(timeElapsedS));
    }
}
