defmodule MeksDevWeb.Router do
  use MeksDevWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {MeksDevWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MeksDevWeb do
    pipe_through :browser

    live "/", PortfolioLive
    live "/blogs/the-theatre-of-pull-requests-and-code-review", BlogsLive.PullRequest
    live "/blogs/escape", BlogsLive.Escape
    live "/blogs/wood-with-legs", BlogsLive.WoodWithLegs
    live "/blogs/blueberries-in-krakow", BlogsLive.BlueberriesInKrakow
    live "/blogs/sky-water", BlogsLive.SkyWater
    live "/blogs/the-sprite-unbound", BlogsLive.TheSpriteUnbound
    live "/stories", StoriesLive.Index
  end

  # Other scopes may use custom stacks.
  # scope "/api", MeksDevWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard in development
  if Application.compile_env(:meks_dev, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: MeksDevWeb.Telemetry
    end
  end
end
