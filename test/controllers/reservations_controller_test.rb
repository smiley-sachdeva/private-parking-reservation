require "test_helper"

class ReservationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @reservation = reservations(:one)
  end

  test "should get index" do
    get reservations_url
    assert_response :success
  end

  test "should get new" do
    get new_reservation_url
    assert_response :success
  end

  test "should create reservation" do
    assert_difference("Reservation.count") do
      post reservations_url, params: { reservation: { cancellation_amount: @reservation.cancellation_amount, cancelled_at: @reservation.cancelled_at, customer_id: @reservation.customer_id, from: @reservation.from, plate_number: @reservation.plate_number, slot_id: @reservation.slot_id, to: @reservation.to, total_amount: @reservation.total_amount } }
    end

    assert_redirected_to reservation_url(Reservation.last)
  end

  test "should show reservation" do
    get reservation_url(@reservation)
    assert_response :success
  end

  test "should get edit" do
    get edit_reservation_url(@reservation)
    assert_response :success
  end

  test "should update reservation" do
    patch reservation_url(@reservation), params: { reservation: { cancellation_amount: @reservation.cancellation_amount, cancelled_at: @reservation.cancelled_at, customer_id: @reservation.customer_id, from: @reservation.from, plate_number: @reservation.plate_number, slot_id: @reservation.slot_id, to: @reservation.to, total_amount: @reservation.total_amount } }
    assert_redirected_to reservation_url(@reservation)
  end

  test "should destroy reservation" do
    assert_difference("Reservation.count", -1) do
      delete reservation_url(@reservation)
    end

    assert_redirected_to reservations_url
  end
end
