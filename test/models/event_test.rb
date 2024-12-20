require "test_helper"

class EventTest < ActiveSupport::TestCase
  setup do
    @event = events(:one) 
    @valid_event_params = { #assuming assuming test with this parameters
      name: "Concert",
      description: "Description",
      price: 100.0,
      total_tickets: 100,
      remaining_tickets: 50
    }
  end

  test "pricing increasing if less than 10%? expected:yes" do # math test remaining tickets
    event = Event.create(@valid_event_params.merge(remaining_tickets: 10))
    original_price = event.price
    event.save 
    assert_equal original_price * 1.10, event.reload.price, "Increase 10% if there are 10% tickets left"
  end

  test "pricing increasing if more than 10% remaining? expected:no" do #math test 
    event = Event.create(@valid_event_params.merge(remaining_tickets: 20))
    original_price = event.price
    event.save 
    assert_equal original_price, event.reload.price, "Price should not change if remaining tickets are greater than 10%"
  end

  test "buy successfuly when avaliable? expected: yes" do #test if successful bought decreasing the number
    event = Event.create(@valid_event_params.merge(remaining_tickets: 10))
    initial_remaining_tickets = event.remaining_tickets
    event.buy_ticket
    assert_equal initial_remaining_tickets - 1, event.reload.remaining_tickets, "Decreasing 1 if ticket have been bought"
  end

  test "destroy comments if event is deleted? expected: yes" do #test if deleted event remaing comments
    event = Event.create(@valid_event_params)
    comment = Comment.create(content: "Good Event", user_name: "Vinny", event: event)
    assert_difference("Comment.count", -1) do
      event.destroy
    end
  end
end
