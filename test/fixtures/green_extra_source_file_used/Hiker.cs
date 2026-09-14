public class Hiker
{
    public int Answer()
    {
        return 6 * 7;
    }

    public int AnswerChecksum()
    {
        return Checksum.Of(Answer());
    }
}
