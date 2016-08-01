require 'test_helper'

class DatabaseEvolutionsTest < Minitest::Test
  def setup
    super
	@squirtle = DatabaseEvolutions.new('', "Squirtle")
	@wartortle = DatabaseEvolutions.new('', "Wartortle")
	@blastoise = DatabaseEvolutions.new('', "Blastoise")
	@id_test = DatabaseEvolutions.new('', 18)
	@new_id_test = DatabaseEvolutions.new('', 24)
    # This setup will automatically be run before each test below.
  end

  # Your tests are defined here. Tests must be contained in a method
  # that begins with test_ or it won't work. An example test:

  def test_stage1_chain
  	evolution_chain = @squirtle.evolution_chain

  	assert_kind_of(Array, evolution_chain)
  	assert_equal( [{"evolution_id"=>3, "stage1"=>"squirtle", "stage2"=>"wartortle", "stage3"=>"blastoise", 0=>3, 1=>"squirtle", 2=>"wartortle", 3=>"blastoise"}], evolution_chain)
  	refute_nil(evolution_chain)
  end

  def test_stage2_chain
  	evolution_chain = @wartortle.evolution_chain

  	assert_kind_of(Array, evolution_chain)
  	assert_equal( [{"evolution_id"=>3, "stage1"=>"squirtle", "stage2"=>"wartortle", "stage3"=>"blastoise", 0=>3, 1=>"squirtle", 2=>"wartortle", 3=>"blastoise"}], evolution_chain)
  	refute_nil(evolution_chain)
  end

  def test_stage3_chain
  	evolution_chain = @blastoise.evolution_chain

  	assert_kind_of(Array, evolution_chain)
  	assert_equal( [{"evolution_id"=>3, "stage1"=>"squirtle", "stage2"=>"wartortle", "stage3"=>"blastoise", 0=>3, 1=>"squirtle", 2=>"wartortle", 3=>"blastoise"}], evolution_chain)
  	refute_nil(evolution_chain)
  end

  def test_display_stage1_for_stage1
  	stage1 = @squirtle.stage1

  	assert_kind_of(String, stage1)
  	refute_nil(stage1)
  	assert_equal("Squirtle", stage1)
  end

  def test_display_stage1_for_stage2
  	stage1 = @wartortle.stage1

  	assert_kind_of(String, stage1)
  	refute_nil(stage1)
  	assert_equal("Squirtle", stage1)
  end

  def test_display_stage1_for_stage3
  	stage1 = @blastoise.stage1

  	assert_kind_of(String, stage1)
  	refute_nil(stage1)
  	assert_equal("Squirtle", stage1)
  end

  def test_display_stage2_for_stage3
  	stage2 = @blastoise.stage2

  	assert_kind_of(String, stage2)
  	refute_nil(stage2)
  	assert_equal("Wartortle", stage2)
  end

    def test_display_stage2_for_stage2
  	stage2 = @wartortle.stage2

  	assert_kind_of(String, stage2)
  	refute_nil(stage2)
  	assert_equal("Wartortle", stage2)
  end

  def test_display_stage2_for_stage1
  	stage2 = @squirtle.stage2

  	assert_kind_of(String, stage2)
  	refute_nil(stage2)
  	assert_equal("Wartortle", stage2)
  end

  def test_display_stage3_for_stage1
  	stage3 = @squirtle.stage3

  	assert_kind_of(String, stage3)
  	refute_nil(stage3)
  	assert_equal("Blastoise", stage3)
  end

  def test_display_stage3_for_stage2
  	stage3 = @wartortle.stage3

  	assert_kind_of(String, stage3)
  	refute_nil(stage3)
  	assert_equal("Blastoise", stage3)
  end

  def test_display_stage3_for_stage3
  	stage3 = @blastoise.stage3

  	assert_kind_of(String, stage3)
  	refute_nil(stage3)
  	assert_equal("Blastoise", stage3)
  end

  def test_evolution_columns
  	columns = @squirtle.evolution_columns
  	column_names = "evolution_id, stage1, stage2, stage3"

  	assert_equal(column_names, columns)
  	refute_nil(columns)
  	assert_kind_of(String, columns)
  end

  def test_for_existing_chain
  	result = @id_test.chain_exists?

  	assert_kind_of(TrueClass, result)
  	assert_equal(TRUE, result)
  	refute_nil(result)
  end

  def test_for_non_existing_chain
  	result = @new_id_test.chain_exists?

  	assert_kind_of(FalseClass, result)
  	assert_equal(FALSE, result)
  	refute_nil(result)
  end
end