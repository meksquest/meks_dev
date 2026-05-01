defmodule MeksDev.Blogs do
  alias MeksDev.Blog.Post

  use NimblePublisher,
    build: Post,
    from: Application.app_dir(:meks_dev, "priv/posts/**/*.md"),
    as: :posts,
    highlighters: []

  @posts Enum.sort_by(@posts, & &1.date, {:desc, Date})
  @tags @posts |> Enum.flat_map(& &1.tags) |> Enum.uniq() |> Enum.sort()
  @per_page_default 5
  @per_page_allowed [5, 10, 25]

  def all_posts, do: @posts
  def all_tags, do: @tags

  def get_post_by_slug!(slug) do
    Enum.find(all_posts(), &(&1.slug == slug)) ||
      raise MeksDevWeb.NotFoundError, "Post not found: #{slug}"
  end

  @doc """
  Returns posts, optionally filtered by a list of tags (union match) and sorted.

  ## Options
    - `:tags` - a list of tag strings, or `[]`/`nil` for all posts
    - `:sort` - one of `:date_desc` (default), `:date_asc`, `:title_asc`
  """

  def list_posts(opts \\ []) do
    tags = opts |> Keyword.get(:tags, []) |> List.wrap() |> Enum.reject(&(&1 == ""))
    sort = Keyword.get(opts, :sort, :date_desc)
    page = opts |> Keyword.get(:page, 1) |> max(1)
    per_page = opts |> Keyword.get(:per_page, @per_page_default) |> parse_per_page()

    all =
      all_posts()
      |> filter_by_tags(tags)
      |> sort_posts(sort)

    total = length(all)
    total_pages = max(ceil(total / per_page), 1)
    page = min(page, total_pages)
    paged = all |> Enum.drop((page - 1) * per_page) |> Enum.take(per_page)

    %{
      posts: paged,
      tags: tags,
      sort: sort,
      page: page,
      per_page: per_page,
      total_pages: total_pages,
      total: total
    }
  end

  defp parse_per_page(n) when n in @per_page_allowed, do: n
  defp parse_per_page(_), do: @per_page_default

  # No filter when the list is empty
  defp filter_by_tags(posts, []), do: posts

  # Union: post must have AT LEAST ONE of the selected tags
  defp filter_by_tags(posts, tags) do
    Enum.filter(posts, fn post ->
      Enum.any?(tags, &(&1 in post.tags))
    end)
  end

  defp sort_posts(posts, :date_desc), do: Enum.sort_by(posts, & &1.date, {:desc, Date})
  defp sort_posts(posts, :date_asc), do: Enum.sort_by(posts, & &1.date, {:asc, Date})
  defp sort_posts(posts, :title_asc), do: Enum.sort_by(posts, &String.downcase(&1.title), :asc)
  defp sort_posts(posts, _), do: posts
end
