defmodule TourGuide.TourInstanceTest do
  use TourGuide.ModelCase

  alias TourGuide.TourInstance

  @valid_attrs %{capacity: 42, registred: 42, status: 42, time: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = TourInstance.changeset(%TourInstance{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = TourInstance.changeset(%TourInstance{}, @invalid_attrs)
    refute changeset.valid?
  end
end
