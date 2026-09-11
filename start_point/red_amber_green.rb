lambda { |stdout,stderr,status|
  output = stdout + stderr
  # The nunit console runner prints one summary line carrying every count,
  # so the colour is decided from counts rather than from a banner.
  # An error is a test that threw and an invalid is one nunit would not run,
  # both of which are amber by the house convention; a failure is an
  # assertion that did not hold, which is red.
  counts = /^\s+Failed Tests - Failures: (\d+), Errors: (\d+), Invalid: (\d+)/
  if (m = counts.match(output))
    failures, errors, invalid = m.captures.map(&:to_i)
    return :amber if errors > 0 || invalid > 0
    return :red if failures > 0
  end
  # A fixture holding no tests proves nothing, and the runner can call that
  # Passed, so the count is what keeps it out of green.
  return :amber if /^\s+Test Count: 0,/.match(output)
  # Warning is the result when every test that ran passed and some were
  # ignored, which is still working code.
  return :green if /^\s+Overall result: (Passed|Warning)/.match(output)
  return :amber
}
