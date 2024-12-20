require "test_helper"

class EventsControllerTest < ActionDispatch::IntegrationTest #inherited class
  setup do #setup creates a valid event object defining set of valid parameters
    @event = events(:one) 
    @new_event_params = { # test when send a JSON data parameters
      event: {
        name: "Concert",
        description: "Big concert",
        price: 20.0,
        total_tickets: 100,
        remaining_tickets: 100
      }
    }
  end

  test "getting index? expected: yes" do #success if receive data
    get events_url, as: :json
    assert_response :success
    assert_includes @response.body, @event.name
  end

  test "showing event? expected: yes" do #test if fetching event
    get event_url(@event), as: :json
    assert_response :success
    assert_includes @response.body, @event.name
  end

  test "creating event? expected: yes" do  #test if event is created
    assert_difference("Event.count") do
      post events_url, params: @new_event_params, as: :json
    end
    assert_response :created
  end

  test "updating event? expected: yes" do #test event update
    updated_name = "Updated Event Name"
    patch event_url(@event), params: { event: { name: updated_name } }, as: :json
    assert_response :success
    @event.reload
    assert_equal updated_name, @event.name
  end

  test "updating with invalid data? expected: no" do #test with a -5 input
    patch event_url(@event), params: { event: { total_tickets: -5 } }, as: :json
    assert_response :unprocessable_entity
  end 
  #got error on this test, the application is accept -5

  test "destroy event? expected: yes" do #test delete event
    assert_difference("Event.count", -1) do
      delete event_url(@event), as: :json
    end
    assert_response :no_content
  end


end
