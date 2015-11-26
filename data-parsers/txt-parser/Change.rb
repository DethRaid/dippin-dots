class Change
  attr_reader :semesters_lost
  attr_reader :semesters_gained
  attr_reader :course_id
  attr_reader :new
  attr_reader :dropped

  def initialize(course_id, semesters_lost, semesters_gained, dropped = false, new = false)
    @semesters_lost = semesters_lost
    @semesters_gained = semesters_gained
    @course_id = course_id
    @new = new
    @dropped = dropped
  end

  def changed?
    @semesters_lost.length > 0 || @semesters_gained.length > 0 || @new || @dropped
  end

  def to_s
    ret_val = "Course '#{@course_id}'"

    ret_val += "\n\t* No longer offered during the #{@semesters_lost.join(',')} semesters" if semesters_lost.length > 0

    ret_val += "\n\t* Now offered during the #{@semesters_gained.join(',')} semesters" if semesters_gained.length > 0

    ret_val += "\n\t* Is new" if @new
    ret_val += "\n\t* Was dropped" if @dropped

    ret_val
  end
end
