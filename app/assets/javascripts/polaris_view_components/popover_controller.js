import { Controller } from "@hotwired/stimulus"
import { createPopper } from "@popperjs/core/dist/esm"

export default class extends Controller {
  static targets = ["activator", "popover"]
  static classes = ["open", "closed"]
  static values = {
    placement: String,
    active: Boolean
  }

  connect() {
    createPopper(this.activatorTarget, this.popoverTarget, {
      placement: this.placementValue,
      modifiers: [
        {
          name: 'offset',
          options: {
            offset: [0, 5],
          },
        },
      ]
    })
    if (this.activeValue) {
      this.show()
    }
  }

  toggle() {
    this.popoverTarget.classList.toggle(this.closedClass)
    this.popoverTarget.classList.toggle(this.openClass)
  }

  show() {
    this.popoverTarget.classList.remove(this.closedClass)
    this.popoverTarget.classList.add(this.openClass)
  }

  hide(event) {
    if (!this.element.contains(event.target) && !this.popoverTarget.classList.contains(this.closedClass)) {
      this.popoverTarget.classList.remove(this.openClass)
      this.popoverTarget.classList.add(this.closedClass)
    }
  }
}
