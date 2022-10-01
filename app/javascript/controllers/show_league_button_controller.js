import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button", "link"]

  show() {
    console.log(this.linkTarget)
    this.buttonTarget.classList.toggle("league-choice");
    this.linkTarget.classList.toggle("hidden");
  }

}
