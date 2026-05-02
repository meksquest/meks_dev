defmodule MeksDevWeb.RSS do
  @behaviour Plug

  import Plug.Conn
  alias MeksDev.Blogs

  def init(opts), do: opts

  def call(conn, _opts) do
    posts = Blogs.all_posts()
    body = render(posts)

    conn
    |> put_resp_content_type("application/rss+xml; charset=utf-8")
    |> send_resp(200, body)
    |> halt()
  end

  defp render(posts) do
    latest_updated = posts |> List.first() |> then(& &1.date)

    items =
      Enum.map_join(posts, "\n", fn post ->
        pub_date = Calendar.strftime(post.date, "%a, %d %b %Y 00:00:00 +0000")
        url = MeksDevWeb.Endpoint.url() <> "/blogs/#{post.slug}"

        """
        <item>
          <title>#{escape(post.title)}</title>
          <link>#{url}</link>
          <guid isPermaLink="true">#{url}</guid>
          <pubDate>#{pub_date}</pubDate>
          #{if post.description, do: "<description>#{escape(post.description)}</description>", else: ""}
          #{if post.location, do: "<category>#{escape(post.location)}</category>", else: ""}
          #{Enum.map_join(post.tags, "\n  ", fn tag -> "<category>#{escape(tag)}</category>" end)}
          <content:encoded><![CDATA[#{post.body}]]></content:encoded>
        </item>
        """
      end)

    """
    <?xml version="1.0" encoding="UTF-8"?>
    <rss version="2.0"
      xmlns:atom="http://www.w3.org/2005/Atom"
      xmlns:content="http://purl.org/rss/1.0/modules/content/">
    <channel>
      <title>meks.quest</title>
      <link>#{MeksDevWeb.Endpoint.url()}</link>
      <description>Travel and Tech writing and stories by Meks McClure</description>
      <language>en-us</language>
      <lastBuildDate>#{Calendar.strftime(latest_updated, "%a, %d %b %Y 00:00:00 +0000")}</lastBuildDate>
      <atom:link href="#{MeksDevWeb.Endpoint.url()}/feed.xml" rel="self" type="application/rss+xml" />
      #{items}
    </channel>
    </rss>
    """
  end

  defp escape(nil), do: ""

  defp escape(str) do
    str
    |> String.replace("&", "&amp;")
    |> String.replace("<", "&lt;")
    |> String.replace(">", "&gt;")
    |> String.replace("\"", "&quot;")
  end
end
