class Corrector
  attr_accessor :fullname

  def initialize(fullname)
    @fullname = fullname
  end

  def correct_name
    if @fullname.length > 10
      @fullname[0..10].split.map(&:capitalize).join(' ')

    else
      @fullname.split.map(&:capitalize).join(' ')
    end
  end
end
