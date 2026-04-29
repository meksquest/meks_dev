defmodule MeksDevWeb.BlogLive.Index do
  use MeksDevWeb, :live_view
  alias MeksDev.Blogs

  def mount(_params, _session, socket) do
    {:ok, assign(socket, tags: Blogs.all_tags())}
  end

  def handle_params(params, _uri, socket) do
    # Phoenix decodes ?tags[]=a&tags[]=b as %{"tags" => ["a", "b"]}
    active_tags = Map.get(params, "tags", []) |> List.wrap()
    {:noreply, load_posts(socket, active_tags)}
  end

  defp load_posts(socket, active_tags) do
    result = Blogs.list_posts(tags: active_tags)
    assign(socket, posts: result.posts, active_tags: result.tags)
  end

  # Computes the toggled tag list for a given tag pill
  defp toggle_tag(active_tags, tag) do
    if tag in active_tags do
      List.delete(active_tags, tag)
    else
      [tag | active_tags]
    end
  end

  def render(assigns) do
    ~H"""
    <div class="bg-journal-cream paper-texture min-h-screen">
      <.primary_button href={~p"/"} class="handwritten text-xl m-8">
        meks.quest
      </.primary_button>

      <div class="mx-auto max-w-3xl px-6 py-8">
        <%!-- Tag Filter Bar --%>
        <div class="flex flex-wrap gap-2 mb-8">
          <%!-- "All" clears the filter --%>
          <.tag_pill active={@active_tags == []} patch={~p"/blogs"}>
            All
          </.tag_pill>

          <.tag_pill
            :for={tag <- @tags}
            active={tag in @active_tags}
            patch={
              case toggle_tag(@active_tags, tag) do
                [] -> ~p"/blogs"
                new_tags -> ~p"/blogs?#{[tags: new_tags]}"
              end
            }
          >
            #{tag}
          </.tag_pill>
        </div>

        <%!-- Active filter summary --%>
        <p :if={@active_tags != []} class="text-sm text-gray-500 mb-4">
          Showing posts tagged:
          <span :for={tag <- @active_tags} class="font-semibold ml-1">#{tag}</span>
        </p>

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
              <.link
                :for={tag <- post.tags}
                patch={
                  case toggle_tag(@active_tags, tag) do
                    [] -> ~p"/blogs"
                    new_tags -> ~p"/blogs?#{[tags: new_tags]}"
                  end
                }
                class={[
                  "text-xs px-2 py-0.5 rounded-full transition-colors",
                  if(tag in @active_tags,
                    do: "bg-journal-charcoal text-journal-cream",
                    else: "bg-gray-100 text-gray-600 hover:bg-gray-200"
                  )
                ]}
              >
                #{tag}
              </.link>
            </div>
          </article>
        </div>

        <%!-- Empty state --%>
        <p :if={@posts == []} class="text-gray-500 text-center py-12">
          No posts found for the selected tags.
        </p>
      </div>
    </div>
    """
  end

  attr :active, :boolean, default: false
  attr :patch, :string, required: true
  slot :inner_block, required: true

  defp tag_pill(assigns) do
    ~H"""
    <.link
      patch={@patch}
      class={[
        "text-sm px-3 py-1 rounded-full border transition-colors",
        if(@active,
          do: "bg-journal-charcoal text-journal-cream border-journal-charcoal",
          else: "bg-white text-gray-600 border-gray-300 hover:border-gray-500"
        )
      ]}
    >
      {render_slot(@inner_block)}
    </.link>
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
