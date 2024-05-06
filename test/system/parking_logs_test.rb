require "application_system_test_case"

class ParkingLogsTest < ApplicationSystemTestCase
  setup do
    @parking_log = parking_logs(:one)
  end

  test "visiting the index" do
    visit parking_logs_url
    assert_selector "h1", text: "Parking logs"
  end

  test "should create parking log" do
    visit parking_logs_url
    click_on "New parking log"

    fill_in "Checkin time", with: @parking_log.checkin_time
    fill_in "Checkout time", with: @parking_log.checkout_time
    fill_in "Duration", with: @parking_log.duration
    fill_in "Plate number", with: @parking_log.plate_number
    fill_in "Price", with: @parking_log.price
    fill_in "Reservation", with: @parking_log.reservation_id
    click_on "Create Parking log"

    assert_text "Parking log was successfully created"
    click_on "Back"
  end

  test "should update Parking log" do
    visit parking_log_url(@parking_log)
    click_on "Edit this parking log", match: :first

    fill_in "Checkin time", with: @parking_log.checkin_time
    fill_in "Checkout time", with: @parking_log.checkout_time
    fill_in "Duration", with: @parking_log.duration
    fill_in "Plate number", with: @parking_log.plate_number
    fill_in "Price", with: @parking_log.price
    fill_in "Reservation", with: @parking_log.reservation_id
    click_on "Update Parking log"

    assert_text "Parking log was successfully updated"
    click_on "Back"
  end

  test "should destroy Parking log" do
    visit parking_log_url(@parking_log)
    click_on "Destroy this parking log", match: :first

    assert_text "Parking log was successfully destroyed"
  end
end
