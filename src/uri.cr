class URI
  def /(other : String)
    out_path = @path
    out_path += '/' unless out_path[-1] == '/'
    other = other[1..-1] if other[0] == '/'

    output = dup
    output.path = out_path + other
    output
  end
end
