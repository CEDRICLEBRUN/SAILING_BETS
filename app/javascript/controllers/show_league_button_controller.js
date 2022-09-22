import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button", "link"]

  show() {
    this.buttonTarget.classList.toggle("league-choice");
    this.linkTarget.classList.toggle("hidden");
  }

}
