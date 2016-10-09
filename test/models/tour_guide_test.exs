defmodule TourGuide.TourGuideTest do
  use TourGuide.ModelCase

  alias TourGuide.TourGuide

  @valid_attrs %{about: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = TourGuide.changeset(%TourGuide{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = TourGuide.changeset(%TourGuide{}, @invalid_attrs)
    refute changeset.valid?
  end
end
