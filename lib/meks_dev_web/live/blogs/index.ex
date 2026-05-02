defmodule MeksDevWeb.BlogLive.Index do
  use MeksDevWeb, :live_view
  alias MeksDev.Blogs

  @valid_sorts ~w(date_desc date_asc title_asc)
  @per_page_opts [5, 10, 25]
  @per_page_default 10

  def mount(_params, _session, socket) do
    {:ok, assign(socket, tags: Blogs.all_tags())}
  end

  def handle_params(params, _uri, socket) do
    active_tags = Map.get(params, "tags", []) |> List.wrap()
    sort = parse_sort(params["sort"])
    page = parse_page(params["page"])
    per_page = parse_per_page(params["per"])

    result = Blogs.list_posts(tags: active_tags, sort: sort, page: page, per_page: per_page)

    {:noreply,
     assign(socket,
       posts: result.posts,
       active_tags: result.tags,
       sort: result.sort,
       page: result.page,
       per_page: result.per_page,
       total_pages: result.total_pages,
       total: result.total
     )}
  end

  defp toggle_tag(active_tags, tag) do
    if tag in active_tags do
      List.delete(active_tags, tag)
    else
      [tag | active_tags]
    end
  end

  defp parse_sort(value) when value in @valid_sorts, do: String.to_existing_atom(value)
  defp parse_sort(_), do: :date_desc

  defp parse_page(value) when is_binary(value) do
    case Integer.parse(value) do
      {n, ""} when n > 0 -> n
      _ -> 1
    end
  end

  defp parse_page(_), do: 1

  defp parse_per_page(value) when is_binary(value) do
    case Integer.parse(value) do
      {n, ""} when n in @per_page_opts -> n
      _ -> @per_page_default
    end
  end

  defp parse_per_page(_), do: @per_page_default

  # Single path builder — all state in one place, defaults omitted for clean URLs
  defp blogs_path(tags, sort, page, per_page) do
    params =
      %{}
      |> then(fn p -> if tags != [], do: Map.put(p, "tags", tags), else: p end)
      |> then(fn p ->
        if sort != :date_desc, do: Map.put(p, "sort", Atom.to_string(sort)), else: p
      end)
      |> then(fn p -> if page > 1, do: Map.put(p, "page", page), else: p end)
      |> then(fn p ->
        if per_page != @per_page_default, do: Map.put(p, "per", per_page), else: p
      end)

    if params == %{}, do: ~p"/blogs", else: ~p"/blogs?#{params}"
  end

  def render(assigns) do
    ~H"""
    <div class="bg-journal-cream paper-texture min-h-screen">
      <div class="flex items-center justify-between mb-4">
        <.primary_button href={~p"/"} class="handwritten text-xl m-8">
          meks.quest
        </.primary_button>

        <a
          href="/feed.xml"
          target="_blank"
          class="flex items-center gap-1 text-s m-8 text-gray-400 hover:text-gray-600 transition-colors"
          title="Subscribe via RSS"
        >
          <%!-- RSS icon (inline SVG) --%>
          <svg class="w-4 h-4" viewBox="0 0 24 24" fill="currentColor">
            <path d="M6.18 15.64a2.18 2.18 0 0 1 2.18 2.18C8.36 19.01 7.38 20 6.18 20C4.98 20 4 19.01 4 17.82a2.18 2.18 0 0 1 2.18-2.18M4 4.44A15.56 15.56 0 0 1 19.56 20h-2.83A12.73 12.73 0 0 0 4 7.27V4.44m0 5.66a9.9 9.9 0 0 1 9.9 9.9h-2.83A7.07 7.07 0 0 0 4 12.93V10.1z" />
          </svg>
          RSS
        </a>
      </div>

      <div class="mx-auto max-w-3xl px-6 py-8">
        <%!-- Tag Filter Bar --%>
        <p class="text-xs font-medium text-gray-400 uppercase tracking-wide mr-1 my-2">Filter</p>
        <div class="flex flex-wrap gap-2">
          <.tag_pill active={@active_tags == []} patch={blogs_path([], @sort, 1, @per_page)}>
            All
          </.tag_pill>
          <.tag_pill
            :for={tag <- @tags}
            active={tag in @active_tags}
            patch={blogs_path(toggle_tag(@active_tags, tag), @sort, 1, @per_page)}
          >
            #{tag}
          </.tag_pill>
        </div>

        <%!-- Sort Bar --%>
        <p class="text-xs font-medium text-gray-400 uppercase tracking-wide mr-1 my-2">Sort</p>
        <div class="flex flex-wrap gap-2 mb-6">
          <.sort_pill
            active={@sort == :date_desc}
            patch={blogs_path(@active_tags, :date_desc, 1, @per_page)}
          >
            Newest
          </.sort_pill>
          <.sort_pill
            active={@sort == :date_asc}
            patch={blogs_path(@active_tags, :date_asc, 1, @per_page)}
          >
            Oldest
          </.sort_pill>
          <.sort_pill
            active={@sort == :title_asc}
            patch={blogs_path(@active_tags, :title_asc, 1, @per_page)}
          >
            Title A–Z
          </.sort_pill>
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
              <p :if={post.location} class="text-gray-600 text-sm mt-2">{post.location}</p>
              <p :if={post.description} class="text-gray-700 mt-2">{post.description}</p>
            </a>
            <div class="flex gap-2 mt-2">
              <.link
                :for={tag <- post.tags}
                patch={blogs_path(toggle_tag(@active_tags, tag), @sort, 1, @per_page)}
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

        <%!-- Pagination + per-page selector --%>
        <div
          :if={@total_pages > 1 or @total > 5}
          class="flex items-center justify-between mt-10 gap-4"
        >
          <.pagination
            page={@page}
            total_pages={@total_pages}
            tags={@active_tags}
            sort={@sort}
            per_page={@per_page}
            path_fn={&blogs_path/4}
          />
          <.per_page_selector
            per_page={@per_page}
            tags={@active_tags}
            sort={@sort}
            path_fn={&blogs_path/4}
          />
        </div>
      </div>
    </div>
    """
  end

  # --- Per-page selector ---

  attr :per_page, :integer, required: true
  attr :tags, :list, required: true
  attr :sort, :atom, required: true
  attr :path_fn, :any, required: true

  defp per_page_selector(assigns) do
    assigns = assign(assigns, :opts, @per_page_opts)

    ~H"""
    <div class="flex items-center gap-2">
      <span class="text-xs font-medium text-gray-400 uppercase tracking-wide whitespace-nowrap">
        Per page
      </span>
      <div class="inline-flex rounded-md border border-gray-300 overflow-hidden">
        <.link
          :for={n <- @opts}
          patch={@path_fn.(@tags, @sort, 1, n)}
          class={[
            "text-sm px-3 py-1 border-r border-gray-300 last:border-r-0 transition-colors",
            if(n == @per_page,
              do: "bg-journal-charcoal text-journal-cream",
              else: "bg-white text-gray-600 hover:bg-gray-50"
            )
          ]}
        >
          {n}
        </.link>
      </div>
    </div>
    """
  end

  # --- Pagination component ---

  attr :page, :integer, required: true
  attr :total_pages, :integer, required: true
  attr :tags, :list, required: true
  attr :sort, :atom, required: true
  attr :per_page, :integer, required: true
  attr :path_fn, :any, required: true

  defp pagination(assigns) do
    ~H"""
    <nav class="flex items-center gap-1" aria-label="Pagination">
      <.page_link
        label="← Prev"
        patch={@path_fn.(@tags, @sort, @page - 1, @per_page)}
        disabled={@page <= 1}
      />
      <.page_link
        :for={n <- page_range(@page, @total_pages)}
        label={if n == :ellipsis, do: "…", else: to_string(n)}
        patch={if n == :ellipsis, do: nil, else: @path_fn.(@tags, @sort, n, @per_page)}
        active={n == @page}
        disabled={n == :ellipsis}
      />
      <.page_link
        label="Next →"
        patch={@path_fn.(@tags, @sort, @page + 1, @per_page)}
        disabled={@page >= @total_pages}
      />
    </nav>
    """
  end

  attr :label, :string, required: true
  attr :patch, :string, default: nil
  attr :active, :boolean, default: false
  attr :disabled, :boolean, default: false

  defp page_link(assigns) do
    ~H"""
    <.link
      patch={@patch || "#"}
      class={[
        "px-3 py-1 text-sm rounded-md border transition-colors",
        @active && "bg-journal-charcoal text-journal-cream border-journal-charcoal",
        @disabled && "opacity-40 pointer-events-none border-transparent",
        !@active && !@disabled && "bg-white text-gray-600 border-gray-300 hover:border-gray-500"
      ]}
      aria-current={if @active, do: "page", else: nil}
    >
      {@label}
    </.link>
    """
  end

  defp page_range(_current, total) when total <= 7, do: Enum.to_list(1..total)

  defp page_range(current, total) do
    always = MapSet.new([1, total, current, current - 1, current + 1])

    1..total
    |> Enum.filter(&MapSet.member?(always, &1))
    |> Enum.reduce([], fn page, acc ->
      case acc do
        [prev | _] when page - prev > 1 -> [page, :ellipsis | acc]
        _ -> [page | acc]
      end
    end)
    |> Enum.reverse()
  end

  # --- Existing components (unchanged) ---

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

  attr :active, :boolean, default: false
  attr :patch, :string, required: true
  slot :inner_block, required: true

  defp sort_pill(assigns) do
    ~H"""
    <.link
      patch={@patch}
      class={[
        "text-sm px-3 py-1 rounded-md border transition-colors",
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
