defmodule MeksDevWeb.PortfolioLive do
  use MeksDevWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, active_section: "hero", mobile_menu_open: false)}
  end

  def handle_event("navigate_to_section", %{"section" => section}, socket) do
    {:noreply,
     socket
     # Close menu when navigating and set active section immediately
     |> assign(active_section: section, mobile_menu_open: false)
     |> push_event("scroll_to_section", %{section: section, disable_spy: true})}
  end

  def handle_event("section_in_view", %{"section" => section}, socket) do
    {:noreply, assign(socket, active_section: section)}
  end

  def handle_event("enable_scroll_spy", _params, socket) do
    {:noreply, socket}
  end

  def handle_event("toggle_mobile_menu", _params, socket) do
    {:noreply, assign(socket, mobile_menu_open: !socket.assigns.mobile_menu_open)}
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
      <.mobile_nav mobile_menu_open={@mobile_menu_open} />
      
    <!-- Mobile Menu Overlay -->
      <.mobile_menu_overlay mobile_menu_open={@mobile_menu_open} />
      
    <!-- Hero Section -->
      <.hero_section />
      
    <!-- About Section -->
      <.about_section />
      
    <!-- Projects Section -->
      <.projects_section />
      
    <!-- Speaking Section -->
      <.speaking_section />
      
    <!-- Writing Section -->
      <.writing_section />
      
    <!-- Tea Sponsorship Section -->
      <.tea_sponsorship_section />
      
    <!-- Footer -->
      <.footer />
    </div>
    """
  end

  # ============================================================================
  # REUSABLE COMPONENTS
  # ============================================================================

  # Section Header Component
  attr :title, :string, required: true
  attr :class, :string, default: ""

  defp section_header(assigns) do
    ~H"""
    <h2 class={[
      "handwritten-bold text-4xl md:text-5xl text-journal-charcoal mb-12 text-center",
      @class
    ]}>
      {@title}
    </h2>
    """
  end

  # Content Card Component
  attr :class, :string, default: ""
  slot :inner_block, required: true

  defp content_card(assigns) do
    ~H"""
    <div class={["p-8 bg-white", @class]}>
      {render_slot(@inner_block)}
    </div>
    """
  end

  # Tech Badge Component (less button-like)
  attr :tech, :string, required: true

  defp tech_badge(assigns) do
    ~H"""
    <span class="inline-block px-2 py-1 text-xs text-journal-gray bg-journal-gray-lighter rounded border border-journal-gray-light">
      {@tech}
    </span>
    """
  end

  # Primary Button Component
  attr :href, :string, required: true
  attr :class, :string, default: ""
  slot :inner_block, required: true

  defp primary_button(assigns) do
    ~H"""
    <a
      href={@href}
      class={[
        "inline-flex items-center gap-2 px-6 py-3 bg-journal-charcoal text-journal-cream rounded-lg",
        "hover:bg-journal-gray transition-colors duration-200",
        "font-medium shadow-sm hover:shadow-md",
        @class
      ]}
    >
      {render_slot(@inner_block)}
    </a>
    """
  end

  # Secondary Button Component
  attr :href, :string, required: true
  attr :class, :string, default: ""
  slot :inner_block, required: true

  defp secondary_button(assigns) do
    ~H"""
    <a
      href={@href}
      class={[
        "inline-flex items-center gap-2 px-4 py-2 border-2 border-journal-charcoal text-journal-charcoal rounded-lg",
        "hover:bg-journal-charcoal hover:text-journal-cream transition-all duration-200",
        "font-medium shadow-sm hover:shadow-md",
        @class
      ]}
    >
      {render_slot(@inner_block)}
    </a>
    """
  end

  # Contact Link Component
  attr :href, :string, required: true
  attr :icon, :string, required: true
  attr :text, :string, required: true

  defp contact_link(assigns) do
    ~H"""
    <a
      href={@href}
      class="flex items-center gap-2 text-journal-charcoal hover:text-journal-gray transition-colors duration-200 group md:hover:scale-110 md:transition-transform md:duration-200"
    >
      <span class="handwritten text-lg md:group-hover:scale-110 md:transition-transform md:duration-200 underline px-2 py-1">
        {@icon} {@text}
      </span>
    </a>
    """
  end

  # Styled Link Component (based on contact_link styling)
  attr :href, :string, required: true
  attr :class, :string, default: ""
  slot :inner_block, required: true

  defp styled_link(assigns) do
    ~H"""
    <a
      href={@href}
      class={[
        "text-gray-800 hover:text-gray-500 transition-all duration-200 inline-block",
        "md:hover:scale-105",
        "font-medium",
        "underline px-2 py-1",
        @class
      ]}
    >
      {render_slot(@inner_block)}
    </a>
    """
  end

  # Project Card Component
  attr :title, :string, required: true
  attr :description, :string, required: true
  attr :image_src, :string, required: true
  attr :image_alt, :string, required: true
  attr :tech_stack, :list, required: true
  attr :links, :list, required: true

  defp project_card(assigns) do
    ~H"""
    <.content_card>
      <h3 class="handwritten-bold text-3xl text-journal-charcoal mb-4">{@title}</h3>
      <p class="text-journal-gray mb-4">{@description}</p>

      <div class="mb-6">
        <img
          src={@image_src}
          alt={@image_alt}
          class="w-full h-48 object-cover border border-journal-gray-light rounded"
        />
      </div>

      <div class="flex flex-wrap gap-2 mb-6">
        <%= for tech <- @tech_stack do %>
          <.tech_badge tech={tech} />
        <% end %>
      </div>

      <div class="flex gap-3">
        <%= for {text, href} <- @links do %>
          <.secondary_button href={href}>
            {text}
          </.secondary_button>
        <% end %>
      </div>
    </.content_card>
    """
  end

  # ============================================================================
  # SECTION COMPONENTS
  # ============================================================================

  defp mobile_nav(assigns) do
    ~H"""
    <div class="lg:hidden fixed top-4 right-4 z-50">
      <button
        phx-click="toggle_mobile_menu"
        class="bg-journal-white border-journal-charcoal border-2 rounded p-2"
      >
        <%= if @mobile_menu_open do %>
          <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path
              stroke-linecap="round"
              stroke-linejoin="round"
              stroke-width="2"
              d="M6 18L18 6M6 6l12 12"
            >
            </path>
          </svg>
        <% else %>
          <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path
              stroke-linecap="round"
              stroke-linejoin="round"
              stroke-width="2"
              d="M4 6h16M4 12h16M4 18h16"
            >
            </path>
          </svg>
        <% end %>
      </button>
    </div>
    """
  end

  defp mobile_menu_overlay(assigns) do
    ~H"""
    <%= if @mobile_menu_open do %>
      <div class="lg:hidden fixed inset-0 bg-journal-cream paper-texture z-40 p-8">
        <div class="flex flex-col items-center justify-center h-full space-y-8">
          <%= for {tab_id, label} <- [{"hero", "meks.quest"}, {"about", "about"}, {"projects", "projects"}, {"speaking", "speaking"}, {"writing", "writing"}] do %>
            <button
              phx-click="navigate_to_section"
              phx-value-section={tab_id}
              class="handwritten text-3xl text-journal-charcoal hover:text-journal-gray"
            >
              {label}
            </button>
          <% end %>
        </div>
      </div>
    <% end %>
    """
  end

  defp hero_section(assigns) do
    ~H"""
    <section id="hero" class="min-h-screen flex items-center justify-center px-4 relative">
      <!-- Vampire drawing as background -->
      <.vampire_sprite class="text-write absolute z-0" />

      <div class="text-center max-w-4xl mx-auto relative z-10">
        <h1 class="handwritten-bold text-7xl md:text-9xl text-journal-charcoal mb-8 text-write">
          meks.quest
        </h1>
        <h2 class="text-3xl md:text-4xl text-journal-charcoal mb-8 text-write">
          (they/them)
        </h2>
        <p class="text-xl md:text-2xl text-journal-gray max-w-2xl mx-auto leading-relaxed text-write mb-8">
          Artist-engineer in flux, dancing between ink and sparkles, crafting peculiar spells with intention.
        </p>
        
    <!-- Quick Contact Links -->
        <div class="flex justify-center gap-8 text-write">
          <.contact_link href="mailto:mmcclure0100@gmail.com" icon="📧" text="Email" />
          <.contact_link href="https://www.linkedin.com/in/meksmcclure/" icon="💼" text="LinkedIn" />
          <.contact_link href="https://github.com/meksquest" icon="🐙" text="GitHub" />
        </div>
      </div>
    </section>
    """
  end

  defp about_section(assigns) do
    ~H"""
    <section id="about" class="py-20 px-4 relative">
      <div class="max-w-4xl mx-auto">
        <.section_header title="about" />

        <div class="grid md:grid-cols-2 gap-12">
          <.content_card>
            <h3 class="handwritten text-2xl text-journal-charcoal mb-6">Professional</h3>
            <p class="text-journal-gray leading-relaxed mb-4">
              I’m an artist-engineer crafting small, intentional
              systems with care and curiosity. My work lives at the
              intersection of elegance and precision—whether I’m building with
              Elixir and Phoenix, tuning my NeoVim config, or shaping focused
              tools that do one thing well.
            </p>
            <p class="text-journal-gray leading-relaxed">
              I’ve presented at several Elixir conferences, where I share the
              joy of strange abstractions, practical design, and soft,
              human-centered tooling. I write to explore, speak to connect, and
              build to create space—for others, and for myself.
            </p>
          </.content_card>

          <.content_card>
            <h3 class="handwritten text-2xl text-journal-charcoal mb-6">Beyond the Code</h3>
            <p class="text-journal-gray leading-relaxed mb-4">
              I live on the road, always moving, always learning. Queerness and
              transition shape how I experience the world—fluid, layered, soft
              at the edges, sharp at the heart. I sketch dragons in ink, I
              sleep beside a sparkly bumblecorn, and I write about my travels,
              the systems I build, and the things I notice along the way.
            </p>
            <p class="text-journal-gray leading-relaxed">
              This site is part of the trail I leave behind. Thanks for walking
              through it.
            </p>
          </.content_card>
        </div>
      </div>
    </section>
    """
  end

  defp projects_section(assigns) do
    ~H"""
    <section id="projects" class="py-20 px-4 relative">
      <div class="max-w-6xl mx-auto">
        <.section_header title="projects" />

        <div class="grid md:grid-cols-2 gap-12 mb-12">
          <.project_card
            title="Quenta"
            description="Expense sharing app prototyped with Elixir/Phoenix, and built with Svelt."
            image_src={~p"/images/projects/quenta-screenshot.png"}
            image_alt="Quenta collaborative storytelling platform screenshot"
            tech_stack={["Elixir", "Phoenix", "LiveView", "PostgreSQL"]}
            links={[
              {"Elixir Prototype GitHub", "https://github.com/MMcClure11/quenta/tree/main/elixir"},
              {"Elixir Prototype Live", "https://ex.quenta.pro/"}
            ]}
          />

          <.project_card
            title="Bookshelf"
            description="A virtual library of all the books you want to keep tabs on, those sneaky buggers tend to run off in search of adventure."
            image_src={~p"/images/projects/bookshelf-screenshot.png"}
            image_alt="Bookshelf book management system screenshot"
            tech_stack={["Elixir", "Phoenix", "LiveView"]}
            links={[
              {"GitHub", "https://github.com/MMcClure11/bookshelf"},
              {"Live", "https://bookshelf-meks.fly.dev/"}
            ]}
          />
        </div>
      </div>
    </section>
    """
  end

  defp speaking_section(assigns) do
    ~H"""
    <section id="speaking" class="py-20 px-4 relative">
      <div class="max-w-5xl mx-auto">
        <.section_header title="speaking" />

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
    """
  end

  defp writing_section(assigns) do
    ~H"""
    <section id="writing" class="py-20 px-4 relative">
      <div class="max-w-4xl mx-auto">
        <.section_header title="writing" />

        <div class="grid md:grid-cols-2 gap-8 mb-8">
          <.content_card class="p-6">
            <h3 class="handwritten text-xl text-journal-charcoal mb-4">Technical Deep Dives</h3>
            <p class="text-journal-gray text-sm mb-4">
              In-depth explorations of Elixir, Phoenix, and LiveView concepts
            </p>
            <.styled_link href="https://dev.to/mmcclure11" class="text-sm">
              Read articles →
            </.styled_link>
          </.content_card>

          <.content_card class="p-6">
            <h3 class="handwritten text-xl text-journal-charcoal mb-4">
              Life & Perspectives (coming July 2025)
            </h3>
            <p class="text-journal-gray text-sm mb-4">
              Stories from the road, queer life, and creative coding.
            </p>
          </.content_card>
        </div>

        <div class="text-center text-journal-gray text-sm italic">
          <p>*Transitioning from dev.to to this personal space</p>
        </div>
      </div>
    </section>
    """
  end

  defp tea_sponsorship_section(assigns) do
    ~H"""
    <section class="py-16 px-4 bg-journal-cream">
      <div class="max-w-4xl mx-auto text-center">
        <div class="p-8 bg-journal-white mb-8 relative overflow-hidden">
          <!-- Background vampire sprite -->
          <.vampire_coffee_sprite class="absolute right-0 bottom-0 h-full object-cover opacity-10 z-0 rotate-6" />
          
    <!-- Content with higher z-index -->
          <div class="relative z-10">
            <h3 class="handwritten-bold text-2xl text-journal-charcoal mb-4">
              Fuel the Creative Process
            </h3>
            <p class="text-journal-gray mb-6 leading-relaxed">
              If you enjoy my work and want to support my continued exploration of art, code, and creative solutions,
              consider sponsoring my tea obsession! Every cup of Chai helps fuel late-night coding and drawing sessions and sparks new ideas.
            </p>
            <.primary_button href="https://buymeacoffee.com/meks" class="handwritten text-xl">
              buy meks brain fuel
            </.primary_button>
          </div>
        </div>
      </div>
    </section>
    """
  end

  defp footer(assigns) do
    ~H"""
    <footer class="py-12 px-4 border-t border-journal-gray-lighter bg-journal-cream">
      <div class="max-w-4xl mx-auto text-center">
        <p class="text-journal-gray mb-2">
          Built by meks.quest • Powered by Elixir/Phoenix • Hosted on Fly.io
        </p>
        <p class="handwritten text-journal-charcoal">
          Made with care and lots of tea ❤️
        </p>
      </div>
    </footer>
    """
  end

  # ============================================================================
  # EXISTING COMPONENTS (keeping these as they are already well-structured)
  # ============================================================================

  attr :conf, :string, default: ""
  attr :title, :string, default: ""
  attr :location, :string, default: ""
  attr :video_link, :string, default: ""
  attr :slides_link, :string, default: ""
  attr :announcement_link, :string, default: ""
  attr :coming_soon?, :boolean, default: false

  defp speaking_card(assigns) do
    ~H"""
    <div class="p-6 bg-white">
      <h3 class="handwritten text-2xl text-journal-charcoal mb-2">{@conf}</h3>
      <h4 class="text-xl text-journal-gray mb-2">{@title}</h4>
      <p class="text-journal-gray mb-4">{@location}</p>
      <div class="flex gap-4">
        <.styled_link :if={@video_link != ""} href={@video_link}>
          📹 Video
        </.styled_link>
        <.styled_link :if={@slides_link != ""} href={@slides_link}>
          📊 Speaker Deck
        </.styled_link>
        <.styled_link :if={@announcement_link != ""} href={@announcement_link}>
          🎉 Talk Announcement
        </.styled_link>
      </div>
    </div>
    """
  end

  defp journal_tabs(assigns) do
    ~H"""
    <div class="hidden lg:block fixed right-8 top-1/2 transform -translate-y-1/2 z-40">
      <div class="flex flex-col space-y-2">
        <%= for {tab_id, label} <- [{"hero", "meks.quest"}, {"about", "about"}, {"projects", "projects"}, {"speaking", "speaking"}, {"writing", "writing"}] do %>
          <button
            phx-click="navigate_to_section"
            phx-value-section={tab_id}
            class={[
              "handwritten text-lg px-6 py-4 relative journal-tab-enhanced shadow-md",
              if(@active_section == tab_id,
                do: "bg-journal-charcoal text-journal-cream",
                else: "text-journal-charcoal"
              )
            ]}
          >
            <span class="tab-text">{label}</span>
          </button>
        <% end %>
      </div>
    </div>
    """
  end

  attr :class, :string, default: ""

  def vampire_sprite(assigns) do
    ~H"""
    <img
      src={~p"/images/drawings/vampire_drawing.svg"}
      alt="Walking vampire"
      class={["vampire-background", @class]}
    />
    """
  end

  attr :class, :string, default: ""

  def vampire_coffee_sprite(assigns) do
    ~H"""
    <img
      src={~p"/images/drawings/vampire_coffee_drawing.svg"}
      alt="Vampire drinking coffee in a coffin"
      class={@class}
    />
    """
  end
end
