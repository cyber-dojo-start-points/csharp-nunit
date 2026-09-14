// Nothing calls this, and it is compiled all the same: cyber-dojo.sh hands
// the compiler every .cs file it finds, in one go, so a file that will not
// parse cannot sit there unnoticed. The build stops and no test runs.
public class Checksum
{
    public static int Of(int n)
    {
        return n % 10
    }
}
