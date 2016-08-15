defmodule TDG.PageControllerTest do
  use TDG.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Generate"
  end
end
