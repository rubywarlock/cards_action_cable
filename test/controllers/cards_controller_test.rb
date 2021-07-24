require "test_helper"

# rails test test/controllers/cards_controller_test.rb

class CardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @card = cards(:one)
  end

  test "should get index" do
    get cards_url
    assert_response :success
  end

  test "should get new" do
    get new_card_url
    assert_response :success
  end

  test "should create card" do
    assert_difference('Card.count') do
      post cards_url, params: {
        card: {
          words_pair_attributes: {
            original_text: "one", translate: "ONE"
          }
        }
      }
    end

    words_pair = WordsPair.find_by(original_text: "one", translate: "ONE")

    assert_not_nil(words_pair)

    assert_redirected_to card_url(Card.last)
  end

  test "should show card" do
    get card_url(@card)
    assert_response :success
  end

  test "should get edit" do
    get edit_card_url(@card)
    assert_response :success
  end

  test "should update card" do
    patch card_url(@card), params: {
      card: {
        words_pair_attributes: {
          original_text: "ONE", translate: "FIRST"
        }
      }
    }

    words_pair = WordsPair.find_by(original_text: "one", translate: "ONE")
    assert_nil(words_pair)

    words_pair = WordsPair.find_by(original_text: "ONE", translate: "FIRST")
    assert_not_nil(words_pair)

    assert_redirected_to card_url(@card)
  end

  test "should destroy card" do
    assert_difference('Card.count', -1) do
      delete card_url(@card)
    end

    assert_redirected_to cards_url
  end

  test "apply" do
    patch apply_url(@card), params: {
      card: {
        card_id: @card.id, result_status: "0"
      }
    }

    assert_equal "1", @card.level

    @card.reload

    assert_equal "2", @card.level

    assert_response :success
  end
end
