class Employee
  attr_reader :name, :title, :salary, :boss

  def initialize(name, title, salary, boss)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
  end

  def bonus(multiplier)
    @salary * multiplier
  end
end

class Manager < Employee
  def initialize(name, title, salary, boss, employees)
    super(name, title, salary, boss)
    @employees = employees
  end

  def bonus(multiplier)
    total = 0
    employees = all_employees
    employees.each {|employee| total += employee.salary}
    total * multiplier
  end

  def all_employees
    sub_employees = []
    @employees.each do |person|
      sub_employees << person
      if person.is_a? Manager
        sub_employees += person.all_employees
      end
    end
    sub_employees
  end
end

david = Employee.new('David', 'TA', 10000, 'Darren')
shawna = Employee.new('Shawna', 'TA', 12000, 'Darren')
darren = Manager.new('Darren', 'TA Manager', 78000, 'Ned', [david, shawna])
ned = Manager.new('Ned', 'Founder', 1000000, nil, [darren])

p ned.bonus(5) # => 500_000
p darren.bonus(4) # => 88_000
p david.bonus(3) # => 30_000
