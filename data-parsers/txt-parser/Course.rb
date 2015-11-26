Course = Struct.new(:id, :name, :description, :credits, :prereqs, :coreqs, :semesters_offered) do
  def ==(other_object)
    (other_object.id == id) || (other_object.name == name)
  end
end
