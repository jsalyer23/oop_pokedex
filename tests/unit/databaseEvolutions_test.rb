require 'test_helper'

class DatabaseEvolutionsTest < Minitest::Test
  def setup
    super

	@id_test = Evolutions.new('', 18)
	@new_id_test = Evolutions.new('', 24)
    # This setup will automatically be run before each test below.
  end

  # Your tests are defined here. Tests must be contained in a method
  # that begins with test_ or it won't work. An example test:

  def test_stage1_chain
  	evolution_chain = Evolutions.evolution_chain("Squirtle")

  	assert_kind_of(Object, evolution_chain)
  	assert_equal("Squirtle", evolution_chain.stage1)
  	refute_nil(evolution_chain)
  end

  def test_stage2_chain
  	evolution_chain = Evolutions.evolution_chain("Wartortle")

  	assert_kind_of(Object, evolution_chain)
  	assert_equal("Wartortle", evolution_chain.stage2)
  	refute_nil(evolution_chain)
  end

  def test_stage3_chain
  	evolution_chain = Evolutions.evolution_chain("Blastoise")

  	assert_kind_of(Object, evolution_chain)
  	assert_equal( "Blastoise", evolution_chain.stage3)
  	refute_nil(evolution_chain)
  end

  def test_display_stage1_for_stage1
  	stage1 = Evolutions.evolution_chain("Squirtle")

    assert_kind_of(Object, stage1)
  	assert_kind_of(String, stage1.stage1)
  	refute_nil(stage1)
  	assert_equal("Squirtle", stage1.stage1)
  end

  def test_display_stage1_for_stage2
  	stage1 = Evolutions.evolution_chain("Wartortle")

    assert_kind_of(Object, stage1)
  	assert_kind_of(String, stage1.stage1)
  	refute_nil(stage1)
  	assert_equal("Squirtle", stage1.stage1)
  end

  def test_display_stage1_for_stage3
  	stage1 = Evolutions.evolution_chain("Blastoise")

    assert_kind_of(Object, stage1)
  	assert_kind_of(String, stage1.stage1)
  	refute_nil(stage1)
  	assert_equal("Squirtle", stage1.stage1)
  end

  def test_display_stage2_for_stage3
  	stage2 = Evolutions.evolution_chain("Blastoise")

    assert_kind_of(Object, stage2)
  	assert_kind_of(String, stage2.stage2)
  	refute_nil(stage2)
  	assert_equal("Wartortle", stage2.stage2)
  end

    def test_display_stage2_for_stage2
  	stage2 = Evolutions.evolution_chain("Wartortle")

    assert_kind_of(Object, stage2)
  	assert_kind_of(String, stage2.stage2)
  	refute_nil(stage2)
  	assert_equal("Wartortle", stage2.stage2)
  end

  def test_display_stage2_for_stage1
  	stage2 = Evolutions.evolution_chain("Squirtle")

    assert_kind_of(Object, stage2)
  	assert_kind_of(String, stage2.stage2)
  	refute_nil(stage2)
  	assert_equal("Wartortle", stage2.stage2)
  end

  def test_display_stage3_for_stage1
  	stage3 = Evolutions.evolution_chain("Squirtle")

    assert_kind_of(Object, stage3)
  	assert_kind_of(String, stage3.stage3)
  	refute_nil(stage3)
  	assert_equal("Blastoise", stage3.stage3)
  end

  def test_display_stage3_for_stage2
  	stage3 = Evolutions.evolution_chain("Wartortle")

    assert_kind_of(Object, stage3)
  	assert_kind_of(String, stage3.stage3)
  	refute_nil(stage3)
  	assert_equal("Blastoise", stage3.stage3)
  end

  def test_display_stage3_for_stage3
  	stage3 = Evolutions.evolution_chain("Blastoise")

    assert_kind_of(Object, stage3)
  	assert_kind_of(String, stage3.stage3)
  	refute_nil(stage3)
  	assert_equal("Blastoise", stage3.stage3)
  end

  def test_evolution_columns
  	instance = Evolutions.new
    columns = instance.evolution_columns
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