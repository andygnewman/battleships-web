module StepHelpers

  SHIP_CELLS = [["A","1"],["A","2"],["A","3"],["A","4"],["A","5"],
                ["B","1"],["B","2"],["B","3"],["B","4"],
                ["C","1"],["C","2"],["C","3"],
                ["D","1"],["D","2"],["D","3"],
                ["E","1"],["E","2"]]


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

  def take_a_shot(c, r)
    select c, from: "column"
    select r, from: "row"
    click_on 'submit'
  end

  def sink_fleet
    last_cell = SHIP_CELLS.pop
    SHIP_CELLS.each do |cell|
      take_a_shot(cell[0], cell[1])
      next_player_shot
      take_a_shot(cell[0], cell[1])
      next_player_shot
    end
    take_a_shot(last_cell[0], last_cell[1])
  end

  def next_player_shot
    click_on 'Next Player Turn'
    click_on 'click this link'
  end

  def ready_for_battle
    click_on 'Click here to start the battle!'
    click_on 'Let Battleships Commence!'
  end

end

World(StepHelpers)
