defmodule TDG.SessionController do
  use TDG.Web, :controller

  alias TDG.Session

  def index(conn, _params) do
    sessions = Repo.all(Session)
    render(conn, "index.html", sessions: sessions)
  end

  def new(conn, _params) do
    changeset = Session.changeset(%Session{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"session" => session_params}) do
    changeset = Session.changeset(%Session{}, session_params)

    case Repo.insert(changeset) do
      {:ok, _session} ->
        conn
        |> put_flash(:info, "Session created successfully.")
        |> redirect(to: session_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    session = Repo.get!(Session, id)
    redirect(conn, to: "/generate/#{session.slug}")
  end

  def edit(conn, %{"id" => id}) do
    session = Repo.get!(Session, id)
    changeset = Session.changeset(session)
    render(conn, "edit.html", session: session, changeset: changeset)
  end

  def update(conn, %{"id" => id, "session" => session_params}) do
    session = Repo.get!(Session, id)
    changeset = Session.changeset(session, session_params)

    case Repo.update(changeset) do
      {:ok, session} ->
        conn
        |> put_flash(:info, "Session updated successfully.")
        |> redirect(to: session_path(conn, :show, session))
      {:error, changeset} ->
        render(conn, "edit.html", session: session, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    session = Repo.get!(Session, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(session)

    conn
    |> put_flash(:info, "Session deleted successfully.")
    |> redirect(to: session_path(conn, :index))
  end
end
