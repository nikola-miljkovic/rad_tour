defmodule TourGuide.TourInstanceControllerTest do
  use TourGuide.ConnCase

  alias TourGuide.TourInstance
  @valid_attrs %{capacity: 42, registred: 42, status: 42, time: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, tour_instance_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing tour instances"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, tour_instance_path(conn, :new)
    assert html_response(conn, 200) =~ "New tour instance"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, tour_instance_path(conn, :create), tour_instance: @valid_attrs
    assert redirected_to(conn) == tour_instance_path(conn, :index)
    assert Repo.get_by(TourInstance, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, tour_instance_path(conn, :create), tour_instance: @invalid_attrs
    assert html_response(conn, 200) =~ "New tour instance"
  end

  test "shows chosen resource", %{conn: conn} do
    tour_instance = Repo.insert! %TourInstance{}
    conn = get conn, tour_instance_path(conn, :show, tour_instance)
    assert html_response(conn, 200) =~ "Show tour instance"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, tour_instance_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    tour_instance = Repo.insert! %TourInstance{}
    conn = get conn, tour_instance_path(conn, :edit, tour_instance)
    assert html_response(conn, 200) =~ "Edit tour instance"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    tour_instance = Repo.insert! %TourInstance{}
    conn = put conn, tour_instance_path(conn, :update, tour_instance), tour_instance: @valid_attrs
    assert redirected_to(conn) == tour_instance_path(conn, :show, tour_instance)
    assert Repo.get_by(TourInstance, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    tour_instance = Repo.insert! %TourInstance{}
    conn = put conn, tour_instance_path(conn, :update, tour_instance), tour_instance: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit tour instance"
  end

  test "deletes chosen resource", %{conn: conn} do
    tour_instance = Repo.insert! %TourInstance{}
    conn = delete conn, tour_instance_path(conn, :delete, tour_instance)
    assert redirected_to(conn) == tour_instance_path(conn, :index)
    refute Repo.get(TourInstance, tour_instance.id)
  end
end
