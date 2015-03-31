module StepHelpers

  def place_all_ships
    [*"A".."E"].each do |c|
      select c, from: "column"
      select "1", from: "row"
      choose "horizontal"
      click_on 'submit'
    end
  end

end

World(StepHelpers)
