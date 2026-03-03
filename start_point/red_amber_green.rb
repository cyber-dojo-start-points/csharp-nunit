
lambda { |stdout,stderr,status|
  output = stdout + stderr
  return :green if /^Passed!/.match(output)
  return :red   if /^Failed!/.match(output) #dotnet test
  return :red   if /^\s+Failed Tests/.match(output) #nunit console runner 
  return :amber
}
