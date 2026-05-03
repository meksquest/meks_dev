defmodule MeksDev.Blog.Post do
  @enforce_keys [:id, :title, :author, :date, :slug, :body]
  defstruct [:id, :title, :author, :date, :slug, :description, :location, :body, tags: []]

  def build(filename, attrs, body) do
    base_url = MeksDevWeb.Endpoint.url()

    html =
      body
      |> MDEx.to_html!(render: [unsafe: true])
      |> String.replace(~r/src="\//, ~s(src="#{base_url}/))

    struct!(
      __MODULE__,
      Map.merge(attrs, %{id: filename, body: html})
    )
  end
end
