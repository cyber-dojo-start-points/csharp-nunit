using NUnit.Framework;

public class HikerTest
{
    [Test]
    public void life_the_universe_and_everything()
    {
        // a simple example to start you off
        Assert.That(Hiker.Answer(), Is.EqualTo(42));
    }
}
