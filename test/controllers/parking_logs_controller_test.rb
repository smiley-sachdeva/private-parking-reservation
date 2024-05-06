require "test_helper"

class ParkingLogsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @parking_log = parking_logs(:one)
  end

  test "should get index" do
    get parking_logs_url
    assert_response :success
  end

  test "should get new" do
    get new_parking_log_url
    assert_response :success
  end

  test "should create parking_log" do
    assert_difference("ParkingLog.count") do
      post parking_logs_url, params: { parking_log: { checkin_time: @parking_log.checkin_time, checkout_time: @parking_log.checkout_time, duration: @parking_log.duration, plate_number: @parking_log.plate_number, price: @parking_log.price, reservation_id: @parking_log.reservation_id } }
    end

    assert_redirected_to parking_log_url(ParkingLog.last)
  end

  test "should show parking_log" do
    get parking_log_url(@parking_log)
    assert_response :success
  end

  test "should get edit" do
    get edit_parking_log_url(@parking_log)
    assert_response :success
  end

  test "should update parking_log" do
    patch parking_log_url(@parking_log), params: { parking_log: { checkin_time: @parking_log.checkin_time, checkout_time: @parking_log.checkout_time, duration: @parking_log.duration, plate_number: @parking_log.plate_number, price: @parking_log.price, reservation_id: @parking_log.reservation_id } }
    assert_redirected_to parking_log_url(@parking_log)
  end

  test "should destroy parking_log" do
    assert_difference("ParkingLog.count", -1) do
      delete parking_log_url(@parking_log)
    end

    assert_redirected_to parking_logs_url
  end
end
