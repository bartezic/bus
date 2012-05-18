class ReserveNotification
  @queue = :reserve_notification_queue

  def self.perform(reservation_id)
    reservation = Reservation.find(reservation_id)
    UserMailer.reserve_email(reservation.name,reservation.email).deliver
    ManagerMailer.reserve_email(reservation).deliver
  end
end