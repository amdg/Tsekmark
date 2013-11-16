module BlastsHelper
  def right_location(blast)
    blast.location != blast.blaster_location ? blast.location : blast.blaster_location
  end
end
