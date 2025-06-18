let Hooks = {}

Hooks.ScrollSpy = {
  mounted() {
    this.handleScroll = this.handleScroll.bind(this)
    this.scrollSpyEnabled = true
    window.addEventListener('scroll', this.handleScroll)

    this.handleEvent("scroll_to_section", ({ section, disable_spy }) => {
      const element = document.getElementById(section)
      if (element) {
        // Temporarily disable scroll spy during navigation
        if (disable_spy) {
          this.scrollSpyEnabled = false
        }
        
        element.scrollIntoView({ behavior: 'smooth' })
        
        // Re-enable scroll spy after scroll animation completes
        if (disable_spy) {
          setTimeout(() => {
            this.scrollSpyEnabled = true
            this.pushEvent("enable_scroll_spy", {})
          }, 1000) // Wait for scroll animation to complete
        }
      }
    })
  },

  destroyed() {
    window.removeEventListener('scroll', this.handleScroll)
  },

  handleScroll() {
    if (!this.scrollSpyEnabled) return
    
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
