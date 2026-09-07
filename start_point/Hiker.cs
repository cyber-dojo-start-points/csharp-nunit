public class Hiker
{
    private readonly ILogger logger;

    public Hiker(ILogger logger)
    {
        this.logger = logger;
    }

    public int Answer()
    {
        var answer = 6 * 9;
        logger.Log($"the answer is {answer}");
        return answer;
    }
}
