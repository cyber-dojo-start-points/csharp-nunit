
lambda { |stdout,stderr,status|
  output = stdout + stderr
   #dotnet test:
  return :green if /^Passed!/.match(output)
  return :red   if /^Failed!/.match(output)

  #nunit console runner:
  return :green if /^\s+Overall result: Passed/.match(output)
  return :red   if /^\s+Failed Tests/.match(output) 
  return :amber
}
