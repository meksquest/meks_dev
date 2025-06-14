defmodule MeksDevWeb.PortfolioLive do
  use MeksDevWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, active_section: "hero")}
  end

  def handle_event("navigate_to_section", %{"section" => section}, socket) do
    {:noreply, assign(socket, active_section: section)}
  end

  def render(assigns) do
    ~H"""
    <div class="min-h-screen bg-journal-cream paper-texture relative overflow-x-hidden">
      <!-- Journal Tabs Navigation - Desktop -->
      <.journal_tabs active_section={@active_section} />
      
    <!-- Mobile Navigation -->
      <div class="lg:hidden fixed top-4 right-4 z-50">
        <button class="bg-journal-white border-journal-charcoal border-2 rounded p-2">
          <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path
              stroke-linecap="round"
              stroke-linejoin="round"
              stroke-width="2"
              d="M4 6h16M4 12h16M4 18h16"
            >
            </path>
          </svg>
        </button>
      </div>
      
    <!-- Hero Section -->
      <section id="hero" class="min-h-screen flex items-center justify-center px-4 relative">
        <div class="text-center max-w-4xl mx-auto relative z-10">
          <h1 class="handwritten-bold text-7xl md:text-9xl text-journal-charcoal mb-6 text-write">
            Meks McClure
          </h1>
          <p class="text-xl md:text-2xl text-journal-gray mb-4 text-write">
            (they/them)
          </p>
          <h2 class="text-2xl md:text-3xl text-journal-charcoal mb-8 text-write">
            Developer • Artist • Problem Solver
          </h2>
          <p class="text-lg md:text-xl text-journal-gray max-w-2xl mx-auto leading-relaxed text-write mb-8">
            Elixir & Phoenix specialist who brings artistic sensibility to code architecture and user experience design.
          </p>
          
    <!-- Quick Contact Links -->
          <div class="flex justify-center gap-8 text-write">
            <a
              href="mailto:meks@example.com"
              class="flex items-center gap-2 text-journal-charcoal hover:text-journal-gray transition-colors organic-hover group"
            >
              <span class="handwritten text-lg">📧 Email</span>
            </a>
            <a
              href="#"
              class="flex items-center gap-2 text-journal-charcoal hover:text-journal-gray transition-colors organic-hover group"
            >
              <span class="handwritten text-lg">💼 LinkedIn</span>
            </a>
            <a
              href="#"
              class="flex items-center gap-2 text-journal-charcoal hover:text-journal-gray transition-colors organic-hover group"
            >
              <span class="handwritten text-lg">🐙 GitHub</span>
            </a>
          </div>
        </div>
      </section>
      
    <!-- About Section -->
      <section id="about" class="py-20 px-4 relative">
        <div class="max-w-4xl mx-auto">
          <h2 class="handwritten-bold text-4xl md:text-5xl text-journal-charcoal mb-12 text-center">
            About
          </h2>

          <div class="grid md:grid-cols-2 gap-12">
            <div class="sketchy-border p-8 ink-bleed organic-hover">
              <h3 class="handwritten text-2xl text-journal-charcoal mb-6">Professional</h3>
              <p class="text-journal-gray leading-relaxed mb-4">
                Passionate Elixir & Phoenix developer with expertise in building scalable, real-time applications.
                I specialize in LiveView, functional programming, and creating elegant solutions to complex problems.
              </p>
              <p class="text-journal-gray leading-relaxed">
                Active in LGBTQIA+ leadership and mentoring, helping grow the next generation of developers
                through inclusive practices and community building.
              </p>
            </div>

            <div class="sketchy-border p-8 ink-bleed organic-hover">
              <h3 class="handwritten text-2xl text-journal-charcoal mb-6">Beyond the Code</h3>
              <ul class="text-journal-gray space-y-2">
                <li class="flex items-center gentle-wobble">
                  <span class="mr-3">☕</span>
                  <span>Tea enthusiast (Earl Grey is ♥️)</span>
                </li>
                <li class="flex items-center gentle-wobble">
                  <span class="mr-3">📔</span>
                  <span>Journal keeper & analog lover</span>
                </li>
                <li class="flex items-center gentle-wobble">
                  <span class="mr-3">🐦‍⬛</span>
                  <span>Crow enthusiast & nature observer</span>
                </li>
                <li class="flex items-center gentle-wobble">
                  <span class="mr-3">♿</span>
                  <span>Accessibility advocate</span>
                </li>
              </ul>
            </div>
          </div>
        </div>
      </section>
      
    <!-- Footer -->
      <footer class="py-12 px-4 border-t border-journal-gray-lighter">
        <div class="max-w-4xl mx-auto text-center">
          <p class="text-journal-gray mb-2">
            Built by Meks • Powered by Elixir/Phoenix • Hosted on Fly.io
          </p>
          <p class="handwritten text-journal-charcoal">
            Made with care and lots of tea ❤️
          </p>
        </div>
      </footer>
    </div>
    """
  end

  defp journal_tabs(assigns) do
    ~H"""
    <div class="hidden lg:block fixed right-8 top-1/2 transform -translate-y-1/2 z-40">
      <div class="flex flex-col space-y-2">
        <%= for {tab_id, label} <- [{"hero", "Start"}, {"about", "About"}, {"projects", "Work"}, {"speaking", "Talks"}, {"writing", "Words"}] do %>
          <button
            phx-click="navigate_to_section"
            phx-value-section={tab_id}
            class={[
              "handwritten text-lg px-6 py-4 transform transition-all duration-300 hover:scale-105 relative journal-tab shadow-md hover:shadow-lg",
              if(@active_section == tab_id,
                do: "bg-journal-charcoal text-journal-white shadow-lg",
                else: "bg-journal-white hover:bg-journal-cream text-journal-charcoal hover:shadow-xl"
              )
            ]}
            style={if @active_section == tab_id, do: "transform: translateX(-8px);", else: ""}
          >
            <span class="relative z-10">{label}</span>
          </button>
        <% end %>
      </div>
    </div>
    """
  end
end
