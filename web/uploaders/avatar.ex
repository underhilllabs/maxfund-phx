defmodule Maxfund.Avatar do
  use Arc.Definition
  use Arc.Ecto.Definition

  def __storage, do: Arc.Storage.Local # Add this
  # Include ecto support (requires package arc_ecto installed):
  # use Arc.Ecto.Definition

  #@versions [:original]

  # To add a thumbnail version:
  @versions [:original, :profile, :thumb]

  # Whitelist file extensions:
  def validate({file, _}) do
    ~w(.jpg .jpeg .gif .png) |> Enum.member?(Path.extname(file.file_name))
  end

  # Define a thumbnail transformation:
  def transform(:thumb, _) do
    {:convert, "-strip -thumbnail 300x300^ -gravity center -extent 300x300 -format png"}
  end
  # Define profile picture
  def transform(:profile, _) do
    {:convert, "-strip -thumbnail 500x500^ -gravity center -extent 500x500 -format png"}
  end

  # To retain the original filename, but prefix the version and user id:
	def filename(version, {file, scope}) do
		"#{scope.id}_#{version}_#{file.file_name}"
	end
  # Override the persisted filenames:
  # def filename(version, _) do
  #   version
  # end

  # Override the storage directory:
  # def storage_dir(version, {file, scope}) do
  #   "uploads/user/avatars/#{scope.id}"
  # end

  # Provide a default URL if there hasn't been a file uploaded
  # def default_url(version, scope) do
  #   "/images/avatars/default_#{version}.png"
  # end
end
