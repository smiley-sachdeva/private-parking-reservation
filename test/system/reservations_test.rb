require "application_system_test_case"

class ReservationsTest < ApplicationSystemTestCase
  setup do
    @reservation = reservations(:one)
  end

  test "visiting the index" do
    visit reservations_url
    assert_selector "h1", text: "Reservations"
  end

  test "should create reservation" do
    visit reservations_url
    click_on "New reservation"

    fill_in "Cancellation amount", with: @reservation.cancellation_amount
    fill_in "Cancelled at", with: @reservation.cancelled_at
    fill_in "Customer", with: @reservation.customer_id
    fill_in "From", with: @reservation.from
    fill_in "Plate number", with: @reservation.plate_number
    fill_in "Slot", with: @reservation.slot_id
    fill_in "To", with: @reservation.to
    fill_in "Total amount", with: @reservation.total_amount
    click_on "Create Reservation"

    assert_text "Reservation was successfully created"
    click_on "Back"
  end

  test "should update Reservation" do
    visit reservation_url(@reservation)
    click_on "Edit this reservation", match: :first

    fill_in "Cancellation amount", with: @reservation.cancellation_amount
    fill_in "Cancelled at", with: @reservation.cancelled_at
    fill_in "Customer", with: @reservation.customer_id
    fill_in "From", with: @reservation.from
    fill_in "Plate number", with: @reservation.plate_number
    fill_in "Slot", with: @reservation.slot_id
    fill_in "To", with: @reservation.to
    fill_in "Total amount", with: @reservation.total_amount
    click_on "Update Reservation"

    assert_text "Reservation was successfully updated"
    click_on "Back"
  end

  test "should destroy Reservation" do
    visit reservation_url(@reservation)
    click_on "Destroy this reservation", match: :first

    assert_text "Reservation was successfully destroyed"
  end
end
