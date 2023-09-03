import Debug "mo:base/Debug";    // To use print function, Debug library is used, which is at mo:base/Debug
import Time "mo:base/Time";
import Float "mo:base/Float";

actor DBank {
  stable var currentValue :Float = 100.54554; // var keyword is used to intilize the value of a variable.
  // currentValue := 300; // if you want to change the value of the variable you need to use := operator instead of =
  Debug.print(debug_show(currentValue));

  stable var startTime = Time.now();
  startTime := Time.now();
  Debug.print(debug_show(startTime));

  public func topUp(amount: Float) {
    currentValue += amount;
    Debug.print(debug_show(currentValue));
  };

  public func withdraw(amount: Float) {    // Update function goes through the blockchain, so takes time
    let tempValue: Float = currentValue - amount;
    if (tempValue>=0) {
      currentValue -=amount;
      Debug.print(debug_show(currentValue));
    }
    else {
      Debug.print("Entered number is larger than the sum present in the the currentValue");
    }
  };

  public query func checkBalance(): async Float{  // Query function does not change the data, does not go through the blockchian, so very fast
    return currentValue;
  };


  public func compound() {
    let currentTime = Time.now();
    var timeElapsedN = (currentTime-startTime);
    var timeElapsed = timeElapsedN/(1000000000);
    Debug.print(debug_show(timeElapsed));
    currentValue := currentValue * (1.01 )** Float.fromInt(timeElapsed);
    startTime := currentTime;
  };
  
}

