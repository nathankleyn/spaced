cells = []
matcher = /(^\s+|\*|[+-^"!@<>&][0-9]*)/

lines = File.readlines(ARGV.first).map { |line| line.split(';') }.flatten
loop_starts = []
stack_ptr = 0
preserve_cell_ptr = false

begin
  cell_ptr = 0 if !preserve_cell_ptr || !cell_ptr
  line = lines[stack_ptr].rstrip

  line.scan(matcher) do |match|
    match = match.first
    multipler = match[1..-1].to_i
    multipler = 1 if multipler.zero?

    case match.chars.first
    when ' '
      cell_ptr += match.length
    when '>'
      cell_ptr += multipler
    when '<'
      cell_ptr -= multipler
    when '@'
      preserve_cell_ptr = !preserve_cell_ptr
    when '+'
      cells[cell_ptr] = cells[cell_ptr].to_i + multipler
    when '-'
      cells[cell_ptr] = cells[cell_ptr].to_i - multipler
    when '"'
      print cells[cell_ptr].chr
    when '!'
      print cells[cell_ptr].to_i
    when '*'
      loop_starts << stack_ptr
    when '^'
      stack_ptr = loop_starts.pop - 1 unless !cells[cell_ptr] || cells[cell_ptr] <= 0
    when '&'
      begin
        cells[cell_ptr] = if char = STDIN.readchar
          char.bytes.first
        else
          0
        end
      rescue
        0
      end
    end
  end

  stack_ptr += 1
end until (stack_ptr == lines.length)
