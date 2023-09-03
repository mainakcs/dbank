  import { dbank_backend } from "../../declarations/dbank_backend";
  window.addEventListener("load", async function () {
    // console.log("finish loading");
    update();
  });

  document.querySelector("form").addEventListener("submit", async function(event) {
    event.preventDefault();
    console.log("Submitted.");

    const button = event.target.querySelector("#submit-btn");

    const inputAmount = parseFloat(document.getElementById("input-amount").value);
    const outputAmount = parseFloat(document.getElementById("withdrawal-amount").value);

    button.setAttribute("disabled",true); // Here disables the finalize button 

    if (document.getElementById("input-amount").value.length != 0) {
      await dbank_backend.topUp(inputAmount);
    }
    
    await dbank_backend.withdraw(outputAmount);

    update();

    document.getElementById("input-amount").value=""; // resets the value of the 
    document.getElementById("withdrawal-amount").value = "";

    await dbank_backend.compound();

    button.removeAttribute("disabled"); // Here again enables the finalize button, after the new currentValue is set

  }); 

  async function update() {
    const currentAmount = await dbank_backend.checkBalance();
    document.getElementById("value").innerText = Math.round(currentAmount * 100) /100;
  }