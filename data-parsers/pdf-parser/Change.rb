class Change
  attr_reader :semesters_lost
  attr_reader :semesters_gained
  attr_reader :course_id

  def initialize(course_id, semesters_lost, semesters_gained)
    @semesters_lost = semesters_lost
    @semesters_gained = semesters_gained
    @course_id = course_id
  end

  def changed?
    @semesters_lost.length > 0 || @semesters_gained.length > 0
  end

  def to_str
    ret_val = "Course #{@course_id}"

    ret_val + '\tNo longer offered during the ' + @semesters_lost.join(',') + ' semesters' if semesters_lost.length > 0

    ret_val + '\n\tNow offered during the ' + @semesters_gained.join(',') + ' semesters' if semesters_gained.length > 0

    ret_val
  end
end
