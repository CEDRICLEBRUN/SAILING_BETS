import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["info"]

  close() {
    this.infoTarget.classList.toggle("hidden")
  }

}
