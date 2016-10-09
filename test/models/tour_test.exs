defmodule TourGuide.TourTest do
  use TourGuide.ModelCase

  alias TourGuide.Tour

  @valid_attrs %{rating: "120.5", title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Tour.changeset(%Tour{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Tour.changeset(%Tour{}, @invalid_attrs)
    refute changeset.valid?
  end
end
