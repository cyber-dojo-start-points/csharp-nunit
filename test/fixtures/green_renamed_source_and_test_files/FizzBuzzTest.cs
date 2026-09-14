using NUnit.Framework;

public class FizzBuzzTest
{
    [Test]
    public void fifteen_says_fizz_buzz()
    {
        Assert.That(new FizzBuzz().Say(15), Is.EqualTo("FizzBuzz"));
    }
}
