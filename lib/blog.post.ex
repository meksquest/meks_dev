defmodule MeksDev.Blog.Post do
  @enforce_keys [:id, :title, :author, :date, :slug, :body]
  defstruct [:id, :title, :author, :date, :slug, :description, :body, tags: []]

  def build(filename, attrs, body) do
    html = MDEx.to_html!(body, render: [unsafe: true])

    struct!(
      __MODULE__,
      Map.merge(attrs, %{
        id: filename,
        body: html
      })
    )
  end
end
