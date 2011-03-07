class String
  def red;        colorize("\e[1m\e[31m");  end
  def yellow;     colorize("\e[1m\e[33m");  end
  def purpule;    colorize("\e[1m\e[35m");  end

  def green;      colorize("\e[1m\e[32m");  end
  def dark_green; colorize("\e[32m"     );  end

  def blue;       colorize("\e[1m\e[34m");  end
  def dark_blue;  colorize("\e[34m"     );  end

  def colorize(color) "#{color}#{self}\e[0m" end
end
