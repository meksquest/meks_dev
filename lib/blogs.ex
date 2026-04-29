defmodule MeksDev.Blogs do
  alias MeksDev.Blog.Post

  use NimblePublisher,
    build: Post,
    from: Application.app_dir(:meks_dev, "priv/posts/**/*.md"),
    as: :posts,
    highlighters: []

  @posts Enum.sort_by(@posts, & &1.date, {:desc, Date})

  # Derive all unique tags at compile time
  @tags @posts |> Enum.flat_map(& &1.tags) |> Enum.uniq() |> Enum.sort()

  # --- Public API ---

  def all_posts, do: @posts
  def all_tags, do: @tags

  def get_post_by_slug!(slug) do
    Enum.find(all_posts(), &(&1.slug == slug)) ||
      raise MeksDevWeb.NotFoundError, "Post not found: #{slug}"
  end

  @doc """
  Returns all posts.
  """
  def list_posts(_opts \\ []) do
    posts = all_posts()

    %{posts: posts}
  end
end
