using NUnit.Framework;

public class Hiker
{
    public int Answer()
    {
        // The learner put a print inside a loop to see what was happening,
        // and it prints far more than the 50K the runner keeps of a stream.
        // System.Console is not on the compiler command line, so the print
        // goes through NUnit's writer, and every one of those lands on
        // stdout. That is the stream the summary comes on too, so the
        // summary is what falls off the end.
        for (var i = 0; i < 10000; i++)
        {
            TestContext.Progress.WriteLine("debug: i is " + i);
        }
        return 6 * 7;
    }
}
