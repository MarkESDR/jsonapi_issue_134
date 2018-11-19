defmodule JsonapiIssue134Web.CommentControllerTest do
  use JsonapiIssue134Web.ConnCase

  alias JsonapiIssue134.Content
  alias JsonapiIssue134.Content.Comment

  @post_attrs %{
    name: "some post"
  }
  @create_attrs %{
    body: "some body"
  }
  @update_attrs %{
    body: "some updated body"
  }
  @invalid_attrs %{body: nil}

  def fixture(:post) do
    {:ok, post} = Content.create_post(@post_attrs)
    post
  end

  def fixture(:comment) do
    %{id: post_id} = fixture(:post)
    attrs = Map.merge(@create_attrs, %{post_id: post_id})
    {:ok, comment} = Content.create_comment(attrs)
    comment
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all comments", %{conn: conn} do
      conn = get(conn, Routes.comment_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "jsonapi" do
    setup [:create_comment]

    test "allows valid includes", %{conn: conn, comment: comment} do
      conn = get(conn, Routes.comment_path(conn, :show, comment, include: "post"))

      assert %{
               "data" => %{"relationships" => %{"post" => %{"data" => %{"id" => id}}}},
               "included" => [%{"type" => "posts", "id" => id}]
             } = json_response(conn, 200)
    end
  end

  describe "create comment" do
    test "renders comment when data is valid", %{conn: conn} do
      %{id: post_id} = fixture(:post)
      attrs = Map.merge(@create_attrs, %{post_id: post_id})
      conn = post(conn, Routes.comment_path(conn, :create), comment: attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.comment_path(conn, :show, id))

      assert %{
               "id" => id,
               "attributes" => %{"body" => "some body"}
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.comment_path(conn, :create), comment: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update comment" do
    setup [:create_comment]

    test "renders comment when data is valid", %{conn: conn, comment: %Comment{id: id} = comment} do
      conn = put(conn, Routes.comment_path(conn, :update, comment), comment: @update_attrs)
      id = Integer.to_string(id, 10)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.comment_path(conn, :show, id))

      assert %{
               "id" => id,
               "attributes" => %{"body" => "some updated body"}
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, comment: comment} do
      conn = put(conn, Routes.comment_path(conn, :update, comment), comment: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete comment" do
    setup [:create_comment]

    test "deletes chosen comment", %{conn: conn, comment: comment} do
      conn = delete(conn, Routes.comment_path(conn, :delete, comment))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.comment_path(conn, :show, comment))
      end
    end
  end

  defp create_comment(_) do
    comment = fixture(:comment)
    {:ok, comment: comment}
  end
end
