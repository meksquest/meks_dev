let Hooks = {}

Hooks.ScrollSpy = {
  mounted() {
    this.handleScroll = this.handleScroll.bind(this)
    window.addEventListener('scroll', this.handleScroll)

    this.handleEvent("scroll_to_section", ({ section }) => {
      const element = document.getElementById(section)
      if (element) {
        element.scrollIntoView({ behavior: 'smooth' })
      }
    })
  },

  destroyed() {
    window.removeEventListener('scroll', this.handleScroll)
  },

  handleScroll() {
    const sections = ['hero', 'about', 'projects', 'speaking', 'writing']
    const current = sections.find(section => {
      const element = document.getElementById(section)
      if (element) {
        const rect = element.getBoundingClientRect()
        return rect.top <= 100 && rect.bottom >= 100
      }
      return false
    })

    if (current) {
      this.pushEvent("section_in_view", { section: current })
    }
  }
}

export default Hooks
