using NUnit.Framework;

public class Hiker
{
    public int Answer()
    {
        // System.Console is not one of the assemblies cyber-dojo.sh names on
        // the compiler command line, so a print goes through NUnit's own
        // writer instead. Every one of those writers lands on stdout, which
        // is also the stream the framework's summary comes on.
        TestContext.Progress.WriteLine("answer was called");
        return 6 * 7;
    }
}
