defmodule Maxfund.CatDetail do
  alias Maxfund.Repo
  alias Maxfund.Avatar

  @doc """
  Scrapes page for cat with id `Maxfund.Cat.maxfund_id`

  Returns the full page body 
  """

  @special_cats_url "http://ws.petango.com/webservices/adoptablesearch/wsAdoptableAnimals.aspx?species=Cat&gender=A&agegroup=All&location=&site=&onhold=A&orderby=ID&colnum=3&authkey=p7g1vsddpj3s7t2rpej6xav1kdgniumbqmxsefs8vrr5v2hjln&recAmount=&detailsInPopup=No&featuredPet=Include&stageID=35515"
  @reg_cats_url "http://ws.petango.com/webservices/adoptablesearch/wsAdoptableAnimals.aspx?species=Cat&gender=A&agegroup=All&location=&site=&onhold=A&orderby=ID&colnum=3&authkey=p7g1vsddpj3s7t2rpej6xav1kdgniumbqmxsefs8vrr5v2hjln&recAmount=&detailsInPopup=No&featuredPet=Include&stageID=2"
  @cat_detail_url "http://ws.petango.com/webservices/adoptablesearch/wsAdoptableAnimalDetails.aspx?id="

  
  def get_cats() do
    @reg_cats_url |>
    scrape_page |>
    get_ids 
    #Enum.map(&(Maxfund.CatDetail.get_cat(&1)))
  end
     

  # scrape and insert the cat
  def get_cat(cat_id) do
    scrape(cat_id) |>
    parse_cat |>
    insert_cat
  end

  def scrape(cat_id) do
    url = @cat_detail_url <> cat_id
    %{body: body} = HTTPoison.get!(url) 
    body
  end

  def parse_cat(page) do
    age = Floki.find(page, "span#lbAge") |> Floki.text
    breed = Floki.find(page, "span#lbBreed") |> Floki.text
    color = Floki.find(page, "span#lblColor") |> Floki.text
    desc = parse_detail(page)
    maxfund_id = Floki.find(page, "span#lblID") |> Floki.text
    img = get_image(page)
    IO.puts "image is #{img}"
    intake_date = Floki.find(page, "span#lblIntakeDate") |> Floki.text
    location = Floki.find(page, "span#lblLocation") |> Floki.text
    name = Floki.find(page, "span#lbName") |> Floki.text
    sex = Floki.find(page, "span#lbSex") |> Floki.text
    cat_size = Floki.find(page, "span#lblSize") |> Floki.text

    cat = %{
      age: age,
      breed: breed,
      color: color,
      description: desc,
      avatar: img,
      intake_date: intake_date,
      location: location,
      maxfund_id: maxfund_id,
      name: name,
      sex: sex,
      cat_size: cat_size,
    }
    IO.puts "here's the new cat"
    IO.inspect cat
    cat
  end

  def parse_detail(page) do
    description = Floki.find(page, "span#lbDescription") |> Floki.text
    description
  end

  def get_image(page) do
    img_s = Floki.find(page, "img#imgAnimalPhoto") |> 
          Floki.attribute("src")  |>
          List.first
    img = "http:#{img_s}" 
    IO.puts "img is #{img}"
    #{:ok, file} = Avatar.store(img)
    #file
    img
  end

  
  @doc """
  Parses html for cat ids

  Returns a list of `Maxfund.Cat.maxfund_id`
  """
  def get_ids(body) do
    cat_ids = Floki.find(body, "div.list-animal-id")  |> Enum.map(fn(x) -> Floki.text(x) end)
    cat_ids
  end

  def insert_cat(cat_params) do
    IO.inspect cat_params
    IO.puts "maxfund id is #{cat_params.maxfund_id}"
    changeset =
      case Repo.get_by(Maxfund.Cat, maxfund_id: cat_params.maxfund_id) do
        nil -> %Maxfund.Cat{} # Post not found, we build one
        cat -> cat          # Post exists, let's use it
      end |>
      Maxfund.Cat.changeset(cat_params)
    IO.inspect changeset
    Repo.insert_or_update(changeset)
  end

  def scrape_page(url) do
    # url = ""
    %{body: body} = HTTPoison.get!(url)
    body
  end
end
