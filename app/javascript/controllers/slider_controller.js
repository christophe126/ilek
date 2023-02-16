import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="slider"
export default class extends Controller {
   static targets = ["minvalue", "maxvalue", "input"]
  connect() {
    //console.log(window.location.href);
    let url = new URL(window.location.href);
    if (url.search) {
      let pmin = url.searchParams.get("pxmin");
      let pmax = url.searchParams.get("pxmax");
      this.minvalueTarget.innerText = pmin + " €";
      this.maxvalueTarget.innerText = pmax + " €";
      this.inputTargets[0].value = pmin;
      this.inputTargets[1].value = pmax;
    }
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
