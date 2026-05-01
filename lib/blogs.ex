defmodule MeksDev.Blogs do
  alias MeksDev.Blog.Post

  use NimblePublisher,
    build: Post,
    from: Application.app_dir(:meks_dev, "priv/posts/**/*.md"),
    as: :posts,
    highlighters: []

  @posts Enum.sort_by(@posts, & &1.date, {:desc, Date})
  @tags @posts |> Enum.flat_map(& &1.tags) |> Enum.uniq() |> Enum.sort()

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

    posts =
      all_posts()
      |> filter_by_tags(tags)
      |> sort_posts(sort)

    %{posts: posts, tags: tags, sort: sort}
  end

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
