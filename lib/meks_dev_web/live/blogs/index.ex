defmodule MeksDevWeb.BlogLive.Index do
  use MeksDevWeb, :live_view
  alias MeksDev.Blogs

  def mount(_params, _session, socket) do
    {:ok, socket |> load_posts()}
  end

  defp load_posts(socket) do
    result =
      Blogs.list_posts()

    assign(socket, posts: result.posts)
  end

  def render(assigns) do
    ~H"""
    <div class="bg-journal-cream paper-texture min-h-screen">
      <.primary_button href={~p"/"} class="handwritten text-xl m-8">
        meks.quest
      </.primary_button>
      <div class="mx-auto max-w-3xl px-6 py-8">
        <%!-- Post List --%>
        <div class="space-y-6">
          <article :for={post <- @posts} class="border-b border-gray-200 pb-6">
            <a href={~p"/blogs/#{post.slug}"} class="group">
              <h2 class="text-xl font-semibold group-hover:text-blue-700 transition-colors">
                {post.title}
              </h2>
              <p class="text-sm text-gray-500 mt-1">
                {Calendar.strftime(post.date, "%B %d, %Y")}
              </p>
              <p :if={post.description} class="text-gray-700 mt-2">{post.description}</p>
            </a>
            <div class="flex gap-2 mt-2">
              <span
                :for={tag <- post.tags}
                class="text-xs px-2 py-0.5 bg-gray-100 text-gray-600 rounded-full"
              >
                #{tag}
              </span>
            </div>
          </article>
        </div>
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
