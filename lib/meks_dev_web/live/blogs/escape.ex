defmodule MeksDevWeb.BlogsLive.Escape do
  use MeksDevWeb, :live_view

  def mount(_, _, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="bg-journal-cream paper-texture">
      <.primary_button href={~p"/"} class="handwritten text-xl m-3">
        meks.quest
      </.primary_button>

      <div class={container_classes()}>
        <h1 class={h1_classes()}>Escape</h1>
        <h3 class={h3_classes()}>Meks McClure · April 07, 2026</h3>

        <p class={p_classes()}>
Tell me
Did you think that time would close it?

That the wound would gather itself
like a river mouth filling with silt
until the water forgot
it had ever been open?

It doesn't.

Loss is a black hole pressed onto the white page
of your precious, terrified life
so wide there is no margin left,
no room for even your name.

Escape
feels like the only way.

You cannot heal the hole.
But you can build around it.

The crow knows.
She carries bright things

   a button
   an earring
   a key

to place in the dark
like small, deliberate stars.

A sunset so low and so gold
for a moment you forget yourself.
An unremarkable Tuesday
except for the scent of fresh baked bread.
A friend shaking beside you with laughter
at nothing and everything.

   Gather them.

   Hoard them.

   Be greedy.

   Be chaotic.

Let your collection be wild and unruly
as the universe itself.

These are not big moments.
Nobody will write them down in the history books.
They are small and ordinary as pennies.

And this is what you must choose.

You can collect the pennies of your pain
drop them one by one into the buckets
on the yoke across your shoulders
until the weight brings you to your knees
on a road going nowhere.

Or you can gather the bright ordinary
and build your own messy, improbable mountain
to climb hand over hand
sparkle by sparkle
up and out of the dark.

The hole does not shrink.
The page grows.
New color, new ink, new life
layered around that dark dot
until it's small enough to carry
without kneeling.

The glimmers do not erase grief.
They give you the one thing you need
when you want nothing more
than to escape the night.

    Hope

which is not a promise
but a direction
a leaning of the self into tomorrow.
And the crow is already flying
with something shining in her beak.
        </p>
      </div>
    </div>
    """
  end

  defp container_classes, do: "mx-auto max-w-3xl px-3 py-4"

  defp h1_classes, do: "text-3xl sm:text-4xl font-bold tracking-tight text-gray-900 mb-6"
  defp h3_classes, do: "text-xl font-semibold text-gray-900 mt-8 mb-3"

  defp p_classes, do: "text-gray-800 leading-relaxed mb-4 whitespace-pre-wrap"

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
