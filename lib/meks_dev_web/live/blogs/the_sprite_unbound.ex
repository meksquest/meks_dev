defmodule MeksDevWeb.BlogsLive.TheSpriteUnbound do
  use MeksDevWeb, :live_view

  def mount(_, _, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="bg-journal-cream paper-texture">
      <.primary_button href={~p"/"} class="handwritten text-xl m-8">
        meks.quest
      </.primary_button>

      <.primary_button href={~p"/stories"} class="handwritten text-xl m-3">
        Stories
      </.primary_button>

      <div class={container_classes()}>
        <h1 class={h1_classes()}>The Sprite Unbound</h1>
        <h3 class={h3_classes()}>Meks McClure · April 26, 2026</h3>

        <div class={poem_classes()}>
          <p class={p_classes()}>
            <em>Look —</em><b  r />
            <em>do you see him?</em>
          </p>

          <p class={p_classes()}>
            There, at the edge of the forest.<br /> The one who has just remembered<br />
            he has a body.
          </p>

          <p class={p_classes()}>
            He was held a long time<br /> in a country with no name,<br />
            where the light was the wrong color<br /> and the ground gave nothing back.
          </p>

          <p class={p_classes()}>
            He learned to be small there.<br /> He learned to be silent.
          </p>

          <p class={p_classes()}>But look at him now.</p>

          <hr class={hr_classes()} />

          <p class={p_classes()}><strong>He is laughing.</strong></p>

          <p class={p_classes()}>
            Loud and doubling over<br /> in the middle of a Tuesday<br />
            as the world tilts sideways —
          </p>

          <p class={p_classes()}>
            and then soft at the edge of the day,<br /> the contented exhale that means<br />
            <em>yes, this</em>.
          </p>

          <p class={p_classes()}>
            He laughs, and then looks surprised<br /> as if he had forgotten<br />
            that joy was something he was,<br /> not something he had to earn.
          </p>

          <p class={p_classes()}><em>Look at him. Do you see?</em></p>

          <hr class={hr_classes()} />

          <p class={p_classes()}><strong>He is creating.</strong></p>

          <p class={p_classes()}>
            Watch his hands —<br /> how they move like they know a secret,<br />
            how he finds the glimmer in everything<br /> and makes more of it.
          </p>

          <p class={p_classes()}>
            He is leaving traces.<br /> Small deliberate stars<br /> in every room he passes through.
          </p>

          <p class={p_classes()}><em>Look at him. Do you see?</em></p>

          <hr class={hr_classes()} />

          <p class={p_classes()}><strong>He is loving.</strong></p>

          <p class={p_classes()}>
            Not carefully. Not in measured amounts.<br />
            The kind that opens its hands and doesn't count what's given.<br />
            The kind that lets you be held.
          </p>

          <p class={p_classes()}>
            He is letting himself be known —<br /> and this is the bravest thing,<br />
            after the long silence,<br /> after the country with no name.
          </p>

          <p class={p_classes()}>
            He belongs — to people, to place,<br /> to the living web of care that moves between us.
          </p>

          <p class={p_classes()}><em>Look at him. Do you see?</em></p>

          <hr class={hr_classes()} />

          <p class={p_classes()}><strong>He is dancing.</strong></p>

          <p class={p_classes()}>
            In the ballroom. In the kitchen.<br /> In the forest with bare feet and no audience.
          </p>

          <p class={p_classes()}>
            There are places where the world grows thin,<br />
            where the music and the earth and the body<br /> become one thing,<br />
            and something older and wilder<br /> rises up to meet you.
          </p>

          <p class={p_classes()}>
            I watch him find the stillness<br /> between the steps,<br /> the anchor,<br />
            the settle,<br /> the weight of himself<br /> returned to his own body.
          </p>

          <p class={p_classes()}>
            He knows those places. He goes looking for them.<br /> And he knows the way home.
          </p>

          <p class={p_classes()}><em>Look at him. Do you see?</em></p>

          <hr class={hr_classes()} />

          <p class={p_classes()}><strong>He is asking.</strong></p>

          <p class={p_classes()}>
            He turns to me,<br />
            <em>why</em> breathing across his lips.<br />
            <em>I want to know what shaped you,</em> <br />
            <em>what you carry,</em> <br />
            <em>what you dream about when no one is watching.</em>
          </p>

          <p class={p_classes()}>
            He asks why of himself, too.<br /> Sits with the silence until it answers.
          </p>

          <p class={p_classes()}>
            He is not trying to arrive.<br /> He moves — following the thread,<br />
            stretching toward the next question,<br /> the next version of himself he hasn't met yet.
          </p>

          <p class={p_classes()}><em>Look at him. Do you see?</em></p>

          <hr class={hr_classes()} />

          <p class={p_classes()}><strong>He is laughter, flame, love, movement, wonder.</strong></p>

          <p class={p_classes()}>
            He is not healed.<br /> He is not finished.<br /> He is not the same as before —
          </p>

          <p class={p_classes()}>
            He is something that has been through fire<br /> and come out knowing its own name.
          </p>

          <p class={p_classes()}>The flame burns.</p>

          <p class={p_classes()}>The wild dances.</p>

          <p class={p_classes()}>The warmth holds.</p>

          <p class={p_classes()}><em>Look at him.</em></p>

          <p class={p_classes()}>
            He is exactly enough.<br /> He is exactly this.
          </p>

          <p class={p_classes()}><em>And he is beautiful.</em></p>
        </div>
      </div>
    </div>
    """
  end

  defp container_classes, do: "mx-auto max-w-3xl px-6 py-8"

  defp h1_classes, do: "text-3xl sm:text-4xl font-bold tracking-tight text-gray-900 mb-6"
  defp h3_classes, do: "text-xl font-semibold text-gray-900 mt-8 mb-3"

  defp poem_classes, do: "mt-10 space-y-2"

  defp p_classes, do: "text-gray-800 leading-relaxed mb-4"

  defp hr_classes, do: "my-8 border-t border-gray-300"

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
