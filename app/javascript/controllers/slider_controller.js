import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="slider"
export default class extends Controller {
   static targets = ["minvalue", "maxvalue", "input"]
  connect() {
      // console.log("Hello wine slider!");
  }

  updatePrice(e) {
    let arraySave = [];
    this.inputTargets.forEach((input) => {
      arraySave.push(input.value);
    });
    let minPrice = parseInt(arraySave[0]);
    let maxPrice = parseInt(arraySave[1]);

    if (minPrice > maxPrice) {
      // Swap to Values
      let tempValue = maxPrice;
      maxPrice = minPrice;
      minPrice = tempValue;
    }
    this.minvalueTarget.innerText = minPrice + " €";
    this.maxvalueTarget.innerText = maxPrice + " €";
  }
}
