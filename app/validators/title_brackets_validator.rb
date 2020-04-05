class TitleBracketsValidator < ActiveModel::Validator
  def validate(record)
    @title = record.title

    record.errors.add(:title, "Invalid brackets in title ") unless valid_title?
  end

  def valid_title?
    return false if have_empty_brackets?

    selected = []
    brackets = { "{" => "}", "[" => "]", "(" => ")" }
    @title.each_char do |c|
      selected << c if brackets.key?(c)
      return false if brackets.key(c) && brackets.key(c) != selected.pop
    end
    selected.empty?
  end

  def have_empty_brackets?
    %w(() {} []).any? { |b| @title.include?(b) }
  end
end
