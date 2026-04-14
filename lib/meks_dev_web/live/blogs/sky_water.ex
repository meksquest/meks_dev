defmodule MeksDevWeb.BlogsLive.SkyWater do
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
        <h1 class={h1_classes()}>Sky Water</h1>
        <h3 class={h3_classes()}>Meks McClure · November 22, 2025</h3>

        <p class={p_classes()}>
          It's 10 am and I'm out walking the dusty streets of Bali, looking for a tailor I found on the internet.
        </p>

        <p class={p_classes()}>
          I bought a pair of linen pants yesterday — bright, sunny orange, much more colorful than my typical black. And they have <em>pockets</em>! Only problem is, they're too long. Like untied-shoelaces-threat-of-tripping too long. Everything else I brought is woefully too warm. So these pants need to work, and they need to work by 2:00 pm, when I leave for a wedding.
        </p>

        <p class={p_classes()}>
          I find the place down a narrow alley: an off-kilter door with a sewing needle and thread painted onto it. The dog dozing on the step opens one eye suspiciously. A woman answers promptly — tape measure around her neck, scissors in one hand, pillow full of pins in the other.
          <em>Ok, I'm definitely in the right place.</em>
        </p>

        <p class={p_classes()}>
          She marks the hem, I hand over the pants, and ask if she can do it by 2:00. "No problem." How much? 50,000 rupiah. I do some quick math: <em>3 USD</em>. I try to hide the shock, nod my head, and go to collect the cash.
        </p>

        <p class={p_classes()}>
          When I come back a couple of hours later, they fit perfectly, hitting just above my ankle. I give her 75,000 rupiah and tell her to keep the change. I step back over the dog, who hasn't moved.
        </p>

        <hr class="my-6 border-gray-300" />

        <p class={p_classes()}>
          Now: getting to the wedding. Realistically, the only way to get there is to hire a scooter driver.
        </p>

        <p class={p_classes()}>
          Riding a scooter through Balinese traffic, even as a passenger, has a very specific emotional arc: you get on, take a deep breath, and wonder,
          <em>okay… is this the time I die?</em>
        </p>

        <p class={p_classes()}>
          Then you merge into traffic and stop thinking altogether. The engine roars, oil and exhaust filling my nostrils, as we dodge and weave — street dogs, potholes, other scooters close enough to touch as they scream past. Through a narrow section of pavement with brambles reaching out for unsuspecting passersby, I feel a sharp brush against my foot and ankle and take in a gulp of air.
        </p>

        <p class={p_classes()}>
          By the time I arrive, my heart is pounding from the lingering adrenaline. The cortisol gradually eases as I walk into a lush garden full of tall trees, deep green everywhere, the kind of place that feels like an oasis rather than a venue.
        </p>

        <p class={p_classes()}>
          I find a place in the open-air seating near the back. The groom is already standing at the front in a deep purple suit with subtle colors, textures, and patterns that I've only ever seen in Bali — the kind of thing only someone like Marcus, who grew up here, could pull off. When the bride arrives in her white gown and veil, she passes off her bouquet, and they greet each other in a mix of English and Indonesian that somehow tells you everything about how they met — Zoe from New Zealand, Marcus from Indonesia, the ceremony blending both worlds. Vows, shared rice, a drink passed between them.
        </p>

        <p class={p_classes()}>
          As the singing begins, a light rain starts to fall. A gentle pattering on the wooden shingles.
        </p>

        <p class={p_classes()}>
          Light at first. Gentle.
        </p>

        <p class={p_classes()}>
          Then heavier.
        </p>

        <p class={p_classes()}>
          Then <em>loud</em>.
        </p>

        <p class={p_classes()}>
          Now the rain is pounding on the roof, I can no longer hear what is being said into the microphone, and the backdrop behind Marcus and Zoe is a sheet of water, obscuring the garden, which is a faint blur of color.
        </p>

        <p class={p_classes()}>
          Just as the bride and groom go to kiss, there's a flash of lightning and a roll of thunder that shakes my ribcage, as if the skies themselves were intent on blessing the ceremony too.
        </p>

        <hr class="my-6 border-gray-300" />

        <p class={p_classes()}>
          Once Zoe and Marcus are sent off for a brief reprieve, everyone eagerly moves into the reception room where we can smell the tantalizing fragrances of slow-cooked beef, basmati rice, and spices and herbs I've never heard of.
        </p>

        <p class={p_classes()}>
          As I'm eating my "not spicy" rice dish — which is actively bringing tears to my eyes and making me question the sanity of a person who calls this "not spicy" — I overhear one of Marcus's foreign friends ask, "Hey, where are all your surfer friends?"
        </p>

        <p class={p_classes()}>
          Marcus shrugs. "It's raining."
        </p>

        <p class={p_classes()}>
          There's a pause.
        </p>

        <p class={p_classes()}>
          The kind of pause that only people who have never lived in the tropics can produce.
        </p>

        <p class={p_classes()}>
          "…and?" someone else pipes in.
        </p>

        <p class={p_classes()}>
          "They won't come while it's raining. They'll show up later when it stops," he explains confidently.
        </p>

        <p class={p_classes()}>
          <em>Surfers</em>. People who voluntarily spend most of their time <em>in the ocean</em>.
        </p>

        <p class={p_classes()}>
          And they missed their good friend's wedding because… sky water.
        </p>

        <hr class="my-6 border-gray-300" />

        <p class={p_classes()}>
          Marcus is right about the rain. As dinner is wrapping up and the live band is beginning to play, the rain gradually quiets and then stops altogether.
        </p>

        <p class={p_classes()}>
          The dance floor picks up, switching between Western English songs and Indonesian ones, different groups cycling in and out, everyone slowly blending together with the occasional guest stealing the microphone for some impromptu karaoke.
        </p>

        <p class={p_classes()}>
          And then, during a particularly bumping song, as if on cue, they arrive.
        </p>

        <p class={p_classes()}>
          A full pack of surfer guys surges onto the dance floor as if they've been released from a dam. The energy immediately spikes — louder, rowdier, more chaotic. Marcus is beaming, the center of attention with Zoe. And with the surfers comes the chaos they were apparently saving up: fireworks.
        </p>

        <p class={p_classes()}>
          Not sparklers. Not a polite series of poppers.
        </p>

        <p class={p_classes()}>
          Actual, large, booming, <em>this-feels-like-it-should-require-a-permit</em> fireworks. In the middle of the garden. Under the trees.
        </p>

        <p class={p_classes()}>
          I'm ducking and weaving, trying to figure out where to stand so I don't lose an eye to a falling ember.
        </p>

        <p class={p_classes()}>
          At one point, a piece lands in a tree and starts to burn…
        </p>

        <p class={p_classes()}>
          …and immediately goes out. Everything is still soaked from the rain.
        </p>

        <p class={p_classes()}>
          Standing there, half-hidden behind a tree, watching sparks rain down on branches that refuse to catch fire, I realize: the surfers were right to respect the rain. Just not for the reasons I thought.
        </p>
      </div>
    </div>
    """
  end

  defp container_classes, do: "mx-auto max-w-3xl px-6 py-8"

  defp h1_classes, do: "text-3xl sm:text-4xl font-bold tracking-tight text-gray-900 mb-6"
  defp h3_classes, do: "text-xl font-semibold text-gray-900 mt-8 mb-3"

  defp p_classes, do: "text-gray-800 leading-relaxed mb-4"

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
