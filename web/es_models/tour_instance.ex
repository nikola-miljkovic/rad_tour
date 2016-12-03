defmodule TourGuide.ES.TourInstance do
  @moduledoc false

  @derive [Poison.Encoder]
  defstruct [
    :id, :time, :capacity, :registered, :status,             #tour_instance
    :tour_id, :title, :rating, :description, :category_id,  #tour
    :tour_guide_id,                                         #tour_guide
    :tour_guide_first_name, :tour_guide_last_name           #user
    ]

end