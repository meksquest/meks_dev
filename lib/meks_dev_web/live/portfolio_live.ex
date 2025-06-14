defmodule MeksDevWeb.PortfolioLive do
  use MeksDevWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, active_section: "hero")}
  end

  def handle_event("navigate_to_section", %{"section" => section}, socket) do
    {:noreply,
     socket
     |> assign(active_section: section)
     |> push_event("scroll_to_section", %{section: section})}
  end

  def handle_event("section_in_view", %{"section" => section}, socket) do
    {:noreply, assign(socket, active_section: section)}
  end

  def render(assigns) do
    ~H"""
    <div
      class="min-h-screen bg-journal-cream paper-texture relative overflow-x-hidden"
      phx-hook="ScrollSpy"
      id="portfolio-container"
    >
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
            meks.dev
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
              href="mailto:mmcclure0100@gmail.com"
              class="flex items-center gap-2 text-journal-charcoal hover:text-journal-gray transition-colors organic-hover group"
            >
              <span class="handwritten text-lg">📧 Email</span>
            </a>
            <a
              href="https://www.linkedin.com/in/meksmcclure/"
              class="flex items-center gap-2 text-journal-charcoal hover:text-journal-gray transition-colors organic-hover group"
            >
              <span class="handwritten text-lg">💼 LinkedIn</span>
            </a>
            <a
              href="https://github.com/MMcClure11"
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
                Passionate developer with expertise in building scalable, real-time applications.
                I specialize in LiveView with Phoenix and Elixir, functional programming, and creating elegant solutions to complex problems.
              </p>
              <p class="text-journal-gray leading-relaxed">
                Active in LGBTQIA+ leadership, helping grow the next generation of developers
                through inclusive practices, community building, and education.
              </p>
            </div>

            <div class="sketchy-border p-8 ink-bleed organic-hover">
              <h3 class="handwritten text-2xl text-journal-charcoal mb-6">Beyond the Code</h3>
              <ul class="text-journal-gray space-y-2">
                <li class="flex items-center gentle-wobble">
                  <span class="mr-3">☕</span>
                  <span>Tea enthusiast (matcha is ♥️)</span>
                </li>
                <li class="flex items-center gentle-wobble">
                  <span class="mr-3">🎨</span>
                  <span>Journal destroyer & ink consumer</span>
                </li>
                <li class="flex items-center gentle-wobble">
                  <span class="mr-3">🗺️</span>
                  <span>Traveler</span>
                </li>
              </ul>
            </div>
          </div>
        </div>
      </section>
      
    <!-- Projects Section -->
      <section id="projects" class="py-20 px-4 relative">
        <div class="max-w-6xl mx-auto">
          <h2 class="handwritten-bold text-4xl md:text-5xl text-journal-charcoal mb-12 text-center">
            Projects
          </h2>

          <div class="grid md:grid-cols-2 gap-12 mb-12">
            <div class="sketchy-border p-8 ink-bleed organic-hover">
              <h3 class="handwritten-bold text-3xl text-journal-charcoal mb-4">Quenta</h3>
              <p class="text-journal-gray mb-4">
                Expense sharing app prototyped with Elixir/Phoenix, and built with Svelt.
              </p>
              <div class="w-full h-48 bg-journal-cream border border-journal-gray-light flex items-center justify-center mb-6 gentle-wobble">
                <span class="text-journal-gray handwritten">Screenshot Coming Soon</span>
              </div>
              <div class="flex flex-wrap gap-3 mb-4">
                <span class="sketchy-tech-badge">Elixir</span>
                <span class="sketchy-tech-badge">Phoenix</span>
                <span class="sketchy-tech-badge">LiveView</span>
                <span class="sketchy-tech-badge">PostgreSQL</span>
              </div>
              <div class="flex gap-4">
                <a
                  href="https://github.com/MMcClure11/quenta/tree/main/elixir"
                  class="organic-hover text-journal-charcoal hover:text-journal-gray transition-colors handwritten"
                >
                  Elixir Prototype GitHub
                </a>
                <a
                  href="https://ex.quenta.pro/"
                  class="organic-hover text-journal-charcoal hover:text-journal-gray transition-colors handwritten"
                >
                  Elixir Prototype Live
                </a>
              </div>
            </div>

            <div class="sketchy-border p-8 ink-bleed organic-hover">
              <h3 class="handwritten-bold text-3xl text-journal-charcoal mb-4">Bookshelf</h3>
              <p class="text-journal-gray mb-4">
                A virtual library of all the books you want to keep tabs on, those sneaky buggers tend to run off in search of adventure.
              </p>
              <div class="w-full h-48 bg-journal-cream border border-journal-gray-light flex items-center justify-center mb-6 gentle-wobble">
                <span class="text-journal-gray handwritten">Screenshot Coming Soon</span>
              </div>
              <div class="flex flex-wrap gap-3 mb-4">
                <span class="sketchy-tech-badge">Elixir</span>
                <span class="sketchy-tech-badge">Phoenix</span>
                <span class="sketchy-tech-badge">LiveView</span>
              </div>
              <div class="flex gap-4">
                <a
                  href="https://github.com/MMcClure11/bookshelf"
                  class="organic-hover text-journal-charcoal hover:text-journal-gray transition-colors handwritten"
                >
                  GitHub
                </a>
                <a
                  href="https://bookshelf-meks.fly.dev/"
                  class="organic-hover text-journal-charcoal hover:text-journal-gray transition-colors handwritten"
                >
                  Live
                </a>
              </div>
            </div>
          </div>

          <div class="text-center">
            <button class="sketchy-border px-6 py-3 bg-journal-white organic-hover handwritten text-lg text-journal-charcoal flex items-center gap-2 mx-auto">
              <span>☕</span> Buy me tea
            </button>
          </div>
        </div>
      </section>
      
    <!-- Speaking Section -->
      <section id="speaking" class="py-20 px-4 relative">
        <div class="max-w-5xl mx-auto">
          <h2 class="handwritten-bold text-4xl md:text-5xl text-journal-charcoal mb-12 text-center">
            Speaking
          </h2>

          <div class="flex flex-col gap-8">
            <.speaking_card
              conf="Goatmire Sept 10-12, 2025"
              title="Resiliency: On Designing Adaptable Code and Becoming a Flexible Engineer"
              location="Varberg, Sweden"
              announcement_link="https://goatmire.com/talk/resiliency-on-designing-adaptable-code-and-becoming-a-flexible-engineer"
              coming_soon?={true}
            />

            <.speaking_card
              conf="ElixirConf EU 2025"
              title="LT: Resilient Code, Resilient Engineer: Lessons from Changing Requirements"
              location="Krakow, Poland"
              video_link="https://www.youtube.com/watch?v=n2RQtPyCJt8"
            />

            <.speaking_card
              conf="ElixirConf EU 2024"
              title="The Bookshelf: Engage Your Users with LiveView and Tailwind CSS"
              location="Lisbon, Portugal"
              video_link="https://www.youtube.com/watch?v=lGfVYDyIY5c"
              slides_link="https://github.com/MMcClure11/bookshelf/files/15010688/The.Bookshelf.-.Meks.McClure.pdf"
            />

            <.speaking_card
              conf="ElixirConf US 2023"
              title="SVG Island: Building your own charts in LiveView"
              location="Orlando, Florida, USA"
              video_link="https://www.youtube.com/watch?v=YDYF8oAC2nE"
            />

            <.speaking_card
              conf="ElixirConf US 2022"
              title="How to Grow Your Own Juniors: A Guide to Mentoring in an Elixir Environment"
              location="Aurora, Colorado, USA"
              video_link="https://www.youtube.com/watch?v=NjFI46Yc2Sc"
              slides_link="https://speakerdeck.com/nkyllonen/how-to-grow-your-own-juniors-a-guide-to-mentoring-in-an-elixir-environment"
            />

            <.speaking_card
              conf="Elixir Wizards 2022"
              title="Meks McClure on Communication, Diversity, & Ergonomics"
              location="Remote"
              video_link="https://www.youtube.com/watch?v=jGN-eniKNP8"
            />
          </div>
        </div>
      </section>

      <section id="writing" class="py-20 px-4 relative">
        <div class="max-w-4xl mx-auto text-center">
          <h2 class="handwritten-bold text-4xl text-journal-charcoal mb-8">Writing</h2>
          <p class="text-journal-gray">Coming soon...</p>
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

  attr :conf, :string, default: ""
  attr :title, :string, default: ""
  attr :location, :string, default: ""
  attr :video_link, :string, default: ""
  attr :slides_link, :string, default: ""
  attr :announcement_link, :string, default: ""
  attr :coming_soon?, :boolean, default: false

  defp speaking_card(assigns) do
    ~H"""
    <div class="sketchy-border p-6 ink-bleed organic-hover">
      <h3 class="handwritten text-2xl text-journal-charcoal mb-2">{@conf}</h3>
      <h4 class="text-xl text-journal-gray mb-2">{@title}</h4>
      <p class="text-journal-gray mb-4">{@location}</p>
      <div class="flex gap-4">
        <a
          :if={@video_link != ""}
          href={@video_link}
          class="organic-hover text-journal-charcoal hover:text-journal-gray transition-colors handwritten"
        >
          📹 Video
        </a>
        <a
          :if={@slides_link != ""}
          href={@slides_link}
          class="organic-hover text-journal-charcoal hover:text-journal-gray transition-colors handwritten"
        >
          📊 Speaker Deck
        </a>
        <a
          :if={@announcement_link != ""}
          href={@announcement_link}
          class="organic-hover text-journal-charcoal hover:text-journal-gray transition-colors handwritten"
        >
          🎉 Talk Announcement
        </a>
      </div>
    </div>
    """
  end

  defp journal_tabs(assigns) do
    ~H"""
    <div class="hidden lg:block fixed right-8 top-1/2 transform -translate-y-1/2 z-40">
      <div class="flex flex-col space-y-2">
        <%= for {tab_id, label} <- [{"hero", "meks.dev"}, {"about", "about"}, {"projects", "projects"}, {"speaking", "speaking"}, {"writing", "writing"}] do %>
          <button
            phx-click="navigate_to_section"
            phx-value-section={tab_id}
            class={[
              "handwritten text-lg px-6 py-4 transform transition-all duration-300 hover:scale-105 relative journal-tab-enhanced shadow-md hover:shadow-lg",
              if(@active_section == tab_id,
                do: "ink-gradient-active",
                else: "text-journal-charcoal hover:shadow-xl"
              )
            ]}
            style={if @active_section == tab_id, do: "transform: translateX(-8px);", else: ""}
          >
            <span class="tab-text">{label}</span>
          </button>
        <% end %>
      </div>
    </div>
    """
  end
end
