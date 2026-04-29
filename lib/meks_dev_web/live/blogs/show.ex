defmodule MeksDevWeb.BlogLive.Show do
  use MeksDevWeb, :live_view
  alias MeksDev.Blogs

  def mount(%{"slug" => slug}, _session, socket) do
    post = Blogs.get_post_by_slug!(slug)
    {:ok, assign(socket, :post, post)}
  end

  def render(assigns) do
    ~H"""
    <div class="bg-journal-cream paper-texture">
      <.primary_button href={~p"/"} class="handwritten text-xl m-8">
        meks.quest
      </.primary_button>

      <.primary_button href={~p"/blogs"} class="handwritten text-xl m-3">
        Stories
      </.primary_button>

      <div class="mx-auto max-w-3xl px-6 py-8">
        <h1 class="text-3xl sm:text-4xl font-bold tracking-tight text-gray-900 mb-6">
          {@post.title}
        </h1>
        <h3 class="text-xl font-semibold text-gray-900 mt-8 mb-3">
          {@post.author} · {Calendar.strftime(@post.date, "%B %d, %Y")}
        </h3>

        <article class={
          if "poetry" in @post.tags, do: "poetry-content", else: "prose prose-gray max-w-none"
        }>
          {Phoenix.HTML.raw(@post.body)}
        </article>
      </div>
    </div>
    """
  end

  attr :href, :string, required: true
  attr :class, :string, default: ""
  slot :inner_block, required: true

  defp primary_button(assigns) do
    ~H"""
    <a
      href={@href}
      class={"inline-flex items-center gap-2 px-6 py-3 bg-journal-charcoal text-journal-cream rounded-lg hover:bg-journal-gray transition-colors duration-200 font-medium shadow-sm hover:shadow-md " <> @class}
    >
      {render_slot(@inner_block)}
    </a>
    """
  end
end
