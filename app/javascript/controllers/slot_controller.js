import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { day: Number, hour: Number, toggleUrl: String }

  async toggle() {
    const response = await fetch(this.toggleUrlValue, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
        "Accept": "text/vnd.turbo-stream.html"
      },
      body: JSON.stringify({
        day_of_week: this.dayValue,
        hour:        this.hourValue
      })
    })

    const html = await response.text()
    Turbo.renderStreamMessage(html)
  }
}
