module StepHelpers

  def place_all_ships
    [*"A".."E"].each do |c|
      select c, from: "column"
      select "1", from: "row"
      choose "horizontal"
      click_on 'submit'
    end
  end

  def ready_to_register_player_1
    visit '/'
    click_on 'new game'
    click_on "Register Player 1"
  end

  def register_player_1(name = "Andy")
    fill_in 'player_name', with: name
    click_on 'submit'
  end

  def register_player_2(name = "Josh")
    click_on "Click here to register Player 2"
    fill_in 'player_name', with: name
    click_on 'submit'
  end

  def register_and_place_ships
    ready_to_register_player_1
    register_player_1
    place_all_ships
    register_player_2
    place_all_ships
  end

end

World(StepHelpers)
